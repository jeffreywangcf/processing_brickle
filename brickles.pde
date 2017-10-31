int DIRECTION = 135;

int STEP = 4;
int MOVEMENT = 25;

int BALL_X = 540;
int BALL_Y = 670;
int BALL_RAD = 15;

int LAST_X = -1;
int LAST_Y = -1;

int BASE_X = 0;
int BASE_Y = 688;
int BASE_LEN = 1080;
int BASE_HEIGHT = 20;

int brickLen = 108;
int brickHeight = 40;

class Bricks
{
  private int m_X;
  private int m_Y;
  private int m_Len;
  private int m_Height;
  private float[] m_colors;
  private boolean m_status;
  public Bricks(int x, int y, int len, int h)
  {
    this.m_X = x;
    this.m_Y = y;
    this.m_Len = len;
    this.m_Height = h;
    this.m_status = true;
    this.m_colors = new float[2];
    m_colors[0] = random(128, 256);
    m_colors[1] = m_colors[0] + random(16, 64);
  }
}

Bricks[][] brickles = new Bricks[8][10];
int totalActivatedBricks = 0;


void setup()
{
  size(1080, 720);
  background(#111732);
  strokeWeight(0);
  fill(#FF3459);
  ellipse(BALL_X, BALL_Y, BALL_RAD, BALL_RAD);
  fill(#F6F5FF);
  rect(BASE_X, BASE_Y, BASE_LEN, BASE_HEIGHT);
  int yVal = 0;
  for(int i = 0; i < brickles.length; i++)
  {
    int xVal = 0;
    for(int j = 0; j < brickles[i].length; j++)
    {
      brickles[i][j] = new Bricks(xVal, yVal, brickLen, brickHeight);
      fill(brickles[i][j].m_colors[0], brickles[i][j].m_colors[1], 255);
      rect(brickles[i][j].m_X, brickles[i][j].m_Y, brickles[i][j].m_Len, brickles[i][j].m_Height);
      xVal += brickLen;
    }
    yVal += brickHeight;
  }
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
  ellipse(BALL_X, BALL_Y, BALL_RAD, BALL_RAD);
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
void erase(int brick_X, int brick_Y)
{
  fill(#111732);
  rect(brickles[brick_X][brick_Y].m_X, brickles[brick_X][brick_Y].m_Y, 
        brickles[brick_X][brick_Y].m_Len, brickles[brick_X][brick_Y].m_Height);
  bounce(brickles[brick_X][brick_Y].m_X, brickles[brick_X][brick_Y].m_Y, 
        brickles[brick_X][brick_Y].m_Len, brickles[brick_X][brick_Y].m_Height);
  brickles[brick_X][brick_Y].m_status = false;
}
void draw()
{
  touch();
  move();
  if(BALL_Y - BALL_RAD/2 < brickHeight * 8)
    if(brickles[int((BALL_Y - BALL_RAD/2)/brickHeight)][int(BALL_X/brickLen)].m_status)
      erase(int((BALL_Y - BALL_RAD/2)/brickHeight), int(BALL_X/brickLen));
}
