class_name CountSelector extends Overlay


signal count_submitted(count: float)


@export var title_label: Label

@export var title_section: VBoxContainer

@export var current_amount_label: Label

@export var min_amount_label: Label

@export var max_amount_label: Label

@export var count_slider: HSlider

@export var submit_button: Button




var use_float:= true

var min_count: float

var max_count: float

var title: String


func _ready() -> void:

	gui_input.connect(_on_gui_input)

	submit_button.pressed.connect(_on_submit_pressed)

	count_slider.value_changed.connect(_on_count_changed)

	current_amount_label.text = "0"

	if title == "":

		title_section.hide()




func set_title(_title: String) -> void:

	title = _title

	title_section.show()

	title_label.text = title




func set_count(_min_count: float, _max_count: float, _use_float:= true) -> void:

	use_float = _use_float

	min_count = _min_count

	max_count = _max_count

	count_slider.min_value = min_count

	count_slider.max_value = max_count

	_update_min_max_labels()





func _update_min_max_labels() -> void:

	if !use_float:

		min_amount_label.text = str(int(min_count))

		max_amount_label.text = str(int(max_count))

	else:

		min_amount_label.text = str(min_count)

		max_amount_label.text = str(max_count)




func _update_selected_count_label() -> void:

	var value = count_slider.value

	if !use_float:

		current_amount_label.text = str(int(value))

	else:

		current_amount_label.text = str(value)





func _on_submit_pressed() -> void:

	count_submitted.emit(count_slider.value)

	UI.remove_overlay(self)



func _on_count_changed(value: float) -> void:

	_update_selected_count_label()




func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.is_pressed():

		UI.remove_overlay(self)