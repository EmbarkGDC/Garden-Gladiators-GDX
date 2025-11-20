extends Node

var scores: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scores = [0, 0, 0, 0]


func player_score(player_id: int, score: int) -> void:
	scores[player_id] += score
