class_name EntityDisplay extends MarginContainer



@export var data_display: MarginContainer

@export var def_display: MarginContainer

@export var entity_id_label: Label

@export var unique_id_label: Label

@export var view_def_button: Button



var entity_data: EntityData

var entity_def: EntityDef




func _ready() -> void:

	data_display.visible = false

	def_display.visible = false

	view_def_button.pressed.connect(_on_view_def_pressed)






func display_entity_data(_entity_data: EntityData) -> void:

	data_display.visible = true

	def_display.visible = false
	
	entity_data = _entity_data

	unique_id_label.text = entity_data.def.unique_id






func display_entity_def(_entity_def: EntityDef) -> void:

	data_display.visible = false

	def_display.visible = true

	entity_def = _entity_def

	entity_id_label.text = entity_def.entity_id

	







func _on_view_def_pressed() -> void:

	display_entity_def(entity_data.def)