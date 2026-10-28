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
	AudioManager.play_BGM(Util.SCENES.TITLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_pressed() -> void:
	print("Quit")
	get_tree().quit()


func _on_minigame_pressed() -> void:
	print("Sushido")
	get_tree().change_scene_to_file("res://Scenes/Components/Character Select/character_select_main.tscn")


func _on_credit_pressed() -> void:
	print("Credits")
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_minigame_focus_entered() -> void:
	minigame.new_color()
func _on_minigame_focus_exited() -> void:
	minigame.og_color()

func _on_credit_focus_entered() -> void:
	credit.new_color()
func _on_credit_focus_exited() -> void:
	credit.og_color()

func _on_exit_focus_entered() -> void:
	exit.new_color()
func _on_exit_focus_exited() -> void:
	exit.og_color()
