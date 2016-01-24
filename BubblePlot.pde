import de.voidplus.myo.*;
import java.util.Collections;

Myo myo;

ArrayList<Bubble> data = new ArrayList<Bubble>();

float z_val, xOff, yOff, val_min, val_max;
String[] format, lines;
// Determined from spec line
int val_ind, text_ind, num_vals, num_texts;
boolean pan = false;
int state;

public static final int CLUSTER = 0;
public static final int SPIRAL = 1; 

void setup() {
  size(800, 600);
  colorMode(HSB, 255);
  background(0);

  myo = new Myo(this);

  val_ind = text_ind = num_vals = num_texts = 0;
  z_val = 1.0;

  lines = loadStrings("college_data.sfd");
  format = lines[0].split(",");
  for (int i = 1; i < lines.length; i++) {
    Bubble b = new Bubble();
    String[] line = lines[i].split(",");
    for (int j = 0; j < format.length; j++) {
      switch(format[j].charAt(0)) {
      case '%':
        b.vals.add(Float.parseFloat(line[j]));
        break;

      case '"':
        b.texts.add(line[j]);
        break;

      default:
        println("Unknown format specifier");
        break;
      }
    }
    data.add(b);
  }

  num_vals = data.get(0).vals.size();
  text_ind = num_texts = data.get(0).texts.size();
  state = CLUSTER;
  val_min = getMin();
  val_max = getMax();
}

void draw() {
  background(0);
  PVector dir = myo.getOrientation();
  z_val = constrain(z_val, 0.5, 4.0);

  if (pan) {
    xOff = map(dir.z, 0.0, 16.0, -50, 50);
    yOff = map(dir.y, 0.0, 16.0, -50, 50);
    xOff += xOff / 10;
    yOff += yOff / 10;
    translate(xOff * z_val, yOff * z_val);
  }
  // need translate to compensate for zoom offset
  translate((width/2)*(1-z_val), (height/2)*(1-z_val));
  scale(z_val);

  // Move bubbles based on state
  if (state == CLUSTER) {
    cluster();
  } else if (state == SPIRAL) {
    spiral();
  }

  // If all the bubbles are in the center, make next spiral
  boolean change = true;
  for (Bubble b : data) {
    if (b.xPos <= width/2 - 10 || b.xPos >= width/2 + 10 ||
      b.yPos <= height/2 - 10 || b.yPos >= height/2 + 10) {
      change = false;
    }
  }
  if (change) {
    val_min = getMin();
    val_max = getMax();
    for (Bubble b : data) {
      b.weight = map(b.vals.get(val_ind), val_min, val_max, 5, 90);
    }
    Collections.sort(data, Collections.reverseOrder());
    state = SPIRAL;
  }

  // Draw all the things
  for (Bubble b : data) {
    b.drawBubble(text_ind, val_ind);
  }
  System.out.printf("xOff: %f, yOff: %f, z_val: %f\n", xOff, yOff, z_val);
}

// -------------- Data Stuffs ---------------

float getMin() {
  float min = data.get(0).vals.get(val_ind);
  for (Bubble b : data) {
    float val = b.vals.get(val_ind);
    if (val < min) {
      min = val;
    }
  }
  return min;
}

float getMax() {
  float max = data.get(0).vals.get(val_ind);
  for (Bubble b : data) {
    float val = b.vals.get(val_ind);
    if (val > max) {
      max = val;
    }
  }
  return max;
}
// ---------------- Drawing -----------------

void spiral() {
  for (int i = 0; i < data.size (); i++) {
    Bubble b = data.get(i);
    float cx = width / 2, cy = height / 2, px, py;
    float R = 0.0, dR = 0.5, theta = 0.0, dTheta = 0.5;
    do {
      float x = cx + R * cos(theta);
      float y = cy + R * sin(theta);
      b.setXY(x, y);
      px = x;
      py = y;
      theta += dTheta;
      R += dR;
    } 
    while (!b.clear (data, i));
  }
}

void cluster() {
  for (Bubble b : data) {
    float xVec = b.xPos - width/2;
    float yVec = b.yPos - height/2;
    xVec *= 0.1;
    yVec *= 0.1;
    b.xPos -= xVec;
    b.yPos -= yVec;
  }
}

// -------------- Myo Controls --------------

void myoOnPose(Myo myo, long timestamp, Pose pose) {
  println("Sketch: myoOnPose");
  switch (pose.getType()) {
  case REST:
    println("Pose: REST");
    break;
  case FIST:
    println("Pose: FIST");
    val_ind = ++val_ind % num_vals;
    state = CLUSTER;
    break;
  case FINGERS_SPREAD:
    println("Pose: FINGERS_SPREAD");
    text_ind = ++text_ind % (num_texts + 1);
    break;
  case DOUBLE_TAP:
    println("Pose: DOUBLE_TAP");
    pan = !pan;
    break;
  case WAVE_IN:
    println("Pose: WAVE_IN");
    z_val += 0.2;
    break;
  case WAVE_OUT:
    println("Pose: WAVE_OUT");
    z_val -= 0.2;
    break;
  default:
    break;
  }
}

