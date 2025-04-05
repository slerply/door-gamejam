extends Button


func _process(delta: float) -> void:
	if(button_pressed):
		position =  get_global_mouse_position()
		position.x -= size.x/2
		position.y -= size.y/2


func _on_win_area_area_entered(area: Area2D) -> void:
	print("you Win")
	pass # Replace with function body.


func _on_death_area_area_entered(area: Area2D) -> void:
	print("you loose")
	button_pressed= false
	position = Vector2(0,0)
	pass # Replace with function body.
