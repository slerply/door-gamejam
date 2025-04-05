extends Node2D

var await_time = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if await_time <= 0:
		get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
	else:
		await_time -= _delta
