class_name BarterItemRow extends InventoryItemRow


signal buy_requested(row: BarterItemRow)

signal sell_requested(row: BarterItemRow)





@export var buy_button: Button

@export var sell_button: Button

var is_player_side:= true



func _ready() -> void:

	buy_button.pressed.connect(_on_buy_pressed)

	sell_button.pressed.connect(_on_sell_pressed)




func set_barter_side(_is_player_side: bool) -> void:

	is_player_side = _is_player_side

	if is_player_side:

		buy_button.hide()

		sell_button.show()

	else:

		buy_button.show()

		sell_button.hide()





func _on_buy_pressed() -> void:

	buy_requested.emit(self)



func _on_sell_pressed() -> void:

	sell_requested.emit(self)
