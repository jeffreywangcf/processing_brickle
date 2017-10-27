int DIRECTION = 135;

int STEP = 5;
int MOVEMENT = 20;

int BALL_X = 540;
int BALL_Y = 670;
int BALL_RAD = 25;

int LAST_X = -1;
int LAST_Y = -1;

int BASE_X = 465;
int BASE_Y = 688;
int BASE_LEN = 100;
int BASE_HEIGHT = 20;

void setup()
{
  size(1080, 720);
  background(#111732);
  strokeWeight(0);
  fill(#FF3459);
  ellipse(BALL_X, BALL_Y, BALL_RAD, BALL_RAD);
  fill(#F6F5FF);
  rect(BASE_X, BASE_Y, BASE_LEN, BASE_HEIGHT);
}
void gameOver()
{
  delay(1000000);
}
void touch()
{
  if(bounce(BASE_X, BASE_Y, BASE_LEN, BASE_HEIGHT))
    return;
  if(BALL_Y > (720 - BALL_RAD/2))
    gameOver();
  boolean onRightBound = BALL_X > (1080 - BALL_RAD/2);
  boolean onLeftBound = BALL_X < BALL_RAD/2;
  boolean onTopBound = BALL_Y < BALL_RAD/2;
  if(onRightBound || onLeftBound || onTopBound)
  {
    //print("touch\n");
    //print(DIRECTION, LAST_X, LAST_Y, BALL_X, BALL_Y);
    //print("\n");
    if(onRightBound)
      if(LAST_Y < BALL_Y)
        DIRECTION -= 90;
      else
        DIRECTION += 90;
    else if(onLeftBound)
      if(LAST_Y < BALL_Y)
        DIRECTION += 90;
      else
        DIRECTION -= 90;
    else
      if(LAST_X < BALL_X)
        DIRECTION -= 90;
      else
        DIRECTION += 90;
    if(DIRECTION < 0)
      DIRECTION = 315;
    if(DIRECTION > 360)
      DIRECTION = 45;
    LAST_X = BALL_X;
    LAST_Y = BALL_Y;
  }
}
boolean bounce(int shapeX, int shapeY, int shapeLen, int shapeHeight)
{
  boolean c1 = ((BALL_X + BALL_RAD/2) >= shapeX && (BALL_X - BALL_RAD/2) <= (shapeX + shapeLen));
  boolean c2 = ((BALL_Y + BALL_RAD/2) >= shapeY && (BALL_Y - BALL_RAD/2) <= (shapeY + shapeHeight));
  if(c1 && c2)
  {
    //print("bounce\n");
    //print(DIRECTION, LAST_X, LAST_Y, BALL_X, BALL_Y);
    //print("\n");
    if((BALL_Y - BALL_RAD/2) <= (shapeY + shapeHeight / 2))
      if(LAST_X > BALL_X)
        DIRECTION -= 90;
      else
        DIRECTION += 90;
    else if((BALL_Y - BALL_RAD/2) > (shapeY + shapeHeight / 2))
      if(LAST_X > BALL_X)
        DIRECTION += 90;
      else
        DIRECTION -= 90;
    else if((BALL_X + BALL_RAD/2) <= (shapeX + shapeLen / 2))
      if(LAST_Y > BALL_Y)
        DIRECTION += 90;
      else
        DIRECTION -= 90;
    else
      if(LAST_Y > BALL_Y)
        DIRECTION -= 90;
      else
        DIRECTION += 90;
    if(DIRECTION < 0)
      DIRECTION = 315;
    if(DIRECTION > 360)
      DIRECTION = 45;
    LAST_X = BALL_X;
    LAST_Y = BALL_Y;
    return true;
  }
  return false;
}
void move()
{
  fill(#111732);
  //ellipse(BALL_X, BALL_Y, BALL_RAD, BALL_RAD);
  switch(DIRECTION)
  {
    case 135:
      BALL_X -= STEP;
      BALL_Y -= STEP;
      break;
    case 225:
      BALL_X -= STEP;
      BALL_Y += STEP;
      break;
    case 315:
      BALL_X += STEP;
      BALL_Y += STEP;
      break;
    default:
      BALL_X += STEP;
      BALL_Y -= STEP;
      break;
  }
  fill(#FF3459);
  ellipse(BALL_X, BALL_Y, BALL_RAD, BALL_RAD);
  fill(#F6F5FF);
  rect(BASE_X, BASE_Y, BASE_LEN, BASE_HEIGHT);
}
void keyPressed()
{
  if(key == CODED)
  {
    if(keyCode == LEFT)
    {
      fill(#111732);
      rect(BASE_X, BASE_Y, BASE_LEN, BASE_HEIGHT);
      BASE_X -= MOVEMENT;
      fill(#F6F5FF);
      rect(BASE_X, BASE_Y, BASE_LEN, BASE_HEIGHT);
    }
    else if(keyCode == RIGHT)
    {
      fill(#111732);
      rect(BASE_X, BASE_Y, BASE_LEN, BASE_HEIGHT);
      BASE_X += MOVEMENT;
      fill(#F6F5FF);
      rect(BASE_X, BASE_Y, BASE_LEN, BASE_HEIGHT);
    }
  }
}
void draw()
{
  touch();
  move();
}