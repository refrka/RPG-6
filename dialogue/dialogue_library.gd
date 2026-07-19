class_name DialogueLibrary extends Resource




@export var greetings: Array[Greeting]


@export var dialogue_nodes: Array[DialogueNode]






func get_quest_dialogue_nodes(quest_ids: Array[StringName]) -> Array[DialogueNode]:

	var quest_nodes = dialogue_nodes.duplicate()

	quest_nodes = quest_nodes.filter(func(node): return node is QuestDialogueNode and quest_ids.has(node.related_quest_id))

	return quest_nodes



func get_root_dialogue_nodes() -> Array[DialogueNode]:

	var all_nodes = dialogue_nodes.duplicate()

	var root_nodes = all_nodes.filter(func(node): return not node is QuestDialogueNode)

	return root_nodes