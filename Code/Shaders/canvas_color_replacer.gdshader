shader_type canvas_item;

const int COLOR_COUNT = 6;

uniform vec4 colors[COLOR_COUNT] : source_color;
uniform vec4 replace_colors[COLOR_COUNT] : source_color;
uniform float thresholds[COLOR_COUNT];

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    for (int i = 0; i < COLOR_COUNT; i++) {
        float dist = length(tex_color.rgb - colors[i].rgb);

        if (dist < thresholds[i]) {
            tex_color.rgb = replace_colors[i].rgb;
            break;
        }
    }

    COLOR = tex_color;
}