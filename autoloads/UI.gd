extends Node


signal popup_boolean_completed(state: bool)


@onready var popup_scene:= preload("res://ui/game_popup.tscn")

@onready var count_selector_scene:= preload("res://ui/count_selector.tscn")



var overlay_registry: Dictionary[Script, Overlay]

var active_overlays: Array[Overlay]

var pause_overlays: Array[Overlay]


var overlay_root: Control

var notice_root: NoticeRoot

var popup_root: Control



func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	overlay_root = get_tree().get_first_node_in_group("overlay_root")

	notice_root = get_tree().get_first_node_in_group("notice_root")

	popup_root = get_tree().get_first_node_in_group("popup_root")




func register_overlay(overlay: Overlay) -> void:

	var script = overlay.get_script()

	overlay_registry[script] = overlay

	overlay.close_requested.connect(_on_overlay_close_requested.bind(overlay))




func unregister_overlay(overlay: Overlay) -> void:

	var script = overlay.get_script()

	overlay_registry.erase(script)





func add_overlay(overlay: Overlay) -> void:

	active_overlays.append(overlay)

	overlay._activate()

	if overlay.pause:

		pause_overlays.append(overlay)
	
		if !Game.is_paused():

			Game.pause()




func remove_overlay(overlay: Overlay = null) -> void:

	if overlay == null:

		overlay = active_overlays.back()

	overlay._deactivate()

	if active_overlays.has(overlay):

		active_overlays.erase(overlay)

		if overlay.pause:

			pause_overlays.erase(overlay)

			if pause_overlays.is_empty() and Game.is_paused():

				Game.resume()





func get_overlay(overlay_script: Script) -> Overlay:

	var overlay: Overlay = null

	if overlay_registry.has(overlay_script):

		overlay = overlay_registry[overlay_script]

	return overlay




func deactivate_overlays() -> void:

	for overlay in active_overlays:

		remove_overlay(overlay)








# Various overlays: Notices, Popups, Dialogue, CountSelector


func show_notice(primary: String, secondary:= "") -> Notice:

	var notice = notice_root.add_notice(primary, secondary)

	return notice





func show_popup(mode: GamePopup.PopupMode, message: String, title:= "") -> GamePopup:

	var popup = popup_scene.instantiate() as GamePopup

	popup.set_mode(mode)

	popup.set_text(message, title)

	popup.popup_completed.connect(_on_popup_completed)

	popup.boolean_completed.connect(_on_popup_boolean_completed)

	popup_root.add_child(popup)

	popup._activate()

	return popup





func show_dialogue_panel(greeting: Greeting, options: Array[DialogueNode] = [], source: EntityNode = null) -> DialoguePanel:

	var dialogue_panel = get_overlay(DialoguePanel) as DialoguePanel

	dialogue_panel.set_dialogue(source, greeting, options)

	add_overlay(dialogue_panel)

	return dialogue_panel




func show_barter_panel(target_entity: EntityNode) -> BarterPanel:

	var barter_panel = get_overlay(BarterPanel) as BarterPanel

	barter_panel.load_barter_inventories(target_entity)

	add_overlay(barter_panel)

	return barter_panel





func close_dialogue_panel() -> void:

	var overlay = get_overlay(DialoguePanel)

	if active_overlays.has(overlay):

		remove_overlay(overlay)
		
		
		
		
func show_count_selector(min_count: int, max_count: int, use_float:= true) -> CountSelector:

	var overlay = count_selector_scene.instantiate() as CountSelector

	overlay.set_count(min_count, max_count, use_float)

	overlay_root.add_child(overlay)

	add_overlay(overlay)

	return overlay







func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back"):

		if !Game.is_active():

			return

		if !active_overlays.is_empty():

			remove_overlay()

		else:

			var overlay = get_overlay(GameMenu)

			add_overlay(overlay)

	var game_menu = get_overlay(GameMenu)

	if game_menu.active:

		return

	if event.is_action_pressed("profile"):

		if Game.is_active():

			var profile = get_overlay(ProfilePanel)

			if !profile.active:

				add_overlay(profile)

			else:

				remove_overlay(profile)





func _on_popup_completed(popup: GamePopup) -> void:

	popup.queue_free()



func _on_popup_boolean_completed(popup: GamePopup, state: bool) -> void:

	popup.queue_free()

	popup_boolean_completed.emit(state)



func _on_overlay_close_requested(overlay: Overlay) -> void:

	overlay._close()

	remove_overlay(overlay)