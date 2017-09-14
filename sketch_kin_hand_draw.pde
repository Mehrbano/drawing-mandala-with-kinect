import SimpleOpenNI.*;
//declare
SimpleOpenNI kinect;
//global variables
    //int savedTime;
    //int totalTime = 12000;
    //String s = "ALERT: PROGRAM ERROR";
int closestValue;
int closestX;
int closestY;
float lastX;
float lastY;

void setup()
{
  size(960, 720);
    //savedTime = millis();
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  background(0);

  
}
void draw() {
    
  //this value is kept high
  closestValue = 8000;
  kinect.update();
  //map the depth
  int[] depthValues = kinect.depthMap();
  for (int y = 0; y < 480; y++) { 
    for (int x = 0; x < 640; x++) { 
      // reverse x by moving in from the right side of the image 
      int reversedX = 640-x-1;
      // use reversedX to calculate array index
      int i = reversedX + y * 640;
      int currentDepthValue = depthValues[i];
      // only look for the closestValue within range
      if (currentDepthValue > 610 && currentDepthValue < 3000 
        && currentDepthValue < closestValue) {
        closestValue = currentDepthValue;
        closestX = x;
        closestY = y;
      }
    }
  }
  // "linear interpolation" smooth transition between last point to new closest point
  float interpolatedX = lerp(lastX, closestX, 1.5f); 
  float interpolatedY = lerp(lastY, closestY, 1.5f);
  pushMatrix ();
  translate(width/2, height/2);
  rotate(random(-45, 45));
  stroke(255, 0, 0);
  noFill();
  strokeWeight(3);
  ellipse (lastX, lastY, 20, 20); 
  popMatrix();
  
  pushMatrix ();
  translate(width/2, height/2);
  rotate(random(-45, 45));
  stroke(255, 204, 0);
  noFill();
  strokeWeight(3);
  ellipse (lastY/2, lastX/2, 15, 15); 
  popMatrix();
  
  pushMatrix ();
  translate(width/2, height/2);
  rotate(random(-45, 45));
  stroke(0, 204, 0);
  noFill();
  strokeWeight(2);
  ellipse (lastX/3, lastY/3, 10, 10); 
  popMatrix();
  
  lastX = interpolatedX;
  lastY = interpolatedY;
}
void mousePressed() {
  // save image to a file
  save("drawing.png");
    // then clear it on the screen
  background(0,100);
}

