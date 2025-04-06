extends Minigame
class_name Aimtrainer

var times_pressed = 0

func _ready():
	enter()
func _process(delta: float):
	physics_update(delta)

func enter():
	$TextureButton.pressed.connect(_on_button_pressed)

func exit():
	pass
	
func update(_delta: float): 
	pass

func physics_update(_delta: float):
	if times_pressed > 5:
		times_pressed = 0
		minigame_finished.emit(self)
		
func _on_button_pressed():
	times_pressed += 1
	setPosition_for_element($TextureButton)
	
func setPosition_for_element(element):
	element.global_position.x = randf_range($minPos.global_position.x, $maxPos.global_position.x)
	element.global_position.y = randf_range($minPos.global_position.y, $maxPos.global_position.y)
