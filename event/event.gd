@abstract class_name Event extends Resource



var data: Dictionary = {}




func fire(_data: Dictionary, with_notice:= false) -> void:

	data = _data

	if with_notice:

		show_notice()



func show_notice() -> void:

	UI.show_notice(_get_notice_primary_text(), _get_notice_secondary_text())




func _get_notice_primary_text() -> String:

	return ""


func _get_notice_secondary_text() -> String:

	return ""


func _get_popup_message_text() -> String:

	return ""