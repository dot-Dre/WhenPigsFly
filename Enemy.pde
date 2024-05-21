class enemy {

  // fields for enemy object
  private float w = 140; // width of the enemy object
  public float x; // x coordinate of the enemy object
  public float y; // y coordinate of the enemy object
  private PImage p;
  public String dORA = "alive";
  public String level = "1";
  public float speed;
  public float ySpeed = random(-3,3);
  public PImage p1;
  public PImage p2;
  
  public enemy(float x, float y, float speed, String level) { // constructor for an enemy object
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.level = level;
    p = loadImage("pigu.png");
    p1 = loadImage("dhead.png");
    p2 = loadImage("hh.png");
  }

  public void drawE() { // draws the enemy object
    image(p, this.x, this.y, this.w, this.w);
  }

  public void moveE() { // moves the enemy object
    if(this.level.equals("1")){ // if the object's level is one
      this.x -= speed; // basic straight across screen movement   
    }
    
    if(this.level.equals("2")){ // if the object's level is two
      // adds vertical movement plus increases speed
      this.x -= speed;
      this.y += ySpeed;
      if(this.y + 100 > height){
        this.y = height - 100;
        this.ySpeed = -ySpeed;
      }
      if(this.y < 0){
        this.y = 10;
        this.ySpeed = -ySpeed;
      }
    }
    
    if(this.level.equals("3")){ // if the object's level is three
    // same movement mechanics as level two
      this.x -= speed;
      this.y += ySpeed;
      if(this.y + 100 > height){
        this.y = height - 100;
        this.ySpeed = -ySpeed;
      }
      if(this.y - 100 < 0){
        this.y = 100;
        this.ySpeed = -ySpeed;
      } 
    }
    
    if(this.level.equals("4")){ // if the object's level is four
    // same movement mechanics as level three and two
      this.x -= speed;
      this.y += ySpeed;
      if(this.y + 100 > height){
        this.y = height - 100;
        this.ySpeed = -ySpeed;
      }
      if(this.y < 0){
        this.y = 100;
        this.ySpeed = -ySpeed;
      } 
    }
    
    if(this.level.equals("5")){ // if the object's level is five
    // same movement mechanics as level two, three and four
      this.x -= speed;
      this.y += ySpeed;
      if(this.y + 100 > height){
        this.y = height - 100;
        this.ySpeed = -ySpeed;
      }
      if(this.y - 100 < 0){
        this.y = 100;
        this.ySpeed = -ySpeed;
      } 
    }
    drawE();
  }

  public void shoot(ArrayList<projectile> p, String state){ // function to enable enemy object to shoot their own projectile
    if(this.dORA == "alive" && random(1) < 0.00193 && (state == "2" || state == "3")){ // if the enemy object is alive, and it's level is two or three and the random condition is met
      p.add(new projectile(this.x, this.y));
    }
  }

  public void die() { // death animation for pig
    tint(255, 0, 0);
    drawE();
    tint(255, 255, 255);
  }
}
