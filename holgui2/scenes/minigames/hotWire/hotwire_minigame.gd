extends Minigame 
class_name Hotwire

#gets called when player is in win area from HotwirePlayer
func win():
	minigame_finished.emit(self)
	pass
