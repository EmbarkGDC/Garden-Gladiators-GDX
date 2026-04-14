extends Node3D

@onready var interactable: Area3D = $Interactable
@onready var calculator: scoring_calculator = $SushidoScoringCalculator

var held_item: fish
var is_active: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_interact(player: Player) -> void:
	print("cutting board")
	print(player.held_item)
	if player.held_item == null:
		return
	held_item = player.held_item
	held_item.reparent(self, false)
	player.held_item = null
	held_item.global_position = $HoldingPosition.global_position
	#calculator.process_mode = Node.PROCESS_MODE_PAUSABLE
	calculator.start_cut_sequence(held_item)
	player.is_cutting = true


func _on_player_player_action(player: Player) -> void:
	if player.is_cutting:
		pass
