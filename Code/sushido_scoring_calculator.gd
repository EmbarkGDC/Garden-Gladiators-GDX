class_name scoring_calculator extends Node

@export var cut: cut_meter
#@export var player_ref: Player

var cut_fish: fish
var hit_area: float
var offset: float


signal finished_cutting

func _process(_delta: float) -> void:
	pass

func start_cut_sequence(target: fish) -> void:
	hit_area = target.hit_area * 0.1
	offset = randf_range(-cut.cut_hit_area / 2, cut.cut_hit_area / 2)
	print(offset)
	cut_fish = target
	cut.speed = target.speed
	cut.cut_offset = offset
	cut.visible = true
	cut.start_meter(target.hit_area * 0.1, target.perfect_hit_area * 0.1)

func get_cut_result() -> void:
	var result: = cut.cut()
	var score: int = 0
	match result:
		cut_meter.cut_result.Miss:
			score = cut_fish.penalty_value
		cut_meter.cut_result.Hit:
			score = cut_fish.score_value
		cut_meter.cut_result.Perfect:
			score = cut_fish.perfect_value
	await get_tree().create_timer(1.0).timeout
	finished_cutting.emit(score, cut_fish.multiply_on_perfect if result == cut_meter.cut_result.Perfect else false)
	cut_fish.change_to_sushi()
	cut.visible = false
	self.process_mode = Node.PROCESS_MODE_DISABLED
