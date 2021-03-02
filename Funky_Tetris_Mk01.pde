/*
code modified from several of Daniel Shiffman's 'Nature of Coding' example sketches
Created by Jared Ireland && Trae Gallemit-Fraser
*/



// Import all related libraries for physics engine
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
//import org.jbox2d.dynamics.joints.*;


// A reference to our box2d world
Box2DProcessing box2d;

// A list to track fixed objects
ArrayList<Boundary> boundaries;

// initialize TetSystem ts
TetSystem ts; 

boolean buttonPressed;

float reset = 0;

// set Challenge rating and difficulty
float startingDifficulty     =       1;       // 1 is easy, 5 is hard, 10 is extreme 
float challengeRating        =       1;       // 0 is no challenge, 1 is easy, 10 is hard, 100 is EXTREME 
float gravity;
// Initiate variables for buttons
int buttonX, buttonY, buttonW, buttonH;
PImage img;
PImage img2;
PFont mono;

void setup() {
  size(375,750);
  // Establish link to background images
  img = loadImage("start menu.jpg");
  img2 = loadImage("game baord.jpg");
  
  // Some basic parameters for the start button
  buttonW = 200;
  buttonH = 50;
  textSize(buttonH);
  buttonX = (width-buttonW)/2;
  buttonY = (height-buttonH)/2/4;
  // Assume the button has not been pressed
  buttonPressed = false;
  
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this,20);
  box2d.createWorld();
  // Turn on collision listening!
  // box2d.listenForCollisions();
 

  ts = new TetSystem(new Vec2(width/2, 50));
  
  
  // create arraylist for boundary  
  boundaries = new ArrayList<Boundary>();

  int bOffsetX = 83;
  int bOffsetY = 130;

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(width/2,height-bOffsetY,width,10,0));
  boundaries.add(new Boundary(width/2,0,width/2,3,0));
  boundaries.add(new Boundary(bOffsetX,height/2,3,height*2,0));
  boundaries.add(new Boundary(width-bOffsetX,height/2,3,height*2,0));
  }

void draw() {
  background(0);
  image(img, 0, 0);
  
  // set the gravity of the world
  // gravity is based on difficulty and challenge rating
  // we use 'reset' to reset the gravity when game starts 
  gravity = -startingDifficulty - ((frameCount * challengeRating) - (reset * challengeRating)) / 10000;
  box2d.setGravity(0, gravity);
  
  // Check if button has been pressed
  if (buttonPressed) {
    println("Time Since Start: "+(frameCount/60-reset/60)+", gravity: "+gravity+", reset: "+reset);
    // Change background image
    image(img2, 0, 0);
    mono = createFont("ColdWar.ttf",15);
    textFont(mono);
    text("Use arrow keys to move", buttonX-15, 15);
    text("Press 'N' to spawn new piece", buttonX-35, 35);
    // call on TetSystems functions
    ts.run();
    ts.applyWind();
    ts.applySpin();
    // Step through time
    box2d.step();
    // Display all the boundaries
    for (Boundary wall: boundaries) { wall.display(); }
  } else {
    println("Time on Menu: "+frameCount/60+", gravity: "+gravity);
    // Change text colour on hover
      if (mouseX > buttonX           &&
          mouseX < buttonX + buttonW && 
          mouseY > buttonY           &&
          mouseY < buttonY + buttonH) 
           { fill(0, 225, 0); }
      else { fill(250, 100, 0); }
    // Show the button
    mono = createFont("ColdWar.ttf",30);
    textFont(mono);
    text("START GAME", buttonX, buttonY+buttonH-10);    
  }  
}

void mousePressed() {
   if ( mouseX > buttonX         && 
        mouseX < buttonX+buttonW && 
        mouseY > buttonY         && 
        mouseY < buttonY+buttonH )
      { buttonPressed = true; 
        ts.addTet();
        reset = frameCount;
        println(reset);
      }  
    }

void keyPressed(){ if (key == 'n' || key == 'N' ) { ts.addTet(); } }
    
//// Collision event functions!
//void beginContact(Contact cp) {
//  //Get both fixtures
//  Fixture f1 = cp.getFixtureA();
//  Fixture f2 = cp.getFixtureB();
//  // Get both bodies
//  Body b1 = f1.getBody();
//  Body b2 = f2.getBody();

//  // Get our objects that reference these bodies
//  Object o1 = b1.getUserData();
//  Object o2 = b2.getUserData();
  
//  if (o1.getClass() == Tetronimoes.class && o2.getClass() == Tetronimoes.class) {
//    Tetronimoes t1 = (Tetronimoes) o1;
//    t1.change();
//    Tetronimoes t2 = (Tetronimoes) o2;
//    t2.change();
//  }
  
//}
