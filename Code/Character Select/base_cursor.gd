extends Sprite2D

@export var cursor_speed: float = 300

func _process(delta: float) -> void:
	var move : Vector2 = Input.get_vector("move_left", "move_right","move_up","move_down")
	pass
