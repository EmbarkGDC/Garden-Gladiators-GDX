class_name Player
extends CharacterBody3D

@export var player_id:int = 0
@export var is_AI:bool = false

var held_item: fish = null
var now_holding: bool = false

const SPEED:float = 5.0
const JUMP_VELOCITY:float = 4.5

func _ready() -> void:
	$InteractingComponent.player_ref = self


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if held_item and now_holding:
			held_item.put_down()
			now_holding = false
			return
		now_holding = true
