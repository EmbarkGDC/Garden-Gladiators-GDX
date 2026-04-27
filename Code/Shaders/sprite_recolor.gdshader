shader_type spatial;

uniform sampler2D sprite_texture : source_color, filter_nearest;
uniform vec4 new_color: source_color = vec4(1.0,1.0,1.0,1.0);

/*

void vertex() {
	//do_what_you_want();
	
}
*/
vec4 color_burn(vec4 base, vec4 blend)
{
	return 1.0 - (1.0 - base) / blend;
}

void fragment() {
	vec4 color = texture(sprite_texture, UV);
	color = color_burn(color, new_color);
	ALBEDO = color.rgb;
	ALPHA = color.a;
}


