extends Node


var overlay_root: Control

var overlay_registry: Dictionary[Script, Overlay]

var active_overlays: Array[Overlay]

var pause_overlays: Array[Overlay]




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	overlay_root = get_tree().get_first_node_in_group("overlay_root")




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

	print("overlay deactivated")

	if active_overlays.has(overlay):

		active_overlays.erase(overlay)

		print("overlay erased")

		if overlay.pause:

			pause_overlays.erase(overlay)

			print("pause erased")

			if pause_overlays.is_empty() and Game.is_paused():

				print("resumed")

				Game.resume()

		



func get_overlay(overlay_script: Script) -> Overlay:

	var overlay: Overlay = null

	if overlay_registry.has(overlay_script):

		overlay = overlay_registry[overlay_script]

	return overlay




func deactivate_overlays() -> void:

	for overlay in active_overlays:

		remove_overlay(overlay)







func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back"):

		if !Game.is_active():

			return

		if !active_overlays.is_empty():

			remove_overlay()

		else:

			var overlay = get_overlay(GameMenu)

			add_overlay(overlay)

		