class_name NotificationRoot extends Control


var notification_list: Array[NotificationOverlay]

var current_notification: NotificationOverlay




func add_notification(overlay: NotificationOverlay) -> void:

	add_child(overlay)

	notification_list.append(overlay)

	overlay.visible = false

	overlay.complete.connect(_on_notification_complete)

	if !current_notification:

		show_next_notification()




func show_next_notification() -> void:

	current_notification = notification_list.pop_front()

	current_notification.visible = true

	current_notification.show_notification()





func _on_notification_complete() -> void:

	print("notificaiton complete")

	current_notification = null

	if !notification_list.is_empty():

		show_next_notification()