extends Node2D

var current = 0
var progress = 0
var goal = 10

func _process(delta: float) -> void:
	print(progress)
	%progress.text = str(int(progress/4)) + " / "+ str(goal)
	if(int(progress/4) == goal):
		$"..".win()
	if global_position.y >  get_global_mouse_position().y and current == 0:
		current =1
		progress += 1
	elif global_position.x <  get_global_mouse_position().x and current == 1:
		current = 2
		progress += 1
	elif global_position.y <  get_global_mouse_position().y and current == 2:
		current = 3
		progress += 1
	elif global_position.x >  get_global_mouse_position().x and current == 3:
		current = 0
		progress += 1
