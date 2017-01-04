
void setup() {
  configurarpines();
  size(800, 600);
  frameRate(15);
  background(255);
  rectMode(CENTER);
}

void draw() {
  background(255);
  textSize(14);
  fill(0, 102, 153);
  text("flechas para subir bajar motores por igual", 30, 20);
  stroke(255);
  rect(width/2, height/2, width*0.5, height*0.5);
}

void mousePressed() {

}