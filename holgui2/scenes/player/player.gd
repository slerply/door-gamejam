extends Node

@onready var camera_3d: Camera3D = $Camera3D

@export var speed: float = 2

func _process(delta: float) -> void:
	camera_3d.position.x += speed * delta
