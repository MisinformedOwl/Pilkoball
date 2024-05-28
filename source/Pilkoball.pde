ArrayList<MoneyBall> balls = new ArrayList<MoneyBall>();
ArrayList<peg> pegs = new ArrayList<peg>();
ArrayList<goal> goals = new ArrayList<goal>();

void setup() {
  int spacerValue = 80;
  size(1000, 1000);
  background(0);
  noStroke();
  rotate(180);

  int leng = 12;

  for (int y = 3; y < 12; y++) {
    for (int x = 0; x < y*spacerValue; x+=spacerValue) {
      pegs.add(new peg((width/2-(y*spacerValue)/2)+spacerValue/2 + x, (y-2)*spacerValue+spacerValue));
    }
  }

  float[] values = {5.6, 2, 0.9, 0.5, 0.2, 0.2, 0.5, 0.9, 2, 5.6};



  for (int a = 0; a < leng-2; a++) {
    goals.add(new goal((int)((a*spacerValue))+spacerValue+30,
      (leng-2)*spacerValue+spacerValue/2,
      values[a],
      color(255-values[a]*100, values[a]*100, 0)));
  }
}

float betting = 1000;
float score = 10000;

void mouseWheel(MouseEvent event) {
  int e = -event.getCount();
  if (e == 1 && betting < score) {
    betting += 100;
  } else if (e == -1 && betting >0) {
    betting -= 100;
  }
}

void mouseClicked() {
  if (betting == 0) {
    return;
  }
  if (score >=betting) {
    print(betting/score);
    balls.add(new MoneyBall(random(width/2-50, width/2+50), 50, color(255*(1-betting/score), 255*(betting/score), 0), betting));
    score -= betting;
  }
}

void draw() {
  fill(0, 140);
  rect(0, 0, width, height);
  for (int b = 0; b < balls.size(); b++) {
    balls.get(b).run();
    if (balls.get(b).dead) {
      balls.remove(b);
    }
  }
  for (peg p : pegs) {
    p.draw();
  }
  for (goal g : goals) {
    g.draw();
  }
  textSize(40);
  fill(color(255, 255, 255));
  text("Bank: £"+score, 0, 40);
  text("Betting: £" + betting, width-400, 40);
  textSize(20);
}
