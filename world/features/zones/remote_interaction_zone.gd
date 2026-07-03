class_name RemoteInteractionZone extends Zone


@export var linked_object: ObjectNode

var interactable_component: InteractableComponent



func _ready() -> void:

	sensor.body_entered.connect(_on_body_entered_zone)

	interactable_component = _get_interactable_component(linked_object)






func _get_interactable_component(entity_node: EntityNode) -> InteractableComponent:

	for component in entity_node.get_all_components():

		if component is InteractableComponent:

			return component

	return null




func _on_body_entered_zone(_body: PhysicsBody2D) -> void:

	interactable_component.interact()