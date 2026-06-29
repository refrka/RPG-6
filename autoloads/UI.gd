extends Node


@onready var dialogue_panel_scene:= preload("res://ui/dialogue_panel.tscn")


var overlay_root: Control

var overlay_registry:= {}


var pause_count:= 0






func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	overlay_root = get_tree().get_first_node_in_group("overlay_root")













##  Top-level Methods









func open_dialogue(target_entity: EntityNode) -> DialoguePanel:

	var dialogue_panel = dialogue_panel_scene.instantiate()

	overlay_root.add_child(dialogue_panel)

	dialogue_panel.load_root_options(target_entity)

	return dialogue_panel





func close_dialogue() -> void:

	var dialogue_panel = get_tree().get_first_node_in_group("dialogue_panel")

	dialogue_panel.queue_free()








func register_overlay(overlay: UIOverlay) -> void:

	overlay_registry[overlay.get_script()] = overlay





func get_overlay(overlay_script: Script) -> UIOverlay:

	var overlay = _get_overlay(overlay_script)

	return overlay





func deactivate_overlays() -> void:

	for overlay in overlay_registry.values():

		overlay._deactivate()





func add_pause() -> void:

	pause_count += 1

	if !Game.is_paused():

		Game.pause()





func remove_pause() -> void:

	pause_count = max(0, pause_count - 1)

	if pause_count <= 0 and Game.is_paused():

		Game.resume()












func _get_overlay(overlay_script: Script) -> UIOverlay:

	if overlay_registry.has(overlay_script):

		return overlay_registry[overlay_script]

	return null






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back"):

		if Game.is_active():

			var menu = _get_overlay(GameMenu)

			menu.toggle()