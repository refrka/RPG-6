class_name ComponentRoot extends Node



var entity: EntityNode



func setup(_entity: EntityNode) -> void:

	entity = _entity

	for component in get_children():

		component._setup(entity)






func activate_all() -> void:

	for component in get_children():

		component._activate()





func deactivate_all() -> void:

	for component in get_children():

		component._deactivate()