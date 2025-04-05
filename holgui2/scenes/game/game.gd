extends Node

@onready var corridor_spawner: Node = $CorridorSpawner
@onready var player: Node = $Player
@onready var minigame_controller: MinigameController = $MinigameController

var total_minigames: int = 6

func _ready() -> void:
	corridor_spawner.init_minigame.connect(init_minigame)

func init_minigame() -> void:
	player.toggle_movement()
	# start minigame
	minigame_controller.start_all_minigames(total_minigames)
