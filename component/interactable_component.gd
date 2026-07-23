class_name InteractableComponent extends Component






@export var duration:= 0.0

@export var interaction_conditionals: Array[ConditionalCommandSet]


# Interaction examples:

# 1. Push button, light turns on (no duration, no dialogue)

# 2. Push (hold) rusty button, light turns on (duration, no dialogue)

# 3. Either 1. or 2. with a dialogue overlay popup (duration/no duration, dialogue)

# 4. 1., 2., or 3. 





func _interact() -> bool:

	for conditional_command_set in interaction_conditionals:

		conditional_command_set.execute_commands({"entity_node": entity})

	return true




func _can_interact() -> bool:

	return true




