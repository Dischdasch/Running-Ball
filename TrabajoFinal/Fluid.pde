class Fluid {
    private String fluidType;
    private Platform fluidMesh;
    private float fluidHeight;
    
    private final String fragmentShaderPath = "./StandardFrag.glsl";
    private final String vertexShaderPath = "./StandardVert.glsl";
    PShader vertexShader, fragmentShader;

    public Fluid(float height, boolean isWater){
        vertexShader = loadShader(vertexShaderPath);
        fragmentShader = loadShader(fragmentShaderPath);
        if (isWater) {
            fluidType = "WATER";
        } else {
            fluidType = "LAVA";
        }
        this.fluidHeight = height;
        fluidMesh = new Platform(0, fluidHeight, 0, 100000, 10, 100000, 0, 0, 0, new PVector(1, 1, 1));
    }

    public void update(){
        if (fluidType == "WATER") {
            setValuesForWaterShader();
        }
        if (fluidType == "LAVA") {
            setValuesForLavaShader();
        }
        shader(vertexShader);
        shader(fragmentShader);
        fluidMesh.display();
    }

    private void setValuesForWaterShader(){
        vertexShader.set("transformMatrix", (PMatrix2D) getMatrix());
        vertexShader.set();
        vertexShader.set();
        vertexShader.set();
        vertexShader.set();

        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
    }

    private void setValuesForLavaShader(){
        vertexShader.set();
        vertexShader.set();
        vertexShader.set();
        vertexShader.set();
        vertexShader.set();

        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
        fragmentShader.set();
    }

    public Platform getPlatform(){
        return fluidMesh;
    }
}
