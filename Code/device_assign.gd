class_name DeviceAssign
extends Node

signal send_device(device: int, playernum: int)

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
	var device: int
	if event is InputEventMouse or event is InputEventJoypadMotion:
		return
	elif event is InputEventKey:
		device = -1
	else:
		device = event.device
	
	for i:int in using_device.size():
		if using_device[i] == device:
			return
		elif using_device[i] < -1:
			using_device[i] = device
			send_device.emit(device, i)
			return

func player_dropout(player: int) -> void:
	using_device[player] = -128
