class_name fish extends holdable


@export var fish_sprite: Node3D
@export var sushi_sprite: Node3D

@export var hit_area: float = 1.0
@export var perfect_hit_area: float = 1.0
@export var speed: float = 1.0
@export var penalty_value: int = 0
@export var score_value: int = 0
@export var perfect_value: int = 0
@export var multiply_on_perfect: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact

func change_to_sushi() -> void:
	fish_sprite.visible = false
	sushi_sprite.visible = true
	$Interactable.process_mode = Node.PROCESS_MODE_DISABLED
	$AnimationPlayer.play("despawn")
