extends Node

@onready var corridor_spawner: Node = $CorridorSpawner
@onready var player: Node = $Player
@onready var minigame_controller: MinigameController = $MinigameController
@onready var scary_handler = $ScaryHandler

# TODO remove when publish -> only temp for development
@onready var deathtimer_label = $Deathtimer

var total_minigames: int = 3

var start_contingent = 2.0#24.0
var bonus_per_minigame = 1.5

var number_minigames = 1 # remove variable from MinigameController
var deathtimer: float

var minigame_started = false
var minigame_finished = false
var dead = false
var score = 0

signal current_deathtimer
signal died

func _ready() -> void:
	corridor_spawner.init_minigame.connect(init_minigame)
	print("GAME ready")
	minigame_controller.connect("all_minigames_finished", _on_all_minigames_finished)
	minigame_controller.connect("minigame_finished", _on_minigame_finished)
	deathtimer = start_contingent

func init_minigame() -> void:
	player.toggle_movement()
	# open door
	print("open door")
	# TODO add animation
	# start minigame
	print("start_all_minigames")
	minigame_controller.start_all_minigames(number_minigames)
	minigame_started = true

func _process(_delta: float) -> void:
	if minigame_started && !dead:
		handle_deathtimer(_delta)

func handle_deathtimer(_delta: float) -> void:
	current_deathtimer.emit(deathtimer)
	deathtimer_label.text = str(deathtimer)
	# reset timer when finished, add one to minigames
	if minigame_finished:
		print("SUCCESS >> ADD MORE")
		number_minigames += 1
		minigame_started = false
		minigame_finished = false
		player.reset()
		corridor_spawner.init_corridor()
		player.toggle_movement()
	# count timer down
	elif deathtimer > 0:
		deathtimer -= _delta
	# emit died when deathtimer runs out
	elif deathtimer <= 0:
		minigame_controller.stop_all_minigames()
		print("YOU DIED")
		died.emit(score)
		dead = true

func _on_all_minigames_finished() -> void:
	minigame_finished = true
	$CorridorSpawner.corridor_count = randi_range(1,10)
	print("on_all_minigames_finished")

func _on_minigame_finished() -> void:
	print("on_minigame_finished")
	deathtimer += bonus_per_minigame
	score += 1
