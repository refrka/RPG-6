extends Node






var overlay_registry:= {}








func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS




func register_overlay(overlay: UIOverlay) -> void:

	overlay_registry[overlay.get_script()] = overlay








func _get_overlay(overlay_script: Script) -> UIOverlay:

	if overlay_registry.has(overlay_script):

		return overlay_registry[overlay_script]

	return null




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back"):

		if Game.is_active():

			print("active!")