class_name Cursor
extends Sprite2D

@onready var token_coord: Node2D = $TokenCoord

@export var cursor_speed: float

var controllerID : int
var token : PlayerToken


func _ready() -> void:
	var newToken = preload("res://Scenes/Components/Character Select/BaseBadge.tscn")
	token = newToken.instantiate()
	add_child(token)
	token.position = token_coord.position
	if controllerID != null:
		token.controllerID = controllerID

func _process(_delta: float) -> void:
	var move : Vector2 = Input.get_vector("move_left", "move_right","move_up","move_down")
	position = position + move * cursor_speed


#func set_player_color() -> void:
	#We need this function to set the Material colors for the Cursor Sprite2D node and the Badge Sprite2D Node
	#We also need it to change the texture of the BadgeLabel Sprite2D node depending on what the playerId is
	
