
import processing.io.*;

// Definiciones de pines
int[] motorenable = new int[numerodemotores];
int[] motorstep = new int[numerodemotores];
int[] motordir = new int[numerodemotores];
// Motor 0 o X
motorenable[0] = 27;
motorstep[0] = 4;
motordir[0] = 22;
// Motor 1 o Y
motorenable[1] = 111;
motorstep[1] = 111;
motordir[1] = 111;
// Motor 2 o Z
motorenable[2] = 111;
motorstep[2] = 111;
motordir[2] = 111;

void configurarpines(){
  GPIO.pinMode(motor0step, GPIO.OUTPUT);
  GPIO.pinMode(motor0enable, GPIO.OUTPUT);
  GPIO.pinMode(motor0dir, GPIO.OUTPUT);
}

void movermotores(int pasosmotor0, int pasosmotor1, int pasosmotor2){
  //numerodemotores tiene que ser 3 
  int[] pasosmotor = new int[numerodemotores];
  pasosmotor[0] = pasosmotor0;
  pasosmotor[1] = pasosmotor1;
  pasosmotor[2] = pasosmotor2;
    for (int i=0; i < numerodemotores; i++){
    if(pasosmotor[i] < 0){
      pasosmotor[i] *= -1;
      dirmotor[i] = false;
    }
    else
      dirmotor[i] = true;
  }
  int indicemayor = sacarmayor(pasosmotor);
  int mayor = pasosmotor[indicemayor];
  Aretardos0 = generararrayretardos(pasosmotor[0], mayor);
  Aretardos1 = generararrayretardos(pasosmotor[1], mayor);
  Aretardos2 = generararrayretardos(pasosmotor[2], mayor);
  for (int i=0; i < numerodemotores; i++)
    activarmotor(i, true);
  if (pasosmotor[0] != 0)
    thread("movermotor0");
  if (pasosmotor[1] != 0)
    thread("movermotor1");
  if (pasosmotor[2] != 0)
    thread("movermotor2");    
}

void activarmotor(int motor, boolean activar)
{
  if (activar)
    GPIO.digitalWrite(motorenable[motor], GPIO.LOW); // se activa con cero
  else
    GPIO.digitalWrite(motorenable[motor], GPIO.HIGH);
}

void movermotor0() {
  int pasos = pasosmotor[0];
  boolean pasoactual = false;
  int i = 0;
  while (pasos > 0) {
    pasoactual = !pasoactual;
    if (pasoactual) {
      delay(Aretardos0[i]);
      GPIO.digitalWrite(motorstep[0], GPIO.HIGH);      
      pasos--;
    } else {
      delay(1);
      GPIO.digitalWrite(motorstep[0], GPIO.LOW);      
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
      GPIO.digitalWrite(motorstep[1], GPIO.HIGH);      
      pasos--;
    } else {
      delay(1);
      GPIO.digitalWrite(motorstep[1], GPIO.LOW);      
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
      GPIO.digitalWrite(motorstep[2], GPIO.HIGH);      
      pasos--;
    } else {
      delay(1);
      GPIO.digitalWrite(motorstep[2], GPIO.LOW);      
    }
    i++;
  }
}