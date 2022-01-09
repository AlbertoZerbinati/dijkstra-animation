class Node {
  float x, y, r;
  boolean visited;
  boolean start;
  boolean target;
  int index;

  Node(float x, float y, int i) {
    this.x = x;
    this.y = y;
    this.r = 40;
    this.visited = false;
    this.index = i;
  }

  void display() {
    fill(150);
    if (this.start) {
      fill(200, 200, 0, 200);
    } else if (this.target) {
      fill(0, 200, 200, 200);
    }
    if (this.visited) {
      stroke(255, 0, 0);
      strokeWeight(3);
    } else {
      stroke(255);
      strokeWeight(1);
    }

    circle(this.x, this.y, this.r);

    textSize(20);
    textAlign(CENTER);
    fill(255);
    text(this.index, this.x, this.y);
  }

  float distanceFrom(Node other) {
    return sqrt(pow((this.x-other.x), 2) + pow((this.y-other.y), 2));
  }

  @Override
    boolean equals(Object other) {
    if (!(other instanceof Node)) {
      return false;
    }

    Node o = (Node) other;
    return o.x == this.x && o.y == this.y;
  }
}
