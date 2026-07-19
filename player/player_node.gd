class_name PlayerNode extends CharacterNode



@export var interact_sensor: Sensor





func _initialize(entity_data: EntityData = null) -> void:

	super(entity_data)

	if entity_data != null and entity_data is PlayerData:

		_load_data(entity_data)

	else:

		data = PlayerData.new()

	Events.fire(PlayerInitializedEvent)





func _setup() -> void:

	super()

	interact_sensor.setup(self)

	var input_component = get_component(InputComponent)

	if !input_component.interact_pressed.is_connected(_on_interact_pressed):

		input_component.interact_pressed.connect(_on_interact_pressed)

	Events.subscribe(PlayerEnteredLocationEvent, _on_player_entered_location)





func get_display_name() -> String:

	var save_data = Game.get_save_data()

	return save_data.save_name






func _on_player_entered_location(event: Event) -> void:

	var location_scene = event.data["location_scene"]

	var location_id = location_scene.location_id

	var spawn_id = event.data["spawn_id"]

	if !data.discovered_locations.has(location_id):

		data.discovered_locations.append(location_id)

		Events.fire(LocationDiscoveredEvent, event.data)

	_update_current_location(location_id, spawn_id)







func _update_current_location(location_id: StringName, spawn_id: StringName) -> void:

	var save_data = Game.get_save_data()

	save_data.current_location_id = location_id

	save_data.current_spawn_id = spawn_id






func _try_interact(target_entity: EntityNode) -> void:

	var root_nodes = Dialogue.get_root_nodes(target_entity)

	var greeting = Dialogue.get_greeting(target_entity, root_nodes)

	if greeting:

		Dialogue.dialogue_finished.connect(_on_dialogue_finished, CONNECT_ONE_SHOT)

		Dialogue.start_dialogue(target_entity, greeting, root_nodes)

	state_machine.request_state(InteractingState)










func _on_interact_pressed() -> void:

	if state_machine.get_current_state() is InteractingState:

		return

	var target = interact_sensor.get_nearest_body()

	if target:

		_try_interact(target)





func _on_dialogue_finished() -> void:

	state_machine.request_state(IdleState)