class MoneyBall {
  float x, y = 0;
  float prevX, prevY = 0;
  int size = 30;
  float velx = 0;
  float vely = 0;
  color col;
  float bounce = 0.7;
  boolean dead = false;
  float value;
  float weight = 0.4;
  
  public MoneyBall(float x, float y, color col, float value){
    this.x = x;
    this.y = y;
    this.col = col;
    this.value = value;
  }
  
  private void pegCheck(){
    for (peg p : pegs){
      if (p.collided(this.x, this.y, this.size)){
        this.collision(p);
      } else {
        this.saveCords();
      }
    }
    for (goal g : goals){
      if(g.collision(this)){
        this.scored(g);
      }
    }
  }
  
  private void scored(goal g){
    this.dead = true;
    
    score+=this.value*g.value;
  }
  
  private void preCollision(){
    this.x = this.prevX;
    this.y = this.prevY;
  }
  
  private void fall(){
    this.x += this.velx;
    this.y += this.vely;
    this.vely +=this.weight;
  }
  
  private void saveCords(){
    this.prevX = this.x;
    this.prevY = this.y;
  }
  
  private void collision(peg p){
    int dist = (this.size/2+p.size/2);
    float yvel = (this.y - p.y)/dist;
    float xvel = (this.x - p.x)/dist;
    
    if (this.velx > 0){
    this.velx = ((this.velx * xvel) + (this.vely * xvel)/2.3)*bounce;
    } else {
    this.velx = ((-this.velx * xvel) + (this.vely * xvel)/2.3)*bounce;
    }
    this.vely = (this.vely * -abs(yvel))*bounce;
    this.preCollision();
    this.fall();
  }

  public void run(){
    this.create();
    this.pegCheck();
    this.fall();
    this.kill();
  }
  
  public void create(){
    fill(this.col);
    ellipse(this.x,this.y,this.size,this.size);
  }
  
  public void kill(){
    if(this.x > width || this.y > height || this.y < 0){
      this.dead = true;
    }
  }
}
