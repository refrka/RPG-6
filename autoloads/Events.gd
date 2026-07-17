extends Node




var subscriptions: Dictionary[Script, Array]



func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS




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





func fire(event_script: Script, _data: Dictionary = {}) -> void:

	var event = event_script.new()

	event.fire(_data)

	call_subscriptions(event)





func call_subscriptions(event: Event) -> void:

	var script = event.get_script()

	if subscriptions.has(script):

		var subs = subscriptions.duplicate()

		for callback in subs[script]:

			if callback.is_valid():

				callback.call(event)
				
			else:

				subscriptions[script].erase(callback)