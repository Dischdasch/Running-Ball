import java.util.Map;

public enum Control { 
  JUMP, FORWARD, BACK, LEFT, RIGHT, CONTINUE, 
    CAMERA_LEFT, CAMERA_RIGHT, CAMERA_UP, CAMERA_DOWN
};

public class ControllerManager {
  public HashMap<Control, Boolean> actionMap;
  private HashMap<Character, Control> mappings;

  private ControlDevice device;

  ControlButton jumpButton;
  ControlSlider leftStickX, leftStickY, rightStickX, rightStickY;

  public ControllerManager() {
    try {
      device = control.getDevice("Dispositivo de entrada Bluetooth compatible con XINPUT");
      leftStickX = device.getSlider("Eje X");
      leftStickY = device.getSlider("Eje Y");
      rightStickX = device.getSlider("Rotación X");
      rightStickY = device.getSlider("Rotación Y");
      leftStickX.setTolerance(0.3);
      leftStickY.setTolerance(0.3);
      rightStickX.setTolerance(0.3);
      rightStickY.setTolerance(0.3);
      jumpButton = device.getButton("Botón 0");
      jumpButton.plug(player, "jump", ControlIO.ON_PRESS);
      jumpButton.plug("onButtonPressed", ControlIO.ON_PRESS);
    } 
    catch (RuntimeException exception) {
      println("Device not found");
    }
    actionMap = new HashMap<Control, Boolean>();
    mappings = new HashMap<Character, Control>();
    addMappings();
  }
  private void addMappings() {
    mappings.put('x', Control.CONTINUE); 
    mappings.put('X', Control.CONTINUE);
    mappings.put('W', Control.FORWARD);  
    mappings.put('w', Control.FORWARD);
    mappings.put('S', Control.BACK); 
    mappings.put('s', Control.BACK);
    mappings.put('A', Control.LEFT); 
    mappings.put('a', Control.LEFT);
    mappings.put('D', Control.RIGHT); 
    mappings.put('d', Control.RIGHT);
    mappings.put(' ', Control.JUMP);
  }
  public void keyPressed(Character key) {
    if (mappings.containsKey(key)) {
      Control control = mappings.get(key);
      actionMap.put(control, true);
    }
  }
  public void keyReleased(Character key) {
    if (mappings.containsKey(key)) {
      Control control = mappings.get(key);
      actionMap.put(control, false);
    }
  }
  public Control [] getActions() {
    Control [] controls = new Control[actionMap.size()];
    int i = 0;
    for (Map.Entry<Control, Boolean> entry : actionMap.entrySet()) {
      if (entry.getValue()) {
        controls[i] = entry.getKey();
        i++;
      }
    }
    Control [] result = new Control[i];
    for (int j = 0; j < i; ++j) {
      if (controls[j] == null) break;
      result[j] = controls[j];
    }
    return result;
  }
  
  PVector getMovement() {
    PVector result = new PVector(0, 0, 0);
    if (device != null) {
      result.z = leftStickX.getValue();
      result.x = -leftStickY.getValue();
    }
    return result;
  }
  
  float getCameraMovement() {
    float result = 0f;
    if (device != null) {
      result = rightStickX.getValue();
    }
    return result;
  }
  
  float getCameraZoom() {
    float result = 0f;
    if (device != null) {
      result = rightStickY.getValue();
    }
    return result;
  }
}
