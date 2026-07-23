class_name PlayerRemovedItemsEvent extends GameEvent




func _get_notice_primary_text() -> String:

	return "Item(s) removed"



func _get_notice_secondary_text() -> String:

	var item_data = data["item_data"]

	var item_def = item_data.get_item_def()

	var amount = data["amount"]

	return "%s x%s" % [item_def.display_name, amount]