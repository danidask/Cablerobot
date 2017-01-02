class Effector {
  PVector Centro, AnclajeA, AnclajeB, AnclajeC, Vtemp;
  float espaciado; //distancia entre el centro y los anlajes

  Effector(PVector _centro, float _espaciado) {
    
    espaciado = _espaciado;
    Centro = _centro.copy();

    Vtemp = new PVector(0, espaciado, 0);
    AnclajeA = Vtemp.copy();
    AnclajeA.add(Centro);

    Vtemp.rotate(radians(120));
    //Vtemp.rotate(PI/3);
    AnclajeB = Vtemp.copy();
    AnclajeB.add(Centro);    

    Vtemp.rotate(radians(120));
    //Vtemp.rotate(PI/3);
    AnclajeC = Vtemp.copy();
    AnclajeC.add(Centro);
  }

  void show() {
    stroke(255,0,0);
    strokeWeight(2);
    line(AnclajeA.x, AnclajeA.y, AnclajeA.z, AnclajeB.x, AnclajeB.y, AnclajeB.z);
    line(AnclajeB.x, AnclajeB.y, AnclajeB.z, AnclajeC.x, AnclajeC.y, AnclajeC.z);
    line(AnclajeC.x, AnclajeC.y, AnclajeC.z, AnclajeA.x, AnclajeA.y, AnclajeA.z);
  }

  void move(PVector movimiento) {
    Centro.add(movimiento);
    AnclajeA.add(movimiento);
    AnclajeB.add(movimiento);
    AnclajeC.add(movimiento);
  }
}