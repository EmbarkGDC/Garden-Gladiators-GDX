extends Node

var scores: Array

signal scores_updated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()

func _on_player_player_just_scored(player_id: int, score: int, mult: bool) -> void:
	if mult:
		scores[player_id] *= score
	else:
		scores[player_id] += score
	print(scores)
	scores_updated.emit(player_id, scores[player_id])

func reset() -> void:
	scores = [0, 0, 0, 0]
