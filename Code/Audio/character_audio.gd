extends AudioStreamPlayer3D

var sound_effect_dict: Dictionary = {} ## Loads all registered SoundEffects on ready as a reference.

#set file path based on the character of this scene
@export var char_voicelines: Array[SoundEffect]

#Character Voice Lines Array
# 0-1 For the character cut action
# 0-2 For the scene start 
# 4 Triggered when portrait is selected (Character Select Screen)
# 5-6 When character loses a game (Gameplay Results Screen)
# 7-8 When character gets a miss on the cut meter
# 9 When the character gets a perfect hit on the cut meter
# 10-11 When the character wins a game (Gameplay Results Screen)
