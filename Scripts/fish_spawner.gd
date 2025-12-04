extends Area3D

@export var min_spawn_time: float
@export var max_spawn_time: float
@export var elements: Array

@onready var box: BoxShape3D = $CollisionShape3D.shape
@onready var shape_pos: Vector3 = $CollisionShape3D.global_position

var time_til_spawn: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	set_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_til_spawn -= delta
	if time_til_spawn <= 0.0:
		spawn_fish()
		set_time()

func spawn_fish() -> void:
	var rand_float: float = randf()
	for entry: spawn_entry in elements:
		if rand_float >= entry.rarity:
			print(rand_float)
			var new_fish: fish = entry.item.instantiate()
			add_child(new_fish)
			new_fish.global_position = determine_position()
			return

func determine_position() -> Vector3:
	var x_out: float = randf_range(shape_pos.x - (box.size.x / 2), shape_pos.x + (box.size.x / 2))
	var z_out: float = randf_range(shape_pos.z - (box.size.z / 2), shape_pos.z + (box.size.z / 2))
	
	return Vector3(x_out, global_position.y, z_out)

func set_time() -> void:
	time_til_spawn = randf_range(min_spawn_time, max_spawn_time)

func reset_area() -> void:
	for entry: Node3D in get_children():
		remove_child(entry)
