class_name CharacterNode extends EntityNode


@export var nav_agent: NavigationAgent2D










func use_item(item_id: StringName, in_inventory: bool) -> void:

	var item_def = Items.get_item_def(item_id)
	
	var used:= false

	var effects_component = get_component("effects")

	match item_def.get_script():

		ConsumableDef:

			for effect in item_def.effects_on_consume:

				effects_component.add_effect(effect)

			used = true

	if used and in_inventory:

		inventory.remove_item(item_id, 1)