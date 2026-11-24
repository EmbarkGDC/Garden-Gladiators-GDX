extends AudioStreamPlayer3D

var voice_line_dict: Dictionary = {} ## Loads all registered SoundEffects on ready as a reference.

#set file path based on the character of this scene
@export var chosen_character := Util.PlayerCharacter.SYLKIE
var chosen_char_string: String
var char_voice_filepath: String
@export var char_voice_lines: Array[SoundEffect]
var speech_effect: SoundEffect
var speech_effect_type: SoundEffect.SOUND_EFFECT_TYPE 
@export var speech_type_position: int = 7 ## The position in the Sound Effects enum where speech sound effects start
	
	

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
		# Duplicate so each instance (e.g. each portrait) gets its own copy.
		# Without this, every instance shares one resource, and loading a
		# voice line for one character would change it for all of them.
		var unique_line: SoundEffect = voice_line.duplicate()
		voice_line_dict[unique_line.type] = unique_line
		print("Added " + str(unique_line.type) + " to the voice lines dictionary.")


## Loads the chosen character's .ogg for [param type] into this instance's voice line dictionary.
func load_voice_line(type: SoundEffect.SOUND_EFFECT_TYPE) -> void:
	var type_string: String = SoundEffect.SOUND_EFFECT_TYPE.keys()[type]
	chosen_char_string = Util.PlayerCharacter.keys()[chosen_character]
	chosen_char_string = chosen_char_string.capitalize()
	char_voice_filepath = "res://Audio/Voice/" + chosen_char_string + "/Gameplay/" + chosen_char_string + type_string + ".ogg"
	if not voice_line_dict.has(type):
		push_error("No SoundEffect of type ", type, " is set in char_voice_lines, so ", char_voice_filepath, " has nowhere to load into.")
		return
	if not ResourceLoader.exists(char_voice_filepath):
		push_error("Voice line file not found: " + char_voice_filepath)
		return
	voice_line_dict[type].sound_effect = load(char_voice_filepath)
	print ("Successfully loaded ogg vorbis at: " + char_voice_filepath)

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
	type = _rand_voice_line(type)
	if voice_line_dict.has(type):
		var sound_effect: SoundEffect = voice_line_dict[type]
		if sound_effect.has_open_limit():
			sound_effect.change_audio_count(1)
			# In 3D scenes, play positionally at the character. In 2D/UI scenes
			# (like Character Select) there is no Camera3D to hear a 3D player,
			# so use a regular non-positional player instead.
			var new_audio # AudioStreamPlayer or AudioStreamPlayer3D
			if get_parent() is Node3D:
				var new_3d_audio: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
				new_3d_audio.position = Vector3.ZERO # Local to this node, so it plays at the character
				new_3d_audio.bus = Util.AUDIO_BUSES.keys()[sound_effect.audio_bus].capitalize()
				new_3d_audio.stream = sound_effect.sound_effect
				new_3d_audio.volume_db = sound_effect.volume
				new_3d_audio.pitch_scale = sound_effect.pitch_scale
				new_audio = new_3d_audio
			else:
				var new_ui_audio: AudioStreamPlayer = AudioStreamPlayer.new()
				new_ui_audio.bus = Util.AUDIO_BUSES.keys()[sound_effect.audio_bus].capitalize()
				new_ui_audio.stream = sound_effect.sound_effect
				new_ui_audio.volume_db = sound_effect.volume
				new_ui_audio.pitch_scale = sound_effect.pitch_scale
				new_audio = new_ui_audio
			add_child(new_audio)
			new_audio.finished.connect(sound_effect.on_audio_finished)
			new_audio.finished.connect(new_audio.queue_free)
			new_audio.play()
			print ("Voice line is playing.")
	else:
		push_error("Audio Manager failed to find setting for type ", type)
