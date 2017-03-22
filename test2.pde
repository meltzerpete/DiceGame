float num;
void setup()
{
  size(600, 600, P3D);
  noStroke();
}

void draw()
{
  background(255);
  smooth(8);
  lights();

  pushMatrix();
  translate(width/2, height/2);
  fill(#999999);
  sphere(50);
  popMatrix();

  pushMatrix();
  translate(width/2, height/2);
  rotateX(num);
  translate(0,200);
  fill(#ff0000);
  box(20);
  popMatrix();

  pushMatrix();
  translate(width/2, height/2);
  rotateY(num);
  translate(200,0);
  fill(#00ff00);
  box(20);
  popMatrix();

  num += 0.05;
}
