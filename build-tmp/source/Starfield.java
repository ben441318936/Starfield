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

public static int num=200;
Particle firework[]=new Particle[num+1];
float counter=0;
boolean launch=false;
boolean explode=false;
float opac=30;
public void setup()
{
	size(500,500);
	background(0);
	for(int i=0;i<num;i++)
	{
		firework[i]=new NormalParticle(width/2,height/2);
	}
	firework[num]=new OddballParticle(width/2,height);
}
public void draw()
{
	if(launch==true)
	{
		noStroke();
		fill(0, opac);
		rect(0,0,width,height);
		for(int i=0;i<num+1;i++)
		{
			firework[i].move();
			firework[i].show();
			((OddballParticle)firework[num]).reachCenter();
		}
		if(counter>=30*(num/100))
		{
			opac=counter*(100.0f/num);
		}
	}
}
class NormalParticle implements Particle
{
	double xPosition,yPosition,angle,speed;
	int c;
	NormalParticle(int x, int y)
	{
		xPosition=x;
		yPosition=y;
		angle=(Math.random()*2)*Math.PI;
		speed=0;
		c=0;
	}
	public void move()
	{
		xPosition=Math.cos(angle)*speed+xPosition;
		yPosition=Math.sin(angle)*speed+yPosition;
		if (xPosition<0 || xPosition>width)
		{
			counter++;
		}
		if (yPosition<0 || yPosition>height)
		{
			counter++;
		}
	}
	public void show()
	{
		noStroke();
		fill(c);
		ellipse((float)(xPosition),(float)(yPosition),3,3);
	}
	public void reCenter()
	{
		xPosition=width/2;
		yPosition=height/2;
		angle=(Math.random()*2)*Math.PI;
		speed=0;
		c=0;
	}
	public void fire()
	{
		xPosition=((OddballParticle)firework[num]).xPosition;
		yPosition=((OddballParticle)firework[num]).yPosition;
		speed=Math.random()*10+1;
		c= color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
	}
}
class OddballParticle implements Particle
{
	double xPosition,yPosition,angle,speed;
	int c;
	OddballParticle(int x, int y)
	{
		xPosition=x;
		yPosition=y;
		angle=Math.random()+4*(Math.PI/3);
		speed=10;
		c= 255;
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
		ellipse((float)(xPosition),(float)(yPosition),10,10);
	}
	public void reachCenter()
	{
		if(yPosition<=height/2)
		{
			speed=0;
			c=0;
			explode();
			xPosition=width/2;
			yPosition=height;
		}
	}
}
interface Particle
{
	public void move();
	public void show();
}
public void explode()
{
	for(int i=0;i<num+1;i++)
	{
		if(firework[i] instanceof NormalParticle)
		{
			((NormalParticle)firework[i]).fire();
		}
	}
}
public void mousePressed()
{
	counter=0;
	opac=30;
	if(launch==true)
	{
		for(int i=0;i<num+1;i++)
		{
			if(firework[i] instanceof NormalParticle)
			{
				((NormalParticle)firework[i]).reCenter();
			}
			if(firework[i] instanceof OddballParticle)
			{
				((OddballParticle)firework[i]).c=255;
				((OddballParticle)firework[i]).speed=10;
				((OddballParticle)firework[i]).angle=Math.random()+4*(Math.PI/3);
			}
		}
	}
	launch=true;
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
