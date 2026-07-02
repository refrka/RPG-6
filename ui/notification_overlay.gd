class_name NotificationOverlay extends UIOverlay



@export var notification_panel: MarginContainer

@export var message_label: Label

@export var animation_player: AnimationPlayer


var timer_active:= false

var timer:= 0.0



func _ready() -> void:

	notification_panel.gui_input.connect(_on_gui_input)

	notification_panel.mouse_entered.connect(_on_mouse_entered)

	notification_panel.mouse_exited.connect(_on_mouse_exited)




func set_message(message: String) -> void:

	message_label.text = message




func show_notification() -> void:

	animation_player.play("show")

	await animation_player.animation_finished

	_start_timer()





func hide_notification() -> void:

	animation_player.play("hide")

	await animation_player.animation_finished

	queue_free()





func _start_timer() -> void:

	timer_active = true

	timer = 2.0




func _stop_timer() -> void:

	timer_active = false

	timer = 0.0





func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:

		hide_notification()




func _on_mouse_entered() -> void:

	_stop_timer()



func _on_mouse_exited() -> void:

	_start_timer()




func _process(delta: float) -> void:

	if timer_active:
		
		timer -= delta

		if timer <= 0.0:

			hide_notification()

