class_name GameScene extends CanvasItem




var active:= false


func _ready() -> void:

	Scenes.register_scene(self)













func _activate() -> void:

	active = true

	show()




func _deactivate() -> void:

	active = false

	hide()