extends AnimatedSprite3D

@onready var character_audio:= $CharacterAudio
var random_voice_line: int = 7


func _input(event: InputEvent) -> void:
	random_voice_line = randi_range(7, 18)
	if event.is_action_pressed("interact"):
		character_audio.play_voice_line(random_voice_line)
