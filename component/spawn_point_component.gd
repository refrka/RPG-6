class_name SpawnPointComponent extends InteractableComponent


@export var spawn_point: SpawnPoint





func _interact() -> bool:

	SetPlayerSpawnPointCommand.run({"spawn_point": spawn_point})

	return false