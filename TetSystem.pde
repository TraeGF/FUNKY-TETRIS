

class TetSystem {
  
  // create ArrayList for Tetronimoes class
  ArrayList<Tetronimoes> tetronimoes;
  Vec2 origin;
  
  // constructor
  TetSystem(Vec2 location) {
    origin = location;
    tetronimoes = new ArrayList<Tetronimoes>();
  }
  
  // create addTet method to call on in draw
  void addTet() {
    float r = random(7);
    println(r);
         if(         r <= 1){tetronimoes.add(new TetI(width/2, 30));}
    else if(r > 1 && r <= 2){tetronimoes.add(new TetJ(width/2, 30));}
    else if(r > 2 && r <= 3){tetronimoes.add(new TetL(width/2, 30));}
    else if(r > 3 && r <= 4){tetronimoes.add(new TetO(width/2, 30));}
    else if(r > 4 && r <= 5){tetronimoes.add(new TetS(width/2, 30));}
    else if(r > 5 && r <= 6){tetronimoes.add(new TetT(width/2, 30));}
    else if(r > 6 && r <= 7){tetronimoes.add(new TetZ(width/2, 30));}
  }
  
  
  
  // create run method to call on in draw
  void run(){
    for (Tetronimoes tet: tetronimoes){
    tet.display();
    }
  
  
  // shapes that leave the screen get deleted
  // they have to be deleted from both the box2d world and our list
    for (int i = tetronimoes.size()-1; i >= 0; i--) {
      Tetronimoes tet = tetronimoes.get(i);
      if (tet.done()) {
        tetronimoes.remove(i);
      }
    }
  }
  
  void applySpin(){
    if (tetronimoes.isEmpty()){
      println("No Tetrominoes on screen");
    } else {
    if (keyPressed && (keyCode == UP)) {
      for (int i = tetronimoes.size()-1; i > tetronimoes.size()-2; i--) {
       Tetronimoes tet = tetronimoes.get(i);
       tet.setSpin(-5);
      }
    }
    else if (keyPressed && (keyCode == DOWN)) {
      for (int i = tetronimoes.size()-1; i > tetronimoes.size()-2; i--) {
       Tetronimoes tet = tetronimoes.get(i);
       tet.setSpin(5);
      }
    } else {
       for (int i = tetronimoes.size()-1; i > tetronimoes.size()-2; i--) {
       Tetronimoes tet = tetronimoes.get(i);
       tet.setSpin(0);
       }
     }
   }
 }
  
  void applyWind(){
    int f = 50;
      // apply the wind force when mouse is pressed
    if (keyPressed && (keyCode == RIGHT)) {
      for (int i = tetronimoes.size()-1; i > tetronimoes.size()-2; i--) {
       Tetronimoes tet = tetronimoes.get(i);
       Vec2 wind = new Vec2(f,0);
       tet.applyForce(wind);
      }
    } else if (keyPressed && (keyCode == LEFT)) {
      for (int i = tetronimoes.size()-1; i > tetronimoes.size()-2; i--) {
        Tetronimoes tet = tetronimoes.get(i);
        Vec2 wind = new Vec2(-f,0);
        tet.applyForce(wind);
      }
    }
  }
}
