var axis = 0;
var rX = 0;
var rY = 0;
var rZ = 0;
var count = 0;
PImage one;
PImage two;
PImage three;
PImage four;
PImage five;
PImage six;

void setup(){
  size(200, 200, P3D);  // Size must be the first statement
  stroke(0);     // Set line drawing color to white
  frameRate(30);
  // noFill();
  fill(230, 0, 0);
  one = loadImage("one.png");
  two = loadImage("two.png");
  three = loadImage("three.png");
  four = loadImage("four.png");
  five = loadImage("five.png");
  six = loadImage("six.png");
}

void draw(){

  background(255, 173, 51);
  camera(200.0, -100.0, 200.0, 50, 50, 0,
    0.0, 1.0, 0.0);
  translate(50, 50, 0);

  //rotate in chosen direction
  switch(axis){
    case 1:
      rX += PI / 200;
      count++;
      if (count === 100) {
        axis = 2;
        count = 0;
      };
      break;
    case 2:
      rY += PI / 200;
      count++;
      if (count === 100) {
        axis = 3;
        count = 0;
      };
      break;
    case 3:
      rZ += PI / 200;
      count++;
      if (count === 100) {
        axis = 0;
        count = 0;
      };
      break;
    default:
      break;
  }

  // box(100);
  rotateX(rX);
  rotateY(rY);
  rotateZ(rZ);

  beginShape();
  texture(one);
  vertex(-50,-50,-50, 0,0);
  vertex(50,-50,-50, 100, 0);
  vertex(50,-50,50, 100, 100);
  vertex(-50,-50,50, 0, 100);
  endShape(CLOSE);

  beginShape();
  texture(two);
  vertex(-50,-50,50, 0,0);
  vertex(50,-50,50, 100, 0);
  vertex(50,50,50, 100, 100);
  vertex(-50,50,50, 0, 100);
  endShape(CLOSE);

  beginShape();
  texture(three);
  vertex(50,-50,50, 0,0);
  vertex(50,-50,-50, 100, 0);
  vertex(50,50,-50, 100, 100);
  vertex(50,50,50, 0, 100);
  endShape(CLOSE);

  beginShape();
  texture(four);
  vertex(-50,-50,-50, 0,0);
  vertex(-50,-50,50, 100, 0);
  vertex(-50,50,50, 100, 100);
  vertex(-50,50,-50, 0, 100);
  endShape(CLOSE);

  beginShape();
  texture(five);
  vertex(50,50,-50, 0,0);
  vertex(-50,50,-50, 100, 0);
  vertex(-50,-50,-50, 100, 100);
  vertex(50,-50,-50, 0, 100);
  endShape(CLOSE);

  beginShape();
  texture(six);
  vertex(-50,50,-50, 0,0);
  vertex(50,50,-50, 100,0);
  vertex(50,50,50, 100,100);
  vertex(-50,50,50, 0,100);
  endShape(CLOSE);



}

void mouseClicked(){
  axis = (axis + 1) % 4
}
