extends Minigame
class_name Luke_test2D

func enter():
	pass
	
func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		print(self.name.to_lower()," updates")
		Transitioned.emit(self)
