class_name InteractionComponent extends Component


@export var sensor: Sensor



var target_entity: EntityNode

var target_interactable_component: InteractableComponent

var interaction_timer:= 0.0







func _initialize(_entity: EntityNode = null) -> void:

	super(_entity)

	sensor.setup(entity)

	sensor.body_entered.connect(_on_body_entered_sensor)

	var input_component = entity.get_component(InputComponent)

	if !input_component:
		
		return

	input_component.interact_pressed.connect(_on_interact_pressed)

	input_component.interact_released.connect(_on_interact_released)






func _try_interaction(_target_entity: EntityNode) -> void:

	if _is_interacting() and target_interactable_component._can_end():

		_end_interaction()

	else:

		var interactable_component = _target_entity.get_component(InteractableComponent)

		if !interactable_component:

			return

		if !interactable_component._can_interact():

			if interactable_component is LootContainerComponent: 
				
				if !interactable_component.can_unlock(entity):

					UI.show_popup(GamePopup.PopupMode.CONTINUE, "This container is locked")

					return

				else:

					interactable_component.set_lock_state(false)

					target_entity = _target_entity

					target_interactable_component = interactable_component

					_start_interaction.call_deferred()

		else:

			target_entity = _target_entity

			target_interactable_component = interactable_component

			_start_interaction.call_deferred()




func _start_interaction() -> void:

	entity.state_machine.request_state(InteractingState)

	target_interactable_component.interaction_ended.connect(_on_interaction_ended, CONNECT_ONE_SHOT)

	if target_interactable_component._interact():

		if target_interactable_component.duration > 0.0:

			interaction_timer = target_interactable_component.duration

		else:

			_end_interaction()

	else:

		_execute_interaction()





func _execute_interaction() -> void:

	target_interactable_component._execute()




func _cancel_interaction() -> void:

	target_interactable_component.interaction_ended.disconnect(_on_interaction_ended)

	_end_interaction()




func _end_interaction() -> void:

	interaction_timer = 0.0

	entity.state_machine.request_state(IdleState)

	target_interactable_component._end()




func _complete_interaction() -> void:

	entity.state_machine.request_state(IdleState)

	target_interactable_component._end()

	interaction_timer = 0.0

	target_entity = null

	target_interactable_component = null




func _pick_up(item_node: DroppedItemNode) -> void:

	var player = Game.get_player()

	player.inventory.add_data(item_node.item_data)

	item_node.pick_up()





func _is_interacting() -> bool:

	return entity.state_machine.get_current_state() is InteractingState










	

func _on_interact_pressed() -> void:

	var _target_entity = sensor.get_nearest_body()

	if !_target_entity:

		return

	if entity.state_machine.get_current_state() is InteractingState:

		var barter_panel = UI.get_overlay(BarterPanel)

		if barter_panel.active:

			barter_panel._close()

		else:

			_end_interaction()

	else:

		_try_interaction(_target_entity)





func _on_interact_released() -> void:

	if interaction_timer > 0.0 and _is_interacting():

		_cancel_interaction()




func _on_interaction_ended() -> void:

	_complete_interaction()




func _on_body_entered_sensor(body: PhysicsBody2D) -> void:

	if body is DroppedItemNode:

		# _pick_up(body)

		pass








func _process(delta: float) -> void:

	if interaction_timer > 0.0:

		target_interactable_component.update_progress_display(interaction_timer)

		interaction_timer -= delta

		if interaction_timer <= 0.0:

			_execute_interaction()