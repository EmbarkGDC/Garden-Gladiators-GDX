extends Control

signal new_game

func on_game_end(score: int) -> void:
	visible = true
	$VBoxContainer/Control/Label2.text = "Your Score: %d" % score

func _on_button_pressed() -> void:
	new_game.emit()
