class_name CharacterSelect
extends Control

signal player_joined
signal character_chosen
signal character_unchosen
signal player_dropout
signal all_players_ready

@onready var DeviceAssign: device_assign = $DeviceAssign
@onready var cursor_spawn: Node2D = $CursorSpawn
@onready var player_colors: PlayerColors = $PlayerColors

@export var packed_cursor : PackedScene

var cursors : Array[Cursor]
var PlayersReady: bool = false
var ReadyPlayers: int = 0
var playerdropped: bool = false

func _input(event: InputEvent) -> void:
	if playerdropped:
		playerdropped = false
		return
	var device:int
	if event is InputEventMouseMotion:
		return
	if event is InputEventKey:
		device = -1
	else:
		device = event.device
	var same : bool = false
	var num : int = 0
	while !same and num < DeviceAssign.using_device.size():
		if device == DeviceAssign.using_device[num]:
			same = true
		else:
			num += 1
	if same:
		var search: Cursor = find_cursor(device)
		if search == null:
			var newCursor : Cursor
			newCursor = packed_cursor.instantiate()
			newCursor.controllerID = device
			newCursor.chosen.connect(new_ready_player)
			newCursor.chosen.connect(character_chosen.emit)
			newCursor.unchosen.connect(not_ready_player)
			newCursor.unchosen.connect(character_unchosen.emit)
			newCursor.PlayerDrop.connect(remove_cursor)
			cursors.append(newCursor)
			newCursor.PlayerColor = player_colors.PlayerColorList[num]
			add_child(newCursor)
			newCursor.position = cursor_spawn.position
			player_joined.emit()
		else:
			if device == 0:
				if PlayersReady and event.is_action_pressed("ui_accept"):
					all_players_ready.emit()

func find_cursor(id: int) -> Cursor:
	for i:int in cursors.size():
		var cursor: Cursor = cursors[i]
		if cursor.controllerID == id:
			return cursor
	return null

func new_ready_player() -> void:
	ReadyPlayers += 1
	if ReadyPlayers == cursors.size():
		PlayersReady = true

func not_ready_player() -> void:
	ReadyPlayers -= 1
	if PlayersReady:
		PlayersReady = false

func remove_cursor(cursor:Cursor) -> void:
	if cursor.get_child_count() == 0:
		cursor.add_child(cursor.badge)
	
	DeviceAssign.player_dropout(cursor.controllerID)
	cursors.erase(cursor)
	if cursor.hasChosen:
		not_ready_player()
	cursor.queue_free()
	player_dropout.emit()
	playerdropped = true
