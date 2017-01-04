import processing.io.*;

int maximonumeropasos = 100000;
int numerodemotores = 3; //no se puede cambiar solo aqui
int[] pasosmotor = new int[numerodemotores];

int[] Aretardos0  = new int[maximonumeropasos];
int[] Aretardos1  = new int[maximonumeropasos];
int[] Aretardos2  = new int[maximonumeropasos];

// Definiciones de pines
int[] motorenablepin =  new int[numerodemotores];//pines para motores0 1 y 2 o X Y y Z
int[] motorsteppin  = new int[numerodemotores];
int[] motordirpin  = new int[numerodemotores];

void configurarpines() {
  // Motor X
  motorenablepin[0] = 27;
  motorsteppin[0] = 4;
  motordirpin[0] = 22;
  // Motor Y  
  motorenablepin[1] = 27;
  motorsteppin[1] = 4;
  motordirpin[1] = 22;
  // Motor Z  
  motorenablepin[2] = 27;
  motorsteppin[2] = 4;
  motordirpin[2] = 22;
  
  for (int i=1; i < numerodemotores; i++) {
    GPIO.pinMode(motorenablepin[i], GPIO.OUTPUT);
    GPIO.pinMode(motorsteppin[i], GPIO.OUTPUT);
    GPIO.pinMode(motordirpin[i], GPIO.OUTPUT);
  }
}

void movermotores(int pasosmotor0, int pasosmotor1, int pasosmotor2) {
  boolean[] motordir = new boolean[numerodemotores];
  pasosmotor[0] = pasosmotor0;
  pasosmotor[1] = pasosmotor1;
  pasosmotor[2] = pasosmotor2;
  for (int i=0; i < numerodemotores; i++) {
    if (pasosmotor[i] < 0) {
      pasosmotor[i] *= -1;
      motordir[i] = false;
    } else
      motordir[i] = true;
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
    GPIO.digitalWrite(motorenablepin[motor], GPIO.LOW); // se activa con cero
  else
    GPIO.digitalWrite(motorenablepin[motor], GPIO.HIGH);
}

void movermotor0() {
  int pasos = pasosmotor[0];
  boolean pasoactual = false;
  int i = 0;
  while (pasos > 0) {
    pasoactual = !pasoactual;
    if (pasoactual) {
      delay(Aretardos0[i]);
      GPIO.digitalWrite(motorsteppin[0], GPIO.HIGH);      
      pasos--;
    } else {
      delay(1);
      GPIO.digitalWrite(motorsteppin[0], GPIO.LOW);
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
      GPIO.digitalWrite(motorsteppin[1], GPIO.HIGH);      
      pasos--;
    } else {
      delay(1);
      GPIO.digitalWrite(motorsteppin[1], GPIO.LOW);
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
      GPIO.digitalWrite(motorsteppin[2], GPIO.HIGH);      
      pasos--;
    } else {
      delay(1);
      GPIO.digitalWrite(motorsteppin[2], GPIO.LOW);
    }
    i++;
  }
}