class_name cut_meter extends Node3D

enum cut_result {Miss, Hit, Perfect}
var result: float

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var bar: MeshInstance3D = $Bar
@onready var camera: Camera3D = get_viewport().get_camera_3d()
var speed: float = 1.0
var cut_hit_area: float = 0.2
var perfect_hit_area: float = 0.05
var cut_offset: float = 0.0

#Character animation
@onready var char_anim_tree:= $"../AnimationManager/AnimatedSprite3D/AnimationPlayer/AnimationTree"
@onready var now_holding: bool = get_parent().now_holding

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#start_meter()
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	look_at(camera.global_position, camera.global_transform.basis.y)
	#var out_str: String = "%f"
	#$Label3D.text = out_str % result
	#if Input.is_key_pressed(Key.KEY_SPACE):
		#cut(1.0, 0.0)

func start_meter(hit: float, perfecrt: float) -> void:
	now_holding = false
	$SFX_Cut_Meter_Hyōshigi.play()
	char_anim_tree["parameters/conditions/grabs"] = false
	char_anim_tree["parameters/conditions/drops_item"] = true
	char_anim_tree["parameters/conditions/ready_to_cut"] = true
	cut_hit_area = hit
	perfect_hit_area = perfecrt
	anim.play("back_and_forth")
	anim.speed_scale = speed
	var mat: Material = bar.get_active_material(0)
	mat.set_shader_parameter("offset", cut_offset)
	mat.set_shader_parameter("difficulty", cut_hit_area)
	mat.set_shader_parameter("perfect_difficulty", perfect_hit_area)

func cut() -> cut_result:
	char_anim_tree["parameters/conditions/ready_to_cut"] = false
	char_anim_tree["parameters/conditions/cuts"] = true
	anim.pause()
	var location: float = anim.current_animation_position / anim.current_animation_length
	location = location * 2.0 - 1.0
	result = ((location * cut_hit_area) - (cut_hit_area - 1.0) / 2.0) + cut_offset
	#result = snappedf(abs(result), 0.5)
	result = abs(result)
	if result <= 0.2:
		if result <= perfect_hit_area * 0.2:
			print("Perfect!")
			return cut_result.Perfect
		print("Hit")
		return cut_result.Hit
	print("Miss")
	return cut_result.Miss
