class_name scoring_calculator extends Node

@export var cut: cut_meter
var cut_fish: fish
var difficulty: float
var offset: float

signal finished_cutting

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("cut"):
		cut.cut()
		await get_tree().create_timer(1.0).timeout
		finished_cutting.emit()
		cut_fish.change_to_sushi()
		cut.visible = false
		self.process_mode = Node.PROCESS_MODE_DISABLED

func start_cut_sequence(target: fish) -> void:
	difficulty = target.difficulty
	offset = randf_range(-cut.cut_difficulty / 2, cut.cut_difficulty / 2)
	print(offset)
	cut_fish = target
	cut.speed = target.speed
	cut.cut_offset = offset
	cut.visible = true
	cut.start_meter()
