//import processing.sound.*;

//// Initializing game variables
//SoundFile death;
//SoundFile background;
//SoundFile back;
PImage img;
PImage img2;
PImage img3;
PImage img4;
PImage img6;
PImage night;
PImage sunrise;
PFont font;


int pun = 1; // Damage pigs do to the point tally
String name = "Level 1"; // Level name
int score = 0; // Score tally
String state = "s0"; // current state
String passing = "one"; // Variable for enemies to use
String level = "1"; // level 
float r = 0.01; // randomness variable
float speed = 5; // Speed of the pigs
String mode = "Starting"; // Current mode
boolean hacks = false;

//Stats
int pigsKilled;


// Initializing lists of game objects
Dragon d = new Dragon(15);
float count = 0;
ArrayList<enemy> mobs = new ArrayList<enemy>(); // list of enemies
ArrayList<fire> shots = new ArrayList<fire>(); // list of fireballs
ArrayList<enemy> dead = new ArrayList<enemy>(); // list dead pigs
ArrayList<projectile> projectiles = new ArrayList<projectile>(); // list of enemy projectiles
ArrayList<enemy> cOD = new ArrayList<enemy>(); // list of pigs which have killed the player
ArrayList<projectile> cODP = new ArrayList<projectile>(); // list of projectiles which have hit the player
ArrayList<cloud> clouds = new ArrayList<cloud>(); // list of clouds
ArrayList<cloud> deadClouds = new ArrayList<cloud>(); // list of clouds off of the screen
float musicCount = 0;

void setup() {

  frameRate(120);
  size(1700, 700);

  //loading images into the program,
  //includes:
  // - background image
  // - dragon heads and body
  // - Fireball 1 and 2
  sunrise = loadImage("skyy.png");
  night = loadImage("night.jpg");
  img = loadImage("dragonhead.png");
  img2 = loadImage("evo2.png");
  img3 = loadImage("bacc.jpg");
  img4 = loadImage("fire2.png");
  img6 = loadImage("bod3.png");
  font = createFont("slkscre.ttf", 255);
  //loading soundFiles 
  //death = new SoundFile(this, "death.mp3");
  //background = new SoundFile(this, "music.mp3");
  textFont(font);
}

void keyPressed() { // Key Pressed function
  if (key == 'r' && mode == "lost") { // To transition from "lost" mode to "play" mode. 
    mode = "Starting";
  }
  if (key == 'e' && mode == "lost") { // To exit the game while the game is in the "lost" mode.
    exit();
  }
  if (key == 'p' && mode == "play") { // To pause the game if the game is in the "play" mode. 
    mode = "pause";
  }
  if (key == 't' && mode == "pause") { // To resume the game if the game is in the "pause" mode.
    mode = "play";
  }
  if ( key == 'h') { // Turns on cheats
    hacks = !hacks;
  }
  if (key == 's') { // Skips to final level
    score = 699;
    hacks = true;
  }
  if (key == 'a' && mode == "won") { // If the player wants to play again after winning. Changing mode from "won" to "starting"
    reset();
  }
}

void draw() { // For every frame(main game loop)
  if (musicCount == 1 ) {
    //  background.play();
  }
  if (musicCount > 3600 ) {
    //  background.play();
    //  musicCount = 1;
  }
  background(0);
  count++; // Increments count

  if (mode == "Starting") { // If the mode is in "starting"
    startScreen(); // Call the startScreen function
    if (mousePressed) { // starts the game by transitioning to "play" mode.
      mode = "play";
    }
  }

  if (mode == "pause") { // If the "mode" is pause
    pauseScreen(); // call the pauseScreen function
  }

  if (mode == "lost") { // If the "mode" is lost
    loseScreen(); // Call the loseScreen function
  }

  if (mode == "won") { // If the "mode" is won
    winScreen(); // Call the winScreen function
  }

  if (mode == "play") { // If the mode is "play" 
    fill(255);
    image(img3, 0, 0); // draws the background image for the first level
    
    if (score >= 15) { // If the player has reached the threshold for the second level, change game configurations by changing game variables 
      image(img3, 0, 0); // Draws the background image for the second level
      pun = 3;
      state = "two";
      d.setState(state);
      passing = "two";
      name = "Level 2";
      level = "2";
      r = 0.02;
      speed = 10;
    }
    if (score >= 50) { // If the player has reached the threshold for the third level, change game configurations by changing game variables
      image(img3, 0, 0); // Draws the background image for the third level
      pun = 5;
      state = "three";
      d.setState(state);
      passing = "two";
      name = "Level 3";
      level = "3";
      r = 0.06;
      speed = 10;
    }
    if (score >= 100) { // If the player has reached the threshold for the fourth level, change the game configurations by changing game variables
      image(night, 0, 0); // Draws the background image for the fourth level 
      pun = 10;
      r=0.09;
      speed = 20;
      name = "Level 4";
      state = "four";
      level = "4";
      speed = 15;
    }

    if (score >= 200) { // If the player has reached the threshold for the fifth level, change the game configurations by changing game variables
      image(night, 0, 0); // Draws the background image for the fifth level
      pun = 15;
      r=0.3;
      speed = 20;
      name = "Level 5";
      level = "5";
      speed = 15;
    }

    if (score >= 700) { // If the player has reached the point threshold for victory, set the mode to won 
      mode = "won";
    }


    if (score < 0) { // If the player's point tally has gone below 0, set mode to lost
      mode = "lost";
    }

    if (random(1) < r) { // Randomiser for spawning pigs
      mobs.add(new enemy(1699, random(0, 600), speed, level));
    }

    if (random(1) < 0.02) { // Randomiser for spawning clouds
      clouds.add(new cloud(1800, random(500, 700), speed));
    }

    d.drawDragon(mouseX, mouseY); // Draw the dragon
    
    for (enemy e : mobs) { // For every enemy in the list of enemies
      e.moveE(); // Draw and move the enemy
      e.shoot(projectiles, level); // If the conditions are correct, shoot a projectile
      if (e.x < 0) { // if an enemy's x coordinate is past the screen(below 0), set them to dead and add them to the list of pigs to be removed from the list of pigs
        e.dORA = "dead";
        dead.add(e);
        score -= pun; // Decrease the score by the current damage value 
      }
    }

    for (projectile p : projectiles) { // For every enemy projectile in the list of projectiles, shoot them
      p.shootProjectile();
    }

    if (state == "four" || state == "five" || hacks) { // If the player is currently in level 4 or level 5, or cheats are activated enable fire breath
      if (mousePressed) { // Fire breath
        shots.add(new fire(mouseX, mouseY, 2, passing));
      }
    }

    for (fire f : shots) { // For every fireball in the list of fireballs
      if (f.state == "active") { // If the fireball is active, draw and shoot the fireball 
        f.shoot();
      }
    }

    if (shots.size() > 10) { // To limit the size of the list of fireballs to balance the game
      shots.remove(0); 
    }

    checkColliding(); // Check if any fireballs have hit any of the pigs
    
    for (enemy e : dead) { // For every enemy in the list of dead pigs, remove them from the original list of pigs
      mobs.remove(e);
    }
    
    if (dragonHit()) { // If the dragon has collided with any pigs
      delay(1000);
      mode = "lost";
    }
    
    if (checkHit()) { // Check if the dragon has been hit by any of the pig projectiles
      score--; // if so, decrease score by one
      tint(255, 0, 0);
      d.drawDragon(mouseX, mouseY);
      tint(255, 255, 255);
    }
    
    for (projectile p : cODP) { // For every projectile in the dead projectiles, remove them from the original list of projectiles
      projectiles.remove(p);
    }

    for (cloud c : clouds) { // For every cloud in the list of clouds
      c.moveClouds(); // move the cloud
      if (c.x < -300) { // if the cloud is past the left side of the screen add it to the list of dead clouds
        deadClouds.add(c);
      }
    }

    for (cloud c : deadClouds) { // For every cloud in the list of dead clouds, remove them from the list of original clouds
      clouds.remove(c);
    }

    // Draws game state text on screen
    textSize(50);
    text(score, 100, 100);
    textSize(20);
    text("Press 'p' to pause", 100, 650);
    textSize(70);
    text(name, 500, 100);
  }
  musicCount++;
}


/////////////////////////////////////////////////

public void mouseClicked() { // if mouse is clicked
  if (mode == "play" && count > 10) { 
    shots.add(new fire(mouseX, mouseY, 2, passing)); // add a new fireball to list of fireballs
  }
}

public void startScreen() { // Start Screen function
  reset(); // Resets game variables
  image(img3, 0, 0);
  textSize(135);
  text("WHEN PIGS FLY", 200, 400);
  textSize(50);
  text("Press mouse to begin!", 435, 600);
}

public boolean checkHit() { // checkHit function
  ArrayList<ball> drag = d.getDragon(); // Gets the list of ball objects which make up the dragon's body
  for (ball b : drag) { // For every ball object in the dragon's body
    for (projectile p : projectiles) { // For every projectile in the list of projectiles
      if (b.x >p.x-p.w && b.x < p.x+p.w && b.y > p.y-p.w && b.y < p.y+p.w || mouseX + 50 > p.x-p.w && mouseX-50 < p.x+p.w && mouseY > p.y-p.w-10 && mouseY < p.y+p.w+20) { // Check whether either the dragon's head or any ball is colliding with a projectile
        cODP.add(p); // If so add that projectile to the list of dead projectiles
        return true; // return true
      }
    }
  }
  return false;
}

public boolean checkColliding() { // checkColliding function
  for (enemy e : mobs) { // For every enemy in the list of enemies
    for (fire f : shots) { // For every fireball in the list of fireballs
      if (f.x - 20> e.x-e.w/2 && f.x -20 < e.x+e.w/2 && f.y > e.y-e.w/2 && f.y < e.y+e.w/2 && f.state == "active" && e.dORA == "alive") { // Check whether any of the fireball objects are colliding with any pigs
        e.die(); // if so, kill the pig and add it to the list of dead pigs
        dead.add(e);
        e.dORA = "dead";
        f.state = "no"; // fireball is no longer active
        score++; // increment the score
        pigsKilled++; // increment the amount of pigs killed
        return true; // return true
      }
    }
  }
  return false;
}

public boolean dragonHit() { // dragonHit function
  ArrayList<ball> bb = d.getDragon();
  for (ball b : bb) { // For every ball in the dragon's body
    for (enemy e : mobs) { // for every active mob
      if (b.x > e.x-e.w/2 && b.x < e.x+e.w/2 && b.y > e.y-e.w/2 && b.y < e.y+e.w/2 && e.dORA == "alive" || mouseX + 30 > e.x-e.w/2 && mouseX-30 < e.x+e.w/2 && mouseY > e.y-e.w/2 && mouseY < e.y+e.w/2) { // check whether any ball object is colliding with an enemy or if the dragon's head is colliding with any mobs 
        cOD.add(e); // if so, add the pig to the list of pigs which have killed the dragon
        return true; // return true
      }
    }
  }
  return false;
}

public void winScreen() { // winScreen function
  mobs.clear(); // clears list of mobs
  image(sunrise, 0, 0); // draws win screen background
  d.drawDragon(mouseX, mouseY); // draws the dragon
  textSize(90);
  text("You Won!", 400, 310);
  textSize(50);
  text("Pigs killed: " + pigsKilled, 420, 400);
  textSize(20);
  text("Thanks for playing :)", 1300, 660);
  text("Press 'a' to play again", 420, 510);
  if (hacks) {
    textSize(30);
    text("u cheated tho", 420, 430);
  }
}

public void pauseScreen() { // pauseScreen function
  background(255);
  fill(0);
  textSize(90);
  text("Current Stats", 400, 300);
  textSize(40);
  text("Pigs killed: " + pigsKilled, 420, 400);
  textSize(20);
  text("Press 't' to resume", 420, 450);
}

public void loseScreen() { // loseScreen function
  fill(255);
  background(0);
  tint(255, 45, 40);
  textSize(200);
  text("You lose", 200, 400);
  textSize(50);
  text("Press 'e' to exit", 530, 600);
  textSize(30);
  text("Press 'r' to play again", 570, 640);
  textSize(20);
  text("Ghost Dragon", mouseX, mouseY - 70);
  tint(40, 20, 170);
  d.drawDragon(mouseX, mouseY);
  tint(255, 255, 255);
  for (enemy e : cOD) {
    tint(255, 89, 23);
    e.drawE();
    tint(255, 255, 255);
    fill(255, 0, 0);
    textSize(15);
    text("This pig killed you", e.x, e.y);
  }
}

public void reset() { // Sets all game variable and lists to initial states
  d = new Dragon(15);
  tint(255);
  fill(255);
  mobs.clear();
  clouds.clear();
  shots.clear();
  dead.clear();
  projectiles.clear();
  cOD.clear();
  name = "Level 1";
  score = 0;
  state = "s0";
  passing = "one";
  level = "1";
  r = 0.01;
  speed = 5;
  mode = "Starting";
  count = 0;
}
