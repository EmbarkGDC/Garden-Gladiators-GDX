class_name Player
extends CharacterBody3D

@export var player_id:int = 0
@export var using_device: int = -1
@export var is_AI:bool = false

#var input: DeviceInput

@onready var calculator: scoring_calculator = $ScoringCalculator

var held_item: fish = null
var now_holding: bool = false

var is_cutting: bool = false

const SPEED:float = 7.0
const JUMP_VELOCITY:float = 4.5
var original_location: Vector3

signal player_just_scored

func _ready() -> void:
	$InteractingComponent.player_ref = self
	original_location = global_position
	#var device: int = PlayerManager.get_player_device(player_id)
	#input = DeviceInput.new(device)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_cutting:
		return
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var input_dir :Vector2 = MultiplayerInput.get_vector(using_device, "move_left", "move_right", "move_up", "move_down")
	var direction :Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(_event: InputEvent) -> void:
	#if event.is_action_pressed("interact"):
	if MultiplayerInput.is_action_pressed(using_device, "interact"):
		if held_item != null and now_holding and not $InteractingComponent.current_interactions:
			held_item.put_down(self)
			now_holding = false
			return
		now_holding = true



func _on_scoring_calculator_finished_cutting(score: int, mult: bool) -> void:
	is_cutting = false
	player_just_scored.emit(player_id, score, mult)

func reset() -> void:
	global_position = original_location
	for entry: Node3D in $HoldPosition.get_children():
		$HoldPosition.remove_child(entry)
