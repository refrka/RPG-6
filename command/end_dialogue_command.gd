class_name EndDialogueCommand extends Command




func execute(_data: Dictionary = {}) -> bool:

	Dialogue.end_dialogue()

	return super()






static func run(_data: Dictionary) -> bool:

	var command = EndDialogueCommand.new()

	return command.execute(_data)