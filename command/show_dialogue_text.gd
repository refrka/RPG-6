class_name ShowDialogueText extends Command




@export var dialogue_text: DialogueText



func execute(data: Dictionary = {}) -> bool:

	if data.has("dialogue_text"):

		dialogue_text = data["dialogue_text"]

	Dialogue.load_dialogue_text(dialogue_text)

	return true