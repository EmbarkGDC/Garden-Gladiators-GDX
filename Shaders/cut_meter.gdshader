shader_type spatial;
render_mode unshaded;

//uniform sampler2D tex: filter_nearest, repeat_disable;
uniform float offset = 0.0;
uniform float difficulty = 1.0;

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
	float hit_area = step(abs(coord.x), 0.5);
	float perfect_area = step(abs(coord.x), 0.1);
	vec3 output = vec3(0) + (vec3(0.5) * hit_area) + (vec3(1) * perfect_area);
	
	ALBEDO = output;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
