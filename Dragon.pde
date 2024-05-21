class Dragon {

  // fields for dragon object
  private ArrayList<ball> dragon = new ArrayList<ball>(); // Array list of ball objects which represent the dragon object's body
  private int size; // size of the dragon
  private String state = "one"; // state of the dragon
  public float dx = 27; // xDelay for draw method
  public float dw = 5; // wDelay for draw method
 
  public Dragon(int s) { // constructor for dragon object
    this.size = s;
  }
 
  public void drawDragon(float x, float y) { // drawDragon method
    dragon.add(new ball(x, y, state));
    for (ball b : dragon) { // for every ball object in the dragon body list, draw it, but decrease its x value by dx everytime and decrease its w value by dw
      b.drawB();
      b.x -= dx;
      b.w -= dw;
    }
    if (dragon.size() > this.size) { // if the dragon's body has become larger than the size field
      dragon.remove(0);
    }
    
    if(state == "one"){ // if state equals one, draw the stage 1 dragon head
    image(img, mouseX, mouseY-80, 200, 200);
    }
    else if(state == "two"){ // if state equals two, draw the stage 2 dragon head 
    image(img2, mouseX-20, mouseY-80, 200, 200);
    }
    else if(state == "three"){ // if state equals three, draw the stage 3 dragon head
    image(img6, mouseX-29, mouseY-70, 180, 180);
    }
  }

  public ArrayList getDragon() { // returns the dragon object's list of ball objects 
    return dragon;
  }
  
  public void setState(String s){ // sets the state of the dragon object
   this.state = s;
  }
}
