extends Minigame 
class_name Hotwire

#gets called when player is in win area from HotwirePlayer
func transition():
	print("fin")
	minigame_finished.emit(self)
	pass
