shader_type canvas_item;
render_mode unshaded;

uniform sampler2D tex: hint_albedo;
uniform float deformAmount :hint_range(-1, 1);
uniform float deform_speed : hint_range(0.5, 4);
uniform bool animate;
uniform vec2 u_resolution;
const vec3 colorA = vec3(0.5,0.3,0.8);
const vec3 colorB = vec3(1.0,0.6,0.4);

void fragment(){
	vec2 st = FRAGCOORD.xy/u_resolution.xy;
	vec3 color = vec3(0.0);
	
	vec3 pct = vec3(st.x);
	
	color = mix(colorA, colorB, pct);
	
	COLOR = vec4(color, 1.0);
	//vec3 color = vec3(0.0);
	//float pct = pow(abs(TIME), 0.5);
	//float pct = abs(sin(TIME));
	//float pct = sin(abs(TIME));
	//float pct = abs(TIME) + sin(TIME);
	//color = mix(colorA, colorB, pct);
	
	//COLOR = vec4(color, 1.0);
//	COLOR = vec4(st.x, st.y, 0.0, 1.0);
	//COLOR = vec4(abs(sin(TIME*2.0)), abs(sin(TIME)), abs(sin(TIME/2.0)), 1.0);
	//COLOR = vec4(1.0, 0.0, 0.0, 1.0);
	//COLOR = texture(TEXTURE, clamp(UV + cl.r * defAmt/2.0, vec2(0.0), vec2(1.0)));
}
