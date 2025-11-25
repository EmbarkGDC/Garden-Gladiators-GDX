extends Control

var score_displays: Array[player_score]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_displays = [$PlayerScore, $PlayerScore2, $PlayerScore3, $PlayerScore4]
	score_displays[0].set_player_name("Player 1")
	score_displays[1].set_player_name("Player 2")
	score_displays[2].set_player_name("Player 3")
	score_displays[3].set_player_name("Player 4")


func _on_score_manager_scores_updated(player_id: int, score: int) -> void:
	score_displays[player_id].set_score(score)
