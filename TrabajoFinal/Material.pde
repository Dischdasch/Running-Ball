class Material {
  float ambientIntensity, diffuseIntensity, specularIntensity;
  PVector fogColor, ambientColor, diffuseColor, specularColor;
  PImage albedo, bumpMap;
  float scale, bumpScale;
  PShader material;
  
  Material(PShader material, float ambientIntensity, float diffuseIntensity, float specularIntensity, PVector fogColor, PVector ambientColor, PVector diffuseColor, PVector specularColor, PImage albedo, float scale, PImage bumpMap, float bumpScale) {
    this.ambientIntensity = ambientIntensity;
    this.diffuseIntensity = diffuseIntensity;
    this.specularIntensity = specularIntensity;
    this.fogColor = fogColor.copy();
    this.ambientColor = ambientColor.copy();
    this.diffuseColor = diffuseColor.copy();
    this.specularColor = specularColor.copy();
    this.albedo = albedo;
    this.bumpMap = bumpMap;
    this.scale = scale;
    this.bumpScale = bumpScale;
    this.material = material;
    setMaterial();
  }
  
  void setMaterial() {
    material.set("ambientIntensity", ambientIntensity);
    material.set("diffuseIntensity", diffuseIntensity);
    material.set("specularIntensity", specularIntensity);
    material.set("fogColor", fogColor);
    material.set("ambientColor", ambientColor.x, ambientColor.y, ambientColor.z);
    material.set("diffuseColor", diffuseColor.x, diffuseColor.y, diffuseColor.z);
    material.set("specularColor", specularColor.x, specularColor.y, specularColor.z);
    material.set("texMap", albedo);
    material.set("scale", scale);
    material.set("bumpMap", bumpMap);
    material.set("bumpScale", bumpScale);
    material.set("fogIntensity", fogIntensity);
    shader(material);
  }
}
