class_name holdable extends Node3D

@onready var interact_obj: Area3D = $Interactable

var old_parent: Node3D = null
var old_position: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_obj.interact = _on_interact


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_interact(mechanic: Node3D) -> void:
	var hold_mech: hold_mechanic = mechanic as hold_mechanic
	if not hold_mech:
		printerr("not a valid hold mechanic node")
		return
	#holder.held_object = self
	print("interact")
	#print("fish has been interacted with by " + player.name)
	if !hold_mech.is_holding():
		hold_mech.held_object = self
	elif hold_mech.is_holding() && hold_mech.placeable:
		hold_mech.stop_holding()
	#	return
	#if old_parent:
	#	put_down(player)
	#else:
	#	start_holding(player)

func start_holding() -> void:
	old_parent = get_parent()
	old_position = position
	position = Vector3.ZERO

func put_down() -> void:
	reparent(old_parent)
	old_parent = null
	position = Vector3(global_position.x, old_position.y, global_position.z)
