extends Control

var score_displays: Array[player_score]
#var gladiator_names: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_displays = [$HBoxContainer/PlayerScore, $HBoxContainer/PlayerScore2, $HBoxContainer/PlayerScore3, $HBoxContainer/PlayerScore4]
	score_displays[0].set_player_name("Player1", Global.Player1Color)
	score_displays[1].set_player_name("Player2", Global.Player2Color)
	score_displays[2].set_player_name("Player3", Global.Player3Color)
	score_displays[3].set_player_name("Player4", Global.Player4Color)


func _on_score_manager_scores_updated(player_id: int, score: int) -> void:
	score_displays[player_id].set_score(score)

func reset() -> void:
	score_displays[0].set_score(0)
	score_displays[1].set_score(0)
	score_displays[2].set_score(0)
	score_displays[3].set_score(0)

#func set_name_labels() -> void:
	#for i:int in get_parent().players.size():
		#match PlayerSelectBridge.player_characters[i]:
			#Util.PlayerCharacter.NONE:
				#continue
			#Util.PlayerCharacter.ANAGO:
				#gladiator_names[i] = "Anago"
			#Util.PlayerCharacter.BLADEZ:
				#gladiator_names[i] = "Bladez"
			#Util.PlayerCharacter.MAGURO:
				#gladiator_names[i] = "Maguro"
			#Util.PlayerCharacter.SYLKIE:
				#gladiator_names[i] = "Sylkie"
			#_:
				#continue
#
