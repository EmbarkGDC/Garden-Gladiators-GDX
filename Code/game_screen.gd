extends Control

signal new_game

var single_player: bool
@onready var winner_label: Label = $VBoxContainer/Control/Label

func on_game_end(score: int, winner: int) -> void:
	visible = true
	if single_player:
		winner_label.text = "Time's up!"
	else:
		winner_label.text = "Player %d wins!" % winner
	
	$VBoxContainer/Control/Label2.text = "Your Score: %d" % score

func _on_button_pressed() -> void:
	new_game.emit()
