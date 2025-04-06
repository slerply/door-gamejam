extends Control

#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	#animated_sprite_2d.play("default")
	pass

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/intro_scene/intro_scene.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu/options_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
