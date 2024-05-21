class ball {
  
  // fields for ball object
  private float x; // x coordinate of the ball object
  private float y; // y coordinate of the ball object
  private float w = 120; // width of the ball object
  private PImage p;
  private PImage p1;
  private PImage p2;
  private String state = "one"; // state of the ball object

  public ball(float x, float y, String state) { // constructor for ball object
    this.state = state;
    this.x = x-55;
    this.y = y-55;
    p = loadImage("bod2.png");
  }

  public void drawB(){ // draws ball object
    PImage ps = this.p;
  //  if(state == "one"){ps=this.p;}
  //  else if(state == "two"){ps=this.p;}
  //  else if(state == "three"){ps=this.p;}
    image(ps, this.x, this.y, w, w);
  }
  
}
