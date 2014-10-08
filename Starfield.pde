public static int num=200;
Particle firework[]=new Particle[num+1];
int counter=0;
boolean launch=false;
boolean explode=false;
void setup()
{
	size(500,500);
	background(0);
	for(int i=0;i<num;i++)
	{
		firework[i]=new NormalParticle(width/2,height/2);
	}
	firework[num]=new OddballParticle(width/2,height);
}
void draw()
{
	//background(0);
	noStroke();
	fill(0, 50);
	rect(0,0,width,height);
	for(int i=0;i<num+1;i++)
	{
		if (explode==true)
		{
			if(firework[i] instanceof NormalParticle)
			{
				((NormalParticle)firework[i]).reCenter();
			}
		}
		firework[i].move();
		firework[i].show();
	}
	if(counter>=170)
	{
		for(int i=0;i<num+1;i++)
		{
			if(firework[i] instanceof NormalParticle)
			{
				((NormalParticle)firework[i]).reFire();
			}			
		}
		counter=0;
	}
}
class NormalParticle implements Particle
{
	double xPosition,yPosition,angle,speed;
	color c;
	NormalParticle(int x, int y)
	{
		xPosition=x;
		yPosition=y;
		angle=(Math.random()*2)*Math.PI;
		speed=Math.random()*10;
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
	
	void reCenter()
	{
		if (xPosition<0 || xPosition>width)
		{
			xPosition=width/2;
			yPosition=height/2;
			angle=(Math.random()*2)*Math.PI;
			speed=0;
			counter++;
		}
		if (yPosition<0 || yPosition>height)
		{
			xPosition=width/2;
			yPosition=height/2;
			angle=(Math.random()*2)*Math.PI;
			speed=0;
			counter++;
		}
	}
	void reFire()
	{
		speed=Math.random()*10;

	}
}

class OddballParticle implements Particle
{
	double xPosition,yPosition,angle,speed;
	color c;
	OddballParticle(int x, int y)
	{
		xPosition=x;
		yPosition=y;
		angle=3*Math.PI/2;
		speed=10;
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
		fill(255);
		ellipse((float)(xPosition),(float)(yPosition),10,10);
	}
	void bounce()
	{
		if (xPosition<=0 || xPosition>=500)
		{
			angle=180-angle;
		}
		if (yPosition<=0 || yPosition>=500)
		{
			angle=-angle;
		}
	}
}

interface Particle
{
	public void move();
	public void show();
}

void mousePressed()
{
	launch=true;
}