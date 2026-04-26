class_name CharacterSelect
extends Control

signal player_joined
signal character_chosen
signal character_unchosen
signal player_dropout
signal all_players_ready

@onready var DeviceAssign: device_assign = $DeviceAssign


@export var packed_cursor : PackedScene
@export var Player1Color : Color
@export var Player2Color : Color
@export var Player3Color : Color
@export var Player4Color : Color

var cursors : Array[Cursor]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	var same : bool = false
	var num : int = 0
	while !same and num < DeviceAssign.using_device.size():
		if event.device == DeviceAssign.using_device[num]:
			same = true
		else:
			num += 1
	if !same:
		var newCursor : Cursor
		if cursors.size() == 0:
			newCursor = packed_cursor.instantiate()
			newCursor.controllerID = event.device
			newCursor.PlayerColor = Player1Color
			cursors.append(newCursor)
		elif cursors.size() == 1:
			newCursor = packed_cursor.instantiate()
			newCursor.controllerID = event.device
			newCursor.PlayerColor = Player2Color
			cursors.append(newCursor)
		elif cursors.size() == 2:
			newCursor = packed_cursor.instantiate()
			newCursor.controllerID = event.device
			newCursor.PlayerColor = Player3Color
			cursors.append(newCursor)
		elif cursors.size() == 3:
			newCursor = packed_cursor.instantiate()
			newCursor.controllerID = event.device
			newCursor.PlayerColor = Player4Color
			cursors.append(newCursor)
