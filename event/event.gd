class_name Event extends Resource



var data: Dictionary = {}




func fire(_data: Dictionary) -> void:

	data = _data



func show_notice() -> void:

	print("show a notice")

	UI.show_notice(_get_notice_primary_text(), _get_notice_secondary_text())




func _get_notice_primary_text() -> String:

	return ""


func _get_notice_secondary_text() -> String:

	return ""


func _get_popup_message_text() -> String:

	return ""