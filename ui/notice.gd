class_name Notice extends Overlay


signal notice_ended(notice: Notice)


@export var primary_label: Label

@export var secondary_label: Label

@export var secondary_label_section: VBoxContainer

@export var animation_player: AnimationPlayer


var timer:= 0.0


func _ready() -> void:

	animation_player.animation_finished.connect(_on_animation_finished)



func set_text(primary: String, secondary:= ""):

	primary_label.text = primary

	if secondary == "":

		secondary_label_section.hide()

	else:

		secondary_label.text = secondary

		secondary_label_section.show()





func _start_timer() -> void:

	timer = 3.0


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

	if timer > 0.0:

		timer -= delta

		if timer <= 0.0:

			_end_timer()