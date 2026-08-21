class_name portrait
extends MarginContainer

@onready var color_tex: TextureRect = $ColorTex
@export var CharacterID: Util.PlayerCharacter
@onready var char_tex: TextureRect = $CharTex
@export var bug_tex: CompressedTexture2D

var currentController: int
var isChosen := false
var current_cursors: Array[Cursor]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_portrait()
	add_sillouette()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_portrait_collision_area_entered(area: Area2D) -> void:
	print("Enter")
	var entered_cursor : Cursor = area.get_parent()
	if current_cursors.size() == 0:
		color_tex.modulate = entered_cursor.PlayerColor
	entered_cursor.currentHoverPortrait = self
	current_cursors.append(area.get_parent())


func _on_portrait_collision_area_exited(area: Area2D) -> void:
	print("Exit")
	var exited_cursor : Cursor = area.get_parent()
	for i:int in current_cursors.size():
		if current_cursors[i-1] == exited_cursor:
			current_cursors[i-1].currentHoverPortrait = null
			current_cursors.pop_at(i-1)
	if !isChosen:
		if current_cursors.size() > 0:
			var priorityCursor : Cursor = current_cursors[0]
			priorityCursor.currentHoverPortrait = self
			color_tex.modulate = priorityCursor.PlayerColor
			remove_sillouette()
		else :
			color_tex.modulate = Color(1.0, 1.0, 1.0, 1.0)

func change_portrait() -> void:
	char_tex.texture = bug_tex

func add_sillouette() -> void:
	char_tex.modulate = Color(0.09, 0.06, 0.07, 1.0)
func remove_sillouette() -> void:
	char_tex.modulate = Color(1.0, 1.0, 1.0, 1.0)
