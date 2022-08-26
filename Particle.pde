
abstract class Particle
{
  // p = position, v = velocity
  protected float px, py, vx, vy, angle;
  protected float prevX, prevY;
  
  public Particle()
  {
    px = random(-BOUNDS_MARGIN, width + BOUNDS_MARGIN);
    py = random(-BOUNDS_MARGIN, height + BOUNDS_MARGIN);
    prevX = px;
    prevY = py;
    vx = vy = 0.f;
    angle = random(TWO_PI);
  }
  
  // allowed to be +/- 10 pixels off-screen in any direction before wrapping around
  protected static final float BOUNDS_MARGIN = 10.f;
  // distance from mouse before particle is affected by its proximity
  protected static final float DIST_THRESHOLD = 150.f;
  // we can use this value to compare distance from mouse against the threshold without sqrt()
  protected static final float DIST_THRSLD_SQ = DIST_THRESHOLD * DIST_THRESHOLD;
  // maximum number of pixels travelled per millisecond
  protected static final float MAX_SPEED = 0.1f;
  protected static final float IDLE_SPEED = 0.02f;
  protected static final float IDLE_ANGLE_CHANGE = TWO_PI/500.f;
  
  protected static final int MAX_SAVED = 4;
  
  public abstract void update(float time);
  
  public void draw(float time)
  {
    fixAngle();
    
    float speed = (vx * vx + vy * vy) / (MAX_SPEED * MAX_SPEED * time * time);
    speed = max(speed, .25f);
    
    strokeWeight(3.f);
    stroke(angle, 1.f, 1.f, speed);
    
    if (abs(px - prevX) < width && abs(py - prevY) < height)
      line(px, py, prevX, prevY);
    
    prevX = px;
    prevY = py;
  };
  
  protected void wrapAround()
  {
    if (px < -BOUNDS_MARGIN)
      px = width + BOUNDS_MARGIN / 2.f;
    else if (px > width + BOUNDS_MARGIN)
      px = BOUNDS_MARGIN / -2.f;
      
    if (py < -BOUNDS_MARGIN)
      py = height + BOUNDS_MARGIN / 2.f;
    else if (py > height + BOUNDS_MARGIN)
      py = BOUNDS_MARGIN / -2.f;
  }
  
  private void fixAngle()
  {
    if (angle < 0.f)
      angle += TWO_PI;
    else if (angle > TWO_PI)
      angle -= TWO_PI;
  }
}
