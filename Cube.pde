var guessTime;

var score = 0;
var incorrect;
var currentFace;

var numsVis = true;
var axis = getRandomInt(0, 3);
var r = [0,0,0];
var count;
var selected;

var pSpin;
var pR = [0,0,0];
var pAxis = Math.random() > 0.5 ? 0 : 2;
var pCount;
var rawBounce;
var bounce;

var dUpDown = Math.random() > 0.5 ? 1 : -1;
var pUpDown = pAxis === 0 ? 1 : -1;

var bSize;
var aHeight = 0;

var stop;

PImage faces = [];

void setup(){
  size(0.9 * min(window.innerWidth, window.innerHeight), 0.9 * min(window.innerWidth, window.innerHeight), P3D);
  frameRate(30);
  bSize = width/13;

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
  rotateX(HALF_PI);

  // rotate dice on random axis
  if (!stop) {
    for (var xyz = 0; xyz < 3; xyz++){
      if (xyz === axis) {
        r[xyz] += dUpDown * PI / 100;
        count++;
        if (count === 50) {
          count = 0;
          axis = getRandomInt(0, 3);
        }
      }
    }
  }

  rotateX(r[0]);
  rotateY(r[1]);
  rotateZ(r[2]);

  var dxCoords = [];
  var dyCoords = [];
  var dzCoords = [];

  // draw cube
  for (var face = 1; face < faces.length; face++) {

    dxCoords[face - 1] = round(modelX(0, 0, 1));
    dyCoords[face - 1] = round(modelY(0, 0, 1));
    dzCoords[face - 1] = round(modelZ(0, 0, 1));

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

  popMatrix();

  // pointer

  // rotate pointer on random axis
  if (!stop) {
    for (var xyz = 0; xyz < 3; xyz++){
      if (xyz === pAxis) {
        pR[xyz] += pUpDown * PI / 100;
        pCount++;
        if (pCount === 50) {
          pUpDown = Math.random() > 0.5 ? 1 : -1;
          pAxis = getRandomInt(0, 3);
          pCount = 0;
          stop = true;
          guessTime = true;
        }
      }
    }
  }

  pushMatrix();

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

  // draw the pointer

  pxCoord = round(modelX(0,0,1));
  pyCoord = round(modelY(0,0,1));
  pzCoord = round(modelZ(0,0,1));

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

  // text/buttons
  camera();

  var d = [];
  for (var i = 0; i < 6; i++) {
    d[i] = dist(dxCoords[i], dyCoords[i], dzCoords[i], pxCoord, pyCoord, pzCoord);
  }
  currentFace = d.indexOf(min(d)) + 1;

  // show buttons
  fill(200, 0, 0);
  stroke(0);
  strokeWeight(1);

  if (stop && aHeight < 1) {
    aHeight += 0.2;
  } else if (!stop && aHeight > 0) {
    aHeight -= 0.2;
  }

  for (int i = 1; i < faces.length; i++) {
    beginShape();
    texture(faces[i]);
    vertex((2*i-1)*bSize,height-2*bSize*aHeight,0, 0,0);
    vertex((2*i-1)*bSize+bSize,height-2*bSize*aHeight,0, 100,0);
    vertex((2*i-1)*bSize+bSize,height+bSize-2*bSize*aHeight,0, 100,100);
    vertex((2*i-1)*bSize,height+bSize-2*bSize*aHeight,0, 0,100);
    endShape(CLOSE);
  }

  // show faces after incorrect guess
  if (incorrect) {
    numsVis = true;
    incorrect = false;
  }

  textSize(18);
  fill(0);
  text("Score: " + score, 10, 10);

}

void mouseClicked() {

  if (guessTime) {

    for (var i = 1; i < faces.length; i++) {
      if (mouseX > (2*i-1)*bSize
      && mouseX < (2*i-1)*bSize+bSize
      && mouseY > height-2*bSize*aHeight
      && mouseY < height+bSize-2*bSize*aHeight) {
        if (i === currentFace) {
          console.log("correct");
          numsVis = false;
          stop = false;
          score++;
          guessTime = false;
          break;
        } else {
          incorrect = true;
        }
      }
    }

    if (incorrect) {
      score -= 5;
      if (score < 0) score = 0;
      console.log("incorrect");
    }


  }
}

function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min)) + min;
}
