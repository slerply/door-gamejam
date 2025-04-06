extends Minigame
class_name Numpad

var numbers = ["1","2","3","4","5","6","7","8","9"]
var buttons
var amount_of_correct = 0
var last_pressed_number = 0

func _ready():
	enter()

func _process(delta: float):
	physics_update(delta)
	
func enter():
	buttons = [
		$Button,
		$Button2,
		$Button3,
		$Button4,
		$Button5,
		$Button6,
		$Button7,
		$Button8,
		$Button9
	]
	numbers.shuffle()
	for x in 9:
		buttons[x].text = numbers[x]
		buttons[x].pressed.connect(_on_button_pressed.bind(numbers[x]))
	
func _on_button_pressed(button):
	last_pressed_number =  int(button)
	if last_pressed_number != amount_of_correct + 1:
		print(last_pressed_number)
		amount_of_correct = 0
		last_pressed_number = 0
		$ColorRect.color = Color.RED
	elif last_pressed_number == amount_of_correct + 1:
		amount_of_correct += 1
		print("right")
		$ColorRect.color = Color.GREEN

func physics_update(_delta: float):
	if amount_of_correct == 9:
		minigame_finished.emit(self)
