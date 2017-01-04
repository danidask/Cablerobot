

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

void activarmotor(int motor, boolean activar)
{
  println("test: motor " + motor + " activado: "+ activar);
}

void configurarpines(){
  println("test: configurar pies");
}