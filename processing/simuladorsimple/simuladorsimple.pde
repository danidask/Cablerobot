//CONFIGURACION
float espaciado = 300; //(cm) distancia entre el centro y los anclajes 
float altura = 400; //(cm) distancia entre los anclajes y el suelo
float espaciadoef = 40; //(cm) distancia entre el centro del endeffector y los anclajes del mismo
float pasosporcentimetro = 100; //Numero de pasos que tiene quedar el motor PAP para sacar 1cm de cuerda
float escala = 0.9; //esto se puede cambiar para que ajuste la escala automaticamente en funcion de distancfias y tamaño pantalla

float longitudA;
float longitudB;
float longitudC;
float AntlongitudA = -1;
float AntlongitudB = -1;
float AntlongitudC = -1;

float distsuelo;

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

  //asume que el EF se encuentra arriba en el centro MODIFICAR!!!
  longitudA = dist(AnclajeA.x, AnclajeA.y, AnclajeA.z, effector.AnclajeA.x, effector.AnclajeA.y, effector.AnclajeA.z);
  longitudB = dist(AnclajeB.x, AnclajeB.y, AnclajeB.z, effector.AnclajeB.x, effector.AnclajeB.y, effector.AnclajeB.z);
  longitudC = dist(AnclajeC.x, AnclajeC.y, AnclajeC.z, effector.AnclajeC.x, effector.AnclajeC.y, effector.AnclajeC.z);
  AntlongitudA = longitudA;
  AntlongitudB = longitudB;
  AntlongitudC = longitudC;

}

void draw() {
  longitudA = dist(AnclajeA.x, AnclajeA.y, AnclajeA.z, effector.AnclajeA.x, effector.AnclajeA.y, effector.AnclajeA.z);
  longitudB = dist(AnclajeB.x, AnclajeB.y, AnclajeB.z, effector.AnclajeB.x, effector.AnclajeB.y, effector.AnclajeB.z);
  longitudC = dist(AnclajeC.x, AnclajeC.y, AnclajeC.z, effector.AnclajeC.x, effector.AnclajeC.y, effector.AnclajeC.z);
  distsuelo = altura + effector.Centro.z;
  
  int[] pasosadar = { 0, 0, 0 };
  boolean hayquemover = false;
  if (AntlongitudA != longitudA){
    pasosadar[0] = round((longitudA - AntlongitudA) * pasosporcentimetro);
    AntlongitudA = longitudA;
    hayquemover = true;
  }
  if (AntlongitudB != longitudB){
    pasosadar[1] = round((longitudB - AntlongitudB) * pasosporcentimetro);
    AntlongitudB = longitudB;
    hayquemover = true;
  }
  if (AntlongitudC != longitudC){
    pasosadar[2] = round((longitudC - AntlongitudC) * pasosporcentimetro);
    AntlongitudC = longitudC;
    hayquemover = true;
  }  
  
  if (hayquemover){
    printArray(pasosadar);
  }
  
  translate(width/2, height/2, 0);
  scale(escala);
  background(255);
  // Dibujar area de trabajo
  noStroke();
  noFill();
  ellipse(0, 0, espaciado*2, espaciado*2);  
  
  effector.show();

  // Dibujar anclajes
  stroke(0);
  strokeWeight(1);
  ellipse(AnclajeA.x, AnclajeA.y, 30, 30);
  ellipse(AnclajeB.x, AnclajeB.y, 30, 30);
  ellipse(AnclajeC.x, AnclajeC.y, 30, 30);

  //Textos
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

  //Pilares
  //stroke(0, 0, 255);
  //strokeWeight(4);
  //line(AnclajeA.x, AnclajeA.y, AnclajeA.z, AnclajeA.x, AnclajeA.y, AnclajeA.z - distsuelo);
  //line(AnclajeB.x, AnclajeB.y, AnclajeB.z, AnclajeB.x, AnclajeB.y, AnclajeB.z - distsuelo);
  //line(AnclajeC.x, AnclajeC.y, AnclajeC.z, AnclajeC.x, AnclajeC.y, AnclajeC.z - distsuelo);
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
    case 'w':
      popMatrix();
      rotateY(PI/18);
      pushMatrix();
      break;
    case 's':
      popMatrix();
      rotateY(-PI/18);
      pushMatrix();
      break;
    case 'e':
      popMatrix();
      rotateX(PI/18);
      pushMatrix();
      break;
    case 'd':
      popMatrix();
      rotateX(-PI/18);
      pushMatrix();
      break;
    case 'r':
      popMatrix();
      rotateZ(PI/18);
      pushMatrix();
      break;
    case 'f':
      popMatrix();
      rotateZ(-PI/18);
      pushMatrix();
      break;
    case 't':
      popMatrix();   
      popMatrix();
      pushMatrix();
      pushMatrix();
      break;
    default:
      break;
    }
  }
}

void mouseDragged() {
  if (mouseButton == RIGHT) {
    if (abs(mouseX - pmouseX) > 3) {
      popMatrix();
      if (mouseX < pmouseX) {
        rotateY(PI/90);
      } else {
        rotateY(-PI/90);
      }
      pushMatrix();
    }
    if (abs(mouseY - pmouseY) > 3) {
      popMatrix();
      if (mouseY < pmouseY) {
        rotateX(PI/90);
      } else {
        rotateX(-PI/90);
      }
      pushMatrix();
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  popMatrix();
  if (e < 0) {
    rotateZ(PI/45);
  } else {
    rotateZ(-PI/45);
  }
  pushMatrix();
}

void mousePressed() {
  if (mouseButton == CENTER) {
    popMatrix();   
    popMatrix();
    pushMatrix();
    pushMatrix();
  }
}