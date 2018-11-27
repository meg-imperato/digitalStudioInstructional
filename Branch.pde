void keyTyped() { //regrow tree when space bar pressed
  if (key == ' '){
    makeBackground();
    pointsTree= new ArrayList<ArrayList<PVector[]>>();
    for (int i=0; i<=levels; i++){
      pointsTree.add(new ArrayList<PVector[]>());
    }
    drawY(levels,0,new PVector(width/2,height/2));
    drawLevel=levels;
  }
}

void drawY(int level,float angle, PVector lastPos) {
  // base case
  if (level < 0) 
    return;
  
  // create vector, and add onto last location of branch
  PVector currentPos = new PVector(0,-level*5).rotate(angle).add(lastPos);
  
  // other base case, if branch is under ground
  if (currentPos.copy().sub(new PVector(mouseX,mouseY)).y > height) 
    return;
  
  // add the line start end location into the level's array
  PVector[] temp ={lastPos, currentPos};
  pointsTree.get(level).add(temp);
  
  // do branch if random lets it 
  if (parseInt(random(1+level*level/10)) != 0)
    drawY(level-1,angle-PI/random(4,8),currentPos);
  
  // do branch if random lets it 
  if (parseInt(random(1+level*level/10)) != 0)
    drawY(level-1,angle+PI/random(4,8),currentPos);
}
