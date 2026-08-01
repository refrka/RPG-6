class_name DamageSet extends Resource



@export var amount: float

@export var type: DamageType




func _init(_type: DamageType, _amount: float) -> void:

	type = _type

	amount = _amount