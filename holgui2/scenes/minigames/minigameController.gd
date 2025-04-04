extends Node
class_name MiniGameController

@export var initial_minigame: Minigame
var current_minigame: Minigame
var minigames: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is Minigame:
			minigames[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)

	if initial_minigame:
		initial_minigame.enter()
		current_minigame = initial_minigame
			
func _process(delta: float) -> void:
	if current_minigame:
		current_minigame.update(delta)

func _physics_process(delta: float) -> void:
	if current_minigame:
		current_minigame.physics_update(delta)

func on_child_transition(minigame, new_minigame_name):
	if minigame != current_minigame:
		return
		
	var new_minigame = minigame.get(new_minigame_name.to_lower())
	if !new_minigame:
		return	
	
	# Clean up previous state
	if current_minigame:
		current_minigame.exit()
	
	# Initialize new state
	new_minigame.enter()
	current_minigame = new_minigame
