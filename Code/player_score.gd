class_name player_score extends VBoxContainer

@onready var player_name: RichTextLabel = $Label
@onready var score_count: RichTextLabel = $Label2
var clean_score_text: String = ""

func set_player_name(new_name: String, new_color: Color) -> void:
	player_name.text = new_name
	player_name.add_theme_color_override("font_shadow_color", new_color)
	score_count.add_theme_color_override("font_shadow_color", new_color)

func set_score(score: int) -> void:
	#print(score)
	var score_str: String = "%d" % score
	score_count.text = score_str
	clean_score_text = score_str
	decrease_score_animation(score_count.text)

func decrease_score_animation(score: String) -> void:
	score_count.text = "[shake rate=50 level=30]" + score
	get_tree().create_timer(.5).timeout.connect(_on_effect_expired)

func _on_effect_expired() -> void:
	score_count.text = clean_score_text
