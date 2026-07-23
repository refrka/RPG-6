class_name DialogueText extends Resource


@export var lines: Array[String]



func get_line(index: int) -> String:

	if lines.size() - 1 < index:

		return ""

	return lines[index]