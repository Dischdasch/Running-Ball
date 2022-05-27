class Fluid {
    private String fluidType;
    private Platform fluidMesh;
    private float fluidHeight;
    
    private final String textureMap = "data/Shaders/Water_002_SD/Water_002_COLOR.jpg";
    private final String bumpMap = "data/Shaders/Water_002_SD/Water_002_ROUGH.jpg";
    private final String fragmentShaderPath = "./data/Shaders/StandardFrag.glsl";
    private final String vertexShaderPath = "./data/Shaders/StandardVert.glsl";
    PShader shader;

    public Fluid(float height, boolean isWater){
        shader = loadShader(fragmentShaderPath, vertexShaderPath);
        shader.set("texMap", loadImage(textureMap));
        shader.set("bumpMap", loadImage(bumpMap));
        shader.set("bumpScale", 100.0);
        shader.set("specularIntensity", 1.0);
        shader.set("diffuseIntensity", 1.0);
        shader.set("ambientIntensity", 1.0);
        shader.set("specularColor", 1.0, 1.0, 1.0);
        shader.set("diffuseColor", 1.0, 1.0, 1.0);
        shader.set("ambientColor", 1.0, 1.0, 1.0);
        shader.set("scale", 1.0);
        shader.set("fogIntensity", 0.0);
        shader.set("u_time", millis()/1000);
        fluidHeight = height;
        fluidMesh = new Platform(0, fluidHeight, 0, 100000, 10, 100000, 0, 0, 0, new PVector(1, 1, 1));
        
    }

    public void update(){
        pushMatrix();
        shader(shader);
        fluidMesh.display();
        popMatrix();
        resetShader();
    }

    public Platform getPlatform(){
        return fluidMesh;
    }
}
