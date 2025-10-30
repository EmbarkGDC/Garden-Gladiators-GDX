extends Node3D

@onready var interactable: Area3D = $Interactable
@onready var label_3d: Label3D = $Label3D
@onready var label_3d_2: Label3D = $Label3D2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact(player: Player) -> void:
	print("fish has been interacted with by " + player.name)
