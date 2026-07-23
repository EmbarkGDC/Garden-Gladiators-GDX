extends TextureButton
#base Button
@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $Label


##

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

#
#Button Movement
#
func _on_mouse_entered() -> void:
	create_tween().tween_property(self, "scale", Vector2(1.1,1.1), 0.1)
	change_label_enter()
	

func _on_mouse_exited() -> void:
	create_tween().tween_property(self, "scale", Vector2(1,1), 0.1)
	change_label_exit()

#
#Text Change
#
func change_label_enter() -> void:
	label.text = "Button"

func change_label_exit() -> void:
	label.text = "no"

#
#
#

func _on_pressed() -> void:
	create_tween().tween_property(self, "scale", Vector2(0.8,0.8), 0.1)
	create_tween().tween_property(self, "scale", Vector2(1.1,1.1), 0.3)
