class_name player_score extends VBoxContainer

@onready var player_name: Label = $Label
@onready var score_count: Label = $Label2

func set_player_name(new_name: String) -> void:
	player_name.text = new_name

func set_score(score: int) -> void:
	#print(score)
	var score_str: String = "%d" % score
	score_count.text = score_str
