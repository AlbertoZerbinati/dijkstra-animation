class Arc {
  Node from, to;
  int cost;
  boolean solution;

  Arc(Node from, Node to) {
    this.from = from;
    this.to = to;
    this.cost = int(random(1, 200));
  }

  Arc(Node from, Node to, int cost) {
    this.from = from;
    this.to = to;
    this.cost = int(cost);
  }

  void display() {
    if (cost >= 200) return;
    float len = from.distanceFrom(to);
    float angle = acos(abs(from.x-to.x)/len);
    len = len-21;
    if (to.y < from.y && to.x > from.x)
      angle = -angle;
    else if (to.y < from.y && to.x < from.x)
      angle = PI + angle;
    else if (to.y > from.y && to.x < from.x)
      angle = PI - angle;

    if (!this.solution) {
      stroke(255, 150);
      strokeWeight(1);
      textSize(10);
    } else {
      stroke(100, 255, 0, 200);
      strokeWeight(3);
      textSize(30);
    }

    pushMatrix();
    translate(from.x, from.y);
    rotate(angle);
    line(0, 0, len, 0);
    line(len, 0, len - 6, -6);
    line(len, 0, len - 6, 6);
    popMatrix();

    stroke(255);

    pushMatrix();
    translate(from.x+len/2*cos(angle), from.y+len/2*sin(angle));
    rotate(angle);
    text(cost, 0, -5);
    popMatrix();
  }

  @Override
    boolean equals(Object other) {
    if (!(other instanceof Arc)) {
      return false;
    }

    Arc o = (Arc) other;
    return o.from.equals(this.from) && o.to.equals(this.to);
  }
}
