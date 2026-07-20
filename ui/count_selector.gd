class_name CountSelector extends Overlay


signal count_submitted(count: float)


@export var current_amount_label: Label

@export var min_amount_label: Label

@export var max_amount_label: Label

@export var count_slider: HSlider

@export var submit_button: Button




func _ready() -> void:

	gui_input.connect(_on_gui_input)

	submit_button.pressed.connect(_on_submit_pressed)

	count_slider.value_changed.connect(_on_count_changed)

	current_amount_label.text = "0"



func set_count(min_count: float, max_count: float) -> void:

	count_slider.min_value = min_count

	count_slider.max_value = max_count

	min_amount_label.text = str(min_count)

	max_amount_label.text = str(max_count)



func _on_submit_pressed() -> void:

	count_submitted.emit(count_slider.value)

	UI.remove_overlay(self)



func _on_count_changed(value: float) -> void:

	current_amount_label.text = str(value)




func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed():

		UI.remove_overlay(self)