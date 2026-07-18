class_name Notice extends Overlay



@export var title_label: Label

@export var secondary_label: Label

@export var animation_player: AnimationPlayer

@export var input_mask: InputMask


var timer:= 0.0




func _ready() -> void:

	input_mask.gui_input_received.connect(_on_gui_input_received)

	animation_player.animation_finished.connect(_on_animation_finished)




func _activate() -> void:

	super()

	animation_player.play("show")




func set_notice_text(title: String, secondary: String) -> void:

	title_label.text = title

	secondary_label.text = secondary





func end() -> void:

	timer = 0.0

	animation_player.play("hide")





func _start_timer() -> void:

	timer = 1.5



func _end_timer() -> void:

	end()





func _on_gui_input_received(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed():

		end()




func _on_animation_finished(anim_name: StringName) -> void:

	if anim_name == "show":

		_start_timer()


	elif anim_name == "hide":

		UI.remove_overlay(self)

		queue_free.call_deferred()






func _process(delta: float) -> void:

	if timer > 0.0:

		timer -= delta

		if timer <= 0.0:

			_end_timer()