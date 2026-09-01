extends AnimatedSprite3D
class_name PlayerCharacterSprite

var player_node: Player
var hold_node: hold_mechanic
@onready var animation_tree: AnimationTree = $AnimationPlayer/AnimationTree

var is_holding: bool = false
var is_walking: bool = false
var ready_to_cut: bool = false
var game_end: bool = false
var player_interacts: bool = false
var player_action: bool = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_node = get_parent() as Player
	hold_node = player_node.find_child("hold_mechanic") as hold_mechanic
	player_node.player_move.connect(move_animation)
	player_node.player_interact.connect(interact_animation)
	player_node.player_action.connect(action_animation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func interact_animation() -> void:
	player_interacts = true
	set_is_holding(hold_node.now_holding)
	if !is_holding:
		set_player_action(true)
		set_ready_to_cut(true)
	pass

func move_animation(direction: Vector2) -> void:
	#print(direction.length())
	if direction.length() > 0:
		set_blend(direction.x)
		set_walking(true)
	else:
		set_walking(false)

func action_animation(_player: Player) -> void:
	set_ready_to_cut(false)
	#animation_tree

func set_blend(direction: float) -> void:
	animation_tree.set("parameters/Grab/blend_position", direction)
	animation_tree.set("parameters/Anticipslash/blend_position", direction)
	animation_tree.set("parameters/Carry/blend_position", direction)
	animation_tree.set("parameters/Grab/blend_position", direction)
	animation_tree.set("parameters/Hold/blend_position", direction)
	animation_tree.set("parameters/Idle/blend_position", direction)
	animation_tree.set("parameters/Slash/blend_position", direction)
	animation_tree.set("parameters/Walk/blend_position", direction)

func set_walking(status: bool) -> void:
	is_walking = status
	animation_tree.set("parameters/conditions/is_walking", status)

func set_game_end(status: bool) -> void:
	game_end = status
	animation_tree.set("parameters/conditions/game_end", status)

func set_is_holding(status: bool) -> void:
	is_holding = status
	animation_tree.set("parameters/conditions/is_holding", status)

func set_player_action(status: bool) -> void:
	player_action = status
	animation_tree.set("parameters/conditions/player_action", status)

func set_player_interacts(status: bool) -> void:
	player_interacts = status
	animation_tree.set("parameters/conditions/player_interacts", status)

func set_ready_to_cut(status: bool) -> void:
	ready_to_cut = status
	animation_tree.set("parameters/conditions/ready_to_cut", status)
