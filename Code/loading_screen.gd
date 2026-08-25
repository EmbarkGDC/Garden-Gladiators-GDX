class_name LoadingScreen
extends CanvasLayer

signal loading_screen_ready
signal loading_screen_finished

@export var animation_player: AnimationPlayer
@export var load_bar: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await  animation_player.animation_finished
	load_bar.visible = true
	loading_screen_ready.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_progress_changed(new_value: float) -> void:
	load_bar.value = new_value * 100

func _on_load_finished() -> void:
	load_bar.visible = false
	animation_player.play_backwards("Transition")
	await animation_player.animation_finished
	loading_screen_finished.emit()
	queue_free()
