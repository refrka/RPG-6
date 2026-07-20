extends Node



@onready var notice_scene:= preload("res://ui/notice.tscn")

@onready var count_selector_scene:= preload("res://ui/count_selector.tscn")

var overlay_root: Control

var notice_root: Control

var overlay_registry: Dictionary[Script, Overlay]

var active_overlays: Array[Overlay]

var pause_overlays: Array[Overlay]

var notice_queue: Array[Notice]





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	overlay_root = get_tree().get_first_node_in_group("overlay_root")

	notice_root = get_tree().get_first_node_in_group("notice_root")





func register_overlay(overlay: Overlay) -> void:

	var script = overlay.get_script()

	overlay_registry[script] = overlay




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

		if overlay is Notice and !notice_queue.is_empty():

			var notice = notice_queue.pop_front()

			overlay_registry.erase(notice.get_script())

			_add_notice(notice)

		



func get_overlay(overlay_script: Script) -> Overlay:

	var overlay: Overlay = null

	if overlay_registry.has(overlay_script):

		overlay = overlay_registry[overlay_script]

	return overlay




func deactivate_overlays() -> void:

	for overlay in active_overlays:

		remove_overlay(overlay)









func show_notice(title: String, secondary: String) -> void:

	var notice = notice_scene.instantiate() as Notice

	notice.set_notice_text(title, secondary)

	_add_notice(notice)

		


func show_count_selector(min_count: int, max_count: int) -> CountSelector:

	var overlay = count_selector_scene.instantiate() as CountSelector

	overlay.set_count(min_count, max_count)

	overlay_root.add_child(overlay)

	add_overlay(overlay)

	return overlay

	





func set_label_color(label: Label, color: Color) -> void:

	label.add_theme_color_override("font_color", color)








func _add_notice(notice: Notice) -> void:

	if get_overlay(Notice) == null:

		notice_root.add_child(notice)

		add_overlay(notice)
		
		notice._activate()

	else:

		notice_queue.append(notice)






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back"):

		if !Game.is_active():

			return

		if !active_overlays.is_empty():

			remove_overlay()

		else:

			var overlay = get_overlay(GameMenu)

			add_overlay(overlay)

		