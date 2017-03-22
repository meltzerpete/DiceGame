var numsVis = true;
var axis = 0;
var r = [0,0,0];
var count = 0;
var selected = 0;

PImage one;
PImage two;
PImage three;
PImage four;
PImage five;
PImage six;
PImage blank;

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
  six = loadImage("dice.svg");
  blank = loadImage("blank.png");
}

void draw(){

  background(255, 173, 51);
  camera(200.0, -100.0, 200.0, 50, 50, 0,
    0.0, 1.0, 0.0);
  translate(50, 50, 0);

  //rotate in chosen direction
  var rand = getRandomInt(-50, 50);

  for (var xyz = 0; xyz < 3; xyz++){
    if (xyz === axis) {
      r[xyz] += PI / 100;
      count++;
      if (count === 50) {
        axis = getRandomInt(0, 3);
        // axis = (axis + 1) % 3
        count = 0;
      }
    }
  }

  rotateX(r[0]);
  rotateY(r[1]);
  rotateZ(r[2]);

  for (var xyz = 0; xyz < 3; xyz++){

  }

  beginShape();
  if (numsVis) texture(one);
  if (!numsVis) texture(blank);
  vertex(-50,-50,-50, 0,0);
  vertex(50,-50,-50, 100, 0);
  vertex(50,-50,50, 100, 100);
  vertex(-50,-50,50, 0, 100);
  endShape(CLOSE);

  beginShape();
  if (numsVis) texture(two);
  if (!numsVis) texture(blank);
  vertex(-50,-50,50, 0,0);
  vertex(50,-50,50, 100, 0);
  vertex(50,50,50, 100, 100);
  vertex(-50,50,50, 0, 100);
  endShape(CLOSE);

  beginShape();
  if (numsVis) texture(three);
  if (!numsVis) texture(blank);
  vertex(50,-50,50, 0,0);
  vertex(50,-50,-50, 100, 0);
  vertex(50,50,-50, 100, 100);
  vertex(50,50,50, 0, 100);
  endShape(CLOSE);

  beginShape();
  if (numsVis) texture(four);
  if (!numsVis) texture(blank);
  vertex(-50,50,-50, 0,0);
  vertex(-50,50,50, 100, 0);
  vertex(-50,-50,50, 100, 100);
  vertex(-50,-50,-50, 0, 100);
  endShape(CLOSE);

  beginShape();
  if (numsVis) texture(five);
  if (!numsVis) texture(blank);
  vertex(50,50,-50, 0,0);
  vertex(-50,50,-50, 100, 0);
  vertex(-50,-50,-50, 100, 100);
  vertex(50,-50,-50, 0, 100);
  endShape(CLOSE);

  beginShape();
  if (numsVis) texture(six);
  if (!numsVis) texture(blank);
  vertex(50,50,50, 0,0);
  vertex(-50,50,50, 100,0);
  vertex(-50,50,-50, 100,100);
  vertex(50,50,-50, 0,100);
  endShape(CLOSE);

}

void mouseClicked(){
  numsVis = !numsVis;
}

function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min)) + min;
}
