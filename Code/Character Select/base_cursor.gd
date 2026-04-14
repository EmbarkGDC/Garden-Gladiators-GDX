class_name Cursor
extends Sprite2D

@onready var token_coord: Node2D = $TokenCoord

@export var cursor_speed: float

var controllerID : int
var token : PlayerToken
var currentHoverPortrait: Portrait
var hasChosen := false
var PlayerColor: Color = Color(0.0, 0.0, 0.0, 1.0)

func _ready() -> void:
	var newToken = preload("res://Scenes/Components/Character Select/BaseToken.tscn")
	token = newToken.instantiate()
	add_child(token)
	token.position = token_coord.position
	if controllerID != null:
		token.controllerID = controllerID

func _process(_delta: float) -> void:
	var move : Vector2 = Input.get_vector("move_left", "move_right","move_up","move_down")
	position = position + move * cursor_speed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		#Determine whether the cursor is hover over a portrait and hasen't droppedit's token yet
		if currentHoverPortrait != null and !hasChosen:
			token.reparent(currentHoverPortrait)
			token.getCharacter()
			hasChosen = true
	if event.is_action_pressed("ui_cancel"):
		#determines whether the token is dropped on a portrait
		if hasChosen:
			token.remove()
			token.reparent(self)
			token.position = token_coord.position
			hasChosen = false
