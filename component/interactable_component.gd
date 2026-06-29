class_name InteractableComponent extends Component



signal end_requested



enum InteractionType {

	INSTANT,

	TOGGLE,

	HOLD,

}

@export var type: InteractionType

@export var duration:= 0.0











func interact() -> bool:

	var panel = UI.open_dialogue(entity)

	panel.close_requested.connect(_on_close_requested)

	return true





func complete() -> void:

	end()





func end() -> void:
	
	UI.close_dialogue()













func _on_close_requested() -> void:

	end_requested.emit()