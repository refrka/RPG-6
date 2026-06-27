class_name DebugOverlay extends UIOverlay


@export var main_button: Button

@export var location_button: Button

@export var entity_button: Button

@export var refresh_button: Button

@export var main_panel: MainPanel

@export var location_panel: LocationPanel

@export var entity_panel: EntityPanel




func _ready() -> void:

	main_button.toggled.connect(_on_main_toggled)

	location_button.toggled.connect(_on_location_toggled)

	entity_button.toggled.connect(_on_entity_toggled)






func _on_main_toggled(_state: bool) -> void:

	main_panel.visible = true

	location_panel.visible = false

	entity_panel.visible = false



func _on_location_toggled(_state: bool) -> void:

	main_panel.visible = false

	location_panel.visible = true

	entity_panel.visible = false



func _on_entity_toggled(_state: bool) -> void:

	main_panel.visible = false

	location_panel.visible = false

	entity_panel.visible = true