class_name Command extends Resource


signal executed




func execute(_data: Dictionary = {}) -> bool:

	executed.emit()

	return true






static func run(_data: Dictionary) -> bool:

	return true