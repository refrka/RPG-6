class_name InteractableComponent extends Component



signal end_requested



enum InteractionType {

	INSTANT,

	TOGGLE,

	HOLD,

}

@export var type: InteractionType

@export var duration:= 0.0


var dialogue_open:= false








func interact() -> bool:

	if entity.def.dialogue_library:

		Events.fire(DialogueStartedEvent, {"entity_node": entity})

		var panel = UI.open_dialogue(entity)

		panel.close_requested.connect(_on_close_requested)

		dialogue_open = true

		return true

	return false





func complete() -> void:

	end()





func end() -> void:

	if dialogue_open:
		
		UI.close_dialogue()





func can_interact() -> bool:

	return true









func _on_close_requested() -> void:

	end_requested.emit()