class_name UIOverlay extends Control




@export var pause:= false








func _ready() -> void:

	UI.register_overlay(self)




func _activate() -> void:

	show()




func _deactivate() -> void:

	hide()