extends Node

#passed info:
#1. device id
#2. is active
#3. character
#4. is human
#5. color

var player_using_device: Array
var player_active: Array
var player_characters: Array
var player_human_or_cpu: Array
var player_alt_colors: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_using_device = [-1, 0, 1, 2]
	player_active = [true, false, false, false]
	player_human_or_cpu = [true, true, true, true]
