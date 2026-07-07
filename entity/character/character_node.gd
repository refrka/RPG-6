class_name CharacterNode extends EntityNode


@export var nav_agent: NavigationAgent2D










func use_item(item_data, in_inventory:= true) -> void:

	var item_def = item_data.get_def()
	
	var used:= false

	var effects_component = get_component("effects")

	match item_def.get_script():

		ConsumableDef:

			for effect in item_def.effects_on_consume:

				effects_component.add_effect(effect)

			used = true

	if used and in_inventory:

		item_data.remove_count(1)