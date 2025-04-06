extends Minigame
class_name Numpad

var numbers = ["1","2","3","4","5","6"]
var buttons
var amount_of_correct = 0
var last_pressed_number = 0

#func _ready():
	#enter()
#
#func _process(delta: float):
	#physics_update(delta)
	
func _ready():
	assign_numbers()

func assign_numbers():
	buttons = [
		$Button,
		$Button2,
		$Button3,
		$Button4,
		$Button5,
		$Button6
	]
	numbers.shuffle()
	for x in buttons.size():
		buttons[x].text = numbers[x]
		buttons[x].pressed.connect(_on_button_pressed.bind(buttons[x]))
	
func _on_button_pressed(button):
	last_pressed_number =  int(button.text)
	print(last_pressed_number)
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
	if amount_of_correct == buttons.size():
		assign_numbers()
		amount_of_correct = 0
		last_pressed_number = 0
		minigame_finished.emit(self)
