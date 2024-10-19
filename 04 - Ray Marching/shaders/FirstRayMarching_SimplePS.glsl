#version 330
#define MAX_STEPS 100
#define MAY_DISTANCE 100.
#define THRESHOLD_DISTANCE .01

uniform vec2 uResolution;
uniform float uTime;

out vec4 outColor;

float GetDistance (vec3 point) {
	vec4 sphere = vec4(0, 1, 6, 1);
	float sphere_distance = length(point - sphere.xyz) - sphere.w;
	float plane_distance = point.y;
	return min(sphere_distance, plane_distance);
}

float RayMarching (vec3 camera_pos, vec3 ray_direction) {
	float distance_from_origin = 0.f;
	
	// LOOP
	for(int i = 0; i < MAX_STEPS; i++) {
		vec3 curr_point = camera_pos + ray_direction * distance_from_origin;
		float distance_to_the_scene = GetDistance(curr_point);
		distance_from_origin += distance_to_the_scene;
		
		if(distance_from_origin > MAY_DISTANCE || 
			distance_to_the_scene < THRESHOLD_DISTANCE) {
			break;			
		}
	}
	return  distance_from_origin;
}


void main()
{
	vec2 uv = (gl_FragCoord.xy - .5f * uResolution.xy) / uResolution.y;
	
	// Camera Model
	vec3 camera_pos = vec3(0.f, 1.f, 0.f);
	vec3 ray_direction = normalize(vec3(uv, 1.f));
	
	float final_distance = RayMarching(camera_pos, ray_direction);
	final_distance /= 6.;
	vec3 final_color = vec3(final_distance);
	
	outColor = vec4(final_color, 1.0f);
}