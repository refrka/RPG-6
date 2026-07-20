class_name AddToInventory extends Command


@export var item_id: StringName

@export var item_def: ItemDef

@export var reference_entity: ReferenceEntity

@export var amount: int


func execute(_data: Dictionary = {}) -> bool:

	var entity_node: EntityNode = null

	if _data.has("entity_node"):

		entity_node = _data["entity_node"]

	if _data.has("item_id"):

		item_id = _data["item_id"]

	if _data.has("item_def"):

		item_def = _data["item_def"]

	if !item_def:

		item_def = Items.get_item_def(item_id)

	entity_node.inventory.add_item(item_def, amount)

	return true