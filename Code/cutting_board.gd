extends Node3D

@onready var interact_obj: Area3D = $Interactable
@onready var calculator: scoring_calculator = $SushidoScoringCalculator

var held_item: fish
var is_active: bool

signal player_scored

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_obj.interact = _on_interact

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_interact(mechanic: Node3D) -> void:
	print("cutting board")
	
	var hold_mech: hold_mechanic = mechanic as hold_mechanic
	#print(player.held_item)
	if !is_instance_valid(hold_mech.held_object):
		return
	held_item = hold_mech.held_object as fish
	held_item.reparent(self, false)
	hold_mech.held_object = null
	held_item.global_position = $HoldingPosition.global_position
	calculator.process_mode = Node.PROCESS_MODE_PAUSABLE
	calculator.start_cut_sequence(held_item)
	hold_mech.my_player.is_cutting = true
	hold_mech.my_player.player_action.connect(player_cut)

func player_cut(player: Player) -> void:
	if player.is_cutting:
		var score: Dictionary = await calculator.get_cut_result()
		player.is_cutting = false
		player.player_action.disconnect(player_cut)
		player_scored.emit(player.player_id, score["score"], score["multiply"])
