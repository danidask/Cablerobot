import gohai.glvideo.*;
GLCapture video;

void setup() {
  size(640, 400, P2D);

  String[] devices = GLCapture.list();
  println("Devices:");
  printArray(devices);
  if (0 < devices.length) {
    String[] configs = GLCapture.configs(devices[0]);
    println("Configs:");
    printArray(configs);
  }

  // this will use the first recognized camera by default
  //video = new GLCapture(this);
  // you could be more specific also, e.g.
  //video = new GLCapture(this, devices[0]);
  video = new GLCapture(this, devices[0], 320, 200, 15);
  //video = new GLCapture(this, devices[0], configs[0]);

  video.play();
}

//void captureEvent(GLCapture video) {
//  video.read();
//}

void draw() {
  background(0);
  if (video.available()) {
    video.read();
  }
  image(video, 0, 0, video.width*2, video.height*2);
}