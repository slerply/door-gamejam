extends Node

@onready var camera_3d: Camera3D = $Camera3D

@export var speed: float = 2

var is_moving: bool = true

func _process(delta: float) -> void:
	if is_moving:
		camera_3d.position.x += speed * delta

func toggle_movement() -> void:
	is_moving = !is_moving
