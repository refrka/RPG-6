class_name SlotData extends Resource


signal slot_updated(slot_data: SlotData)


@export var item_def: ItemDef

@export var quantity:= 0






func set_data(_item_def: ItemDef, _quantity: int) -> void:

	item_def = _item_def

	quantity = _quantity

	slot_updated.emit(self)