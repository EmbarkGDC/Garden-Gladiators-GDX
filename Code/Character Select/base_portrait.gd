class_name Portrait
extends MarginContainer

@onready var color_tex: TextureRect = $ColorTex
@export var characterID: int = 0
var currentController: int
var isChosen := false
var current_cursors: Array[Cursor]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_portrait_collision_area_entered(area: Area2D) -> void:
	print("Enter")
	var entered_cursor : Cursor = area.get_parent()
	if current_cursors.size() == 0:
		color_tex.modulate = entered_cursor.PlayerColor
	entered_cursor.currentHoverPortrait = self
	current_cursors.append(area.get_parent())


func _on_portrait_collision_area_exited(area: Area2D) -> void:
	print("Exit")
	var found := false
	var cursorptr :=0
	while cursorptr < current_cursors.size() and !found:
		if current_cursors[cursorptr] == area.get_parent():
			current_cursors[cursorptr].currentHoverPortrait = null
			current_cursors.pop_at(cursorptr)
			found = true
	if !isChosen:
		if current_cursors.size() > 0:
			var priorityCursor : Cursor = current_cursors[0]
			priorityCursor.currentHoverPortrait = self
			color_tex.modulate = priorityCursor.PlayerColor
		else :
			color_tex.modulate = Color(1.0, 1.0, 1.0, 1.0)
