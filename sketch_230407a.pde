int rows = 20;
int columns = 20;
int numPyramids = rows * columns;
Pyramid[][] pyramids = new Pyramid[rows][columns];
BigPyramid bigPyramid;

void setup() {
  size(1920, 1080, P3D);
  smooth(8);

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      float x = map(j, 0, columns - 1, 100, width - 100);
      float y = map(i, 0, rows - 1, 100, height - 100);
      pyramids[i][j] = new Pyramid(x, y, random(50, 100), random(-0.01, 0.01), random(-0.01, 0.01));
    }
  }
  
  bigPyramid = new BigPyramid(width / 2, height / 2, min(width, height) / 2, 0.005, 0.005);
}

void draw() {
  background(0);

  for (Pyramid[] row : pyramids) {
    for (Pyramid p : row) {
      p.update();
      p.display();
    }
  }

  bigPyramid.update();
  bigPyramid.display();
}

class Pyramid {
  float x, y, size, angleX, angleY;

  Pyramid(float x, float y, float size, float angleX, float angleY) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.angleX = angleX;
    this.angleY = angleY;
  }

  void update() {
    angleX += angleY;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotateX(angleX);
    rotateY(angleY);
    stroke(255);
    noFill();
    drawWireframePyramid(size);
    popMatrix();
  }

  void drawWireframePyramid(float size) {
    float halfSize = size / 2;
    beginShape(LINES);

    // Base
    vertex(-halfSize, halfSize, -halfSize);
    vertex(halfSize, halfSize, -halfSize);

    vertex(halfSize, halfSize, -halfSize);
    vertex(halfSize, halfSize, halfSize);

    vertex(halfSize, halfSize, halfSize);
    vertex(-halfSize, halfSize, halfSize);

    vertex(-halfSize, halfSize, halfSize);
    vertex(-halfSize, halfSize, -halfSize);

    // Lati
    vertex(-halfSize, halfSize, -halfSize);
    vertex(0, -halfSize, 0);

    vertex(halfSize, halfSize, -halfSize);
    vertex(0, -halfSize, 0);

    vertex(halfSize, halfSize, halfSize);
    vertex(0, -halfSize, 0);

    vertex(-halfSize, halfSize, halfSize);
    vertex(0, -halfSize, 0);

    endShape();
  }
}

class BigPyramid {
  float x, y, z, size, angleX, angleY;

  BigPyramid(float x, float y, float size, float angleX, float angleY) {
    this.x = x;
    this.y = y;
    this.z = -size / 2; // Sposta la piramide lungo l'asse Z per evitare intersezioni
    this.size = size;
    this.angleX = angleX;
    this.angleY = angleY;
  }

  void update() {
    angleX += angleY;
  }

  void display() {
    pushMatrix();
    translate(x, y, z); // Aggiungi la coordinata z alla funzione translate()
    rotateX(angleX);
    rotateY(angleY);
    noStroke();
    drawBigPyramid(size);
    popMatrix();
  }

    void drawBigPyramid(float size) {
        float halfSize = size / 2;
        beginShape(TRIANGLES);

        // Faccia bianca
        fill(255);
        vertex(-halfSize, halfSize, -halfSize);
        vertex(halfSize, halfSize, -halfSize);
        vertex(0, -halfSize, 0);

        // Altre facce
        fill(200);
        vertex(halfSize, halfSize, -halfSize);
        vertex(halfSize, halfSize, halfSize);
        vertex(0, -halfSize, 0);

        fill(150);
        vertex(halfSize, halfSize, halfSize);
        vertex(-halfSize, halfSize, halfSize);
        vertex(0, -halfSize, 0);

        fill(100);
        vertex(-halfSize, halfSize, halfSize);
        vertex(-halfSize, halfSize, -halfSize);
        vertex(0, -halfSize, 0);

        endShape();
    }
}

