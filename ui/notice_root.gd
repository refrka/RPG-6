class_name NoticeRoot extends Control



@onready var notice_scene:= preload("res://ui/notice.tscn")


var current_notice: Notice

var notice_queue: Array[Notice]






func add_notice(primary: String, secondary: String) -> Notice:

	var notice = notice_scene.instantiate()

	notice.set_text(primary, secondary)

	if current_notice:

		notice_queue.append(notice)

	else:

		_show_notice(notice)

	return notice




func _show_notice(notice: Notice) -> void:

	add_child(notice)

	current_notice = notice

	current_notice.notice_ended.connect(_on_notice_ended)

	notice._activate()

	notice.animation_player.play("show")




func _on_notice_ended(notice: Notice) -> void:

	if notice == current_notice:

		current_notice = null

	if !notice_queue.is_empty():

		_show_notice(notice_queue.pop_front())