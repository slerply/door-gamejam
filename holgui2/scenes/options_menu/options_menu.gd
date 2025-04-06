extends Control

var bus_index
var value
@onready var sound_volume_slider: HSlider = $MarginContainer/VBoxContainer/VBoxContainer2/SoundVolumeSlider

func _ready() -> void:
	bus_index = AudioServer.get_bus_index("Master")
	sound_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_sound_volume_slider_value_changed(_value: float) -> void:
	#value = _value
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(_value))
