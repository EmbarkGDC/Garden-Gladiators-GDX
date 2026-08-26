class_name DeviceAssign
extends Node

signal send_device(device: int, playernum: int)
signal drop_player(player: int)

var using_device: Array[int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# -1 is keyboard, 0+ are controllers
	# anything less than -1 is considered unassigned
	using_device = [-128, -128, -128, -128]

func _input(event: InputEvent) -> void:
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
			get_viewport().set_input_as_handled()
			return

func player_dropout(player: Cursor) -> void:
	using_device[player.player_slot] = -128
	print(using_device)
	#drop_player.emit(player)
