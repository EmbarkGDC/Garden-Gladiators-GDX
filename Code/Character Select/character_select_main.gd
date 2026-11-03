class_name CharacterSelect
extends Control

signal all_players_ready

@export var StartBanner: Control

var active_players: Array[bool]
var num_active_players: int = 0
var ready_players: Array[bool]
var characters: Array[Util.PlayerCharacter]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active_players = [false, false, false, false]
	ready_players = [false, false, false, false]
	characters = [Util.PlayerCharacter.NONE, Util.PlayerCharacter.NONE, Util.PlayerCharacter.NONE, Util.PlayerCharacter.NONE]

func ready_check() -> bool:
	var players_are_ready: bool = true
	if num_active_players == 0:
		return false
	
	for i:int in active_players.size():
		if ready_players[i] != active_players[i]:
			players_are_ready = false
			break
	
	return players_are_ready

func character_chosen(player: int, character: Util.PlayerCharacter) -> void:
	ready_players[player] = true
	characters[player] = character
	
	if ready_check():
		$StartBanner.visible = true

func character_unchosen(player: int) -> void:
	ready_players[player] = false
	characters[player] = Util.PlayerCharacter.NONE
	
	if $StartBanner.visible:
		$StartBanner.visible = false

func start_game() -> void:
	if ready_check():
		PlayerSelectBridge.player_using_device = $DeviceAssign.using_device
		PlayerSelectBridge.player_active = active_players
		PlayerSelectBridge.player_characters = characters
		PlayerSelectBridge.immediate_start = true
		
		# Switch scenes
		get_tree().change_scene_to_file("res://Scenes/multiplayer_sushido.tscn")

func back() -> void:
	pass


func _on_device_assign_send_device(playernum: int) -> void:
	num_active_players += 1
	active_players[playernum] = true
	if !ready_check():
		$StartBanner.visible = false

func _on_device_assign_drop_player(player: int) -> void:
	num_active_players -= 1
	active_players[player] = false
	ready_players[player] = false
	characters[player] = Util.PlayerCharacter.NONE
	if num_active_players == 0:
		$StartBanner.visible = false

func _on_device_assign_start_game_input() -> void:
	start_game()


func _on_device_assign_character_chosen_input(player: int, character: Util.PlayerCharacter) -> void:
	character_chosen(player, character)


func _on_device_assign_character_unchosen_input(player: int) -> void:
	character_unchosen(player)


func _on_device_assign_go_back_input() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
