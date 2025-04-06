extends Minigame
class_name ConnectWire

@onready var wire_left_1: Button = %WireLeft1
@onready var wire_left_2: Button = %WireLeft2
@onready var wire_left_3: Button = %WireLeft3
@onready var wire_left_4: Button = %WireLeft4

@onready var wire_right_1: Button = %WireRight1
@onready var wire_right_2: Button = %WireRight2
@onready var wire_right_3: Button = %WireRight3
@onready var wire_right_4: Button = %WireRight4


@onready var color_blue = Color("#0000ff")
@onready var color_red = Color("#ff0000")
@onready var color_yellow = Color("#e4c500")
@onready var color_pink = Color("#ff3fed")

@onready var colors = [color_blue, color_red, color_yellow, color_pink]
#var colors: Array

@onready var color_rect1: ColorRect = $Control/Panel/WiresLeft/MarginContainer/VBoxContainer/WireLeft1/ColorRect
@onready var color_rect2: ColorRect = $Control/Panel/WiresLeft/MarginContainer/VBoxContainer/WireLeft2/ColorRect
@onready var color_rect3: ColorRect = $Control/Panel/WiresLeft/MarginContainer/VBoxContainer/WireLeft3/ColorRect
@onready var color_rect4: ColorRect = $Control/Panel/WiresLeft/MarginContainer/VBoxContainer/WireLeft4/ColorRect

@onready var color_rect5: ColorRect = $Control/Panel2/WiresRight/MarginContainer/VBoxContainer/WireRight1/ColorRect
@onready var color_rect6: ColorRect = $Control/Panel2/WiresRight/MarginContainer/VBoxContainer/WireRight2/ColorRect
@onready var color_rect7: ColorRect = $Control/Panel2/WiresRight/MarginContainer/VBoxContainer/WireRight3/ColorRect
@onready var color_rect8: ColorRect = $Control/Panel2/WiresRight/MarginContainer/VBoxContainer/WireRight4/ColorRect

@onready var color_rects_left = [color_rect1, color_rect2, color_rect3, color_rect4]
@onready var color_rects_right = [color_rect5, color_rect6, color_rect7, color_rect8]



#var color_rects_left: Array
#var color_rects_right: Array
var colors_left: Array = []
var colors_right: Array = []

var rng = RandomNumberGenerator.new()

signal got_wire
var wire_selected: bool = false
var current_selected_wire_index: int

var wire_connection_counter: int = 0

func _ready() -> void:
	current_selected_wire_index = -1
	wire_left_1.disabled = false
	wire_left_2.disabled = false
	wire_left_3.disabled = false
	wire_left_4.disabled = false
	wire_right_1.disabled = false
	wire_right_2.disabled = false
	wire_right_3.disabled = false
	wire_right_4.disabled = false
	got_wire.connect(handle_wire)

func enter():
	colors_left = []
	colors_right = []
	
	# give left column colors
	for i in range(0, color_rects_left.size()):
		var rand_color_i = rng.randi_range(0, colors.size()-1)
		color_rects_left[i].set_color(colors[rand_color_i])
		#index_left.append(rand_color_i)
		colors_left.append(colors.pop_at(rand_color_i))
	colors = [color_blue, color_red, color_yellow, color_pink]
	
	# give right column colors 
	for i in range(0, color_rects_right.size()):
		var rand_color_i = rng.randi_range(0, colors.size()-1)
		color_rects_right[i].set_color(colors[rand_color_i])
		#index_right.append(rand_color_i)
		colors_right.append(colors.pop_at(rand_color_i))
	colors = [color_blue, color_red, color_yellow, color_pink]
	
	print(colors_left, colors_right)

func _process(delta: float) -> void:
	if wire_connection_counter == 4:
		wire_connection_counter = 0
		wire_left_1.disabled = false
		wire_left_2.disabled = false
		wire_left_3.disabled = false
		wire_left_4.disabled = false
		wire_right_1.disabled = false
		wire_right_2.disabled = false
		wire_right_3.disabled = false
		wire_right_4.disabled = false
		minigame_finished.emit(self)
	
	if wire_selected:
		pass

func _on_wire_left_1_pressed() -> void:
	var index = 0
	wire_left_1.disabled = true
	wire_left_2.disabled = false
	wire_left_3.disabled = false
	wire_left_4.disabled = false
	got_wire.emit(wire_left_1, 0)
func _on_wire_left_2_pressed() -> void:
	var index = 1
	wire_left_1.disabled = false
	wire_left_2.disabled = true
	wire_left_3.disabled = false
	wire_left_4.disabled = false
	got_wire.emit(wire_left_2, 1)
func _on_wire_left_3_pressed() -> void:
	var index = 2
	wire_left_1.disabled = false
	wire_left_2.disabled = false
	wire_left_3.disabled = true
	wire_left_4.disabled = false
	got_wire.emit(wire_left_3, 2)
func _on_wire_left_4_pressed() -> void:
	var index = 3
	wire_left_1.disabled = false
	wire_left_2.disabled = false
	wire_left_3.disabled = false
	wire_left_4.disabled = true
	got_wire.emit(wire_left_4, 3)


func handle_wire(button, index) -> void:
	#print(button)
	wire_selected = true
	current_selected_wire_index = index
	

func check_if_connect(index1, index2) -> bool:
	if colors_right[index1] == colors_left[index2]:
		return true
	else:
		return false


func _on_wire_right_1_pressed() -> void:
	var index = 0
	if wire_selected:
		if(check_if_connect(current_selected_wire_index, index)):
			wire_right_1.disabled
			wire_connection_counter += 1
			wire_selected = false
			print("connected wire 1")
func _on_wire_right_2_pressed() -> void:
	var index = 1
	if wire_selected:
		if(check_if_connect(current_selected_wire_index, index)):
			wire_right_2.disabled
			wire_connection_counter += 1
			wire_selected = false
			print("connected wire 2")
func _on_wire_right_3_pressed() -> void:
	var index = 2
	if wire_selected:
		if(check_if_connect(current_selected_wire_index, index)):
			wire_right_3.disabled
			wire_connection_counter += 1
			wire_selected = false
			print("connected wire 3")
func _on_wire_right_4_pressed() -> void:
	var index = 3
	if wire_selected:
		if(check_if_connect(current_selected_wire_index, index)):
			wire_right_4.disabled
			wire_connection_counter += 1
			wire_selected = false
			print("connected wire 4")
