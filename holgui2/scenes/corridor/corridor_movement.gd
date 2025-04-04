extends Node3D

#//delete me

func _process(delta: float) -> void:
	position.x = position.x - .05
	
	if(position.x <0):
		position.x = 8
