class_name CharacterSelect
extends Control

signal player_joined
signal character_chosen
signal character_unchosen
signal player_dropout
signal all_players_ready
 
@onready var cursor_spawn: Node2D = $CursorSpawn
@onready var player_colors : PackedColorArray = Global.PlayerUIColors

@export var packed_cursor : PackedScene

var cursors : Array[Cursor]
#var players_ready: bool = false
#var ReadyPlayers: int = 0
#var playerdropped: bool = false

var active_players: Array
var ready_players: Array

func _ready() -> void:
	active_players = [false, false, false, false]
	ready_players = [false, false, false, false]

func find_cursor(id: int) -> Cursor:
	for i:int in cursors.size():
		var cursor: Cursor = cursors[i]
		if cursor.controllerID == id:
			return cursor
	return null

func add_cursor(device: int, player: int) -> void:
	var search: Cursor = find_cursor(device)
	if search == null:
		var newCursor : Cursor
		newCursor = packed_cursor.instantiate()
		newCursor.controllerID = device
		#newCursor.chosen.connect(new_ready_player)
		newCursor.chosen.connect(character_chosen.emit)
		#newCursor.unchosen.connect(not_ready_player)
		newCursor.unchosen.connect(character_unchosen.emit)
		newCursor.PlayerDrop.connect(remove_cursor)
		cursors.append(newCursor)
		newCursor.PlayerColor = Global.PlayerUIColors[player]
		add_child(newCursor)
		newCursor.position = cursor_spawn.position
		#player_joined.emit()

#func new_ready_player() -> void:
	#ReadyPlayers += 1
	#if ReadyPlayers == cursors.size():
		#players_ready = true
#
#func not_ready_player() -> void:
	#ReadyPlayers -= 1
	#if players_ready:
		#players_ready = false

func remove_cursor(cursor:Cursor) -> void:
	if cursor.get_child_count() == 0:
		cursor.add_child(cursor.badge)
	
	#device_assign.player_dropout(cursor.controllerID)
	cursors.erase(cursor)
	#if cursor.hasChosen:
		#not_ready_player()
	cursor.queue_free()
	#player_dropout.emit()
	#playerdropped = true

func active_players_are_ready() -> bool:
	var all_ready: bool = true
	
	for i:int in ready_players.size():
		if ready_players[i] != active_players[i]:
			all_ready = false
			break
	
	return all_ready

func _on_device_assign_assigned_device(device: int, player: int) -> void:
	active_players[player] = true
	add_cursor(device, player)


func _on_device_assign_dropped_player(player: int) -> void:
	var dropped: Cursor = find_cursor(player)
	#remove_cursor(dropped)
	active_players[player] = false
	ready_players[player] = false
