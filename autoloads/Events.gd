extends Node




var subscriptions: Dictionary[Script, Array]




func subscribe(event_script: Script, callback: Callable) -> void:

	if !subscriptions.has(event_script):

		subscriptions[event_script] = []

	if !subscriptions.has(callback):

		subscriptions[event_script].append(callback)






func fire(event_script: Script, _data: Dictionary = {}) -> void:

	var event = event_script.new()

	event.fire(_data)

	call_subscriptions(event)





func call_subscriptions(event: Event) -> void:

	if subscriptions.has(event.get_script()):

		for callback in subscriptions[event.get_script()]:

			if callback.is_valid():

				callback.call(event.data)