class goal{
  String valueTitle;
  float value;
  color col;
  int x,y;
  int len = 70;
  int hei = this.len/2;
  boolean hit = false;
  float sin;
  int sinCount = 0;
  int sinLimit = 10;
  float shader = 0.7;
  int hitCounter = 0;
  
  
  public goal(int x, int y, float value, color col){
    this.value = value;
    this.valueTitle = String.valueOf(value) + "x";
    this.col = col;
    this.x = x;
    this.y = y;
  }
  
  public boolean collision(MoneyBall b){
    float ydiff = abs(this.y - b.y);
    
    if (ydiff < this.hei/2){
      if (b.x >this.x && b.x < this.x+this.len){
        this.hitCounter++;
        this.hit = true;
        return true;
      }
    }
    return false;
  }
  
  public void draw(){
    if (this.hit){ this.moving(); }
    fill(color(red(this.col)*shader, green(this.col)*shader, blue(this.col)*shader));
    rect(this.x,this.y+this.sin+7,len,hei, 6);
    fill(this.col);
    rect(this.x,this.y+this.sin,len,hei, 6);
    fill(color(0,0,0));
    text(valueTitle, this.x+this.len / 5, (this.y + this.hei - this.hei / 3)+ this.sin);
  }
  
  private void moving(){
    this.sinCount++;
    this.sin = sin(sinCount/3)*10;
    if (sinCount > sinLimit){
      this.hit = false;
      this.sin = 0.0;
      sinCount = 0;
    }
  }
}
