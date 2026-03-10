extends Node3D

@export var single_player: bool = true
@export var time_limit: float
@export var timer_label: Label

var time_left: float
var after_countdown: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameScreen.single_player = single_player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not after_countdown:
		return
	time_left -= delta
	
	var minutes: float = time_left / 60
	var seconds: float = fmod(time_left, 60)
	timer_label.text = "%02d:%02d" % [minutes, seconds]
	
	if time_left <= 0.0:
		after_countdown = false
		$GameScreen.visible = true
		$Player.process_mode = Node.PROCESS_MODE_DISABLED
		if not single_player:
			$Player2.process_mode = Node.PROCESS_MODE_DISABLED
		#REPLACE THIS LATER
		var winner: int = $ScoreManager.determine_winner()
		
		if single_player:
			$GameScreen.on_game_end($ScoreManager.scores[0], 1)
		else:
			$GameScreen.on_game_end($ScoreManager.scores[winner], winner+1)
		$FishSpawner.process_mode = Node.PROCESS_MODE_DISABLED

func countdown() -> void:
	$Countdown.visible = true
	$Countdown.text = "3"
	await  get_tree().create_timer(1.0).timeout
	$Countdown.text = "2"
	await  get_tree().create_timer(1.0).timeout
	$Countdown.text = "1"
	await  get_tree().create_timer(1.0).timeout
	$Countdown.text = "GO!"
	$Player.process_mode = Node.PROCESS_MODE_PAUSABLE
	if not single_player:
		$Player2.process_mode = Node.PROCESS_MODE_PAUSABLE
	await  get_tree().create_timer(1.0).timeout
	$Countdown.visible = false
	after_countdown = true
	$FishSpawner.spawn_number(5)
	$FishSpawner.process_mode = Node.PROCESS_MODE_PAUSABLE


func _on_game_screen_new_game() -> void:
	$GameScreen.visible = false
	time_left = time_limit
	countdown()
	$FishSpawner.reset_area()
	$Player.reset()
	if not single_player:
		$Player2.reset()
	$ScoreManager.reset()
	$UI.reset()
