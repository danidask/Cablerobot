

void setup() {
  configurarpines();
  size(800, 600);
  frameRate(15);
  background(255);
  rectMode(CENTER);
}

void draw() {
  background(255);
  textSize(14);
  fill(0, 102, 153);
  text("flechas para subir bajar motores por igual", 30, 20);
  stroke(255);
  rect(width/2, height/2, width*0.5, height*0.5);
}


void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      movermotores(500, 500, 500);
      println("subir");
      break;
    case DOWN:
      movermotores(-500, -500, -500);
      println("bajar");
      break;
    default:
      break;
    }
  } else {
    switch(key) {
    case ' ':
      for (int i=0; i < numerodemotores; i++)
        activarmotor(i, false);
      println("desactivado");
      break;      
    //case 'q':
    //   GPIO.pinMode(27, GPIO.OUTPUT);
    //   GPIO.digitalWrite(27, GPIO.HIGH);
    //  println("encendido");
    //  break;
    //case 'a':
    //   GPIO.pinMode(27, GPIO.OUTPUT);
    //   GPIO.digitalWrite(27, GPIO.LOW);
    //  println("apagadp");
    //  break;

    default:
      break;
    }
  }
}