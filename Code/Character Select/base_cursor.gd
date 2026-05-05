class_name Cursor
extends Sprite2D

signal chosen
signal unchosen

@onready var badge_coord: Node2D = $TokenCoord

@export var cursor_speed: float

var controllerID: int:
	set(ID):
		controllerID = ID
		if badge != null:
			badge.controllerID = controllerID
var badge: PlayerBadge
var currentHoverPortrait: Portrait
var hasChosen := false
var PlayerColor: Color = Color(0.0, 0.0, 0.0, 1.0)

func _ready() -> void:
	var newbadge = preload("res://Scenes/Components/Character Select/BaseBadge.tscn")
	badge = newbadge.instantiate()
	add_child(badge)
	badge.position = badge_coord.position

func _process(_delta: float) -> void:
	var move: Vector2 = MultiplayerInput.get_vector(controllerID, "move_left", "move_right","move_up","move_down")
	position = position + move * cursor_speed

func _input(event: InputEvent) -> void:
	if event.device == controllerID:
		if event.is_action_pressed("ui_accept"):
			#Determine whether the cursor is hover over a portrait and hasen't droppedit's token yet
			if currentHoverPortrait != null and !hasChosen:
				badge.reparent(currentHoverPortrait)
				badge.getCharacter()
				hasChosen = true
		elif event.is_action_pressed("ui_cancel"):
			#determines whether the token is dropped on a portrait
			if hasChosen:
				badge.remove()
				badge.reparent(self)
				badge.position = badge_coord.position
				hasChosen = false
