class_name Inventory extends Resource


signal item_data_count_updated(amount: int, item_data: ItemData, removed: bool)



@export var items: Array[ItemData]


@export var weapon: ItemData

@export var armor: ItemData

@export var accessory: ItemData


@export var gold: int





func initialize() -> void:

	for item_data in items:

		if !item_data.count_updated.is_connected(_on_item_data_count_updated):

			item_data.count_updated.connect(_on_item_data_count_updated)




func clear() -> void:

	pass




func add_item_data(item_data: ItemData) -> void:

	if item_data.data_id == &"":

		var current_data = get_item_data_by_def(item_data.get_def())

		if current_data:

			current_data.add_count(item_data.get_count())

			return

	items.append(item_data)

	item_data.count_updated.connect(_on_item_data_count_updated)

	item_data.count_updated.emit(item_data.get_count(), item_data, false)






func remove_item_by_data(item_data: ItemData) -> void:

	if item_data.data_id == &"":

		var current_data = get_item_data_by_def(item_data.get_def())

		if !current_data:

			return

		current_data.remove_count(item_data.get_count())

	else:

		var current_data = get_item_data_by_data_id(item_data.get_data_id())

		if !current_data:

			return

		current_data.remove_count(1)







func remove_item_by_def(item_def: ItemDef, count:= 1) -> void:

	var item_data = get_item_data_by_def(item_def)

	if !item_data:

		return

	item_data.remove_count(count)









func get_item_data_by_def(item_def: ItemDef) -> ItemData:

	for item_data in items:

		if item_data.get_def() == item_def:

			return item_data

	return null





func get_item_data_by_data_id(data_id: StringName) -> ItemData:

	for item_data in items:

		if item_data.get_data_id() == data_id:

			return item_data

	return null






func get_items(item_script: Script = ItemDef) -> Array[ItemData]:

	var matched_items: Array[ItemData] = []

	for item_data in items:

		var script = item_data.get_def().get_script()

		if script == item_script or script.get_base_script() == item_script:

			matched_items.append(item_data)

	return matched_items






func get_gold_count() -> int:

	return gold













func _on_item_data_count_updated(amount: int, item_data: ItemData, removed: bool) -> void:

	item_data_count_updated.emit(amount, item_data, removed)












func get_dictionary() -> Dictionary:

	var save_dict = {}

	save_dict["items"] = []

	for item_data in items:

		save_dict["items"].append(item_data.get_dictionary())

	return save_dict





static func load_dictionary(save_dict: Dictionary) -> Inventory:

	var inventory = Inventory.new()

	for dict in save_dict["items"]:

		inventory.items.append(ItemData.load_dictionary(dict))

	return inventory



