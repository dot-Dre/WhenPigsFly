class cloud{
  
  //fields for cloud object
  public float x; // x coordinate of cloud object
  public float y; // y coordinate of cloud object
  PImage cloud;
  public float speed; // speed of cloud object

  public cloud(float x, float y, float speed){ // constructor for cloud object
    this.x = x;
    this.y = y;
    this.speed = speed;
    cloud = loadImage("pinkcloud.png");
  }

  public void moveClouds(){ // moves the cloud object across the screen
    image(cloud, this.x, this.y);
    this.x -= this.speed+5;
  }

}
