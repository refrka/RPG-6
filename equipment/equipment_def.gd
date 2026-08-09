class_name EquipmentDef extends ItemDef


enum EquipmentType {
	
	WEAPON,

	ARMOR,

	ACCESSORY,

	TOOL,

	PROJECTILE,

}


@export var equipment_type: EquipmentType


@export var hitbox_collision_shape: Shape2D

@export var hitbox_position: Vector2
