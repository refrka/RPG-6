class_name Profile extends Overlay


@export var player_name_label: Label



func _ready() -> void:

	Events.subscribe(PlayerInitializedEvent, _on_player_initialized)

	var player = Game.get_player()

	var input_component = player.get_component(InputComponent)

	input_component.profile_pressed.connect(_on_profile_input_pressed)




func _load_player_info() -> void:

	var player = Game.get_player()

	player_name_label.text = player.get_display_name()




func _on_player_initialized(_event: Event) -> void:

	_load_player_info()





func _on_profile_input_pressed() -> void:

	if !active:

		UI.add_overlay(self)

	else:

		UI.remove_overlay(self)

