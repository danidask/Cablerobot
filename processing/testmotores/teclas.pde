void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      movermotores(500, 500, 500);
      break;
    case DOWN:
      movermotores(-500, -500, -500);
      break;
    default:
      break;
    }
  } else
  {
    switch(key) {
    case 'q':
      break;
    default:
      break;
    }
  }
}