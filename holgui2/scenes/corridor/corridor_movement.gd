extends Node3D

#//delete me
var speed = .02

func _process(delta: float) -> void:
	position.x = position.x - speed
	
	if(position.x <0):
		position.x = 8
