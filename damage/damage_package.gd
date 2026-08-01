class_name DamagePackage extends Resource



var source: EntityNode

var total_damage: float

@export var damage_sets: Array[DamageSet]







func calculate_type_damage(damage_types: Array[DamageType]) -> Dictionary[DamageType, float]:

	var type_damage: Dictionary[DamageType, float] = {}

	var total_weight:= 0.0

	if damage_types.is_empty():

		var type = PhysicalDamage.new()

		type.weight = 1.0

		damage_types.append(type)

	for damage_type in damage_types:

		total_weight += damage_type.weight
	
	for damage_type in damage_types:

		var remapped_weight = remap(damage_type.weight, 0.0, total_weight, 0.0, 1.0)

		var damage = total_damage * remapped_weight

		type_damage[damage_type] = damage

	return type_damage








static func generate_package(source_entity: EntityNode, attack_entry: AttackEntry) -> DamagePackage:

	var damage_package = DamagePackage.new()

	damage_package.source = source_entity

	damage_package.total_damage = randf_range(attack_entry.damage_range.x, attack_entry.damage_range.y)

	var type_damages = damage_package.calculate_type_damage(attack_entry.damage_types)

	for damage_type in type_damages:

		var damage = type_damages[damage_type]

		var damage_set = DamageSet.new(damage_type, damage)

		damage_package.damage_sets.append(damage_set)

	return damage_package