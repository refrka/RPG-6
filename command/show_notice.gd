class_name ShowNotice extends Command


@export var title: String

@export var secondary: String




func execute(_data: Dictionary = {}) -> bool:

	if _data.has("title"):

		title = _data["title"]

	if _data.has("secondary"):

		secondary = _data["secondary"]

	UI.show_notice(title, secondary)

	return true





static func run(_data: Dictionary) -> bool:

	var command = ShowNotice.new()

	return command.execute(_data)