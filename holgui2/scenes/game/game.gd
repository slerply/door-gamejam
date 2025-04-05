extends Node

@onready var corridor_spawner: Node = $CorridorSpawner
@onready var player: Node = $Player
@onready var minigame_controller: MinigameController = $MinigameController

var total_minigames: int = 3

func _ready() -> void:
	corridor_spawner.init_minigame.connect(init_minigame)
	print("GAME ready")
	game_controller.connect("minigames_finished", _on_minigame_finished)
	_init_deathtimer()

func init_minigame() -> void:
	player.toggle_movement()
	# start minigame
	minigame_controller.start_all_minigames(total_minigames)
## time interval (in seconds) in which the regen happens
var cooldown_interval = 1.0
## current time cooldown until the next time effects are applied
var cooldown: float

var number_minigames = 1 # temp; get from minigame controller
var time_per_minigame = 2.0 # in seconds
var deathtimer: float

var minigame_finished = false

@onready var game_controller = $GameControllerTemp

# emit "dead", when deathtimer runs out
# reset deathtimer, when 

func _process(_delta: float) -> void:
	# reset timer when finished
	if minigame_finished:
		
		_init_deathtimer()
	# count timer down
	elif deathtimer > 0:
		deathtimer -= _delta
	# emit "dead" when deathtimer runs out
	elif deathtimer <= 0:
		print("ADD MORE")
		number_minigames += 1
		_init_deathtimer()
		print("-> new number of minigames=", number_minigames)
		print("-> deathtimer: ", deathtimer)
	pass

## reset the cooldown to original interval
func _init_deathtimer() -> void:
	deathtimer = (0.8 * number_minigames) * time_per_minigame

func _on_minigame_finished() -> void:
	minigame_finished = true
	print("_on_minigame_finished")
