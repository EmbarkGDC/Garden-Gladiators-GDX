extends Control

@onready var p_1: HBoxContainer = $ResultPanel/MarginContainer/VBoxContainer/P1
@onready var p_2: HBoxContainer = $ResultPanel/MarginContainer/VBoxContainer/P2
@onready var p_3: HBoxContainer = $ResultPanel/MarginContainer/VBoxContainer/P3
@onready var p_4: HBoxContainer = $ResultPanel/MarginContainer/VBoxContainer/P4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p_1.playerN = 0
	p_1.result()
	p_2.playerN = 1
	p_2.result()
	p_3.playerN = 2
	p_3.result()
	p_4.playerN = 3
	p_4.result()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
