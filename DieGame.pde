import processing.opengl.*;

xVal = - PI / 6;
yVal = - PI / 6;
zVal = PI / 12
switcher = -1;
count = 0;

void setup()
{
  size(300, 300, P3D);
  background(125);
  // noLoop();
  PFont fontA = loadFont("courier");
  textFont(fontA, 14);
  die = new Die();
}

void draw(){

  translate(150, 150, 0);
  rotateZ(zVal);
  // pushMatrix();
  rotateY(yVal);
  // popMatrix();
  // pushMatrix();
  rotateX(xVal);
  // popMatrix();
  background(255);
  fill(255, 228, 225);
  box(100);
  switch (switcher) {
    case 0:
      xVal += PI / 400;
      count++;
      if (count === 200) {
        count = 0;
        switcher = 1;
      }
      break;
    case 1:
      zVal += PI / 400;
      yVal += PI / 400;
      count++;
      if (count === 200) {
        count = 0;
        switcher = -1;
      }
      break;
  }

}

void mouseClicked() {
    switcher = 0;
}

function rotateCube(n) {
  for (var i = 0; i < 15; i++) {
    rotateX(Math.PI / 16);
    background(255);
    fill(255, 228, 225);
    box(100);
  }
}

function Die() {
  this.top = 1;
  this.front = 2;
  this.right = 3;
  this.rotate = function(n) {

    var oldtop = this.top;
    var oldfront = this.front;
    var oldright = this.right;
    switch (n) {
      case 0:
        this.top = 7 - oldfront;
        this.front = oldtop;
        this.right = oldright;
        break;
      case 1:
        this.top = 7 - oldright;
        this.front = oldfront;
        this.right = oldtop;
        break;
      case 2:
        for (var i = 0; i < 2; i++) {
          this.rotate(0)
        }
        break;
      case n === 3:
        for (var i = 0; i < 2; i++) {
          this.rotate(1)
        }
        break;
    }
  };

}
