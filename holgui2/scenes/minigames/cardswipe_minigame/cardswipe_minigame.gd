extends Minigame
class_name SizeSort_minigame




	
func enter():
	pass
	
func physics_update(_delta: float) -> void:
	pass
	
func win():
	minigame_finished.emit(self)
	pass
