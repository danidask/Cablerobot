import processing.io.*;
import processing.serial.*;

int motorstep = 4;
int motorenable = 27;
int motordir = 22;
int pasos = 0;

boolean ledOn = false;
boolean pasoactual = false;
boolean movimiento = false;
boolean direccion = true;

void setup() {
  GPIO.pinMode(motorstep, GPIO.OUTPUT);
  GPIO.pinMode(motorenable, GPIO.OUTPUT);
  GPIO.pinMode(motordir, GPIO.OUTPUT);
  frameRate(1);
  GPIO.digitalWrite(motorenable, GPIO.HIGH); //activado a cero
  thread("movermotor");
}

void draw() {
  ledOn = !ledOn;
  if (ledOn) {
    fill(204);
  } else {
    fill(255);
  }
  stroke(255);
  ellipse(width/2, height/2, width*0.75, height*0.75);
}

void mousePressed() {
  if (pasos <= 0) {
    direccion = !direccion;
    if (direccion)
      GPIO.digitalWrite(motordir, GPIO.LOW);
    else
      GPIO.digitalWrite(motordir, GPIO.HIGH);


    pasos = 1000;
    activarmotor(true);
    thread("movermotor");
  }
}

void movermotor() {
  while (pasos > 0) {
    pasos--;
    pasoactual = !pasoactual;
    if (pasoactual) {
      GPIO.digitalWrite(motorstep, GPIO.LOW);
      delay(2);
    } else {
      GPIO.digitalWrite(motorstep, GPIO.HIGH);
      delay(1);
    }

  }
  activarmotor(false);
}

void activarmotor(boolean valor)
{
  if (valor)
    GPIO.digitalWrite(motorenable, GPIO.LOW); //activado a cero
  else
    GPIO.digitalWrite(motorenable, GPIO.HIGH);
}


