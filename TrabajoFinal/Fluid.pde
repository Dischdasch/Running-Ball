class Fluid {
    private String fluidType;
    private Platform fluidMesh;
    private float fluidHeight;
    
    private String waterShader;
    private String lavaShader;

    public Fluid(float height, boolean isWater){
        if (isWater) {
            fluidType = "WATER";
        } else {
            fluidType = "LAVA";
        }
        this.fluidHeight = height;
        fluidMesh = new Platform(0, fluidHeight, 0, 100000, 1, 100000, 0, 0, 0);
    }

    public void update(){
        //if (fluidType = "WATER") {
        //    shader(waterShader);
        //}
        //if (fluidType = "LAVA") {
        //    shader(lavaShader);
        //}
        fluidMesh.display();
    }
}
