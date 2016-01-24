/*
 * Author: Patrick Hickey
 *
 * Bubble data structure to encapsulate drawing of data
 */

class Bubble implements Comparable<Bubble>{
  ArrayList<Float> vals;
  ArrayList<String> texts;
  float xPos, yPos, weight;
  
  Bubble() {
    vals = new ArrayList<Float>();
    texts = new ArrayList<String>();
    xPos = width / 2;
    yPos = height / 2;
    weight = 0;
  }
  
  void drawBubble(int text_ind, int val_ind) {
    // map color of bubble based on ratio of weight to actual value
    fill(map(weight/vals.get(val_ind), 0, 2.0, 0, 180), 255, 255);
    ellipse(xPos, yPos, weight, weight);
    if (text_ind != texts.size()) {
      textSize(map(weight, 0, 150, 10, 36));
      fill(255);
      text(texts.get(text_ind), xPos-weight/2, yPos + 5);
      textSize(map(weight, 0, 150, 4, 12));
      text(nf(vals.get(val_ind), 1, 1), xPos - 10, yPos + 12);
    }
  }
  
  void setXY(float x, float y) {
    xPos = x;
    yPos = y;
  }
  
  boolean clear(ArrayList<Bubble> bubs, int n) {
    for (int i = 0; i < n; i++) {
      Bubble b = bubs.get(i);
      if (this.intersects(b) && this != b) {
        return false;
      }
    }
    return true;
  }
  
  boolean intersects(Bubble b) {
    return this.distanceTo(b) < (this.weight + b.weight)/2;
  }
  
  float distanceTo(Bubble b) {
    float x_dist = this.xPos - b.xPos;
    float y_dist = this.yPos - b.yPos;
    return (float) Math.sqrt(x_dist*x_dist + y_dist*y_dist);
  }

  public int compareTo(Bubble b) {
    return int(this.weight - b.weight);
  }
}
