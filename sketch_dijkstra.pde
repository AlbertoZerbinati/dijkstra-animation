import java.util.HashMap;
import java.util.Map;

// the graph
ArrayList<Node> nodes;
ArrayList<Arc> arcs;
// initial and final nodes
Node start;
Node target;

// data structures for the algorithm
int[] L; // shortest path from start to j know until current iteration
HashMap<Node, Node> pred; // predecessor of j in shortest path from s

// number of nodes
int n;

// number of iteration
int k;

// flag for finished alg
boolean solved;

void setup() {
  size(900, 800);

  n = 20;
  solved = false;

  nodes = new ArrayList<Node>(n);
  arcs = new ArrayList<Arc>();

  L = new int[n];
  pred = new HashMap<Node, Node>(n);

  // generate the nodes
  while (nodes.size() < n) {
    float randX = random(40, width-40);
    float randY = random(40, height-40);
    Node newNode = new Node(randX, randY, nodes.size());
    boolean add = true;
    for (int i = 0; i < nodes.size(); i++) {
      Node n = nodes.get(i);
      if (n.distanceFrom(newNode) < 40) {
        add = false;
        break;
      }
    }
    if (nodes.size() == 0 || add) {
      nodes.add(newNode);
    }
  }

  // generate the arcs
  for (int from = 0; from < nodes.size(); from++) {
    for (int to = 0; to < nodes.size(); to++) {
      if (from == to)
        continue;

      Arc newArc;
      // add just a few arcs
      if (random(0, 1) < 0.4)
        newArc = new Arc(nodes.get(from), nodes.get(to));
      else
        // express the absense of an arc by plugging a very high cost fictitious one
        newArc = new Arc(nodes.get(from), nodes.get(to), +9999999);

      arcs.add(newArc);
    }
  }

  // initialize nodes and data structures
  start = nodes.get(0);
  target = nodes.get(nodes.size()-1);
  start.start = true;
  target.target = true;

  L[0] = 0;
  for (int i = 1; i < n; i++) {
    pred.put(nodes.get(i), start);
    int arcIndex = arcs.indexOf(new Arc(start, nodes.get(i)));
    L[i] = arcs.get(arcIndex).cost;
  }

  start.visited = true;
  k = 1;
}

void draw() {
  background(50);

  // display the graph
  for (int i = 0; i < arcs.size(); i++) {
    arcs.get(i).display();
  }
  for (int i = 0; i < nodes.size(); i++) {
    nodes.get(i).display();
  }

  // reached all nodes
  if (k == n)
    solved = true;

  // 1 iteration
  if (!solved) {

    // find min
    int minCost = +9999999;
    Node h = new Node(0, 0, -1);
    int index_h = -1;

    for (int j = 0; j < n; j++) {
      if (! nodes.get(j).visited && L[j] < minCost) {
        minCost = L[j];
        index_h = j;
        h = nodes.get(j);
      }
    }

    if (index_h == -1)
      // no way to keep exploring and target not reached
      println("no solution!");

    else {
      h.visited = true;

      // update data structures
      for (int j = 0; j < n; j++) {
        int arcIndex = arcs.indexOf(new Arc(h, nodes.get(j)));
        if (!nodes.get(j).visited && L[index_h] + arcs.get(arcIndex).cost < L[j]) {
          L[j] = L[index_h] + arcs.get(arcIndex).cost;
          pred.put(nodes.get(j), h);
        }
      }

      // check if early finish
      if (h.equals(target)) {
        println("solved!");
        solved = true;

        // backtrack and highlight the path
        Node current = target;
        while (!current.equals(start)) {
          println(current.index);
          Node next = pred.get(current);
          Arc a = new Arc(next, current);
          arcs.get(arcs.indexOf(a)).solution = true;

          current = next;
        }
        println(current.index);
      }

      k++;
    }
  }

  noLoop();
}

void keyPressed() {
  loop();
}
