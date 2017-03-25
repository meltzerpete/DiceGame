var numsVis = true;
var axis = 0;
var r = [0,0,0];
var count = 0;
var selected = 0;

var pSpin = 0;
var pR = [0,0,0];
var pAxis = 0;
var pCount = 0;
var rawBounce = 0;
var bounce = 0;

var stop;

PImage faces = [];

void setup(){
  size(0.9 * min(window.innerWidth, window.innerHeight), 0.9 * min(window.innerWidth, window.innerHeight), P3D);
  frameRate(30);

  // load textures
  faces.push(loadImage("blank.png"));
  faces.push(loadImage("one.png"));
  faces.push(loadImage("two.png"));
  faces.push(loadImage("three.png"));
  faces.push(loadImage("four.png"));
  faces.push(loadImage("five.png"));
  faces.push(loadImage("dice.svg"));
}

void draw(){

  background(255, 173, 51);
  camera(200.0, -100.0, 200.0, 50, 50, 0,
    0.0, 1.0, 0.0);

  translate(50, 50, 0);

  // dice
  fill(200, 0, 0);
  stroke(0);
  strokeWeight(1);

  pushMatrix();

  // rotate dice on random axis
  if (!stop) {
    for (var xyz = 0; xyz < 3; xyz++){
      if (xyz === axis) {
        r[xyz] += PI / 100;
        count++;
        if (count === 50) {
          axis = getRandomInt(0, 3);
          count = 0;
        }
      }
    }
  }

  rotateX(r[0]);
  rotateY(r[1]);
  rotateZ(r[2]);

  // draw cube
  for (var face = 1; face < faces.length; face++) {

    beginShape();
    if (faces[face]) {
      if (numsVis) texture(faces[face]);
      else texture(faces[0]);
    }
    vertex(-50,-50,50, 0,0);
    vertex(50,-50,50, 100, 0);
    vertex(50,50,50, 100, 100);
    vertex(-50,50,50, 0, 100);
    endShape(CLOSE);

    rotateX(-PI / 2);
    rotateZ(-PI / 2);

    if (face === 3) {
      rotateZ(PI);
      rotateY(PI / 2);
    }
  }

  // popMatrix();

  // pointer

  // rotate pointer on random axis
  if (!stop) {
    for (var xyz = 0; xyz < 3; xyz++){
      if (xyz === pAxis) {
        pR[xyz] += PI / 100;
        pCount++;
        if (pCount === 50) {
          pAxis = getRandomInt(0, 3);
          pCount = 0;
        }
      }
    }
  }

  // pushMatrix();

  fill(255,255,0);
  stroke(0);
  strokeWeight(3);

  // rotate the pointer about the axis
  rotateX(pR[0]);
  rotateY(pR[1]);
  rotateZ(pR[2]);

  // spin the pointer
  rotateY(pSpin += 0.1);
  translate(0, -30, 0);
  if (stop) bounce = 40 * sin(rawBounce += 0.2);

  beginShape();
  vertex(10,-120 + bounce,0);
  vertex(0,-120 + bounce,10);
  vertex(-10,-120 + bounce, 0);
  vertex(0,-120 + bounce,-10);
  endShape(CLOSE);

  for (var i = 0; i < 4; i++) {
    beginShape();
    vertex(0,-80 + bounce,0);
    vertex(10,-120 + bounce,0);
    vertex(0,-120 + bounce,10);
    endShape(CLOSE);
    rotateY(PI / 2);
  }

  popMatrix();

  // text
  fill(0);
  // translate(-100, -100, 0);
  // rotateX(-PI / 12);
  // rotateY(PI / 6);
  // rotateZ(PI / 24);
  camera();
  textSize(18);

  var c = [];
  var p = [];
  var d = [];
  for (var i = 0; i < 3; i++) {
    c[i] = (round((100 * r[i] / TWO_PI)) % 100) / 100;
    p[i] = (round((100 * pR[i] / TWO_PI)) % 100) / 100;
    d[i] = round(100 * (c[i] - p[i])) / 100;
  }

  text("Cube: (" + c[0] + ", " + c[1] + ", " + c[2] + ")", 10, 10);
  text("Point: (" + p[0] + ", " + p[1] + ", " + p[2] + ")", 10, 40);
  text("Diff: (" + d[0] + ", " + d[1] + ", " + d[2] + ")", 10, 70);

}

void mouseClicked(){
  numsVis = !numsVis;
}

void keyPressed() {
  stop = !stop;
}

function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min)) + min;
}
