#version 330

uniform vec2 uResolution;
uniform float uTime;

out vec4 outColor;

vec2 randomVector(vec2 gridCorner) {
	float x = dot(gridCorner, vec2(123.4, 234.5));
	float y = dot(gridCorner, vec2(234.5, 345.6));
	vec2 gradient = vec2(x, y);
	
	gradient = sin(gradient);
	gradient = gradient * 143758.;
	gradient = sin(gradient + uTime);
	return gradient;
}


void main()
{
	float grid_numbers = 4.0f;
	vec3 black_color = vec3(0.0f); 
	vec3 white_color = vec3(1.0f); 

    vec2 uv = gl_FragCoord.xy/uResolution;
    
    uv = uv * grid_numbers;
    vec2 gridId = floor(uv);
    vec2 gridUv = fract(uv);
   
  	// Corners Coords
  	vec2 up_right_corner = gridId + vec2(0.0, 1.0);
  	vec2 up_left_corner = vec2(0.0, 0.0);
  	vec2 bottom_right_corner = vec2(1.0, 1.0);
  	vec2 bottom_left_corner = vec2(1.0, 0.0);
  	
  	// Corner's vector coords
  	vec2 up_right_vector = vec2(randomVector(up_right_corner));
  	vec2 up_left_vector = vec2(randomVector(up_left_corner));
  	vec2 bottom_right_vector = vec2(randomVector(bottom_right_corner));
  	vec2 bottom_left_vector = vec2(randomVector(bottom_left_corner));
  	
  	// Unit vector????????? 
  	// I hace no idea xdd
  	//up_right_vector /= length(up_right_vector);
  	//up_left_vector /= length(up_left_vector);
  	//bottom_right_vector /= length(bottom_right_vector);
  	//bottom_left_vector /= length(up_right_vector);
  	
  	
  	// Random coord
  	vec2 random_vector = randomVector(gridId);
  	
  	// Interpolation
  	float up_right_dot = dot(up_right_vector, random_vector);
  	float up_left_dot = dot(up_left_vector, random_vector);
  	float bottom_right_dot = dot(bottom_right_vector, random_vector);
  	float bottom_left_dot = dot(bottom_left_vector, random_vector);
  	
  	float b = mix(up_right_dot, up_left_dot, gridUv.x);
  	float t = mix(bottom_right_dot, bottom_left_dot, gridUv.x);
  	float perlin = mix(b, t, gridUv.y);
   
   // Final Color
   vec2 final_color = vec2(0.0f);
   final_color = gridUv;
   
   // Post
   
   
    // Output
    outColor = vec4(final_color, perlin, 1.0f);
}