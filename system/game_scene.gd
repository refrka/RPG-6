class_name GameScene extends CanvasItem


enum GameSceneState {

	UNLOADED,

	LOADED,

	ACTIVE,

	INACTIVE,

}




func _ready() -> void:

	Scenes.register_scene(self)







func _activate() -> void:

	show()




func _deactivate() -> void:

	hide()