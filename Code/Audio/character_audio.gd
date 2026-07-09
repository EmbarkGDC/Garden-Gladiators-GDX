extends AudioStreamPlayer3D

var sound_effect_dict: Dictionary = {} ## Loads all registered SoundEffects on ready as a reference.

#set file path based on the character of this scene
@export var chosen_character := Util.PlayerCharacter.SYLKIE
var chosen_char_string: String = Util.PlayerCharacter.keys()[chosen_character]
var char_voice_filepath: String = "res://Audio/Voice/" + chosen_char_string + "/Gameplay/"
@export var char_voicelines: Array[SoundEffect]
var speech_effect: SoundEffect
var speech_effect_type: SoundEffect.SOUND_EFFECT_TYPE 
@export var speech_type_position: int = 7 ## The position in the Sound Effects enum where speech sound effects start

func _ready() -> void:
	#load voice lines based off character directory
	print("This is a message")
	var _all_speech_effects: PackedStringArray = get_files_in_folder(char_voice_filepath)
	#char_voicelines.resize(_all_speech_effects.size())
	for i in range(char_voicelines.size()):
		print ("Trying to add " + str(SoundEffect.SOUND_EFFECT_TYPE.find_key(speech_type_position+i)) + " to the array...")
		var filepath = char_voice_filepath + _all_speech_effects[i]
		char_voicelines[i] = add_speech((speech_type_position+i), filepath) # Starts from the 8th position of the sound effect type
		print("Added " + filepath + " to the array.")
	
	
	

#Character Voice Lines Array
# 0-1 For the character cut action
# 0-2 For the scene start 
# 4 Triggered when portrait is selected (Character Select Screen)
# 5-6 When character loses a game (Gameplay Results Screen)
# 7-8 When character gets a miss on the cut meter
# 9 When the character gets a perfect hit on the cut meter
# 10-11 When the character wins a game (Gameplay Results Screen)
func add_speech(type: SoundEffect.SOUND_EFFECT_TYPE, path: String) -> SoundEffect:
	if sound_effect_dict.has(type):
		speech_effect_type = type
		speech_effect.type = speech_effect_type
		speech_effect.sound_effect = ResourceImporterOggVorbis.load_from_file(path)
		speech_effect.audio_bus = Util.AUDIO_BUSES.SPEECH
	return speech_effect

func get_files_in_folder(path: String) -> PackedStringArray:
	var files = PackedStringArray([])
	#-- Takes all voice lines and loads them into the array --
	files = ResourceLoader.list_directory(path)
	
	#-- CODE I COPIED AND PASTED FROM INTERNET, NOT TESTED --
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	
	return files 
