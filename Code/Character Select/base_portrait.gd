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


func _on_portrait_collision_body_entered(body: Node2D) -> void:
	print("Enter")
	if body is Cursor:
		color_tex.modulate = body.PlayerColor


func _on_portrait_collision_body_exited(body: Node2D) -> void:
	print("Exit")
	if body is Cursor:
		color_tex.modulate = Color()
