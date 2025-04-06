extends Node
class_name MinigameController

## count for all the active Minigames, needs to increase per completed door
@export var count_minigame: int = 1 
var controller: MinigameController
var current_minigame: Minigame
var minigames: Dictionary = {}
var sequence_minigames: Array = []
var queue_minigames: Array = []
signal all_minigames_finished

func _ready() -> void:
	controller = self
	for child in get_children():
		if child is Minigame:
			minigames[child.name.to_lower()] = child
			child.minigame_finished.connect(on_child_finished) # listenes to child signal
			controller.remove_child(child) # deactivates scenes but not deletes

# create random Sequence with the names of all exisiting Minigames, that is fixed for the whole run
	sequence_minigames = minigames.keys()
	randomize()
	sequence_minigames.shuffle()
	

func _process(delta: float) -> void:
	if current_minigame:
		current_minigame.update(delta)

func _physics_process(delta: float) -> void:
	if current_minigame:
		current_minigame.physics_update(delta)

func start_minigame(minigame):
	minigame.enter()
	print("added minigame: ", minigame.name)
	controller.add_child(minigame) # out of memory

func stop_minigame(minigame):
	minigame.exit()
	print("removed minigame: ", minigame.name)
	controller.remove_child(minigame) # deactivates scenes but not deletes
	current_minigame = null
	
func start_all_minigames(current_count_minigame = 1):
	count_minigame = current_count_minigame
	var idx = 0
	for i in range(count_minigame):
		queue_minigames.append(sequence_minigames[idx])  
		idx += 1
		if idx >= len(sequence_minigames):
			idx = 0
	# start first minigame
	if !queue_minigames.is_empty():
		current_minigame = minigames.get(queue_minigames[0].to_lower())
		start_minigame(current_minigame)

func stop_all_minigames():
	if current_minigame:
		stop_minigame(current_minigame)

func on_child_finished(minigame):
	if minigame != current_minigame:
		return
	queue_minigames.remove_at(0) # removes first minigame from Queue
	if queue_minigames.is_empty():
		stop_minigame(minigame)
		print("! Minigames DONE !")
		all_minigames_finished.emit()
		return # all minigame are done
	var new_minigame = minigames.get(queue_minigames[0].to_lower())
	if !new_minigame:
		return	

	# Clean up previous minigame
	if current_minigame:
		stop_minigame(current_minigame)
	# Initialize new minigame
	start_minigame(new_minigame)
	current_minigame = new_minigame

	
