class_name LocationDiscoveredEvent extends Event




func fire(_data: Dictionary = {}) -> void:

	super(_data)

	print("you discovered: ", data["location_id"])