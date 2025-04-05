extends Node

signal minigames_finished
var temp_timer: float
var number_of_minigames = 1

func _ready():
	print("GAME ready")
	_init_timer()
	
func _process(_delta: float) -> void:
	# check if regen interval ran out
	if temp_timer > 0:
		temp_timer -= _delta
	elif temp_timer <= 0:
		minigames_finished.emit()
		_init_timer()

func _init_timer() -> void:
	temp_timer = 10
