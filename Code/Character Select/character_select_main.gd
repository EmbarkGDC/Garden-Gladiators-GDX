class_name CharacterSelect
extends Control

signal player_joined
signal character_chosen
signal character_unchosen
signal player_dropout
signal all_players_ready

@onready var device_assign: Node = $DeviceAssign


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
	if event.is_action_pressed("join"):
		var newCursor : Cursor = packed_cursor.instantiate()
		device_assign.using
		newCursor.controllerID = event.device
		if cursors.size() == 0:
			newCursor.PlayerColor = Player1Color
		elif cursors.size() == 1:
			newCursor.PlayerColor = Player2Color
		elif cursors.size() == 2:
			newCursor.PlayerColor = Player3Color
		else:
			newCursor.PlayerColor = Player4Color
		cursors.append(newCursor)
