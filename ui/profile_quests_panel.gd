class_name ProfileQuestsPanel extends MarginContainer



@onready var quest_list_button_scene:= preload("res://ui/profile_quest_list_button.tscn")

@onready var stage_info_scene:= preload("res://ui/profile_quest_stage_info.tscn")

@export var active_quest_list: VBoxContainer

@export var stage_info_list: VBoxContainer

@export var quest_list_panel: MarginContainer

@export var quest_info_panel: MarginContainer

@export var back_to_quest_list_button: Button







func _ready() -> void:

	back_to_quest_list_button.pressed.connect(_on_back_to_quest_list_pressed)




func show_quest_list() -> void:

	quest_list_panel.visible = true

	quest_info_panel.visible = false

	_load_active_quests()




func show_quest_info(quest_data: QuestData = null) -> void:

	_clear_stage_info_list()

	quest_list_panel.visible = false

	quest_info_panel.visible = true

	var quest_def = Quests.get_quest_def(quest_data.quest_id)

	for i in range(quest_def.stages.size()):

		var stage_info = stage_info_scene.instantiate()

		stage_info_list.add_child(stage_info)
		
		stage_info.load_stage_info(quest_data, i)







func _load_active_quests() -> void:

	_clear_active_quests()

	var save_data = Game.get_save_data()

	for quest_data in save_data.quest_data_list:

		if quest_data.get_state() == QuestData.QuestState.ACTIVE or quest_data.get_state() == QuestData.QuestState.READY	:

			var quest_def = Quests.get_quest_def(quest_data.quest_id)

			var button = quest_list_button_scene.instantiate()
			
			button.pressed.connect(_on_quest_button_pressed.bind(quest_data))

			button.text = quest_def.title

			active_quest_list.add_child(button)




func _clear_active_quests() -> void:

	for child in active_quest_list.get_children():

		child.queue_free()



func _clear_stage_info_list() -> void:

	for child in stage_info_list.get_children():

		child.queue_free()





func _activate() -> void:

	visible = true

	_load_active_quests()




func _deactivate() -> void:

	visible = false





func _on_quest_button_pressed(quest_data: QuestData) -> void:

	show_quest_info(quest_data)



func _on_back_to_quest_list_pressed() -> void:

	show_quest_list()