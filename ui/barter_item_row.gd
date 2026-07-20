class_name BarterItemRow extends InventoryItemRow


\

signal buy_requested(row: InventoryItemRow)

signal sell_requested(row: InventoryItemRow)




@export var buy_button: Button

@export var sell_button: Button





func _ready() -> void:

	super()

	buy_button.pressed.connect(buy_requested.emit.bind(self))

	sell_button.pressed.connect(sell_requested.emit.bind(self))