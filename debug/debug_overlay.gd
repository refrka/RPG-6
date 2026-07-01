class_name DebugOverlay extends UIOverlay


@export var main_button: Button

@export var location_button: Button

@export var entity_button: Button

@export var quest_button: Button

@export var item_button: Button

@export var refresh_button: Button

@export var main_panel: MainPanel

@export var location_panel: LocationPanel

@export var entity_panel: EntityPanel

@export var quest_panel: QuestPanel

@export var item_panel: ItemPanel


var panels: Dictionary[Script, DebugPanel]





func _ready() -> void:
	
	panels = {

		MainPanel: main_panel,

		LocationPanel: location_panel,

		EntityPanel: entity_panel,

		QuestPanel: quest_panel,

		ItemPanel: item_panel,

	}

	main_button.toggled.connect(_on_main_toggled)

	location_button.toggled.connect(_on_location_toggled)

	entity_button.toggled.connect(_on_entity_toggled)

	quest_button.toggled.connect(_on_quest_toggled)

	item_button.toggled.connect(_on_item_toggled)

	refresh_button.pressed.connect(_on_refresh_pressed)

	_on_main_toggled(true)











func _toggle_panel(panel_script: Script, state: bool) -> void:

	for script in panels:

		var panel = panels[script]

		if script == panel_script:

			panel.visible = state

		else:

			panel.visible = !state




func _on_main_toggled(_state: bool) -> void:

	_toggle_panel(MainPanel, _state)



func _on_location_toggled(_state: bool) -> void:

	_toggle_panel(LocationPanel, _state)



func _on_entity_toggled(_state: bool) -> void:

	_toggle_panel(EntityPanel, _state)



func _on_quest_toggled(_state: bool) -> void:

	_toggle_panel(QuestPanel, _state)



func _on_item_toggled(_state: bool) -> void:

	_toggle_panel(ItemPanel, _state)








func _on_refresh_pressed() -> void:

	main_panel.refresh()

	location_panel.refresh()

	entity_panel.refresh()