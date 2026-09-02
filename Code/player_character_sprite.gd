extends AnimatedSprite3D
class_name PlayerCharacterSprite

var player_node: Player
var hold_node: hold_mechanic
@onready var animation_tree: AnimationTree = $AnimationPlayer/AnimationTree

var last_direction_moved: int = 0
var is_now_holding: bool = false
var can_player_action: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_node = get_parent() as Player
	hold_node = player_node.find_child("hold_mechanic") as hold_mechanic
	player_node.player_move.connect(move_animation)
	player_node.player_interact.connect(interact_animation)
	player_node.player_action.connect(action_animation)
	set_idle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func interact_animation() -> void:
	if player_node.interactor.current_interactions.is_empty():
		return
	
	if hold_node.now_holding and !is_now_holding:
		set_is_holding()
		is_now_holding = true
		return
	else:
		set_ready_to_cut()
		return

func move_animation(direction: Vector2) -> void:
	#print(direction.length())
	if direction.length() > 0.01:
		# Before setting anything, check if we're moving on the X axis
		var x_move: int = int(sign(direction.x))
		if x_move != 0:
			last_direction_moved = x_move
		set_blend(direction.x + last_direction_moved)
		set_walking()
	else:
		set_idle()

func action_animation(_player: Player) -> void:
	set_player_action()

func set_blend(direction: float) -> void:
	animation_tree.set("parameters/Grab/blend_position", direction)
	animation_tree.set("parameters/Anticipslash/blend_position", direction)
	animation_tree.set("parameters/Carry/blend_position", direction)
	animation_tree.set("parameters/Grab/blend_position", direction)
	animation_tree.set("parameters/Hold/blend_position", direction)
	animation_tree.set("parameters/Idle/blend_position", direction)
	animation_tree.set("parameters/Slash/blend_position", direction)
	animation_tree.set("parameters/Walk/blend_position", direction)

func set_walking() -> void:
	animation_tree.set("parameters/movement_empty/transition_request", "moving")
	animation_tree.set("parameters/movement_hold/transition_request", "moving")

func set_idle() -> void:
	animation_tree.set("parameters/movement_empty/transition_request", "idle")
	animation_tree.set("parameters/movement_hold/transition_request", "idle")

func set_is_holding() -> void:
	animation_tree.set("parameters/state/transition_request", "holding_item")
	animation_tree.set("parameters/grab_shot/request", AnimationNodeOneShot.OneShotRequest.ONE_SHOT_REQUEST_FIRE)
	can_player_action = true

func set_empty_handed() -> void:
	animation_tree.set("parameters/state/transition_request", "empty_handed")
	is_now_holding = false

func set_player_action() -> void:
	if !can_player_action:
		return
	
	set_empty_handed()
	animation_tree.set("parameters/slash_shot/request", AnimationNodeOneShot.OneShotRequest.ONE_SHOT_REQUEST_FIRE)
	can_player_action = false

func set_ready_to_cut() -> void:
	animation_tree.set("parameters/state/transition_request", "cutting")
