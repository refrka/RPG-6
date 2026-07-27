class_name Effect extends Resource


@warning_ignore("unused_signal")

signal expired


enum EffectType {

	INSTANT,

	DURATION,

	PASSIVE,

	TRIGGER,

}



@export var effect_type: EffectType


var active:= false

var source_entity: EntityNode

var target_entity: EntityNode



func _initialize(_target_entity: EntityNode) -> void:

	target_entity = _target_entity




func _apply(_target_entity: EntityNode = null) -> void:

	if !target_entity:

		target_entity = _target_entity


