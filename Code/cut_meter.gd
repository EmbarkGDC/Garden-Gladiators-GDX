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

const cut_threshold: float = 0.5
const perfect_threshold: float = 0.9

#Character animation
#@onready var char_anim_tree:= $"../AnimationManager/AnimatedSprite3D/AnimationPlayer/AnimationTree"
#@onready var now_holding: bool = get_parent().now_holding

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#start_meter()
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	look_at(camera.global_position, Vector3.UP)
	#var out_str: String = "%f"
	#$Label3D.text = out_str % result
	#if Input.is_key_pressed(Key.KEY_SPACE):
		#cut(1.0, 0.0)

func start_meter(hit: float, perfecrt: float) -> void:
	#now_holding = false
	#char_anim_tree["parameters/conditions/grabs"] = false
	#char_anim_tree["parameters/conditions/drops_item"] = true
	#char_anim_tree["parameters/conditions/ready_to_cut"] = true
	cut_offset = Global.rng.randf_range(-0.4, 0.4)
	AudioManager.create_3d_audio_at_location(position, SoundEffect.SOUND_EFFECT_TYPE.CUT_METER_APPEAR)
	cut_hit_area = hit
	perfect_hit_area = perfecrt
	anim.play("back_and_forth")
	anim.speed_scale = speed
	var mat: Material = bar.get_active_material(0)
	mat.set_shader_parameter("offset", cut_offset)
	mat.set_shader_parameter("difficulty", cut_hit_area)
	mat.set_shader_parameter("perfect_difficulty", perfect_hit_area)
	print(cut_offset)

func cut() -> cut_result:
	#char_anim_tree["parameters/conditions/ready_to_cut"] = false
	#char_anim_tree["parameters/conditions/cuts"] = true
	anim.pause()
	
	#  Get the location of the cut point
	#	The position will be divided by the animation length to provide the function a normalized input (between 0 and 1)
	var location: float = anim.current_animation_position / anim.current_animation_length
	# Remap the cut location to between -1 and 1
	location = location * 2.0 - 1.0
	result = location + cut_offset
	result = abs(result)
	var hit_area: bool = result < cut_hit_area and result > -cut_hit_area
	var perfect_area: bool = result < perfect_hit_area and result > -perfect_hit_area
	
	# Finalize result
	#result = 1.0 - clamp((0.6 * hit_area) + min(1.0, perfect_area), 0.0, 1.0)
	AudioManager.create_3d_audio_at_location(position, SoundEffect.SOUND_EFFECT_TYPE.FISH_CUT)
	
	if hit_area:
		if perfect_area:
			prints("Perfect!", " hit area: ", hit_area, " perfect area: ", perfect_area)
			AudioManager.create_3d_audio_at_location(position, SoundEffect.SOUND_EFFECT_TYPE.SLASH_PERFECT)
			return cut_result.Perfect
		prints("Hit", " hit area: ", hit_area, " perfect area: ", perfect_area)
		AudioManager.create_3d_audio_at_location(position, SoundEffect.SOUND_EFFECT_TYPE.SLASH_NORMAL)
		return cut_result.Hit
	prints("Miss", " hit area: ", hit_area, " perfect area: ", perfect_area)
	AudioManager.create_3d_audio_at_location(position, SoundEffect.SOUND_EFFECT_TYPE.SLASH_MISS)
	return cut_result.Miss
	
