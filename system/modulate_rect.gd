class_name ModulateRect extends ColorRect




@export var animation_player: AnimationPlayer





func _ready() -> void:

	animation_player.animation_finished.connect(_on_animation_finished)





func fade_out(new_color:= Color.BLACK) -> void:

	color = new_color

	animation_player.play("fade_out")





func fade_in() -> void:

	animation_player.play("fade_in")





func _on_animation_finished(anim_name: StringName) -> void:

	pass