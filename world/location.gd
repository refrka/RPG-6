class_name Location extends Node2D





@export var location_id: StringName


@export_group("Node References")

@export var character_root: Node2D

@export var object_root: Node2D



var initialized:= false





# Location life-cycle steps

# - Loading/initializing

# - Activation

# - Pause/resume

# - Deactivation/Unloading







func _initialize() -> bool:

	if initialized:

		return false

	initialized = true

	return true








func pause() -> void:

	process_mode = Node.PROCESS_MODE_DISABLED





func resume() -> void:

	process_mode = Node.PROCESS_MODE_INHERIT