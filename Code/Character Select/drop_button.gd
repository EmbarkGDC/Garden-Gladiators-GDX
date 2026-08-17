class_name DropButton
extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	var object: Node = area.get_parent()
	if object is Cursor:
		var cursor: Cursor = object
		cursor.overdropbutton = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	var object: Node = area.get_parent()
	if object is Cursor:
		var cursor: Cursor = object
		cursor.overdropbutton = false
