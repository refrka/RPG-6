class_name NewSaveData extends Resource




var instances: Dictionary[int, SaveDataInstance]












func register_instance(instance: SaveDataInstance) -> void:

	var uid = instance.get_uid()

	assert(!instances.has(uid), "Duplicate SaveDataInstance, uid: %s" % uid)

	instances[uid] = instance




func get_instance(uid: int) -> SaveDataInstance:

	assert(instances.has(uid), "SaveDataInstance not found, uid: %s" % uid)

	return instances[uid]