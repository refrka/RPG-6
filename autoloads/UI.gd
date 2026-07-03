extends Node


@onready var dialogue_panel_scene:= preload("res://ui/dialogue_panel.tscn")

@onready var notification_overlay_scene:= preload("res://ui/notification_overlay.tscn")


var overlay_root: Control

var notification_root: Control

var overlay_registry:= {}


var pause_list: Array[UIOverlay]

var overlay_list: Array[UIOverlay]




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	overlay_root = get_tree().get_first_node_in_group("overlay_root")

	notification_root = get_tree().get_first_node_in_group("notification_root")

	Events.subscribe(ItemsAddedToInventoryEvent, _on_items_added_to_inventory)
















func show_notification(message: String) -> void:

	var overlay = notification_overlay_scene.instantiate()

	overlay.set_message(message)

	notification_root.add_notification(overlay)





func open_dialogue(target_entity: EntityNode) -> DialoguePanel:

	var dialogue_panel = dialogue_panel_scene.instantiate()

	overlay_root.add_child(dialogue_panel)

	dialogue_panel.load_dialogue(target_entity)

	return dialogue_panel





func close_dialogue() -> void:

	var dialogue_panel = get_tree().get_first_node_in_group("dialogue_panel")

	dialogue_panel.toggle()

	remove_overlay(dialogue_panel)

	dialogue_panel.queue_free()






func open_container(target_container: EntityNode) -> void:

	pass






func register_overlay(overlay: UIOverlay) -> void:

	overlay_registry[overlay.get_script()] = overlay





func get_overlay(overlay_script: Script) -> UIOverlay:

	var overlay = _get_overlay(overlay_script)

	return overlay





func deactivate_overlays() -> void:

	for overlay in overlay_registry.values():

		overlay._deactivate()




func add_overlay(overlay: UIOverlay) -> void:

	overlay_list.append(overlay)

	if overlay.pause:

		add_pause(overlay)





func remove_overlay(overlay: UIOverlay) -> void:

	overlay_list.erase(overlay)

	if overlay.pause:

		remove_pause(overlay)




func add_pause(pause_source: UIOverlay) -> void:

	pause_list.append(pause_source)

	if !Game.is_paused():

		Game.pause()





func remove_pause(pause_source: UIOverlay) -> void:

	pause_list.erase(pause_source)

	if pause_list.is_empty():

		Game.resume()











func _get_overlay(overlay_script: Script) -> UIOverlay:

	if overlay_registry.has(overlay_script):

		return overlay_registry[overlay_script]

	return null













func _on_items_added_to_inventory(event: ItemsAddedToInventoryEvent) -> void:

	var item_id = event.data["item_id"]

	var change = event.data["change"]

	var message = "%s (%s) added to inventory" % [item_id, change]

	show_notification(message)













func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back"):

		if Game.is_active():

			if !overlay_list.is_empty():

				var overlay = overlay_list.pop_back()

				overlay.toggle()

			else:

				var menu = _get_overlay(GameMenu)

				menu.toggle()