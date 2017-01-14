

void setup() {
  configurarpines();
  size(800, 600);
  frameRate(15);
  for (int i=0; i < numerodemotores; i++)
    activarmotor(i, false);
  println("desactivado");
}

void draw() {
  background(255);
  textSize(14);
  fill(0, 102, 153);
  text("quitar canvas", 30, 20);
}