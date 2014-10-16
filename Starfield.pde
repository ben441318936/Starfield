public static int num=200;
Particle firework[]=new Particle[num+1];
float counter=0;
boolean launch=false;
float opac=30;
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
	startLoop();
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
			opac=counter*(100.0/num);
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
		if (xPosition<0 || xPosition>width || yPosition<0 || yPosition>height)
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
		xPosition=((OddballParticle)firework[num]).xPosition;
		yPosition=((OddballParticle)firework[num]).yPosition;
		speed=Math.random()*10+1;
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
		angle=Math.random()+4*(Math.PI/3);
		speed=10;
		c= 255;
	}
	void reset()
	{
		xPosition=width/2;
		yPosition=height;
		angle=Math.random()+4*(Math.PI/3);
		speed=10;
		c= 255;
	}
	public void move()
	{
		xPosition=Math.cos(angle)*speed+xPosition;
		yPosition=Math.sin(angle)*speed+yPosition;
		if(speed != 0)
		{
			if (angle<(3*Math.PI/2))
			{
			angle=angle-0.005;
			}
			else if (angle>(3*Math.PI/2))
			{
				angle=angle+0.005;
			}
		}
	}
	public void show()
	{
		noStroke();
		fill(c);
		ellipse((float)(xPosition),(float)(yPosition),10,10);
	}
	void reachCenter()
	{
		if((yPosition<=height-350) || (xPosition<=100) || (xPosition>=400))
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
void startLoop()
{
	if(counter>=2000)
	{
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
					if(((OddballParticle)firework[i]).speed==0)
					{
						((OddballParticle)firework[i]).angle=Math.random()+4*(Math.PI/3);
					}
					((OddballParticle)firework[i]).speed=10;
				}
			}
		}
		counter=0;
		opac=30;
	}
}
void mouseClicked()
{	
	launch=!launch;
}