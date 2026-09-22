extends Node

#One variable for all RNG in case the player wants to add a seed or alter difficulty in settings
var rng : RandomNumberGenerator

#Add an array here of scenes to define the the SCENES enum

@export var Player1Color : Color = Color(0.957, 0.611, 0.0, 1.0)
@export var Player2Color : Color = Color(0.628, 0.0, 0.628, 1.0)
@export var Player3Color : Color = Color(0.0, 0.739, 0.74, 1.0)
@export var Player4Color : Color = Color(0.599, 0.0, 0.0, 1.0)

var PlayerUIColors : PackedColorArray = [
	Player1Color,
	Player2Color,
	Player3Color,
	Player4Color
]

#storing score array to access in result screen
var pScores: Array

func  _ready() -> void:
	rng = RandomNumberGenerator.new()
