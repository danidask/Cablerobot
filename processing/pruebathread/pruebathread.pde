//import processing.io.*;
//import processing.serial.*;

int maximonumeropasos = 100000;

int motorstep = 4;
int motorenable = 27;
int motordir = 22;

boolean movimiento = false;
boolean direccion = true;

int[] pasosmotor = new int[3];

int[] Aretardos0;
int[] Aretardos1;
int[] Aretardos2;

String mensaje = "pulsa click";
String mensaje0 = "0";
String mensaje1 = "1";
String mensaje2 = "2";
String mensajeotro = "otro";

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
  text(mensaje, 30, 20);
  text(mensaje0, 30, 60);
  text(mensaje1, 30, 100);
  text(mensaje2, 30, 140);
  text(mensajeotro, 30, 180);
  
  
}

void mousePressed() {
  println("\n============================");
  background(255);
  pasosmotor[0] = floor(random(0, 40));
  pasosmotor[1] = floor(random(0, 40));
  pasosmotor[2] = floor(random(0, 40));
  int indicemayor = sacarmayor(pasosmotor);
  int mayor = pasosmotor[indicemayor];

  mensaje = "motor0: " + pasosmotor[0] + " / motor1: " + pasosmotor[1] + " / motor2: " + pasosmotor[2] + " / mayor: " + pasosmotor[indicemayor] + " (" +indicemayor +").";

  Aretardos0 = generararrayretardos(pasosmotor[0], mayor);
  mensaje0 = "";
  for (int i = 0; i < pasosmotor[0]; i++) {
    mensaje0 += Aretardos0[i] + "-";
  }
  int total0=0;
  for (int i = 0; i < pasosmotor[0]; i++) {
    total0 += Aretardos0[i];
  }
  mensaje0 += "\nTotal: " + total0;

  Aretardos1 = generararrayretardos(pasosmotor[1], mayor);
  mensaje1 = "";
  for (int i = 0; i < pasosmotor[1]; i++) {
    mensaje1 += Aretardos1[i] + "-";
  }
  int total1 = 0;
  for (int i = 0; i < pasosmotor[1]; i++) {
    total1 += Aretardos1[i];
  }
  mensaje1 += "\nTotal: " + total1;

  Aretardos2 = generararrayretardos(pasosmotor[2], mayor);
  mensaje2 = "";
  for (int i = 0; i < pasosmotor[2]; i++) {
    mensaje2 += Aretardos2[i] + "-";
  }
  int total2 = 0;
  for (int i = 0; i < pasosmotor[2]; i++) {
    total2 += Aretardos2[i];
  }
  mensaje2 += "\nTotal: " + total2;


  thread("movermotor0");
  thread("movermotor1");
  thread("movermotor2");
}


void movermotor0() {
  int pasos = pasosmotor[0];
  boolean pasoactual = false;
  int i = 0;
  while (pasos > 0) {
    pasoactual = !pasoactual;
    if (pasoactual) {
      delay(Aretardos0[i]);
      //print(" - A" + pasos);
      mensajeotro = " - A" + pasos + mensajeotro;
      pasos--;
    } else {
      delay(1);
    }
    i++;
  }
}

void movermotor1() {
  int pasos = pasosmotor[1];
  boolean pasoactual = false;
  int i = 0;
  while (pasos > 0) {
    pasoactual = !pasoactual;
    if (pasoactual) {
      delay(Aretardos1[i]);
      //print(" - B" + pasos);
      mensajeotro = " - B" + pasos + mensajeotro;      
      pasos--;
    } else {
      delay(1);
    }
    i++;
  }
}

void movermotor2() {
  int pasos = pasosmotor[2];
  boolean pasoactual = false;
  int i = 0;
  while (pasos > 0) {    
    pasoactual = !pasoactual;
    if (pasoactual) {
      delay(Aretardos2[i]);      
      //print(" - C" + pasos);
      mensajeotro = " - C" + pasos + mensajeotro;      
      pasos--;
    } else {
      delay(1);
    }
    i++;
  }
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

int[] generararrayretardos(int valor, int valormaximo) {
  int[] Aretardos = new int[maximonumeropasos];
  int valormedio = 0 ;
  float resto = 0 ; //tiene que ser float para hacer bien la division
  int total = 0;
  int intervalo = 0;
  if (valor > 0) {
    valormedio = floor(valormaximo / valor);
    resto = valormaximo % valor;
    for (int i = 0; i < valor; i++) {
      Aretardos[i] = valormedio;
    }
    while (total != valormaximo) {
      if (resto > 0) {
        intervalo = ceil(valor / resto);
        for (int i = 0; i < valor; i+=intervalo) {
          Aretardos[i]++;
        }
      }
      total = 0;
      for (int i = 0; i < valor; i++) {
        total += Aretardos[i];
      }
      resto = valormaximo - total;
    }
  }
  return Aretardos;
}
