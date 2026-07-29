class_name SwitchComponent extends InteractableComponent




@export var off_on_frames:= Vector2i(0,1)

@export var on:= false

@export var locked:= false

@export var unlock_condition_set: ConditionSet

@export var linked_feature: Feature




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_DISABLED





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	_update_linked_entities()





func _interact() -> bool:

	if !locked:

		_toggle()

	return false




func _update_linked_entities() -> void:

	if linked_feature:

		if on:	linked_feature._activate()

		else:	linked_feature._deactivate()

		





func _toggle() -> void:

	on = !on

	if on:

		entity.body_sprite.frame = off_on_frames.y

	else:

		entity.body_sprite.frame = off_on_frames.x

	_update_linked_entities()





func _activate() -> void:

	_update_linked_entities()