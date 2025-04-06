extends Sprite2D


@onready var start_pos = $"../start_pos"

@onready var start_swipe = $"../start_swipe"
@onready var end_swipe = $"../end_swipe"

var grabbed = false
var okToLeave = false
var tooLate = false
var started = false

func _ready() -> void:
	$touchHelper.modulate = "#ffffff00"
	pass

func _process(delta: float) -> void:
	if(grabbed):
		global_position =  get_global_mouse_position()
		if(global_position.x > start_swipe.global_position.x and global_position.x < end_swipe.global_position.x):
			if(!started):
				tooLate = false
				started = true
				$cardswipeTimingMax.start()
				$cardswipeTimingMin.start()
			global_position.y = start_swipe.global_position.y
		elif (started):
			if(okToLeave):
				started = false
				grabbed = false
				global_position = start_pos.global_position
				$"..".win()
			else:
				reset()
				started = false
				if(tooLate):
					%timingHelp.text = "tooSlow"
					%resetTimingHelpLabel.start()
				else:
					%timingHelp.text = "tooFast"
					%resetTimingHelpLabel.start()


func reset():
	grabbed = false
	$touchHelper.disabled = true
	if start_pos:
		global_position = start_pos.global_position
		
	$reenableButtonDelay.start()
	



func _on_touch_helper_button_down() -> void:
	grabbed = true
	pass # Replace with function body.


func _on_touch_helper_button_up() -> void:
	grabbed = false
	pass # Replace with function body.


func _on_cardswipe_timing_min_timeout() -> void:
	okToLeave =  true
	pass # Replace with function body.


func _on_cardswipe_timing_max_timeout() -> void:
	okToLeave = false
	tooLate = true
	pass # Replace with function body.


func _on_reenable_button_delay_timeout() -> void:
	$touchHelper.disabled = false
	pass # Replace with function body.


func _on_reset_timing_help_label_timeout() -> void:
	%timingHelp.text = ""
	pass # Replace with function body.
