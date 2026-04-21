class_name Player extends CharacterBody3D

@export var can_jump: bool = false

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var using_device: int = -1

signal player_move
signal player_interact
signal player_action

func _physics_process(delta: float) -> void:
	#Check if device is valid
	if not Input.get_connected_joypads().has(using_device) && using_device != -1:
		print("Device missing")
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and can_jump:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := MultiplayerInput.get_vector(using_device, "move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		player_move.emit()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if MultiplayerInput.is_action_just_pressed(using_device, "interact"):
		player_interact.emit()
	
	if MultiplayerInput.is_action_just_pressed(using_device, "action"):
		player_action.emit()

	move_and_slide()
