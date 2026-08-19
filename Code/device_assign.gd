class_name DeviceAssign
extends Node

signal assigned_device
signal dropped_player

var using_device: Array
var searching: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# -1 is keyboard, 0+ are controllers
	# anything less than -1 is considered unassigned
	using_device = [-128, -128, -128, -128]
	searching = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if not searching:
		return
	# don't look for mouse input
	if event is InputEventMouseMotion:
		return
	# which device are we working with?
	var device:int
	if event is InputEventKey:
		device = -1
	elif event is InputEventJoypadMotion:
		# ignore analog joystick inputs for now
		return
	elif event is InputEventJoypadButton:
		device = event.device
	# first check if this device has already been assigned
	for i:int in using_device.size():
		if using_device[i] == device:
			# device has been assigned
			return
	# otherwise, assign device in the first availible player slot
	for i:int in using_device.size():
		if using_device[i] < -1:
			using_device[i] = device
			print(using_device)
			assigned_device.emit(device, i)
			return

func player_dropout(player: int) -> void:
	using_device[player] = -128
	dropped_player.emit(player)
