@tool
extends AnimatedSprite3D

@export var old_texture: Texture2D
@export var new_texture: Texture2D
@export var replace_textures: bool:
	set(value):
		swap_textures()

func swap_textures() -> void:
	for anim_name in sprite_frames.get_animation_names():
		for i in sprite_frames.get_frame_count(anim_name):
			var texture : AtlasTexture = sprite_frames.get_frame_texture(anim_name, i)
			if old_texture.get_image().resource_name == texture.get_image().resource_name:
				texture.atlas = new_texture
				print("Textures replaced")
			else:
				print("Resource names wern't the same")
				print(old_texture.get_image().resource_name + texture.get_image().resource_name)
