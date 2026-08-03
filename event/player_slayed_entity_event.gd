class_name PlayerSlayedEntityEvent extends GameEvent






func fire(_data: Dictionary, with_notice:= false) -> void:

	super(_data, with_notice)

	Globals.add_to_count("%s_slain" % data["entity_node"].get_entity_id(), 1)