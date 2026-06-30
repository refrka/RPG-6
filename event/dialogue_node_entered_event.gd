class_name DialogueNodeEnteredEvent extends Event


func fire(_data: Dictionary) -> void:

	super(_data)

	print("entered dialogue node: ", data["dialogue_node"])