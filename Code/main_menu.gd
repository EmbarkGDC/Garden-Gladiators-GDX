extends Control
@onready var minigame: TextureButton = $VBoxContainer2/minigame
@onready var credit: TextureButton = $VBoxContainer2/credit
@onready var exit: TextureButton = $VBoxContainer2/exit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	minigame.label.text = "minigame"
	credit.label.text = "credit"
	exit.label.text = "exit"
	minigame.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_pressed() -> void:
	print("Quit")
	get_tree().quit()


func _on_minigame_pressed() -> void:
	print("Sushido")
	get_tree().change_scene_to_file("res://Scenes/minigames.tscn")


func _on_credit_pressed() -> void:
	print("Credits")
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
