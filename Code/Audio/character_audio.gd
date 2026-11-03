extends AudioStreamPlayer3D

var voice_line_dict: Dictionary = {} ## Loads all registered SoundEffects on ready as a reference.
var location: Vector3 = Vector3.ZERO 

#set file path based on the character of this scene
@export var chosen_character := Util.PlayerCharacter.SYLKIE
var chosen_char_string: String
var char_voice_filepath: String
@export var char_voice_lines: Array[SoundEffect]
var speech_effect: SoundEffect
var speech_effect_type: SoundEffect.SOUND_EFFECT_TYPE 
@export var speech_type_position: int = 7 ## The position in the Sound Effects enum where speech sound effects start
var new_stream: AudioStream
	
	

#Character Voice Lines Array
# 7-8 For the character cut action
# 9-10 For the scene start 
# 11 Triggered when portrait is selected (Character Select Screen)
# 12-13 When character loses a game (Gameplay Results Screen)
# 14-15 When character gets a miss on the cut meter
# 16 When the character gets a perfect hit on the cut meter
# 17-18 When the character wins a game (Gameplay Results Screen)

func _ready() -> void:
	for voice_line: SoundEffect in char_voice_lines:
		voice_line_dict[voice_line.type] = voice_line
		print("Added " + str(voice_line.type) + " to the voice lines dictionary.")
	

func load_voice_line(type: SoundEffect.SOUND_EFFECT_TYPE) -> void:
	var type_string: String = SoundEffect.SOUND_EFFECT_TYPE.keys()[type]
	chosen_char_string = Util.PlayerCharacter.keys()[chosen_character]
	chosen_char_string = chosen_char_string.capitalize()
	char_voice_filepath = "res://Audio/Voice/" + chosen_char_string + "/Gameplay/" + chosen_char_string + type_string + ".ogg"
	if char_voice_lines[0].sound_effect != null:
		char_voice_lines[0].sound_effect.load_from_file(char_voice_filepath)
		new_stream = load(char_voice_filepath)
		stream = new_stream
		print ("Successfully loaded ogg vorbis at: " + char_voice_filepath)
	else:
		print ("Tried to load ogg vorbis at " + char_voice_filepath + " But was not successful.")

func _rand_voice_line(type: SoundEffect.SOUND_EFFECT_TYPE) -> SoundEffect.SOUND_EFFECT_TYPE: #Returns random integer value as ennum for the random character voice lines.
		match type:
			7, 9, 12, 14, 17:
				print ("Will return random integer as type or type++.")
				type = randi_range(type, type+1) as SoundEffect.SOUND_EFFECT_TYPE
				return type
			_:
				print ("Does not return random value")
				return type
	
func play_voice_line (type: SoundEffect.SOUND_EFFECT_TYPE) -> void:
	if get_parent().global_position is not Vector3:
		var parent_location_2D = get_parent().global_position
		location = Vector3(parent_location_2D.x, parent_location_2D.y, 0.0)
	else:
		location = get_parent().global_position
	type = _rand_voice_line(type)
	if voice_line_dict.has(type):
		var sound_effect: SoundEffect = voice_line_dict[type]
		if sound_effect.has_open_limit():
			sound_effect.change_audio_count(1)
			var new_3d_audio: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
			add_child(new_3d_audio)
			new_3d_audio.bus = str(sound_effect.audio_bus).capitalize()
			new_3d_audio.position = location
			new_3d_audio.stream = sound_effect.sound_effect
			new_3d_audio.volume_db = sound_effect.volume
			new_3d_audio.pitch_scale = sound_effect.pitch_scale
			#new_3d_audio.pitch_scale += Global.rng.randf_range(-sound_effect.pitch_randomness, sound_effect.pitch_randomness )
			new_3d_audio.finished.connect(sound_effect.on_audio_finished)
			new_3d_audio.finished.connect(new_3d_audio.queue_free)
			new_3d_audio.play()
			print ("Voice line is playing.")
	else:
		push_error("Audio Manager failed to find setting for type ", type)
