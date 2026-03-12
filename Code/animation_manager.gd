extends AnimationPlayer

# Retrieve chosen character enum value from player script
@onready var chosen_character = get_parent().chosen_character

# Path to the animation scenes
const ANIMATION_SCENE_PATH = "res://Scenes/Components/Character/animations/"

# Reference to the current AnimatedSprite3D node
@onready var animated_sprite: AnimatedSprite3D = $AnimatedSprite3D

# Called when the node enters the scene tree
func _ready():
	# Load the appropriate character animation
	load_character_animation(chosen_character)

# Load and replace the AnimatedSprite3D based on the character type
func load_character_animation(chosen_character):
	# Convert enum to string and lowercase for filename
	var character_name = Enums.PlayerCharacter.keys()[chosen_character].to_lower()
	var scene_path = ANIMATION_SCENE_PATH + character_name + "_animated_sprite_3d.tscn"
	
	# Check if the scene file exists
	if ResourceLoader.exists(scene_path):
		# Load the scene
		var character_scene = load(scene_path)
		if character_scene:
			# Instance the new AnimatedSprite3D scene
			var new_sprite = character_scene.instantiate()
			
			# Remove any existing animated sprite child
			if animated_sprite:
				animated_sprite.queue_free()
			
			# Add the new sprite as a child of this node
			add_child(new_sprite)
			animated_sprite = new_sprite
			
			print("Successfully loaded character animation: ", character_name)
		else:
			print("Failed to load scene: ", scene_path)
			use_default_sprite()
	else:
		print("Scene not found: ", scene_path, " - Using default sprite")
		use_default_sprite()

# Use the default sprite that's already in the scene
func use_default_sprite():
	if not animated_sprite:
		animated_sprite = get_node_or_null("AnimatedSprite3D")
		if animated_sprite:
			print("Using default AnimatedSprite3D node")
		else:
			print("Warning: No default AnimatedSprite3D node found in scene")

# Optional: Function to change character at runtime
func set_character(character: Enums.PlayerCharacter):
	chosen_character = character
	load_character_animation(chosen_character)

# Optional: Get reference to the current animated sprite
func get_animated_sprite() -> AnimatedSprite3D:
	return animated_sprite
