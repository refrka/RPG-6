class_name ProjectileDef extends EquipmentDef


enum ProjectileType {

	AMMUNITION,

	THROWABLE,

}



@export var projectile_type: ProjectileType

@export var projectile_object_def: ProjectileObjectDef