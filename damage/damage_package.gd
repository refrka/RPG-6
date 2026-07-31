class_name DamagePackage extends Resource



var source: EntityNode

@export var damage_sets: Array[DamageSet]







func calculate_type_damage(total_damage: float, damage_types: Array[DamageType]) -> Dictionary[DamageType, float]:

	var type_damage: Dictionary[DamageType, float] = {}

	var total_weight:= 0.0

	for damage_type in damage_types:

		total_weight += damage_type.weight
	
	for damage_type in damage_types:

		var remapped_weight = remap(damage_type.weight, 0.0, total_weight, 0.0, 1.0)

		var damage = total_damage * remapped_weight

		type_damage[damage_type] = damage

	return type_damage







static func generate_package() -> DamagePackage:

	var damage_package = DamagePackage.new()

	return damage_package