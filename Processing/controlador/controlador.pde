float espaciado = 300;
float altura = 400;
float espaciadoef = 40;
float escala = 0.9;
float pasosporcentimetro = 10;

float longitudA;
float longitudB;
float longitudC;
float antlongitudA;
float antlongitudB;
float antlongitudC;


PVector AnclajeA, AnclajeB, AnclajeC;

Effector effector;

JSONObject json;

void setup() {
  configurarpines();
  size(800, 600, P3D);
  frameRate(15);  

  AnclajeA = new PVector(0, espaciado, 0);
  AnclajeB = AnclajeA.copy();
  AnclajeB.rotate(radians(120));
  AnclajeC = AnclajeB.copy();
  AnclajeC.rotate(radians(120));

// Cargar la posicion actual del EF
  json = loadJSONObject("data/ultimaposicion.json");
  float posx = json.getFloat("posx");
  float posy = json.getFloat("posy");
  float posz = json.getFloat("posz");
  effector = new Effector(new PVector(posx, posy, posz), espaciadoef);  
  
  // Distancia inicial para comparar despues
  longitudA = dist(AnclajeA.x, AnclajeA.y, AnclajeA.z, effector.AnclajeA.x, effector.AnclajeA.y, effector.AnclajeA.z);
  longitudB = dist(AnclajeB.x, AnclajeB.y, AnclajeB.z, effector.AnclajeB.x, effector.AnclajeB.y, effector.AnclajeB.z);
  longitudC = dist(AnclajeC.x, AnclajeC.y, AnclajeC.z, effector.AnclajeC.x, effector.AnclajeC.y, effector.AnclajeC.z);
  antlongitudA = longitudA;
  antlongitudB = longitudB;
  antlongitudC = longitudC;
  
}

void draw() {

  float distsuelo;
  translate(width/2, height/2, 0);
  scale(escala, escala, escala);
  background(255);

  stroke(0);
  strokeWeight(1);
  ellipse(AnclajeA.x, AnclajeA.y, 30, 30);
  ellipse(AnclajeB.x, AnclajeB.y, 30, 30);
  ellipse(AnclajeC.x, AnclajeC.y, 30, 30);

  noStroke();
  noFill();
  ellipse(0, 0, espaciado*2, espaciado*2);

  //Textos
  effector.show();
  //Mostrar longitudes cuerdas
  longitudA = dist(AnclajeA.x, AnclajeA.y, AnclajeA.z, effector.AnclajeA.x, effector.AnclajeA.y, effector.AnclajeA.z);
  longitudB = dist(AnclajeB.x, AnclajeB.y, AnclajeB.z, effector.AnclajeB.x, effector.AnclajeB.y, effector.AnclajeB.z);
  longitudC = dist(AnclajeC.x, AnclajeC.y, AnclajeC.z, effector.AnclajeC.x, effector.AnclajeC.y, effector.AnclajeC.z);
  distsuelo = altura + effector.Centro.z;
  stroke(0);
  strokeWeight(1);
  textSize(18);
  fill(0, 102, 153);
  text("A: " + longitudA, AnclajeA.x+50, AnclajeA.y, 0);
  text("B: " + longitudB, AnclajeB.x - 50, AnclajeB.y - 30, 0);
  text("C: " + longitudC, AnclajeC.x, AnclajeC.y - 30, 0);
  text("dist suelo\n" + distsuelo, AnclajeB.x - 30, 100, 0);
  
  //Mover si procede
  if (antlongitudA != longitudA || antlongitudB != longitudB || antlongitudC != longitudC){
    int moverx = round((longitudA - antlongitudA) * pasosporcentimetro);
    int movery = round((longitudB - antlongitudB) * pasosporcentimetro);
    int moverz = round((longitudC - antlongitudC) * pasosporcentimetro);
  
    antlongitudA = longitudA;
    antlongitudB = longitudB;
    antlongitudC = longitudC;
    
    movermotores(moverx, movery, moverz);
    println(moverx, movery, moverz);
  }
  
  
  //Cables
  strokeWeight(3);
  line(AnclajeA.x, AnclajeA.y, AnclajeA.z, effector.AnclajeA.x, effector.AnclajeA.y, effector.AnclajeA.z);
  line(AnclajeB.x, AnclajeB.y, AnclajeB.z, effector.AnclajeB.x, effector.AnclajeB.y, effector.AnclajeB.z);
  line(AnclajeC.x, AnclajeC.y, AnclajeC.z, effector.AnclajeC.x, effector.AnclajeC.y, effector.AnclajeC.z);
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      effector.move(new PVector(0, -10, 0));
      guardarposicion(effector.Centro);
      break;
    case DOWN:
      effector.move(new PVector(0, 10, 0));
      guardarposicion(effector.Centro);
      break;
    case LEFT:
      effector.move(new PVector(-10, 0, 0));
      guardarposicion(effector.Centro);
      break;
    case RIGHT:
      effector.move(new PVector(10, 0, 0));
      guardarposicion(effector.Centro);
      break;
    case ENTER:
      //println(AnclajeA.mag());
      //println(dist(0, 0, 0, AnclajeA.x, AnclajeA.y, AnclajeA.z));
      //distancia = dist(AnclajeA.x, AnclajeA.y, AnclajeA.z, AnclajeC.x, AnclajeC.y, AnclajeC.z);
      //println(distancia);
    default:
      break;
    }
  } else
  {
    switch(key) {
    case 'q':
      effector.move(new PVector(0, 0, 10));
      guardarposicion(effector.Centro);      
      break;
    case 'a':
      effector.move(new PVector(0, 0, -10));
      guardarposicion(effector.Centro);
      break;
    case ' ':
      for (int i=0; i < numerodemotores; i++)
        activarmotor(i, false);
      println("desactivado");
      break;       
    default:
      break;
    }
  }
}

void guardarposicion(PVector posicion){
    json.setFloat("posx", posicion.x);
    json.setFloat("posy", posicion.y);
    json.setFloat("posz", posicion.z);
    saveJSONObject(json, "data/ultimaposicion.json");
}