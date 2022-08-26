
boolean leftHeld = false, rightHeld = false;

void mousePressed()
{
  switch (mouseButton)
  {
    case LEFT:
      leftHeld = true;
      break;
    case RIGHT:
      rightHeld = true;
      break;
  }
}

void mouseReleased()
{
  switch(mouseButton)
  {
    case LEFT:
      leftHeld = false;
      break;
    case RIGHT:
      rightHeld = false;
      break;
  }
}
