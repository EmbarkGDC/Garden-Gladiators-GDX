shader_type canvas_item;
uniform vec4 color1_original: source_color = vec4(1.0,1.0,1.0,1.0);
uniform vec4 color2_original: source_color = vec4(1.0,1.0,1.0,1.0);

uniform vec4 new_color1: source_color = vec4(1.0,1.0,1.0,1.0);
uniform vec4 new_color2: source_color = vec4(1.0,1.0,1.0,1.0);

uniform float threshold: hint_range(0.0, 1.0) = 0.05;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	vec4 final_color = original_color;
	
	if(distance(original_color.rgb, color1_original.rgb) < threshold){
		final_color = vec4(pow(new_color1.rgb, vec3(2.2)), original_color.a * new_color1.a);
	}
	else if(distance(original_color.rgb, color2_original.rgb) < threshold){
		final_color = vec4(pow(new_color2.rgb, vec3(2.2)), original_color.a * new_color2.a);
	}
	COLOR = final_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
