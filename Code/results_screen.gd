extends Control

@onready var p_1: HBoxContainer = $ResultPanel/MarginContainer/VBoxContainer/P1
@onready var p_2: HBoxContainer = $ResultPanel/MarginContainer/VBoxContainer/P2
@onready var p_3: HBoxContainer = $ResultPanel/MarginContainer/VBoxContainer/P3
@onready var p_4: HBoxContainer = $ResultPanel/MarginContainer/VBoxContainer/P4
@onready var play_again: TextureButton = $"ResultPanel/HBoxContainer/Play Again"
@onready var new_characters: TextureButton = $"ResultPanel/HBoxContainer/New Characters"
@onready var main_menu: TextureButton = $"ResultPanel/HBoxContainer/Main Menu"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p_1.playerN = 0
	p_1.result()
	p_2.playerN = 1
	p_2.result()
	p_3.playerN = 2
	p_3.result()
	p_4.playerN = 3
	p_4.result()
	
	play_again.change_text()
	new_characters.change_text()
	main_menu.change_text()
	
	#makes it so controler input is abel to be read
	new_characters.grab_focus()

#When Buttons are Pressed
func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/multiplayer_sushido.tscn")

func _on_new_characters_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Components/Character Select/character_select_main.tscn")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
