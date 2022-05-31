static class MatrixOperations {
  static PVector xRotate(PVector point, float angle) {
    PVector result = new PVector();
    result.x = point.x;
    result.y = cos(angle)*point.y - sin(angle)*point.z;
    result.z = sin(angle)*point.y + cos(angle)*point.z;
    return result;
  }
  
  static PVector yRotate(PVector point, float angle) {
    PVector result = new PVector();
    result.x = cos(angle)*point.x + sin(angle)*point.z;
    result.y = point.y;
    result.z = -sin(angle)*point.x + cos(angle)*point.z;
    return result;
  }
  
  static PVector zRotate(PVector point, float angle) {
    PVector result = new PVector();
    result.x = cos(angle)*point.x - sin(angle)*point.y;
    result.y = sin(angle)*point.x + cos(angle)*point.y;
    result.z = point.z;
    return result;
  }
  
  static PVector vectorTranslate(PVector origin, PVector destination) {
    return PVector.add(origin, destination);
  }
}
