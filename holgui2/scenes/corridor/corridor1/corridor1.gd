extends Node3D

@onready var light: OmniLight3D = $Light

func toggle_lighting() -> void:
	light.visible = !light.visible

func set_lighting(value: bool) -> void:
	if value == true:
		light.visible = true
	else:
		light.visible = false

func _on_area_3d_area_entered(area: Area3D) -> void:
	toggle_lighting()
