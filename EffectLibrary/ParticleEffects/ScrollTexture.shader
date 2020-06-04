shader_type spatial;
render_mode unshaded;

uniform sampler2D texturemap : hint_albedo;
uniform vec2 direction = vec2(1.0, 0.0);
uniform float speed_scale = 0.05;

void fragment() {
	vec2 move = direction * TIME * speed_scale;
	ALBEDO = texture(texturemap, UV + move).rgb;
	
}
	
