extends Node
@onready var minigame_controller: MinigameController = $MinigameController


func _ready() -> void:
	print("start aaaa")
	minigame_controller.start_all_minigames()
