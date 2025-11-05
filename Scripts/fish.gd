class_name fish extends Node3D

@onready var interactable: Area3D = $Interactable
@onready var label_3d: Label3D = $Label3D
@onready var label_3d_2: Label3D = $Label3D2

var old_parent: Node3D = null
var old_position: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact(player: Player) -> void:
	print("fish has been interacted with by " + player.name)
	if old_parent:
		put_down()
	else:
		start_holding(player)

func start_holding(player: Player) -> void:
	var new_parent: Node3D = player.get_node("HoldPosition")
	player.held_item = self
	old_parent = get_parent()
	old_position = position
	reparent(new_parent, false)
	position = Vector3.ZERO

func put_down() -> void:
	reparent(old_parent)
	old_parent = null
	position.y = old_position.y
