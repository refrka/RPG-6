class_name NewLocationScene extends NewGameScene




enum LocationSceneState {

	LOADED,

	INITIALIZED,

	ACTIVE,

}


var location_state: LocationSceneState

var data: LocationData





@export var location_id: StringName

@export var character_root: Node2D

@export var object_root: Node2D

@export var feature_root: Node2D

















