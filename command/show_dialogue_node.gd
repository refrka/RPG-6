class_name ShowDialogueNode extends Command


@export var dialogue_node: DialogueNode



func execute(data: Dictionary = {}) -> bool:

	if data.has("dialogue_node"):

		dialogue_node = data["dialogue_node"]

	Dialogue.load_dialogue_node(dialogue_node)

	return true