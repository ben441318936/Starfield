int num=200;
Particle firework[]=new Particle[num+1];
float counter=0;
boolean launch=false;
boolean explode=false;
float opacity=30;
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
	if(launch==true)
	{
		noStroke();
		fill(0, opacity);
		rect(0,0,width,height);
		for(int i=0;i<num+1;i++)
		{
			firework[i].move();
			firework[i].show();
			((OddballParticle)firework[num]).reachCenter();
		}
		if(counter>=30*(num/100))
		{
			opacity=counter*(100.0/num);
		}
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
	void reCenter()
	{
		xPosition=width/2;
		yPosition=height/2;
		angle=(Math.random()*2)*Math.PI;
		speed=0;
		c=0;
	}
	void fire()
	{
		speed=Math.random()*10;
		c= color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
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
	void reachCenter()
	{
		if(yPosition<=height/2)
		{
			xPosition=width/2;
			yPosition=height;
			speed=0;
			c=0;
			explode();
		}
	}
}
interface Particle
{
	public void move();
	public void show();
}
void explode()
{
	for(int i=0;i<num+1;i++)
	{
		if(firework[i] instanceof NormalParticle)
		{
			((NormalParticle)firework[i]).fire();
		}
	}
}
void mousePressed()
{
	background(0);
	counter=0;
	opacity=30;
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
			}
		}
	}
	launch=true;
}