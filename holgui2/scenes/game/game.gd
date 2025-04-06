extends Node

@onready var corridor_spawner: Node = $CorridorSpawner
@onready var player: Node = $Player
@onready var minigame_controller: MinigameController = $MinigameController

# temp !
@onready var deathtimer_label = $Deathtimer

var total_minigames: int = 3

var number_minigames = 1 # temp; get from minigame controller
var time_per_minigame = 4.0 # in seconds
var deathtimer: float

var minigame_started = false
var minigame_finished = false

func _ready() -> void:
	corridor_spawner.init_minigame.connect(init_minigame)
	print("GAME ready")
	minigame_controller.connect("all_minigames_finished", _on_minigame_finished)
	_init_deathtimer()

func init_minigame() -> void:
	player.toggle_movement()
	# open door
	print("open door")
	#get_tree().change_scene_to_file("res://scenes/game/door_open.tscn")
	#await get_tree().create_timer(1.0).timeout
	# start minigame
	print("start_all_minigames")
	minigame_controller.start_all_minigames(number_minigames)
	minigame_started = true

func _process(_delta: float) -> void:
	if minigame_started:
		handle_deathtimer(_delta)

func handle_deathtimer(_delta: float) -> void:
	deathtimer_label.text = str(deathtimer)
	# reset timer when finished, add one to minigames
	if minigame_finished:
		print("SUCCESS >> ADD MORE")
		number_minigames += 1
		_init_deathtimer()
		minigame_started = false
		minigame_finished = false
		player.reset()
		corridor_spawner.init_corridor()
		player.toggle_movement()
	# count timer down
	elif deathtimer > 0:
		deathtimer -= _delta
	# emit "dead" when deathtimer runs out
	elif deathtimer <= 0:
		# TODO minigame_controller.stop_all_minigames(number_minigames) --> add in MinigameController
		print("YOU DIED")
		get_tree().change_scene_to_file("res://scenes/game/death.tscn")

## reset the cooldown to original interval
func _init_deathtimer() -> void:
	deathtimer_label.text = str(deathtimer)
	deathtimer = (0.8 * number_minigames) * time_per_minigame
	print("_init_deathtimer = ", deathtimer)

func _on_minigame_finished() -> void:
	minigame_finished = true
	print("_on_minigame_finished")
