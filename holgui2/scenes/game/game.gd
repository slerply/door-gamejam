extends Node

## time interval (in seconds) in which the regen happens
var cooldown_interval = 1.0
## current time cooldown until the next time effects are applied
var cooldown: float

func _ready():
	print("GAME ready")
	_init_cooldown_interval()
	
	
func _process(_delta: float) -> void:
	# check if regen interval ran out
	if cooldown > 0:
		cooldown -= _delta
	elif cooldown <= 0:
		print("cooldown RESET")
		_init_cooldown_interval()
	pass

## reset the cooldown to original interval
func _init_cooldown_interval() -> void:
	cooldown = cooldown_interval
