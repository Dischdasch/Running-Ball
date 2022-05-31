class Fluid {
    private String fluidType;
    private float fluidHeight;
    
    private final String textureMap = "data/Shaders/Water_002_SD/Water_002_COLOR.jpg";
    private final String bumpMap = "data/Shaders/Water_002_SD/Water_002_ROUGH.jpg";
    private final String fragmentShaderPath = "./data/Shaders/WaterFrag.glsl";
    private final String vertexShaderPath = "./data/Shaders/StandardVert.glsl";
    PShader shader;

    public Fluid(float height, boolean isWater){
        shader = loadShader(fragmentShaderPath, vertexShaderPath);
        shader.set("texMap", loadImage(textureMap));
        shader.set("bumpMap", loadImage(bumpMap));
        shader.set("bumpScale", 50.0);
        shader.set("specularIntensity", 1.0);
        shader.set("diffuseIntensity", 1.0);
        shader.set("ambientIntensity", 0.5);
        shader.set("specularColor", 1.0, 1.0, 1.0);
        shader.set("diffuseColor", 1.0, 1.0, 1.0);
        shader.set("ambientColor", 1.0, 1.0, 1.0);
        shader.set("fogColor", backgroundColor.x, backgroundColor.y, backgroundColor.z);
        shader.set("scale", 10.0);
        shader.set("fogIntensity", 100.0);
        shader.set("fluidSpeed", 0.1);
        
        fluidHeight = height;
    }

    public void update(){
        pushMatrix();
        shader.set("u_time", millis()/1000f);
        shader(shader);
        translate(-50000, fluidHeight, -50000);
        rotateX(HALF_PI);
        scale(100000,100000,100000);
        quad(0,0,0,1,1,1,1,0);
        popMatrix();
        resetShader();
    }
}
