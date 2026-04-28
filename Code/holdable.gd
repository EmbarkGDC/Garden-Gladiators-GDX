class_name holdable extends Node3D

@onready var interactable: Area3D = $Interactable

var old_parent: Node3D = null
var old_position: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_interact(mechanic: Node) -> void:
	var hold_mech: hold_mechanic = mechanic as hold_mechanic
	if not hold_mech:
		print("not a valid hold mechanic node")
		return
	#holder.held_object = self
	print("interact")
	#print("fish has been interacted with by " + player.name)
	#if player.held_item != null:
	#	return
	#if old_parent:
	#	put_down(player)
	#else:
	#	start_holding(player)

func start_holding(player: Player) -> void:
	var new_parent: Node3D = player.get_node("HoldPosition")
	player.now_holding = true
	player.held_item = self
	old_parent = get_parent()
	old_position = position
	reparent(new_parent, false)
	position = Vector3.ZERO

func put_down(player: Player) -> void:
	reparent(old_parent)
	player.held_item = null
	player.now_holding = false
	old_parent = null
	position.y = old_position.y
