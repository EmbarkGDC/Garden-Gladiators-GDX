extends Node3D


enum cut_result {Miss, Hit, Perfect, Multiply}

@onready var anim: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("back_and_forth")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_key_pressed(Key.KEY_SPACE):
		cut(1.0, 0.0)

func cut(difficulty: float, offset: float) -> cut_result:
	#anim.pause()
	var location: float = anim.current_animation_position
	location = location * 2.0 - 1.0
	var result: float = ((location * difficulty) - (difficulty - 1.0) / 2.0) + offset
	result = snappedf(abs(result), 0.5)
	var perfect_result: float = snappedf(abs(result), 0.1)
	if result <= 0.5:
		if perfect_result <= 0.1:
			print("Perfect!")
			return cut_result.Perfect
		print("Hit")
		return cut_result.Hit
	print("Miss")
	return cut_result.Miss
