class_name BusyState extends State





var behavior_component: BehaviorComponent




func _setup(_entity: EntityNode) -> void:

	super(_entity)

	behavior_component = entity.get_component(BehaviorComponent)






func _enter() -> void:

	animation_component.travel_playback("root", "DefaultState")

	if behavior_component:

		behavior_component.pause()





func _exit() -> void:

	if behavior_component:

		behavior_component.resume()