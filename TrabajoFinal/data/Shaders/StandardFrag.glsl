#ifdef GL_ES
  precision mediump float;
  precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

uniform sampler2D texMap;
uniform sampler2D bumpMap;
uniform float bumpScale;
uniform float specularIntensity;
uniform float diffuseIntensity;
uniform float ambientIntensity;
uniform vec3 specularColor;
uniform vec3 diffuseColor;
uniform vec3 ambientColor;
uniform vec3 fogColor;
uniform float scale;
uniform float fogIntensity;

varying vec3 vertPosition;
varying vec3 vertNormal;
varying vec4 vertColor;
varying vec4 vertTexCoord;
varying vec4 vertSpecular;
varying float vertShininess;

varying vec3 lightDir;

vec2 dHdxy_fwd(vec2 vUv) {
  vec2 dSTdx = dFdx(vUv);
  vec2 dSTdy = dFdy(vUv);

  float Hll = bumpScale * texture2D(bumpMap, vUv).x;
  float dBx = bumpScale * texture2D(bumpMap, vUv + dSTdx).x - Hll;
  float dBy = bumpScale * texture2D(bumpMap, vUv + dSTdy).x - Hll;

  return vec2(dBx, dBy);
}

vec3 perturbNormalArb(vec3 surf_pos, vec3 surf_norm, vec2 dHdxy) {
  vec3 vSigmaX = dFdx(surf_pos);
  vec3 vSigmaY = dFdy(surf_pos);
  vec3 vN = surf_norm;    // normalized

  vec3 R1 = cross(vSigmaY, vN);
  vec3 R2 = cross(vN, vSigmaX);

  float fDet = dot(vSigmaX, R1);

  vec3 vGrad = sign(fDet) * (dHdxy.x * R1 + dHdxy.y * R2);
  return normalize(abs(fDet) * surf_norm - vGrad);
}

void main() {
  vec2 st = vertTexCoord.st;
  st *= scale;
  vec4 texColor = texture2D(texMap, st);
  gl_FragColor = texColor; //Textura de entrada  
  vec3 displacedNormal = perturbNormalArb(vertPosition, vertNormal, dHdxy_fwd(st));
  float intensity;
  vec4 color;
  // Producto escalar normal y vector hacia la fuente de luz
  intensity = max(0.0, dot(lightDir, displacedNormal));
  float specular = 0.0;
  if (intensity > 0.0) {
    vec3 R = reflect(lightDir, displacedNormal);      // Reflected light vector
    vec3 V = normalize(-vertPosition); // Vector to viewer
    // Compute the specular term
    float specAngle = max(dot(R, V), 0.0);
    specular = pow(specAngle, vertShininess);
  }
  color = vec4(ambientIntensity * ambientColor +
    diffuseIntensity * intensity * diffuseColor +
    specularIntensity * specular * specularColor, 1.0);

  gl_FragColor = mix(color * texColor, vec4(fogColor, 1.0), pow(gl_FragCoord.z, fogIntensity));
}
