class_name Inventory extends Resource





@export var size:= 3


@export var slots: Array[SlotData]







func initialize() -> void:

	_resize()






func _resize() -> void:

	while slots.size() > size:

		slots.pop_back()

	while slots.size() < size:

		slots.append(SlotData.new())