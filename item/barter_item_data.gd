class_name BarterItemData extends ItemData




@export var item_data: ItemData

@export var barter_count: int






static func load_item_data(_item_data: ItemData) -> BarterItemData:

	var barter_item_data = BarterItemData.new()

	barter_item_data.item_data = _item_data

	barter_item_data.def = _item_data.get_def()

	barter_item_data.barter_count = _item_data.get_count()

	return barter_item_data