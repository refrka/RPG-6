class_name InteractableComponent extends Component



signal interaction_ended



@export var duration:= 0.0

@export var interaction_conditionals: Array[ConditionalCommandSet]

@export var dialogue_library: DialogueLibrary

@export var can_barter:= false


# Interaction examples:

# 1. Push button, light turns on (no duration, no dialogue)

# 2. Push (hold) rusty button, light turns on (duration, no dialogue)

# 3. Either 1. or 2. with a dialogue overlay popup (duration/no duration, dialogue)

# 4. 1., 2., or 3. 





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_DISABLED




func _execute() -> void:

	for conditional_command_set in interaction_conditionals:

		conditional_command_set.execute_commands({"entity_node": entity})

	var dialogue_nodes = Dialogue.get_dialogue_nodes(entity)

	if !dialogue_nodes.is_empty():

		Dialogue.dialogue_ended.connect(_on_dialogue_ended, CONNECT_ONE_SHOT)

		Dialogue.start_dialogue(dialogue_nodes, entity)





## Return true when duration is required
func _interact() -> bool:

	return duration > 0.0





func _end() -> void:

	Dialogue.end_dialogue()






func _can_interact() -> bool:

	return true



func _can_end() -> bool:

	var dialogue_panel = UI.get_overlay(DialoguePanel)

	if dialogue_panel and dialogue_panel.is_awake():

		return true

	return false




func _on_dialogue_ended() -> void:

	interaction_ended.emit()