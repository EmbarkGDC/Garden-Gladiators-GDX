extends Area3D

@export var elements: Array
@export var min_spawn_time: float
@export var max_spawn_time: float
@onready var shape_pos: Vector3 =$Marker3D.global_position


var spawner_empty :bool = true
var time_til_spawn: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	set_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_til_spawn -= delta
	if time_til_spawn <= 0.0:
		fish_empty()
		set_time()

func spawn_fish() -> void:
	var rand_float: float = randf()
	shape_pos = $Marker3D.global_position
	for entry: spawn_entry in elements:
		if rand_float >= entry.rarity:
			print(rand_float)
			var new_fish: fish = entry.item.instantiate()
			add_child(new_fish)
			new_fish.global_position = determine_position()
			spawner_empty = false
			return

func fish_empty() -> void:
	if spawner_empty:
		spawn_fish()

func determine_position() -> Vector3:
	return Vector3(shape_pos)

func reset_area() -> void:
	for entry: Node3D in get_children():
		remove_child(entry)
		spawner_empty = true

func set_time() -> void:
	time_til_spawn = randf_range(min_spawn_time, max_spawn_time)

func _on_child_exiting_tree(node: Node) -> void:
	spawner_empty = true
