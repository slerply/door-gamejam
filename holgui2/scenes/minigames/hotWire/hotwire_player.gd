extends Button

## Reference to the minigame scene.
@export var HotwireMinigame: Minigame 

## Reference to the starting point for the key.
@export var start_pos: Node2D 

func _process(delta: float) -> void:
	if(button_pressed):
		global_position =  get_global_mouse_position()
		global_position.x -= size.x/2
		global_position.y -= size.y/2


func _on_win_area_area_entered(area: Area2D) -> void:
	if HotwireMinigame:
		HotwireMinigame.transition()
	pass # Replace with function body.


func _on_death_area_area_entered(area: Area2D) -> void:
	disabled = true
	if start_pos:
		global_position = start_pos.global_position
	position.x -= size.x/2
	position.y -= size.y/2
	$reenableButtonDelay.start()
	pass # Replace with function body.


func _on_reenable_button_delay_timeout() -> void:
	disabled=false
	pass # Replace with function body.
