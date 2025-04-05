extends Node

@onready var corridor_spawner: Node = $CorridorSpawner
@onready var player: Node = $Player

func _ready() -> void:
	corridor_spawner.stop_player.connect(stop_player)

func stop_player() -> void:
	player.toggle_movement()
