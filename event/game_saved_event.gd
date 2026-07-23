class_name GameSavedEvent extends Event





func fire(_data: Dictionary, with_notice:= false) -> void:

	super(_data, with_notice)

	show_notice()




func _get_notice_primary_text() -> String:

	return "Game saved"