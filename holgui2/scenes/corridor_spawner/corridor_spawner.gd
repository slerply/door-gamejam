extends Node

@export var corridor_count: int = 8
@export var pos_offset: int = 2
const CORRIDOR_1 = preload("res://scenes/corridor/corridor1/corridor1.tscn")
const DOOR = preload("res://scenes/corridor/door/door.tscn")

var corridor_elements = [CORRIDOR_1]
var corridors_instances = []

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	spawn_corridors(corridor_count)

func spawn_corridors(count: int) -> void:
	for i in range(count):
		var r_number = rng.randi_range(0, corridor_elements.size() - 1)
		var random_corridor_element = corridor_elements[r_number]
		spawn_new_corridor(random_corridor_element, pos_offset * i)
	spawn_new_corridor(DOOR, pos_offset * count)
	for i in range(0, corridors_instances.size()):
		set_lighting(i, false)

func clear_old_corridors() -> void:
	# delete all existing corridors
	for corridor in corridors_instances:
		corridor.queue_free()
	corridors_instances.clear()

func spawn_new_corridor(corridor_element, pos: int) -> void:
	# instantiate a new corridors
	#print("spawn new corridor")
	var corridor = corridor_element.instantiate()
	add_child(corridor)
	corridors_instances.append(corridor)
	corridor.position.x = pos + pos_offset

func set_lighting(index: int, visible: bool) -> void:
	if corridors_instances[index].has_method("set_lighting"):
		corridors_instances[index].set_lighting(visible)
