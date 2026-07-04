class_name CharacterNode extends EntityNode


@export var nav_agent: NavigationAgent2D








func _initialize() -> void:

	super()

	if def.entity_id == "mim":

		print("sub it")

		Events.subscribe(ItemsAddedToInventoryEvent, _on_added)





func _on_added(event: Event) -> void:

	var nav_com = get_component("navigation")

	nav_com.set_target_pos(global_position + Vector2(50,0))





func use_item(item_id: StringName, in_inventory: bool) -> void:

	var def = Items.get_def(item_id)
	
	var used:= false

	var effects_component = get_component("effects")

	match def.get_script():

		ConsumableDef:

			for effect in def.effects_on_consume:

				effects_component.add_effect(effect)

			used = true

	if used and in_inventory:

		inventory.remove_item(item_id, 1)