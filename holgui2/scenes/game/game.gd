extends Node

@onready var corridor_spawner: Node = $CorridorSpawner
@onready var player: Node = $Player

func _ready() -> void:
	corridor_spawner.init_minigame.connect(init_minigame)

func init_minigame() -> void:
	player.toggle_movement()
	# start minigame
