extends Node

var scores: Array

signal scores_updated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()

func determine_winner() -> int:
	var winner: int = 0
	
	for i: int in range(scores.size()):
		# check for out of bounds
		if i + 1 >= scores.size():
			break
		
		if scores[i+1] > scores[i]:
			winner = i+1
	
	return winner

func reset() -> void:
	scores = [0, 0, 0, 0]


func _on_player_scored(player_id: int, score: int, mult: bool) -> void:
	#print("id: %d score: %d", player_id, score)
	
	if mult:
		scores[player_id] *= score
	else:
		scores[player_id] += score
	print(scores)
	scores_updated.emit(player_id, scores[player_id])
