#define PROCESSING_LIGHT_SHADER

uniform mat4 modelviewMatrix;
uniform mat4 transformMatrix;
uniform mat3 normalMatrix;
uniform mat4 texMatrix;
uniform float u_time;
uniform vec3 lightNormal[8];


attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;
attribute vec4 specular;
attribute float shininess;

varying vec3 vertPosition;
varying vec3 vertNormal;
varying vec4 vertColor;
varying vec4 vertTexCoord;
varying vec4 vertSpecular;
varying float vertShininess;

varying vec3 lightDir;
vec3 permute(vec3 x) { return mod(((x*34.0)+1.0)*x, 289.0); }

float snoise(vec2 v){
  const vec4 C = vec4(0.211324865405187, 0.366025403784439,
           -0.577350269189626, 0.024390243902439);
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);
  vec2 i1;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = mod(i, 289.0);
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
  + i.x + vec3(0.0, i1.x, 1.0 ));
  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy),
    dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}
void main() {
  gl_Position = transformMatrix * position;
  
  //Coordenada de textura
  vertTexCoord = texMatrix * sin(u_time) * vec4(texCoord, 1.0, 1.0);
  
  //Posición del vértice en coordenadas del ojo
  vertPosition = vec3(modelviewMatrix * position);  
  //Normal del vértice en coordenadas del ojo
  vertNormal = normalize(normalMatrix * normal);
  //Características de reflexión
  vertSpecular = specular;
  vertShininess = shininess;
  
  //Vector hacia la luz normalizado
  lightDir = -lightNormal[0];  
  //Color del vértice
  vertColor = color;
}
