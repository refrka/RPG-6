extends Node




var subscriptions: Dictionary[Script, Array]





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	subscribe(GameEndingEvent, _on_game_ending)




func subscribe(event_script: Script, callback: Callable) -> void:

	if !subscriptions.has(event_script):

		subscriptions[event_script] = []

	if !subscriptions[event_script].has(callback):

		subscriptions[event_script].append(callback)




func unsubscribe(event_script: Script, callback: Callable) -> void:

	if subscriptions.has(event_script) and subscriptions[event_script].has(callback):

		subscriptions[event_script].erase(callback)

		if subscriptions[event_script].is_empty():

			subscriptions.erase(event_script)





func fire(event_script: Script, _data: Dictionary = {}, with_notice:= false) -> void:

	var event = event_script.new()

	event.fire(_data, with_notice)

	call_subscriptions(event)





func call_subscriptions(event: Event) -> void:

	if subscriptions.has(event.get_script()):

		for callback in subscriptions[event.get_script()]:

			if callback.is_valid():

				callback.call(event)








func _on_game_ending(event: Event) -> void:

	for script in subscriptions:

		if script.get_base_script() != SystemEvent:

			subscriptions.erase(script)