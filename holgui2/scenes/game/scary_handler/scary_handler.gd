extends Node

@onready var face_tear: AudioStreamPlayer = $FaceTear
@onready var breathing: AudioStreamPlayer = $Breathing
@onready var heartbeat: AudioStreamPlayer = $Heartbeat
@onready var walking: AudioStreamPlayer = $Walking
@onready var hands: AnimatedSprite2D = $Hands
@onready var blood: ColorRect = $Blood

@onready var label: Label = $Label

var hands_animations = ["default", "wiggle", "dead"]
var hands_animations_index = 0

var time = 10.0
var dead = false
# breathing and heartbeat at low volume
# increase volume starting at second 5 going down
# when more time added -> decrease volume again

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.get_parent():
		self.get_parent().connect("current_deathtimer", _on_current_deathtimer)
		self.get_parent().connect("died", _on_died)
	face_tear.connect("finished", _on_finished_face_tear)
	hands.connect("animation_finished", _on_finished_hands_animation)
	print("play background_sounds")
	hands.visible = false
	blood.visible = false
	breathing.play()
	heartbeat.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func handle_deathtimer(deathtimer: float) -> void:
	label.text = str(deathtimer)
	if deathtimer <= 5 && !hands.visible:
		make_background_louder(0.0)
		hands.visible = true
		hands.play(hands_animations[hands_animations_index])
		hands_animations_index += 1
	elif deathtimer <= 2 && !blood.visible:
		make_background_louder(5.0)
		make_blood_thicker()

func _on_finished_hands_animation() -> void:
	print("_on_finished_hands_animation")
	if hands_animations_index > 1:
		return
	hands.play(hands_animations[hands_animations_index])
	hands_animations_index += 1

func die() -> void:
	dead = true
	print("play face_tear")
	hands.play("dead")
	breathing.stop()
	heartbeat.stop()
	face_tear.play()

func _on_finished_face_tear() -> void:
	get_tree().change_scene_to_file("res://scenes/death/death.tscn")

func make_background_louder(value: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(breathing, "volume_db", value, 2.0)
	tween.tween_property(heartbeat, "volume_db", value, 2.0)

func make_blood_thicker() -> void:
	blood.visible = true
	hands.visible = false
	var tween = get_tree().create_tween()
	tween.tween_property(blood, "material:shader_parameters/radius", 0.7, 2.0)

func _on_died() -> void:
	if !dead:
		die()

func _on_current_deathtimer(deathtimer: float) -> void:
	#print("_on_current_deathtimer = ", deathtimer)
	if !dead:
		handle_deathtimer(deathtimer)
