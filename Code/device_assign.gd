extends Node

var using_device: Array
var searching: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# -1 is keyboard, 0+ are controllers
	# anything less than -1 is considered unassigned
	using_device = [-128, -128, -128, -128]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if not searching:
		return
	for i:int in using_device:
		if using_device[i] < -1:
			using_device[i] = event.device
			return

func player_dropout(player: int) -> void:
	using_device[player] = -128
