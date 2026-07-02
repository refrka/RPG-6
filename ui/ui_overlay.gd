class_name UIOverlay extends Control




@export var pause:= false

var active:= false






func _ready() -> void:

	UI.register_overlay(self)








func toggle() -> void:

	if active: _deactivate()

	else: _activate()






func _activate() -> void:

	active = true

	show()

	UI.add_overlay(self)




func _deactivate() -> void:

	active = false

	hide()

	UI.remove_overlay(self)