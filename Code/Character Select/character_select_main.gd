class_name CharacterSelect
extends Control

signal all_players_ready

@onready var cursor_spawn: Node2D = $CursorSpawn

@export var packed_cursor: PackedScene
#@export var device_assign: DeviceAssign
@export var StartBanner: Control

var cursors : Array[Cursor]
var active_players: Array[bool]
var ready_players: Array[bool]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active_players = [false, false, false, false]
	ready_players = [false, false, false, false]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func find_cursor(id: int) -> Cursor:
	for i:int in cursors.size():
		var cursor: Cursor = cursors[i]
		if cursor.controllerID == id:
			return cursor
	return null

func ready_check() -> bool:
	var players_are_ready: bool = true
	
	for i:int in active_players.size():
		if ready_players[i] != active_players[i]:
			players_are_ready = false
			break
	
	return players_are_ready

func character_chosen(player: int) -> void:
	ready_players[player] = true

func character_unchosen(player: int) -> void:
	ready_players[player] = false

func remove_cursor(cursor:Cursor) -> void:
	if cursor.get_child_count() == 0:
		cursor.add_child(cursor.badge)
	
	#device_assign.player_dropout(cursor.controllerID)
	cursors.erase(cursor)
	cursor.queue_free()
	#player_dropout.emit()

func _on_device_assign_send_device(device: int, playernum: int) -> void:
	active_players[playernum] = true
	var newCursor : Cursor = packed_cursor.instantiate()
	newCursor.controllerID = device
	#newCursor.chosen.connect(new_ready_player)
	newCursor.chosen.connect(Callable(self, "character_chosen").bind(playernum))
	#newCursor.unchosen.connect(not_ready_player)
	newCursor.unchosen.connect(Callable(self, "character_unchosen").bind(playernum))
	newCursor.PlayerDrop.connect(remove_cursor)
	newCursor.StartPressed.connect(start_game)
	cursors.append(newCursor)
	newCursor.PlayerColor = Global.PlayerUIColors[playernum]
	newCursor.position = cursor_spawn.position
	#player_joined.emit()
	call_deferred("add_child", newCursor)

func _on_device_assign_drop_player(player: int) -> void:
	var dropped: Cursor = find_cursor(player)
	remove_cursor(dropped)
	active_players[player] = false
	ready_players[player] = false

func start_game() -> void:
	if ready_check():
		pass
