extends HBoxContainer

#@onready var playerName: Label = $PlayerName
@onready var score: Label = $Score
@onready var p1: TextureRect = $PlayerNumber1

#array of 4 integers/numbers representing scores of each player, range of 1-4
var scores: Array
var playerN: int

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	##reset_visibility()
	#toggle_player_number(0)
	#get_score()
	#change_score()
	#determine_winner()

func result() -> void:
	#reset_visibility()
	toggle_player_number(0)
	get_score()
	change_score()
	determine_winner()



func toggle_player_number(player: int) -> void:
	player = get_player_number()
	if player == 0:
		p1.texture = ResourceLoader.load("res://Graphics/UI/BadgeLabel_P1.png")
	elif player == 1:
		p1.texture = ResourceLoader.load("res://Graphics/UI/BadgeLabel_P2.png")
	elif player == 2:
		p1.texture = ResourceLoader.load("res://Graphics/UI/BadgeLabel_P3.png")
	elif player == 3:
		p1.texture = ResourceLoader.load("res://Graphics/UI/BadgeLabel_P4.png")

func get_player_number():
	return playerN

func get_score() -> void:
	#test for debug purpose
	scores = [0001, 0002, 0003, 0004]
	#define future functionality: Access global score manager.

#copied from score_manager.gd
func determine_winner() -> int:
	var winner: int = 0
	
	for i: int in range(scores.size()):
		# check for out of bounds
		if i + 1 >= scores.size():
			break
		
		if scores[i+1] > scores[i]:
			winner = i+1
	
	return winner

func change_score() -> void:
	score.text = str(scores[playerN])
