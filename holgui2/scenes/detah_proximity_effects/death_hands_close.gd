extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("animation_finished", _on_finished_animation_hands)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_hands() -> void:
	self.visible = true
	self.play("closing_in")
	
func _on_finished_animation_hands() -> void:
	self.play("wiggle")
