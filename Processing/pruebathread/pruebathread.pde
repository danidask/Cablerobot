//import processing.io.*;
//import processing.serial.*;

int motorstep = 4;
int motorenable = 27;
int motordir = 22;

boolean movimiento = false;
boolean direccion = true;

int[] pasosmotor = new int[3];

String mensaje = "pulsa click";
String mensaje0 = "0";
String mensaje1 = "1";
String mensaje2 = "2";

void setup() {
  //GPIO.pinMode(motorstep, GPIO.OUTPUT);
  //GPIO.pinMode(motorenable, GPIO.OUTPUT);
  //GPIO.pinMode(motordir, GPIO.OUTPUT);
  activarmotor(true);

  size(800, 600);
  frameRate(15);
  background(255);
  rectMode(CENTER);  // Set rectMode to CENTER
}

void draw() {
  textSize(14);
  fill(0, 102, 153);
  text(mensaje, 30, 30);
  text(mensaje0, 30, 60);
  text(mensaje1, 30, 90);
  text(mensaje2, 30, 120);
}

void mousePressed() {
  background(255);
  pasosmotor[0] = floor(random(0, 40));
  pasosmotor[1] = floor(random(0, 40));
  pasosmotor[2] = floor(random(0, 40));
  int indicemayor = sacarmayor(pasosmotor);


  mensaje = "motor0: " + pasosmotor[0] + " / motor1: " + pasosmotor[1] + " / motor2: " + pasosmotor[2] + " / mayor: " + indicemayor;

    int[] temp0 = new int[10000];
  mensaje0 = "";
  for (int i = 0; i < pasosmotor[0]; i++) {
    temp0[i] = 1;
    mensaje0 += temp0[i] + "-";
  }
  int total0 = 0;
  for (int i = 0; i < pasosmotor[0]; i++) {
     total0 += temp0[i];
  }
  mensaje0 += "T: " + total0;


  int[] temp1 = new int[10000];
  mensaje1 = "";
  for (int i = 0; i < pasosmotor[1]; i++) {
    temp1[i] = 1;
    mensaje1 += temp1[i] + "-";
  }
  int total1 = 0;
  for (int i = 0; i < pasosmotor[1]; i++) {
     total1 += temp1[i];
  }
  mensaje1 += "T: " + total1;
  
  int[] temp2 = new int[10000];
  mensaje2 = "";
  for (int i = 0; i < pasosmotor[2]; i++) {
    temp2[i] = 1;
    mensaje2 += temp2[i] + "-";
  }
  int total2 = 0;
  for (int i = 0; i < pasosmotor[2]; i++) {
     total2 += temp2[i];
  }
  mensaje2 += "T: " + total2;
  
  thread("movermotor0");
  thread("movermotor1");
  thread("movermotor2");
}


void movermotor0() {
  rectMode(CENTER);  // Set rectMode to CENTER
  fill(100);  // Set fill to gray
  int pasos = pasosmotor[0];
  boolean pasoactual = false;
  while (pasos > 0) {
    pasos--;
    pasoactual = !pasoactual;
    if (pasoactual) {
      print(" - A" + pasos);
      delay(2);
    } else {
      delay(1);
    }
  }
  activarmotor(false);
}

void movermotor1() {
  rectMode(CENTER);  // Set rectMode to CENTER
  fill(100);  // Set fill to gray
  int pasos = pasosmotor[1];
  boolean pasoactual = false;
  while (pasos > 0) {
    pasos--;
    pasoactual = !pasoactual;
    if (pasoactual) {
      print(" - B" + pasos);
      delay(2);
    } else {
      delay(1);
    }
  }
  activarmotor(false);
}

void movermotor2() {
  rectMode(CENTER);  // Set rectMode to CENTER
  fill(100);  // Set fill to gray
  int pasos = pasosmotor[2];
  boolean pasoactual = false;
  while (pasos > 0) {
    pasos--;
    pasoactual = !pasoactual;
    if (pasoactual) {
      print(" - C" + pasos);
      delay(2);
    } else {
      delay(1);
    }
  }
  activarmotor(false);
}

void activarmotor(boolean valor)
{
  println("activar motor " + valor);
}

int sacarmayor(int valores[]) {
  int mayor = 0;
  int indicemayor = 0;
  for (int i = 0; i < valores.length; i++) {
    if (valores[i] > mayor) {
      mayor = valores[i] ;
      indicemayor = i;
    }
  }
  return indicemayor;
}