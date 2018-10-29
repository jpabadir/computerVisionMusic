import processing.video.*;
import gab.opencv.*;
import processing.sound.*;

Capture cam;
OpenCV o = new OpenCV(this, width, height);
color cWanted;

SoundFile file;

int pX = 0;
int pY = 0;


void setup() {
  file = new SoundFile(this, dataPath("808-kick.wav"));
  print(dataPath("808-kick.wav"));
  file.play();
  file.amp(0.5);
  frameRate(30);
  size(320, 180);
  println((Object[])Capture.list());
  cam = new Capture(this, 320, 180, 30);
  cam.start();
  strokeWeight(7);
  colorMode(HSB);
}

void draw() {
  cam.read();
  image(cam, 0, 0);
  
  //print(cam.get(mouseX, mouseY));
  fill(cWanted);
  rect(0, 0, 50, 50);
  
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      if((cam.get(x, y) / 100000 >= cWanted / 100000 - 10 &&
      cam.get(x, y) / 100000 <= cWanted / 100000 + 10) && 
      (cam.get(x, y) / 100 >= cWanted / 100 - 10 && 
      cam.get(x, y) / 100 <= cWanted / 100 + 10)){
        
        if(x - pX > 40 || x - pX < - 40) {
         file.play(); 
        }
        
        
        
        pX = x;
        pY = y;
        point(x, y);
    }
}

}



}

void mouseClicked() {
  cWanted = cam.get(mouseX, mouseY);
}
