

//float AnclajeC.x = 400;
//float AnclajeC.y = 575;
//float AnclajeC.z = 0;

float espaciado = 640;
float altura = 400;
float espaciadoef = 60;

PVector AnclajeA, AnclajeB, AnclajeC;
PVector EffectorA, EffectorB, EffectorC;



void setup() {
  size(800, 600, P3D);
  //translate(130, height/2, 0);
  frameRate(15);
  AnclajeA = new PVector(60, 20, 0);

  AnclajeB = AnclajeA.copy();
  AnclajeB.add(espaciado, 0, 0);

  AnclajeC = new PVector(espaciado, 0, 0);
  //AnclajeC.rotate(0.942478);
  AnclajeC.rotate(PI/3);
  AnclajeC.add(AnclajeA);


  EffectorA = new PVector(width/2, height/2, 0);

  EffectorB = new PVector(espaciadoef, 0, 0);
  EffectorB.add(EffectorA);

  EffectorC = new PVector(espaciadoef, 0, 0);
  EffectorC.rotate(PI/3);
  EffectorC.add(EffectorA);
}



void draw() {
  float longitudA;
  float longitudB;
  float longitudC;
  float distsuelo;

  background(220);

  strokeWeight(1);
  ellipse(AnclajeA.x, AnclajeA.y, 30, 30);
  ellipse(AnclajeB.x, AnclajeB.y, 30, 30);
  ellipse(AnclajeC.x, AnclajeC.y, 30, 30);

  //Mostrar longitudes cuerdas
  longitudA = dist(AnclajeA.x, AnclajeA.y, AnclajeA.z, EffectorA.x, EffectorA.y, EffectorA.z);
  longitudB = dist(AnclajeB.x, AnclajeB.y, AnclajeB.z, EffectorB.x, EffectorB.y, EffectorB.z);
  longitudC = dist(AnclajeC.x, AnclajeC.y, AnclajeC.z, EffectorC.x, EffectorC.y, EffectorC.z);
  distsuelo = altura + EffectorC.z;
  textSize(18);
  fill(0, 102, 153, 204);
  text(longitudA, AnclajeA.x+10, AnclajeA.y, -30);
  text(longitudB, AnclajeB.x, AnclajeB.y+30, -30);
  text(longitudC, AnclajeC.x+30, AnclajeC.y+30, -30);
  text("dist suelo", 30, 200, -30);
  text(distsuelo, 30, 240, -30);

  //noStroke();
  //lights();
  //translate(40, 40, 0);
  //sphere(30);
  //translate(760, 40, 0);
  //sphere(30);
  //translate(400, 400, 0);
  //sphere(30);

  //Endeffector
  strokeWeight(2);
  line(EffectorA.x, EffectorA.y, EffectorA.z, EffectorB.x, EffectorB.y, EffectorB.z);
  line(EffectorB.x, EffectorB.y, EffectorB.z, EffectorC.x, EffectorC.y, EffectorC.z);
  line(EffectorC.x, EffectorC.y, EffectorC.z, EffectorA.x, EffectorA.y, EffectorA.z);

  //Cables
  strokeWeight(3);
  line(AnclajeA.x, AnclajeA.y, AnclajeA.z, EffectorA.x, EffectorA.y, EffectorA.z);
  line(AnclajeB.x, AnclajeB.y, AnclajeB.z, EffectorB.x, EffectorB.y, EffectorB.z);
  line(AnclajeC.x, AnclajeC.y, AnclajeC.z, EffectorC.x, EffectorC.y, EffectorC.z);
}

void keyPressed() {
  float distancia;
  PVector movimiento;
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      movimiento = new PVector(0, -10, 0);
      break;
    case DOWN:
      movimiento = new PVector(0, 10, 0);
      break;
    case LEFT:
      movimiento = new PVector(-10, 0, 0);
      break;
    case RIGHT:
      movimiento = new PVector(10, 0, 0);
      break;
    case ENTER:
      //println(AnclajeA.mag());
      //println(dist(0, 0, 0, AnclajeA.x, AnclajeA.y, AnclajeA.z));
      //distancia = dist(AnclajeA.x, AnclajeA.y, AnclajeA.z, AnclajeC.x, AnclajeC.y, AnclajeC.z);
      //println(distancia);
    default:
      movimiento = new PVector(0, 0, 0);
      break;
    }
  } else
  {
    switch(key) {
    case 'q':
      movimiento = new PVector(0, 0, 10);
      break;
    case 'a':
      movimiento = new PVector(0, 0, -10);
      break;
    default:
      movimiento = new PVector(0, 0, 0);
      break;
    }
  }
  EffectorA.add(movimiento);
  EffectorB.add(movimiento);
  EffectorC.add(movimiento);
}