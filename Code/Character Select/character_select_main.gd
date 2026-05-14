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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
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
			newCursor.chosen.connect(character_chosen.emit)
			newCursor.unchosen.connect(character_unchosen.emit)
			cursors.append(newCursor)
			newCursor.PlayerColor = player_colors.PlayerColorList[num]
			add_child(newCursor)
			newCursor.position = cursor_spawn.position
			player_joined.emit()

func find_cursor(id: int) -> Cursor:
	for i:int in cursors.size():
		var cursor: Cursor = cursors[i]
		if cursor.controllerID == id:
			return cursor
	return null
