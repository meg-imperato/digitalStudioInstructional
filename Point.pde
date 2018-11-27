class Point{
  float x;
  float y;
  
  Point(float xyMagnify){
    x = width/2 + cos(angle) * xyMagnify;
    y = height/2 + sin(angle) * xyMagnify;
  }
  
  void show(){
    stroke(LINECOLOR);
    fill(LINECOLOR);
    ellipse(x, y, LINEWIDTH, LINEWIDTH);
  }
}
