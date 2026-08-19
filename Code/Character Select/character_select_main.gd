class_name CharacterSelect
extends Control

signal player_joined
signal character_chosen
signal character_unchosen
signal player_dropout
signal all_players_ready

@onready var cursor_spawn: Node2D = $CursorSpawn

@export var packed_cursor: PackedScene
@export var device_assign: DeviceAssign
@export var StartBanner: TextureRect

var cursors : Array[Cursor]
var PlayersReady: bool = false:
	set(ready):
		StartBanner.visible = ready
var ReadyPlayers: int = 0
var playerdropped: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
		all_players_ready.emit()

func not_ready_player() -> void:
	ReadyPlayers -= 1
	if PlayersReady:
		PlayersReady = false

func remove_cursor(cursor:Cursor) -> void:
	if cursor.get_child_count() == 0:
		cursor.add_child(cursor.badge)
	
	device_assign.player_dropout(cursor.controllerID)
	cursors.erase(cursor)
	cursor.queue_free()
	player_dropout.emit()
	playerdropped = true


func _on_device_assign_send_device(device: int, playernum: int) -> void:
	var newCursor : Cursor = packed_cursor.instantiate()
	newCursor.controllerID = device
	newCursor.chosen.connect(new_ready_player)
	newCursor.chosen.connect(character_chosen.emit)
	newCursor.unchosen.connect(not_ready_player)
	newCursor.unchosen.connect(character_unchosen.emit)
	newCursor.PlayerDrop.connect(remove_cursor)
	newCursor.StartPressed.connect(start_game)
	cursors.append(newCursor)
	newCursor.PlayerColor = Global.PlayerUIColors[playernum]
	newCursor.position = cursor_spawn.position
	player_joined.emit()
	call_deferred("add_child", newCursor)

func start_game() -> void:
	if PlayersReady:
		pass
