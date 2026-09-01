extends TextureButton
#base Button
@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $Label

@export var text: String
@onready var og_font_color: Color = Color(0.333, 0.0, 0.0)
@onready var new_font_color: Color = Color(1.0, 1.0, 1.0)

## Initialization
func _ready() -> void:
	set_pivot()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	focus_entered.connect(_focus_entered)
	focus_exited.connect(_focus_exited)

## Pivot update
func set_pivot() -> void:
	pivot_offset = size/2

## Scale Button
func _on_mouse_entered() -> void:
	create_tween().tween_property(self, "scale", Vector2(1.1,1.1), 0.1)
	grab_focus()

func _on_mouse_exited() -> void:
	create_tween().tween_property(self, "scale", Vector2(1,1), 0.1)

func _focus_entered() -> void:
	create_tween().tween_property(self, "scale", Vector2(1.1,1.1), 0.1)
func _focus_exited() -> void:
	create_tween().tween_property(self, "scale", Vector2(1,1), 0.1)

#
func og_color() -> void:
	label.add_theme_color_override("font_color", og_font_color)
func new_color() -> void:
	label.add_theme_color_override("font_color", new_font_color)

func _on_pressed() -> void:
	create_tween().tween_property(self, "scale", Vector2(0.8,0.8), 0.1)
	create_tween().tween_property(self, "scale", Vector2(1.1,1.1), 0.3)
