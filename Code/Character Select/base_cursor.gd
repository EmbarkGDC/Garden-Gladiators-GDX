class_name Cursor
extends Sprite2D

signal chosen(player: int, character: Util.PlayerCharacter)
signal unchosen(player: int)
signal player_drop(Self:Cursor)
signal start_pressed

@onready var badge_coord: Node2D = $BadgeCoord
@onready var collider: Area2D = $CursorCollision

@export var cursor_speed: float
var input_handler: DeviceInput
var material_to_set: Material

var controllerID: int:
	set(ID):
		controllerID = ID
		if badge != null:
			badge.controllerID = controllerID
var player_slot: int
var badge: base_badge
var currentHoverPortrait: portrait
var hasChosen: bool
var PlayerColor: Color = Color(0.0, 0.0, 0.0, 1.0)
var overdropbutton: bool = false

# prevents selecting a character immediately on spawn
var  cooldown_on_start: float = 0.5

func _ready() -> void:
	input_handler = DeviceInput.new(controllerID)
	hasChosen = false
	var newbadge: Resource = preload("res://Scenes/Components/Character Select/BaseBadge.tscn")
	badge = newbadge.instantiate()
	add_child(badge)
	badge.position = badge_coord.position
	badge.set_label(player_slot)
	set_all_materials(material_to_set)

func _exit_tree() -> void:
	if is_instance_valid(badge):
		if is_instance_valid(badge.currentPort):
			badge.currentPort.reset()
		badge.queue_free()

func _process(delta: float) -> void:
	cooldown_on_start -= delta

func _physics_process(delta: float) -> void:
	var move: Vector2 = input_handler.get_vector("move_left", "move_right","move_up","move_down")
	position = position + move * cursor_speed * delta
	
	if input_handler.is_action_pressed("Start"):
		start_pressed.emit()

func _unhandled_input(event: InputEvent) -> void:
	if cooldown_on_start > 0:
		return
	
	if event.is_action_pressed("ui_accept") and input_handler.is_action_pressed("ui_accept"):
		print("player %d selected"% controllerID)
		#Determine whether the cursor is hover over a portrait and hasen't droppedit's token yet
		if currentHoverPortrait != null and !hasChosen:
			badge.reparent(currentHoverPortrait)
			badge.getCharacter()
			hasChosen = true
			chosen.emit(player_slot, badge.characterID)
		elif overdropbutton:
			player_drop.emit(self)
		# prevents the keyboard being pressed when the controller selects
		get_viewport().set_input_as_handled()
		
	elif event.is_action_pressed("ui_cancel") and input_handler.is_action_pressed("ui_cancel"):
		#determines whether the token is dropped on a portrait
		if hasChosen:
			badge.remove()
			badge.reparent(self)
			badge.position = badge_coord.position
			hasChosen = false
			unchosen.emit(player_slot)
		get_viewport().set_input_as_handled()

func set_all_materials(mat: Material) -> void:
	set_material(mat)
	badge.set_material(mat)
	
