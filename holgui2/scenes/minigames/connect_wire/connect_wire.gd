extends Minigame
class_name ConnectWire

var color_blue = Color(23, 112, 255, 1)
var color_red = Color(255, 0, 30, 1)
var color_yellow = Color(255, 255, 20, 1)
var color_pink = Color(255, 27, 231, 1)

@onready var colors = [color_blue, color_red, color_pink, color_yellow]
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

#var rng = RandomNumberGenerator.new()

func _ready() -> void:
	pass

func enter():
	print(color_rects_left)
	for i in range(0, color_rects_left.size()-1):
		print("aa")
		color_rects_left[i].set_color(colors[i])
	for i in range(0, color_rects_right.size()-1):
		print("aaa")
		color_rects_right[i].set_color(colors[i])

func _process(delta: float) -> void:
	print("hallooooo")

func _on_wire_left_1_pressed() -> void:
	print("Button pressed")
