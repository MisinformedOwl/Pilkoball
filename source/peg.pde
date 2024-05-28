class peg{
  float x, y = 0;
  int size = 18;
  ArrayList<peghit> hits = new ArrayList<peghit>();
  
  public peg(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public boolean collided(float x2, float y2, int size){
    float xdiff = abs(this.x - x2);
    float ydiff = abs(this.y - y2);
    xdiff = xdiff*xdiff;
    ydiff = ydiff*ydiff;
    float pythag = xdiff+ydiff;
    pythag = sqrt(pythag)*2;
    if (pythag < size + this.size){
      hits.add(new peghit(this.x,this.y,this.size));
      return true;
    } else {
      return false;
    }
  }
  
  public void draw(){
    fill(130);
    ellipse(this.x,this.y,this.size,this.size);
    for(int p = 0; p < hits.size(); p++){
      if(hits.get(p).run()){
        hits.remove(p);
      }
    }
  }
}

class peghit{
  float x,y;
  float size;
  int lifetime = 20;
  int counter = 0;
  
  public peghit(float x, float y, float size){
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  public boolean run(){
    size+=1;
    counter+=1;
    fill(200, 255-((255/this.lifetime)*counter));
    ellipse(this.x, this.y, this.size,this.size);
    if (counter == lifetime){
      return true;
    } else {
      return false;
    }
  }
}
