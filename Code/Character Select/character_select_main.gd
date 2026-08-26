class_name CharacterSelect
extends Control

signal all_players_ready

@onready var cursor_spawn: Node2D = $CursorSpawn

@export var packed_cursor: PackedScene
#@export var device_assign: DeviceAssign
@export var StartBanner: Control
@export var cursor_materials: Array[Material]

var cursors : Array[Cursor]
var active_players: Array[bool]
var ready_players: Array[bool]
var characters: Array[Util.PlayerCharacter]
# Buffer for when players dropout
var device_just_dropped: int
var drop_time_elapsed: float = 0
var drop_time: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active_players = [false, false, false, false]
	ready_players = [false, false, false, false]
	characters = [Util.PlayerCharacter.NONE, Util.PlayerCharacter.NONE, Util.PlayerCharacter.NONE, Util.PlayerCharacter.NONE]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	drop_time_elapsed -= delta

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

func remove_cursor(cursor:Cursor) -> void:
	if cursor.get_child_count() == 0:
		cursor.add_child(cursor.badge)
	
	#$DeviceAssign.player_dropout(cursor.player_slot)
	cursors.erase(cursor)
	cursor.queue_free()
	#player_dropout.emit()

func _on_device_assign_send_device(device: int, playernum: int) -> void:
	# Check that we're not re-adding a player that just dropped out
	if drop_time_elapsed > 0 and device_just_dropped == device:
		return
	
	active_players[playernum] = true
	var newCursor : Cursor = packed_cursor.instantiate()
	newCursor.controllerID = device
	newCursor.player_slot = playernum
	
	# connect signals
	newCursor.chosen.connect(Callable(self, "character_chosen"))
	newCursor.unchosen.connect(Callable(self, "character_unchosen"))
	newCursor.player_drop.connect(remove_cursor)
	newCursor.player_drop.connect($DeviceAssign.player_dropout)
	newCursor.start_pressed.connect(start_game)
	
	cursors.append(newCursor)
	newCursor.PlayerColor = Global.PlayerUIColors[playernum]
	newCursor.material_to_set = cursor_materials[playernum]
	newCursor.position = cursor_spawn.position
	#player_joined.emit()
	call_deferred("add_child", newCursor)

func _on_device_assign_drop_player(player: int) -> void:
	var dropped: Cursor = find_cursor(player)
	device_just_dropped = dropped.controllerID
	drop_time_elapsed = drop_time
	print(dropped.controllerID)
	
	remove_cursor(dropped)
	active_players[player] = false
	ready_players[player] = false
	characters[player] = Util.PlayerCharacter.NONE

func start_game() -> void:
	if ready_check():
		PlayerSelectBridge.player_using_device = $DeviceAssign.using_device
		PlayerSelectBridge.player_active = active_players
		PlayerSelectBridge.player_characters = characters
		PlayerSelectBridge.immediate_start = true
		
		# Switch scenes
		get_tree().change_scene_to_file("res://Scenes/multiplayer_sushido.tscn")
