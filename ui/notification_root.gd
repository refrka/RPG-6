class_name NotificationRoot extends Control


var notification_list: Array[NotificationOverlay]

var current_notification: NotificationOverlay




func add_notification(overlay: NotificationOverlay) -> void:

	notification_list.append(overlay)

	if !current_notification:

		show_next_notification()




func show_next_notification() -> void:

	current_notification = notification_list.pop_front()

	add_child(current_notification)

	current_notification.visible = false

	current_notification.hide_finished.connect(_on_overlay_hide_finished)

	current_notification.visible = true

	current_notification.show_notification()





func _on_overlay_hide_finished() -> void:

	current_notification.queue_free()

	current_notification = null

	if !notification_list.is_empty():

		show_next_notification()