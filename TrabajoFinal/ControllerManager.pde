import java.util.Map;

public enum Control { JUMP, FORWARD, BACK, LEFT, RIGHT,
         CAMERA_LEFT, CAMERA_RIGHT, CAMERA_UP, CAMERA_DOWN };

public class ControllerManager {
  public HashMap<Control, Boolean> actionMap;
  private HashMap<Character, Control> mappings;
  public ControllerManager(){
    actionMap = new HashMap<Control, Boolean>();
    mappings = new HashMap<Character, Control>();
    addMappings();
  }
  private void addMappings(){
    mappings.put('w', Control.FORWARD);
    mappings.put('s', Control.BACK);
    mappings.put('a', Control.LEFT);
    mappings.put('d', Control.RIGHT);
    mappings.put(' ', Control.JUMP);
  }
  public void keyPressed(Character key){
    if(mappings.containsKey(key)){
      Control control = mappings.get(key);
      actionMap.put(control, true);
    }
  }
  public void keyReleased(Character key){
    if(mappings.containsKey(key)){
      Control control = mappings.get(key);
      actionMap.put(control, false);
    }
  }
  public Control [] getActions(){
    Control [] controls = new Control[actionMap.size()];
    int i = 0;
    for (Map.Entry<Control, Boolean> entry: actionMap.entrySet()) {
      if(entry.getValue()){
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
}
