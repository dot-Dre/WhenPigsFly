class fire {
  
  // fields for fireball object
  public float x; // x coordinate of fire ball object
  public float y; // y coordinate of fire ball object
  private PImage p; 
  public String state = "active"; // state of the fireball object
  private String power = "one"; // power of the fireball object
  private float v = 5; // speed of the fireball object
  private float w = 100;

  public fire(float x, float y, int d, String l) { // constructor for a fireball object
    this.x = x+160;
    this.y = y-20;
    this.power = l;
    p = loadImage("ball.png");
  }

  public void drawF() { // draws the fireball object
    if(power == "one"){ // if power is one
    image(p, this.x, this.y, this.w, this.w);
    }
    else if(power == "two"){ // if power is two
    image(img4, this.x,this.y, this.w, this.w); // fireball changes form
    this.v = 20; // fire ball is faster
    }
    else if(power == "three"){ // if power is three
    this.w = 120;
    image(p, this.x,this.y, this.w, this.w); 
    this.v = 30; // fire ball is faster
    }
  }

  public void shoot() { // moves the fire ball object across the screen
    this.x += this.v;
    this.w -= 0.5;
    if(this.w <= 0){
      this.state = "no";
    }
    drawF();
  }

}
