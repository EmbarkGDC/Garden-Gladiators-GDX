class_name DeviceAssign
extends Node

signal send_device(device: int, playernum: int)
signal drop_player(player: int)

var using_device: Array
var searching: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# -1 is keyboard, 0+ are controllers
	# anything less than -1 is considered unassigned
	using_device = [-128, -128, -128, -128]

# called when we exit the scene
func _exit_tree() -> void:
	PlayerSelectBridge.player_using_device = using_device

func _input(event: InputEvent) -> void:
	if not searching:
		return
	# don't look for mouse input
	if event is InputEventMouse:
		return
	# which device are we working with?
	var device: int
	if event is InputEventJoypadMotion:
		# ignore analog joystick inputs for now
		return
	elif event is InputEventKey:
		device = -1
	else:
		device = event.device
	
	for i:int in using_device.size():
		# first check if this device has already been assigned
		if using_device[i] == device:
			return
		# otherwise, assign device in the first availible player slot
		elif using_device[i] < -1:
			using_device[i] = device
			send_device.emit(device, i)
			return

func player_dropout(player: int) -> void:
	using_device[player] = -128
	drop_player.emit(player)
