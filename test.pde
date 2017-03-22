float angX, angY;

void setup() {
  size(640, 640, P3D);
  noFill();
}

void draw() {
  background(255);
  translate(width/2, height/2);

  angX = (mouseY-height/2)*TWO_PI/height;
  angY = (mouseX-width/2)*TWO_PI/width;

  // Global coordinate system
  stroke(255, 128, 128);
  line(0, 0, 0, 100, 0, 0); // x
  stroke(128, 255, 128);
  line(0, 0, 0, 0, 100, 0); // y
  stroke(128, 128, 255);
  line(0, 0, 0, 0, 0, 100); // z

  // "Save" initial coordinate system
  pushMatrix();
  rotateX(-angX);
  rotateY(angY);

  // Box's coordinate system
  stroke(128, 0, 0);
  line(0, 0, 0, 100, 0, 0); // x
  stroke(0, 128, 0);
  line(0, 0, 0, 0, 100, 0); // y
  stroke(0, 0, 128);
  line(0, 0, 0, 0, 0, 100); // z

  stroke(0);
  box(100);

  // Global coordinate system unaffected after popMatrix()
  popMatrix();

  // If you had other objects here they would be world aligned again
}
