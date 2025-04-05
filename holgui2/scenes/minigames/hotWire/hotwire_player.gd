extends Button


func _process(delta: float) -> void:
	if(button_pressed):
		global_position =  get_global_mouse_position()
		global_position.x -= size.x/2
		global_position.y -= size.y/2


func _on_win_area_area_entered(area: Area2D) -> void:
	get_parent().get_parent().transition()
	pass # Replace with function body.


func _on_death_area_area_entered(area: Area2D) -> void:
	print("you loose")
	disabled = true
	global_position = get_parent().global_position
	position.x -= size.x/2
	position.y -= size.y/2
	$reenableButtonDelay.start()
	pass # Replace with function body.


func _on_reenable_button_delay_timeout() -> void:
	print("go")
	disabled=false
	pass # Replace with function body.
