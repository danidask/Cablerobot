float espaciado = 300;
float altura = 400;
float espaciadoef = 40;
float escala = 0.9;

PVector AnclajeA, AnclajeB, AnclajeC;

Effector effector;

void setup() {
  size(800, 600, P3D);
  frameRate(15);

  AnclajeA = new PVector(0, espaciado, 0);

  AnclajeB = AnclajeA.copy();
  AnclajeB.rotate(radians(120));

  AnclajeC = AnclajeB.copy();
  AnclajeC.rotate(radians(120));

  effector = new Effector(new PVector(0, 0, 0), espaciadoef);
}

void draw() {
  float longitudA;
  float longitudB;
  float longitudC;
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
      break;
    case DOWN:
      effector.move(new PVector(0, 10, 0));
      break;
    case LEFT:
      effector.move(new PVector(-10, 0, 0));
      break;
    case RIGHT:
      effector.move(new PVector(10, 0, 0));
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
      break;
    case 'a':
      effector.move(new PVector(0, 0, -10));
      break;
    default:
      break;
    }
  }
}