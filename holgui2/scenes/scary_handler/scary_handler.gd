extends Node

@onready var face_tear: AudioStreamPlayer = $FaceTear
@onready var breathing: AudioStreamPlayer = $Breathing
@onready var heartbeat: AudioStreamPlayer = $Heartbeat
@onready var walking: AudioStreamPlayer = $Walking
@onready var hands: AnimatedSprite2D = $Hands
@onready var blood: ColorRect = $Blood
@onready var score_label: Label = $ScoreBG/Score
@onready var dying_animation_player: AnimationPlayer = $DyingAnimationPlayer
@onready var button: Button = $ScoreBG/Button

@onready var label: Label = $Label

var current_hand_animation = ""

# default: counter is higher then 10
# danger: counter is between 5 and 10
# dead: counter is lower then 5
enum Phase {DEFAULT, DANGER, DEAD}
var current_phase = Phase.DEFAULT
var pitch = [1.0, 1.5, 2.0]
var volume = [-5.0, 0.0, 5.0]

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.get_parent():
		self.get_parent().connect("current_deathtimer", _on_current_deathtimer)
		self.get_parent().connect("died", _on_died)
	hands.connect("animation_finished", _on_finished_hands_animation)
	hands.visible = false
	blood.visible = false
	breathing.play()
	heartbeat.play()

func handle_deathtimer(deathtimer: float) -> void:
	if deathtimer > 10:
		set_phase(Phase.DEFAULT)
	elif deathtimer < 10 && deathtimer > 5:
		set_phase(Phase.DANGER)
	else:
		set_phase(Phase.DEAD)
	label.text = str(current_phase)

func set_phase(new_phase: Phase) -> void:
	if current_phase == new_phase:
		return
	print("current_phase: ", current_phase, ' - new_phase: ', new_phase)
	set_background_sounds(volume[new_phase], pitch[new_phase])
	match new_phase:
		Phase.DEFAULT:
			print("default")
			# hands retract again, if previously in DANGER or DEAD phase
			if current_phase == Phase.DANGER || current_phase == Phase.DEAD:
				set_hand_animation("hands_retract")
		Phase.DANGER:
			print("danger")
			# hands move out, if previously in DEFAULT phase
			if current_phase == Phase.DEFAULT:
				hands.visible = true
				set_hand_animation("hands_out")
		Phase.DEAD:
			hands.visible = true
			print("dead")
	current_phase = new_phase

func set_background_sounds(new_volume: float, new_pitch: float) -> void:
	var tween = get_tree().create_tween()
	var duration = 2
	tween.tween_property(breathing, "volume_db", new_volume, duration)
	tween.tween_property(heartbeat, "volume_db", new_volume, duration)
	#tween.tween_property(heartbeat, "pitch_scale", new_volume, duration)

func set_hand_animation(new_animation) -> void:
	print("set_hand_animation: ", new_animation)
	# dont do anything, if animation is already running
	if current_hand_animation == new_animation:
		return
	hands.play(new_animation)
	current_hand_animation = new_animation

func _on_finished_hands_animation() -> void:
	print("_on_finished_hands_animation: ", current_hand_animation)
	if current_hand_animation == "hands_out":
		set_hand_animation("wiggle")
	else:
		hands.visible = false

func die(score: int) -> void:
	dead = true
	score_label.text = str(score)
	dying_animation_player.play("dying")

func _on_finished_face_tear() -> void:
	get_tree().change_scene_to_file("res://scenes/death/death.tscn")

func _on_died(score: int) -> void:
	if !dead:
		die(score)

func _on_current_deathtimer(deathtimer: float) -> void:
	if !dead:
		handle_deathtimer(deathtimer)

func _on_button_pressed() -> void:
	print("_on_button_pressed")
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
