class_name Portrait
extends MarginContainer

@onready var color_tex: TextureRect = $ColorTex
@export var characterID: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_portrait_collision_area_entered(area: Area2D) -> void:
	print("Enter")
	var entered_cursor : Cursor = area.get_parent()
	color_tex.modulate = entered_cursor.PlayerColor


func _on_portrait_collision_area_exited(area: Area2D) -> void:
	print("Exit")
	color_tex.modulate = Color(1.0, 1.0, 1.0, 1.0)
