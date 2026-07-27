class_name DurationEffect extends Effect



@export var duration:= 0.0

@export var tick_rate:= 0.0

var timer:= 0.0

var last_tick:= 0.0





func _initialize(_target_entity: EntityNode) -> void:

	super(_target_entity)

	_start()




func _start() -> void:

	if duration == 0.0:

		expired.emit()

		return

	active = true

	timer = duration

	last_tick = duration





func _tick() -> void:

	last_tick = last_tick - tick_rate




func _process(delta: float) -> void:

	if !active:

		return

	if timer > 0.0:

		timer -= delta

		if last_tick - timer >= tick_rate:

			_tick()

		if timer <= 0.0:

			expired.emit(self)

			print("expired")

