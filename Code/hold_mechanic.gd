class_name hold_mechanic extends Node

@export var placeable: bool = false
@export var hold_point: Node3D

var now_holding: bool = false
var held_object: holdable: set = start_holding, get = holding_what
var old_parent: Node

signal pick_up
signal put_down

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func start_holding(obj: holdable) -> void:
	held_object = obj
	if hold_point:
		obj.reparent(hold_point, false)
		print("Reparenting...")
	else:
		obj.reparent(self, false)
		printerr("Hold point is null. Patenting to self instead.")
	pick_up.emit()

func holding_what() -> holdable:
	return held_object

func stop_holding() -> void:
	held_object.put_down(self)
	held_object = null
	put_down.emit()

func place_in_area() -> void:
	pass

func is_holding() -> bool:
	return is_instance_valid(held_object)
