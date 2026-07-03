class_name NotificationOverlay extends UIOverlay



signal hide_finished


@export var notification_panel: MarginContainer

@export var message_label: Label

@export var animation_player: AnimationPlayer


var timer_active:= false

var timer:= 0.0



func _ready() -> void:

	animation_player.animation_finished.connect(_on_animation_finished)

	notification_panel.gui_input.connect(_on_gui_input)

	notification_panel.mouse_entered.connect(_on_mouse_entered)

	notification_panel.mouse_exited.connect(_on_mouse_exited)




func set_message(message: String) -> void:

	message_label.text = message




func show_notification() -> void:

	animation_player.play("show")





func hide_notification() -> void:

	_stop_timer()

	animation_player.play("hide")





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



func _on_animation_finished(anim_name: String) -> void:

	if anim_name == "hide":

		hide_finished.emit()

	elif anim_name == "show":

		_start_timer()




func _process(delta: float) -> void:

	if timer_active:
		
		timer -= delta

		if timer <= 0.0:

			hide_notification()



