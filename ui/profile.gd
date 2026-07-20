class_name Profile extends Overlay


@export var player_name_label: Label

@export var character_tab_button: Button

@export var inventory_tab_button: Button

@export var quests_tab_button: Button

@export var character_panel: MarginContainer

@export var inventory_panel: MarginContainer

@export var quests_panel: MarginContainer




var panel_registry:= { }

var current_panel: MarginContainer



func _ready() -> void:

	Events.subscribe(PlayerInitializedEvent, _on_player_initialized)

	var player = Game.get_player()

	var input_component = player.get_component(InputComponent)

	input_component.profile_pressed.connect(_on_profile_input_pressed)

	character_tab_button.button_group.pressed.connect(_on_tab_button_pressed)

	panel_registry = {

		character_tab_button: character_panel,

		inventory_tab_button: inventory_panel,

		quests_tab_button: quests_panel

	}

	_on_tab_button_pressed(character_tab_button)




func _activate() -> void:

	super()

	current_panel._activate()





func _load_player_info() -> void:

	var player = Game.get_player()

	player_name_label.text = player.get_display_name()

	quests_panel.show_quest_list()

	inventory_panel.load_player_inventory()




func _on_player_initialized(_event: Event) -> void:

	_load_player_info()





func _on_profile_input_pressed() -> void:

	if !active:

		UI.add_overlay(self)

	else:

		UI.remove_overlay(self)






func _on_tab_button_pressed(button: Button) -> void:

	for tab_button in panel_registry:

		var panel = panel_registry[tab_button]

		if button == tab_button:

			panel._activate()

			current_panel = panel

		else:

			panel._deactivate()