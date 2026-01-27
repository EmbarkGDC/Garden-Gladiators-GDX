class_name cut_meter extends Node3D

enum cut_result {Miss, Hit, Perfect}
var result: float

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var bar: MeshInstance3D = $Bar
var speed: float = 1.0
var cut_difficulty: float = 1.0
var perfect_difficulty: float = 1.0
var cut_offset: float = 0.0

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#start_meter()
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#var out_str: String = "%f"
	#$Label3D.text = out_str % result
	#if Input.is_key_pressed(Key.KEY_SPACE):
		#cut(1.0, 0.0)

func start_meter() -> void:
	anim.play("back_and_forth")
	anim.speed_scale = speed
	var mat: Material = bar.get_active_material(0)
	mat.set_shader_parameter("offset", cut_offset)
	mat.set_shader_parameter("difficulty", cut_difficulty)
	mat.set_shader_parameter("perfect_difficulty", perfect_difficulty)

func cut() -> cut_result:
	anim.pause()
	var location: float = anim.current_animation_position / anim.current_animation_length
	location = location * 2.0 - 1.0
	result = ((location * cut_difficulty) - (cut_difficulty - 1.0) / 2.0) + cut_offset
	#result = snappedf(abs(result), 0.5)
	result = abs(result)
	if result <= 0.5:
		if result <= perfect_difficulty * 0.1:
			print("Perfect!")
			return cut_result.Perfect
		print("Hit")
		return cut_result.Hit
	print("Miss")
	return cut_result.Miss
