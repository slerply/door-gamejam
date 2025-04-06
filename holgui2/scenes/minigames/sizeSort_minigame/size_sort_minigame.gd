extends Minigame 
class_name SizeSort_minigame

@onready var minPos = $minPos
@onready var maxPos = $maxPos

#gets called when player is in win area from HotwirePlayer
func win():
	randomize_positions()
	minigame_finished.emit(self)
	pass

func physics_update(_delta: float) -> void:
	pass

func _process(delta: float) -> void:
	if($smal.global_position > $smalMid.global_position and $smalMid.global_position > $mid.global_position and $mid.global_position > $midBig.global_position and $midBig.global_position > $big.global_position 
	or $smal.global_position < $smalMid.global_position and $smalMid.global_position < $mid.global_position and $mid.global_position < $midBig.global_position and $midBig.global_position < $big.global_position):
		win()
	

func randomize_positions():
	setPosition_for_element($smal)
	setPosition_for_element($smalMid)
	setPosition_for_element($mid)
	setPosition_for_element($midBig)
	setPosition_for_element($big)
	if($smal.global_position > $smalMid.global_position and $smalMid.global_position > $mid.global_position and $mid.global_position > $midBig.global_position and $midBig.global_position > $big.global_position 
	or $smal.global_position < $smalMid.global_position and $smalMid.global_position < $mid.global_position and $mid.global_position < $midBig.global_position and $midBig.global_position < $big.global_position):
		randomize_positions()
	



func setPosition_for_element(element):
	element.reset()
	element.global_position.x = randf_range(minPos.global_position.x, maxPos.global_position.x)
	element.global_position.y = randf_range(minPos.global_position.y, maxPos.global_position.y)
	
