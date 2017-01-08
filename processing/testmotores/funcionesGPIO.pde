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

int segundoretardo = 2;

void configurarpines() {
  // Motor X
  motorenablepin[0] = 22;
  motorsteppin[0] = 27;
  motordirpin[0] = 17;
  // Motor Y  
  motorenablepin[1] = 10;
  motorsteppin[1] = 9;
  motordirpin[1] = 11;
  // Motor Z  
  motorenablepin[2] = 18;
  motorsteppin[2] = 23;
  motordirpin[2] = 24;

  for (int i=0; i < numerodemotores; i++) {
    GPIO.pinMode(motorenablepin[i], GPIO.OUTPUT);
    GPIO.pinMode(motorsteppin[i], GPIO.OUTPUT);
    GPIO.pinMode(motordirpin[i], GPIO.OUTPUT);
  }
  
  for (int i=0; i < numerodemotores; i++) {
    GPIO.digitalWrite(motorenablepin[i], GPIO.LOW);
    GPIO.digitalWrite(motorsteppin[i], GPIO.LOW);
    GPIO.digitalWrite(motordirpin[i], GPIO.LOW);
  }
  
}

void movermotores(int _pasosmotor0, int _pasosmotor1, int _pasosmotor2) {
  boolean[] motordir = new boolean[numerodemotores];
  pasosmotor[0] = _pasosmotor0;
  pasosmotor[1] = _pasosmotor1;
  pasosmotor[2] = _pasosmotor2;
  for (int i=0; i < numerodemotores; i++) {
    if (pasosmotor[i] < 0) {
      pasosmotor[i] *= -1;
      GPIO.digitalWrite(motordirpin[i], GPIO.LOW);
    } else
      GPIO.digitalWrite(motordirpin[i], GPIO.HIGH);
  }
  int indicemayor = sacarmayor(pasosmotor);
  int mayor = pasosmotor[indicemayor];
  Aretardos0 = generararrayretardos(pasosmotor[0], mayor);
  Aretardos1 = generararrayretardos(pasosmotor[1], mayor);
  Aretardos2 = generararrayretardos(pasosmotor[2], mayor);
  for (int i=0; i < numerodemotores; i++)
    activarmotor(i, true);

  if (pasosmotor[0] != 0) {
    thread("movermotor0");
    println(pasosmotor[0], motorenablepin[0], motorsteppin[0], motordirpin[0]);
  }
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
      delay(segundoretardo);
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
      delay(segundoretardo);
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
      delay(segundoretardo);
      GPIO.digitalWrite(motorsteppin[2], GPIO.LOW);
    }
    i++;
  }
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