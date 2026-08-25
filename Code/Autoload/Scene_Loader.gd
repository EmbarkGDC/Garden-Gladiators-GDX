extends Node

signal  progress_changed(progress: float)
signal load_finished

var loading_screen: PackedScene = preload("uid://dqtak1jol1fgv")
var loaded_resource: PackedScene
var scene_path: String
var progress: Array = []
var use_sub_threads: bool = true
var new_load_screen: LoadingScreen
static var call_amount: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_load_screen = loading_screen.instantiate()
	progress_changed.connect(new_load_screen._on_progress_changed)
	load_finished.connect(new_load_screen._on_load_finished)
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	progress_changed.emit(progress[0])
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			get_tree().change_scene_to_packed(loaded_resource)
			load_finished.emit()

func load_scene(_scene_path:String) -> void:
	call_amount += 1
	prints("Calls:",call_amount)
	scene_path = _scene_path
	
	add_child(new_load_screen)
	await  new_load_screen.loading_screen_ready
	
	start_load()

func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)
