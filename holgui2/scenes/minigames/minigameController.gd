extends Node
class_name MinigameController

@export var count_minigame: int = 3 
var controller: MinigameController
var current_minigame: Minigame
var minigames: Dictionary = {}
var queue_minigames: Array = []

func _ready() -> void:
	controller = self
	for child in get_children():
		if child is Minigame:
			minigames[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition) # listenes to child signal
			controller.remove_child(child) # deactivates scenes but not deletes

# create Queue
	var temp = minigames.keys()
	var idx = 0
	for i in range(count_minigame):
		queue_minigames.append(temp[idx])  
		idx += 1
		if idx >= len(temp):
			idx = 0
			
# start first minigame on ready, needs to be changed to signal received
	if !queue_minigames.is_empty():
		current_minigame = minigames.get(queue_minigames[0].to_lower())
		start_minigame(current_minigame)
			
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
	
func on_child_transition(minigame):
	if minigame != current_minigame:
		return
	queue_minigames.remove_at(0) # removes first minigame from Queue
	if queue_minigames.is_empty():
		stop_minigame(minigame)
		print("! Minigames DONE !")
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
