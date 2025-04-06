extends Button


func _process(delta: float) -> void:
	if(button_pressed):
		global_position =  get_global_mouse_position()
		global_position.x -= size.x/2
		global_position.y -= size.y/2




func reset():
	disabled = true
	position.x -= size.x/2
	position.y -= size.y/2
	$reenable_button_delay_a.start()


func _on_reenable_button_delay_a_timeout() -> void:
	disabled=false
	pass # Replace with function body.
