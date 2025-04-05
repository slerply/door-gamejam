extends Minigame 
class_name Spin


var current = 0
var progress = 0

@onready var middlepoint = $middle
#gets called when player is in win area from HotwirePlayer
func win():
	minigame_finished.emit(self)
	pass

func physics_update(_delta: float) -> void:
	pass
