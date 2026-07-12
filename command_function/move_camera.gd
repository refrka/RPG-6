class_name MoveCamera extends CommandFunction



@export var target_pos: Vector2

@export var target_zoom: float

@export var fade:= false




func execute(_data: Dictionary = {}) -> bool:

	super(_data)

	var camera = Game.get_camera()

	var tween = Game.get_tree().create_tween()

	tween.tween_property(camera, "global_position", target_pos, 5.0)

	await tween.finished

	command_executed.emit()

	return true