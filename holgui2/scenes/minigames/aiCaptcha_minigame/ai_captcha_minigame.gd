extends Minigame 
class_name AiCaptcha

@onready var goalArrows = [$Arrow1, $Arrow2, $Arrow3, $Arrow4, $Arrow5, $Arrow6, $Arrow7, $Arrow8]
@onready var playerArrows = [$Node2D/Arrow1, $Node2D/Arrow2, $Node2D/Arrow3, $Node2D/Arrow4, $Node2D/Arrow5, $Node2D/Arrow6, $Node2D/Arrow7, $Node2D/Arrow8]

var rng = RandomNumberGenerator.new()
var targetArrow 
var playerArrow

func _ready() -> void:
	initialiseArrows()
	pass
	
#gets called when player is in win area from HotwirePlayer
func win():
	minigame_finished.emit(self)
	pass

func physics_update(_delta: float) -> void:
	pass


func initialiseArrows() -> void:
	hide_all()
	targetArrow = randi_range(0, goalArrows.size()-1)
	goalArrows[targetArrow].visible = true
	playerArrow = (targetArrow + randi_range(3,6)) % playerArrows.size()-1
	playerArrows[playerArrow].visible = true

func hide_all():
	for arrow in goalArrows:
		arrow.visible = false
	for arrow in playerArrows:
		arrow.visible = false


func _on_turn_right_button_up() -> void:
	playerArrows[playerArrow].visible = false
	playerArrow += 1
	if(playerArrow < 0):
		playerArrow = playerArrows.size()-1
	if(playerArrow > playerArrows.size()-1):
		playerArrow = 0
	playerArrows[playerArrow].visible = true
	pass # Replace with function body.


func _on_turn_left_button_up() -> void:
	playerArrows[playerArrow].visible = false
	playerArrow += -1
	if(playerArrow < 0):
		playerArrow = playerArrows.size()-1
	if(playerArrow > playerArrows.size()-1):
		playerArrow = 0
	playerArrows[playerArrow].visible = true
	pass # Replace with function body.


func _on_submit_button_up() -> void:
	if(targetArrow == playerArrow):
		minigame_finished.emit(self)
	initialiseArrows()
	pass # Replace with function body.
