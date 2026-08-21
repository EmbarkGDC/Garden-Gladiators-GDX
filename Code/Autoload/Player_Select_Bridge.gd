extends Node

#passed info:
#1. device id
#2. is active
#3. character
#4. is human
#5. color

var player_using_device: Array[int]
var player_active: Array[bool]
var player_characters: Array[Util.PlayerCharacter]
var player_human_or_cpu: Array[bool]
var player_alt_colors: Array

var immediate_start: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_using_device = [-1, 0, 1, 2]
	player_active = [true, false, false, false]
	player_human_or_cpu = [true, true, true, true]
