class_name GameSavedEvent extends Event





func fire(_data: Dictionary) -> void:

	super(_data)

	show_notice()




func _get_notice_primary_text() -> String:

	return "Game saved"