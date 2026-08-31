class_name DeviceAssign
extends Node

signal send_device(playernum: int)
signal drop_player(player: int)
signal start_game_input
signal go_back_input
signal character_chosen_input
signal character_unchosen_input

@export var cursor_spawn: Node2D

@export var packed_cursor: PackedScene
@export var cursor_materials: Array[Material]

var cursors : Array[Cursor]
# Buffer for when players dropout
var device_just_dropped: int
var drop_time_elapsed: float = 0
var drop_time: float = 0.5

var using_device: Array[int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# -1 is keyboard, 0+ are controllers
	# anything less than -1 is considered unassigned
	using_device = [-128, -128, -128, -128]

func _process(delta: float) -> void:
	drop_time_elapsed -= delta

func _input(event: InputEvent) -> void:
	# don't look for mouse input
	if event is InputEventMouse:
		return
	# which device are we working with?
	var device: int
	if event is InputEventJoypadMotion:
		# ignore analog joystick inputs for now
		return
	elif event is InputEventKey:
		device = -1
	else:
		device = event.device
	# Check that we're not re-adding a player that just dropped out
	if drop_time_elapsed > 0 and device_just_dropped == device:
		return
	
	for i:int in using_device.size():
		# first check if this device has already been assigned
		if using_device[i] == device:
			return
		# otherwise, assign device in the first availible player slot
		elif using_device[i] < -1:
			using_device[i] = device
			add_cursor(device, i)
			send_device.emit(i)
			get_viewport().set_input_as_handled()
			return

func find_cursor(id: int) -> Cursor:
	for i:int in cursors.size():
		var cursor: Cursor = cursors[i]
		if cursor.controllerID == id:
			return cursor
	return null

func remove_cursor(cursor:Cursor) -> void:
	if cursor.get_child_count() == 0:
		cursor.add_child(cursor.badge)
	
	player_dropout(cursor)
	cursors.erase(cursor)
	cursor.queue_free()
	#player_dropout.emit()

func add_cursor(device: int, playernum: int) -> void:
	var newCursor : Cursor = packed_cursor.instantiate()
	newCursor.controllerID = device
	newCursor.player_slot = playernum
	
	# connect signals
	newCursor.chosen.connect(Callable(self, "character_chosen"))
	newCursor.unchosen.connect(Callable(self, "character_unchosen"))
	newCursor.player_drop.connect(remove_cursor)
	newCursor.start_pressed.connect(start_game)
	newCursor.go_back.connect(go_back)
	
	cursors.append(newCursor)
	newCursor.player_color = Global.PlayerUIColors[playernum]
	newCursor.material_to_set = cursor_materials[playernum]
	newCursor.position = cursor_spawn.position
	#player_joined.emit()
	call_deferred("add_child", newCursor)

func player_dropout(player: Cursor) -> void:
	device_just_dropped = player.controllerID
	drop_time_elapsed = drop_time
	print(player.controllerID)
	
	using_device[player.player_slot] = -128
	print(using_device)
	drop_player.emit(player.player_slot)

func character_chosen(player: int, character: Util.PlayerCharacter) -> void:
	character_chosen_input.emit(player, character)

func character_unchosen(player: int) -> void:
	character_unchosen_input.emit(player)

func start_game() -> void:
	start_game_input.emit()

func go_back() -> void:
	go_back_input.emit()
