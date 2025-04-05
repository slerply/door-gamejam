extends Panel


func _ready():
	$Button.pressed.connect(_on_Button_pressed)

	
func _on_Button_pressed():
	print("Minigame gewonnen!")
	emit_signal("minigame_won")
