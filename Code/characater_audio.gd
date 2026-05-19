extends AudioStreamPlayer

#set file path based on the character of this scene
@export var chosen_character := Enums.PlayerCharacter.SYLKIE
var chosen_char_string = Enums.PlayerCharacter.keys()[chosen_character]
var char_voice_filepath = "res://Audio/Voice/" + chosen_char_string + "/Gameplay/"
var char_voicelines: Array[string] = ["default", "temp", "stuff"]


func _ready() -> void:
	#load voice lines based off character directory
	char_voicelines = get_files_in_folder(char_voice_filepath)

#Character Voice Lines Array
# 0-1 For the character cut action
# 0-2 For the scene start 
# 4 Triggered when portrait is selected (Character Select Screen)
# 5-6 When character loses a game (Gameplay Results Screen)
# 7-8 When character gets a miss on the cut meter
# 9 When the character gets a perfect hit on the cut meter
# 10-11 When the character wins a game (Gameplay Results Screen)

func get_files_in_folder(path: String) -> Array[String]:
	var files: Array[String] = []
	#-- Takes all voice lines and loads them into the array --
	files = ResourceLoader.list_directory(path)
	
	#-- CODE I COPIED AND PASTED FROM INTERNET, NOT TESTED --
	#var dir = DirAccess.open(path)
	#dir.list_dir_begin()
	#while true:
		#var file = dir.get_next()
		#if file == "":
			#break
		#elif not file.begins_with("."):
			#files.append(file)
	
	return files 
