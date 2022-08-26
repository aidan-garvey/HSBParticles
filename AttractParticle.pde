class AttractParticle extends Particle
{
  public AttractParticle()
  {
    super();
  }
  
  public void update(float time)
  {
    // determine distance from mouse (without taking sqrt)
    float mouseDist = Float.MAX_VALUE;
    // don't calculate unneeded values
    if (leftHeld)
      mouseDist = (mouseX - px) * (mouseX - px) + (mouseY - py) * (mouseY - py);

    float speed;
    
    // pick a random angle and velocity and move that way
    float angleChange = random(-IDLE_ANGLE_CHANGE, IDLE_ANGLE_CHANGE) * time;
    angle += angleChange;
    speed = random(IDLE_SPEED) * time;
    
    vx = speed * cos(angle);
    vy = speed * sin(angle);
    px += vx;
    py += vy;
    
    if (leftHeld && mouseDist <= DIST_THRSLD_SQ)
    {
      // move towards mouse, slow down as distance closes
      angle = PI + atan2(py - mouseY, px - mouseX);
      speed = (mouseDist / DIST_THRSLD_SQ) * MAX_SPEED;
      speed *= time;
      vx = speed * cos(angle);
      vy = speed * sin(angle);
      px += vx;
      py += vy;
    }
    
    wrapAround();
  }
}
