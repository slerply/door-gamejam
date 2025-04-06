extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $Node2D/AnimatedSprite2D


func _ready() -> void:
	animation_player.play("intro_anim")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("anim ", anim_name, " finished")
	#animated_sprite_2d.play("default")
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _on_skip_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")
