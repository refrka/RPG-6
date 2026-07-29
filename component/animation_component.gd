class_name AnimationComponent extends Component



@export var anim_player: AnimationPlayer

@export var anim_tree: AnimationTree




func _ready() -> void:

	process_mode = Node.PROCESS_MODE_DISABLED