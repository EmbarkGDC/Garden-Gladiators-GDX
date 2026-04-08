class_name Player
extends CharacterBody3D

@export var player_id:int = 0
@export var chosen_character := Enums.PlayerCharacter.SYLKIE
@export var using_device: int = -1
@export var is_AI:bool = false

#var input: DeviceInput

@onready var calculator: scoring_calculator = $ScoringCalculator
@onready var interactor: interacting_component = $InteractingComponent
@onready var animation_tree:= $AnimationManager/AnimatedSprite3D/AnimationPlayer/AnimationTree

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
	animation_tree.active = true
	#var device: int = PlayerManager.get_player_device(player_id)
	#input = DeviceInput.new(device)

func _physics_process(delta: float) -> void:
	# Check if device is valid
	if not Input.get_connected_joypads().has(using_device) && using_device != -1:
		print("Device missing")
		return
	
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
	#player is moving
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
	#player is idle
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	update_animation_parameters()

func _input(_event: InputEvent) -> void:
	# Check if device is valid
	if not Input.get_connected_joypads().has(using_device) && using_device != -1:
		print("Device missing")
		return
	#if event.is_action_pressed("interact"):
	if MultiplayerInput.is_action_just_pressed(using_device, "interact"):
		print_debug("Now_holding reads as: " + str(now_holding))
		interactor.interact_input()
		if held_item != null and now_holding and not $InteractingComponent.current_interactions:
			held_item.put_down(self)
			now_holding = false
			animation_tree["parameters/conditions/grabs"] = false
			animation_tree["parameters/conditions/drops_item"] = true
			return
		if now_holding:
			animation_tree["parameters/conditions/grabs"] = true
			animation_tree["parameters/conditions/drops_item"] = false
			
	if MultiplayerInput.is_action_just_pressed(using_device, "cut"):
		pass

func update_animation_parameters() -> void:
	#runs idle/hold animations if true or walk/carry if false 
	if velocity == Vector3.ZERO:
		animation_tree["parameters/conditions/is_walking"] = false
		animation_tree["parameters/conditions/is_idle"] = true
	#flips direction of animation depending on 
	else:
		if velocity.x < 0:
			flip_sprites(-1)
		else:
			flip_sprites(1)
		animation_tree["parameters/conditions/is_walking"] = true
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/cuts"] = false
		
		
func flip_sprites(blend_position: float) -> void:
	animation_tree.set("parameters/Anticipslash/blend_position", blend_position)
	animation_tree.set("parameters/Carry/blend_position", blend_position)
	animation_tree.set("parameters/Grab/blend_position", blend_position)
	animation_tree.set("parameters/Hold/blend_position", blend_position)
	animation_tree.set("parameters/Idle/blend_position", blend_position)
	animation_tree.set("parameters/Slash/blend_position", blend_position)
	animation_tree.set("parameters/Walk/blend_position", blend_position)

func _on_scoring_calculator_finished_cutting(score: int, mult: bool) -> void:
	is_cutting = false
	animation_tree["parameters/conditions/cuts"] = false
	player_just_scored.emit(player_id, score, mult)

func reset() -> void:
	global_position = original_location
	for entry: Node3D in $HoldPosition.get_children():
		$HoldPosition.remove_child(entry)
