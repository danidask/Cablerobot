
int maximonumeropasos = 100000;

int numerodemotores = 3; //configurar pines al cambiar

boolean movimiento = false;

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
  configurarpines();
  for (int i=0; i < numerodemotores; i++)
    activarmotor(i, true);

  size(800, 600);
  frameRate(15);
  rectMode(CENTER);  // Set rectMode to CENTER
}

void draw() {
  background(255);
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
