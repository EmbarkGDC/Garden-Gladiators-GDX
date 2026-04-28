class_name hold_mechanic extends Node

@export var placeable: bool = false

var held_object: Node3D: set = start_holding, get = holding_what
var old_parent: Node

signal pick_up
signal put_down

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func start_holding(obj: Node3D) -> void:
	held_object = obj
	pick_up.emit()

func holding_what() -> Node3D:
	return held_object

func stop_holding() -> void:
	held_object = null
	put_down.emit()

func place_in_area() -> void:
	pass

func is_holding() -> bool:
	return !held_object.is_null()
