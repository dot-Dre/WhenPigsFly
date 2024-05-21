class projectile{
  
  // fields for projectile object
  public float x; // x coordinate of projectile object
  public float y; // y coordinate of projectile object
  public float w = 70; // width of projectile object
  public float speed = 20; // speed of projectile object
  
  public projectile(float x, float y){ // constructor for projectile object
    this.x = x;
    this.y = y;
  }
  
  public void shootProjectile(){ // moves the projectile object across the screen
    this.x -= speed;
    drawProj();
  }
 
  public void drawProj(){ // draws the projectile object
    fill(255);
    noStroke();
    circle(this.x, this.y, 25);
  }
  
}
