extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_minigames_pressed() -> void:
	print("Sushido")
	get_tree().change_scene_to_file("res://Scenes/minigames.tscn")


func _on_credits_pressed() -> void:
	print("Credits")
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_exit_pressed() -> void:
	print("Quit")
	get_tree().quit()
