class_name device_assign
extends Node

var using_device: Array
var searching: bool = true
var dropped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# -1 is keyboard, 0+ are controllers
	# anything less than -1 is considered unassigned
	using_device = [-128, -128, -128, -128]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if dropped:
		dropped = false
		return
	var device: int
	if event is InputEventMouseMotion:
		return
	if not searching:
		return
	if event is InputEventKey:
		device = -1
	else:
		device = event.device
	var deviceint: int = find_controller(event.device)
	if event is InputEventKey:
		deviceint = find_keyboard_controller()
	if deviceint > 3:
		for i:int in using_device.size():
			if using_device[i] < -1:
				using_device[i] = device
				print(event.device)
				return

func player_dropout(player: int) -> void:
	using_device[player] = -128
	dropped = true

func find_controller(id: int) -> int:
	for i:int in using_device.size():
		var device: int = using_device[i]
		if device == id:
			return device
	return 4

func find_keyboard_controller() -> int:
	for i:int in using_device.size():
		var device: int = using_device[i]
		if device == -1:
			return device
	return 4
