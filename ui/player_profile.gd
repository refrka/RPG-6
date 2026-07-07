class_name PlayerProfile extends UIOverlay




@export var inventory_panel: PlayerInventoryPanel

@export var info_panel: PlayerInfoPanel





func initialize(player: PlayerNode) -> void:

	info_panel.load_info(player)







func _on_profile_pressed() -> void:

	toggle()






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("profile"):

		if Game.is_active():

			toggle()