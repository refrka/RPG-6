class_name Notice extends Overlay


signal notice_ended(notice: Notice)


@export var primary_label: Label

@export var secondary_label: Label

@export var secondary_label_section: VBoxContainer

@export var animation_player: AnimationPlayer

@export var input_mask: InputMask


var timer_active:= false

var timer:= 0.0


func _ready() -> void:

	animation_player.animation_finished.connect(_on_animation_finished)

	input_mask.gui_input_received.connect(_on_gui_input_received)

	input_mask.mouse_entered.connect(_on_mouse_entered)

	input_mask.mouse_exited.connect(_on_mouse_exited)



func set_text(primary: String, secondary:= ""):

	primary_label.text = primary

	if secondary == "":

		secondary_label_section.hide()

	else:

		secondary_label.text = secondary

		secondary_label_section.show()





func _start_timer() -> void:

	timer_active = true

	timer = 1.5


func _pause_timer() -> void:

	timer_active = false


func _resume_timer() -> void:

	timer_active = true



func _end_timer() -> void:

	notice_ended.emit(self)

	timer = 0.0

	animation_player.play("hide")





func _on_animation_finished(anim_name: StringName) -> void:

	if anim_name == "show":

		_start_timer()

	elif anim_name == "hide":

		queue_free()



	
func _process(delta: float) -> void:

	if !timer_active:

		return

	if timer > 0.0:

		timer -= delta

		if timer <= 0.0:

			_end_timer()





func _on_gui_input_received(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed():

		_end_timer()





func _on_mouse_entered() -> void:

	_pause_timer()


func _on_mouse_exited() -> void:

	_resume_timer()