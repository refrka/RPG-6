class_name DebugShitPanel extends Overlay




@export var control_panel: MarginContainer

@export var entity_info_panel: MarginContainer

@export var toggle_control_panel_button: Button

@export var toggle_entity_info_button: Button

@export var control_panel_hidden_label: Label

@export var entity_info_hidden_label: Label





@export var item_def_list: ItemDefList

@export var item_count_entry: LineEdit

@export var add_item_button: Button

@export var remove_item_button: Button

@export var location_id_list: OptionButton

@export var spawn_id_list: OptionButton

@export var move_button: Button

@export var move_and_set_spawn_button: Button




@export var entity_name_label: Label

@export var no_entity_selected_label: Label

@export var entity_state_label: Label

@export var playback_state_label: Label

@export var root_state_label: Label





var selected_entity: EntityNode




func _ready() -> void:

	Debug.debug_shit_panel = self

	Debug.debug_mask_selected.connect(_on_debug_mask_selected)

	Debug.debug_mask_deselected.connect(_on_debug_mask_deselected)


	_toggle_control_panel(true)

	_toggle_entity_info_panel(false)


	toggle_control_panel_button.pressed.connect(_on_toggle_control_panel_pressed)

	toggle_control_panel_button.mouse_entered.connect(_on_mouse_hovered_control_panel_toggle.bind(true))

	toggle_control_panel_button.mouse_exited.connect(_on_mouse_hovered_control_panel_toggle.bind(false))

	toggle_entity_info_button.pressed.connect(_on_toggle_entity_info_pressed)

	toggle_entity_info_button.mouse_entered.connect(_on_mouse_hovered_entity_info_toggle.bind(true))

	toggle_entity_info_button.mouse_exited.connect(_on_mouse_hovered_entity_info_toggle.bind(false))


	add_item_button.pressed.connect(_on_add_pressed)

	remove_item_button.pressed.connect(_on_remove_pressed)


	location_id_list.item_selected.connect(_on_location_id_selected)

	location_id_list.select(0)

	location_id_list.item_selected.emit(0)


	location_id_list.get_popup().add_theme_constant_override("v_separation", 16)

	spawn_id_list.get_popup().add_theme_constant_override("v_separation", 16)


	move_button.pressed.connect(_on_move_pressed)

	move_and_set_spawn_button.pressed.connect(_on_move_and_set_spawn_pressed)


	entity_name_label.hide()

	no_entity_selected_label.show()







func _toggle_control_panel(state: bool) -> void:

	control_panel_hidden_label.hide()

	if state == false:

		control_panel.hide()

		toggle_control_panel_button.text = ">"

	else:

		control_panel.show()

		toggle_control_panel_button.text = "<"





func _toggle_entity_info_panel(state: bool) -> void:

	entity_info_hidden_label.hide()

	if state == false:

		entity_info_panel.hide()

		toggle_entity_info_button.text = "<"

	else:

		entity_info_panel.show()

		toggle_entity_info_button.text = ">"









func _show_entity_info(entity_node: EntityNode) -> void:

	if selected_entity:

		_disconnect_entity_signals()

	selected_entity = entity_node

	no_entity_selected_label.hide()

	entity_name_label.show()

	entity_name_label.text = entity_node.get_display_name()

	var animation_component = entity_node.get_component(AnimationComponent)

	var root_playback = animation_component.get_state_playback("root")

	var current_root_state = root_playback.get_current_node()

	root_state_label.text = current_root_state

	var current_playback = animation_component.anim_tree.get("parameters/RootState/%s/playback" % current_root_state)

	playback_state_label.text = current_playback.get_current_node()

	_connect_entity_signals()

	_toggle_entity_info_panel(true)




func _clear_entity_info() -> void:

	_toggle_control_panel(false)










func _connect_entity_signals() -> void:

	var animation_component = selected_entity.get_component(AnimationComponent)
	
	animation_component.playback_state_changed.connect(_on_entity_playback_state_changed)

	animation_component.root_state_changed.connect(_on_entity_root_state_changed)

	selected_entity.state_machine.state_changed.connect(_on_entity_state_changed)



func _disconnect_entity_signals() -> void:

	var animation_component = selected_entity.get_component(AnimationComponent)
	
	animation_component.playback_state_changed.disconnect(_on_entity_playback_state_changed)

	selected_entity.state_machine.state_changed.disconnect(_on_entity_state_changed)












func _on_toggle_control_panel_pressed() -> void:

	_toggle_control_panel(!control_panel.visible)



func _on_toggle_entity_info_pressed() -> void:

	_toggle_entity_info_panel(!entity_info_panel.visible)



func _on_mouse_hovered_control_panel_toggle(state: bool) -> void:

	if !control_panel.visible:

		if state == true:

			control_panel_hidden_label.show()

		else:

			control_panel_hidden_label.hide()



func _on_mouse_hovered_entity_info_toggle(state: bool) -> void:

	if !entity_info_panel.visible:

		if state == true:

			entity_info_hidden_label.show()

		else:

			entity_info_hidden_label.hide()




func _on_add_pressed() -> void:

	var item_id: String = item_def_list.get_item_metadata(item_def_list.selected)

	if item_id == "":

		return

	if !item_count_entry.text.is_valid_int():

		return

	var item_def = Items.get_item_def(item_id)

	if !item_def:

		return

	var count = int(item_count_entry.text)

	Game.get_player().inventory.add_items(item_def, count)

	

func _on_remove_pressed() -> void:

	var item_id: String = item_def_list.get_item_metadata(item_def_list.selected)

	if item_id == "":

		return

	if !item_count_entry.text.is_valid_int():

		return

	var item_def = Items.get_item_def(item_id)

	if !item_def:

		return

	var count = int(item_count_entry.text)

	Game.get_player().inventory.remove_items(item_def, count)




func _on_location_id_selected(index: int) -> void:

	spawn_id_list.clear()

	var location_id = location_id_list.get_item_text(index)

	var location = Scenes.get_location_scene(location_id) as Location

	var spawn_points = location.get_all_spawn_points()

	for spawn_point in spawn_points:

		spawn_id_list.add_item(spawn_point.spawn_id)

	location.free()



func _on_move_pressed() -> void:

	if !Game.is_active():

		return

	var location_id = location_id_list.get_item_text(location_id_list.selected)

	var spawn_id = spawn_id_list.get_item_text(spawn_id_list.selected)

	var active_location = Scenes.get_world_scene().get_active_location()

	var player = Game.get_player()

	if active_location.location_id == location_id:

		var spawn_point = active_location.get_spawn_point(spawn_id)

		player.reposition(spawn_point.global_position)

	else:

		Game.hold_player_node()

		var world_scene = Scenes.get_world_scene()

		world_scene.active_location.remove_entity_node(player)

		var location = Scenes.load_location(location_id)

		location.spawn_entity_node(player, spawn_id)



func _on_move_and_set_spawn_pressed() -> void:

	if !Game.is_active():

		return

	_on_move_pressed()

	var location_id = location_id_list.get_item_text(location_id_list.selected)

	var spawn_id = spawn_id_list.get_item_text(spawn_id_list.selected)

	var location = Scenes.get_location_scene(location_id)

	SetPlayerSpawnPointCommand.run({"spawn_id": spawn_id, "location": location})




func _on_debug_mask_selected(debug_mask: DebugMask) -> void:

	_show_entity_info(debug_mask.entity)



func _on_debug_mask_deselected() -> void:

	pass



func _on_entity_playback_state_changed(playback: AnimationNodeStateMachinePlayback) -> void:

	playback_state_label.text = playback.get_current_node()



func _on_entity_root_state_changed(playback: AnimationNodeStateMachinePlayback) -> void:

	root_state_label.text = playback.get_current_node()



func _on_entity_state_changed() -> void:

	entity_state_label.text = selected_entity.state_machine.get_current_state().name



