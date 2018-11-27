/*
Megan Imperato

A4: Open Hand Plant by Zack Ceme
Spiral placed in center of canvas (color of spiral is determined by you, as well as thickness)
Spiral unfurls and becomes straight line (must be horizontal)
Straight line is in center of canvas
Branching pattern grows out from middle of straight line
Light blue/green gradient background
Roots might grow from under straight line (optional)
Everything below straight line is up to your interpretation

References:
Spirals by Mohini Dutta http://www.openprocessing.org/sketch/527404
Tree fractal, natural, animated by EnderPicture https://www.openprocessing.org/sketch/504377
*/

//magic numbers
int GRADWIDTH=5; //makes gradient draw faster
color LINECOLOR=color(250);
int LINEWIDTH=10;
float ANGLEINCREMENT=0.0001;

//variables for spiral
float angle;
float angleChange;
boolean showSpiral;
Point[] points;

//variables for line
int lineX;
int lineX1;
int lineX2;

//variables for tree
int levels;
int drawLevel;
ArrayList<ArrayList<PVector[]>> pointsTree;

//variables for background
boolean redrawBackground;
String[] instructions={"Light blue/green gradient background",
"Spiral placed in center of canvas \n(color of spiral is determined by you, as well as thickness)",
"Spiral unfurls and becomes straight line (must be horizontal) \nStraight line is in center of canvas",
"Branching pattern grows out from middle of straight line \nRoots might grow from under straight line (optional)\nEverything below straight line is up to your interpretation"};
int instruction;

void setup(){
  frameRate(60);
  fullScreen();
  
  angleChange=0;
  showSpiral=true;
  points = new Point[width];
 
  lineX=width/2;
  lineX1=0;
  lineX2=width;
  
  levels =17;
  drawLevel=levels;
  pointsTree= new ArrayList<ArrayList<PVector[]>>();
  for (int i=0; i<=levels; i++){
    pointsTree.add(new ArrayList<PVector[]>());
  }
  drawY(levels,0,new PVector(width/2,height/2-LINEWIDTH));
  
  redrawBackground=true;
  instruction=1;
  makeBackground();
}

void draw(){

  if (redrawBackground){
    makeBackground();
    write();
  }
  fill(LINECOLOR); 
  stroke(LINECOLOR); 
  if (showSpiral){ //draw the spiral?
    //Spiral ---> Horizontal Line
    angle=0.00;
      for (int i=0; i<points.length; i++){
        points[i]=new Point(1+(0.5)*i);
        if (angle>=0){
          angle += 0.01-angleChange;
        } else {
          showSpiral=false;
        }
    }
    angleChange+=ANGLEINCREMENT;
    for (int i=0; i<points.length; i++){ 
      points[i].show(); 
    }
  } else {
    instruction=2;
    stroke(LINECOLOR);
    strokeWeight(LINEWIDTH);
     if (lineX>0) {
       lineX-=width/200;
       line(lineX,height/2,width,height/2);
      } else {
        line(lineX1,height/2,lineX2,height/2);
        if (lineX1<width/2-width/9){ //shrink the line
          lineX1+=width/500;
          lineX2-=width/500;
          if(lineX1>width/2-width/9){
            instruction=3;
          }
        } else { //draw the tree
          redrawBackground=false;
          frameRate(2);
          for (int c = 0; c < pointsTree.get(drawLevel).size(); c++) {
            PVector lastPos = pointsTree.get(drawLevel).get(c)[0];
            PVector currentPos = pointsTree.get(drawLevel).get(c)[1];
            strokeWeight(drawLevel);  
            stroke(map(drawLevel,0,levels,250,0));
            line(lastPos.x, lastPos.y, currentPos.x, currentPos.y);
          }
          // change level if not at end
          if (drawLevel > 0) {
            drawLevel--;
            //icecicles
            float x= random(width/2-width/9, width/2+width/9);
            line(x, height/2+LINEWIDTH, x,random(height/2+LINEWIDTH, height));
          }  else {
            setup();
          }
       }
     }
   }
}

void makeBackground(){
  //blue-green gradient
  for (int i = 0; i < height/GRADWIDTH; i++) {
    strokeWeight(GRADWIDTH);
    stroke(90, 109, 150-i/(GRADWIDTH*.75));
    line(0, i*GRADWIDTH, width, i*GRADWIDTH);
  }
}

void write(){
  fill(#B8DBAC);
  textSize(height/70);
  text(instructions[0]+"\n"+instructions[instruction], width/20, height*.85);
  text("Instructions by Zack Ceme\nImplemented by Meg Imperato", width/20, height*.95);
}
