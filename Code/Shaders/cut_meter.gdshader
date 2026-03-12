shader_type spatial;
render_mode unshaded, cull_disabled;

//uniform sampler2D tex: filter_nearest, repeat_disable;
uniform float offset = 0.0;
uniform float difficulty = 1.0;
uniform float perfect_difficulty = 1.0;

uniform sampler2D colorMap: repeat_disable;

varying vec3 local_pos;

void vertex() {
	// Called for every vertex the material is visible on.
	local_pos = VERTEX;
}

void fragment() {
	// Called for every pixel the material is visible on.
	//vec2 coord = ((UV * difficulty) - (difficulty - 1.0) / 2.0) + offset;
	vec2 coord = ((local_pos.xy * difficulty) - (difficulty - 1.0) / 2.0) + offset;
	//vec3 output = texture(tex, coord).rgb;
	float hit_area = step(abs(coord.x), 0.2);
	float perfect_area = step(abs(coord.x), perfect_difficulty * 0.05);
	float output = (0.5 * hit_area) + min(0.9, perfect_area);
	float newOutput = clamp(output, 0.0, 1.0);
	
	vec3 col = texture(colorMap, vec2(newOutput, 0.5)).rgb;
	
	//ALBEDO = vec3(newOutput);
	//ALBEDO = vec3(hit_area - perfect_area);
	ALBEDO = col;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
