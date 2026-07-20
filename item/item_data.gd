class_name ItemData extends Resource


signal data_updated(item_data: ItemData)

signal data_emptied(item_data: ItemData)


@export var def: ItemDef

@export var count: int







func set_data(_def: ItemDef, _count:= 1) -> void:

	def = _def

	count = _count

	data_updated.emit(self)

	if is_empty():

		data_emptied.emit(self)





func absorb(item_data: ItemData) -> void:

	var new_count = count + item_data.count

	set_data(def, new_count)

	item_data.set_data(null)







func get_def() -> ItemDef:

	return def





func is_empty() -> bool:

	return def == null or count <= 0





static func create(_def: ItemDef, _count:= 1) -> ItemData:

	var item_data = ItemData.new()

	item_data.set_data(_def, _count)

	return item_data