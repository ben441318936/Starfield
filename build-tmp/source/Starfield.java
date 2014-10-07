import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Starfield extends PApplet {

int num=200;
NormalParticle firework[]=new NormalParticle[num];
public void setup()
{
	size(500,500);
	background(0);
	for(int i=0;i<num;i++)
	{
		//firework[i]=new NormalParticle((int)(Math.random()*51)+225,(int)(Math.random()*51)+225);
		firework[i]=new NormalParticle(250,250);
	}
}
public void draw()
{
	//background(0);
	noStroke();
	fill(0, 5);
	rect(0,0,500,500);
	for(int i=0;i<num;i++)
	{
		//firework[i].bounce();
		firework[i].move();
		firework[i].reCenter();
		firework[i].show();
	}
}
class NormalParticle
{
	double xPosition,yPosition,angle,speed;
	int c;
	NormalParticle(int x, int y)
	{
		xPosition=x;
		yPosition=y;
		angle=(Math.random()*2)*Math.PI;
		speed=Math.random()*3;
		c= color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
	}
	public void move()
	{
		xPosition=Math.cos(angle)*speed+xPosition;
		yPosition=Math.sin(angle)*speed+yPosition;
	}
	public void show()
	{
		noStroke();
		fill(c);
		ellipse((float)(xPosition),(float)(yPosition),3,3);
	}
	/*void bounce()
	{
		if (xPosition<=0 || xPosition>=500)
		{
			angle=180-angle;
		}
		if (yPosition<=0 || yPosition>=500)
		{
			angle=-angle;
		}
	}*/
	public void reCenter()
	{
		if (xPosition<=0 || xPosition>=500)
		{
			xPosition=250;
			yPosition=250;
		}
		if (yPosition<=0 || yPosition>=500)
		{
			xPosition=250;
			yPosition=250;
		}
	}
}
interface Particle
{
	//your code here
}
class OddballParticle
{
	//your code here
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Starfield" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
