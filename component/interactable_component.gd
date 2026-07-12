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

	return false





func complete() -> void:

	end()





func end() -> void:

	if dialogue_open:
		
		UI.close_interaction_overlay()





func can_interact() -> bool:

	

	return true









func _on_close_requested() -> void:

	end_requested.emit()