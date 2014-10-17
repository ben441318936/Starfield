@pjs preload="att-park.jpg";
PImage img;
public static int num=100;
Particle firework1[]=new Particle[num+1];
Particle firework2[]=new Particle[num+1];
float counter1=0;
float counter2=0;
boolean launch1=true;
boolean launch2=false;
float opac=30;
boolean beginLoop=false;
void setup()
{
	img=loadImage("att-park.jpg");
	size(640,427);
	background(0);
	for(int i=0;i<num;i++)
	{
		firework1[i]=new NormalParticle(width/2,height/2,1);
	}
	firework1[num]=new OddballParticle(width/2,height,1);
	for(int i=0;i<num;i++)
	{
		firework2[i]=new NormalParticle(width/2,height/2,2);
	}
	firework2[num]=new OddballParticle(width/2,height,2);
	image(img,0,0);
	textAlign(CENTER);
	textSize(36);
	text("Click on the screen!", width/2, height/2);
}
void draw()
{
	if(beginLoop==true)
	{
		startLoop();
		noStroke();
		image(img,0,0);
		fill(0, opac);
		rect(0,0,width,height);
		if(launch1==true)
		{
			for(int i=0;i<num+1;i++)
			{
				firework1[i].move();
				firework1[i].show();
				((OddballParticle)firework1[num]).reachCenter();
			}
		}
		if(launch2==true)
		{
			for(int i=0;i<num+1;i++)
			{
				firework2[i].move();
				firework2[i].show();
				((OddballParticle)firework2[num]).reachCenter();
			}
		}
		checkLaunchStatus();
	}
}
class NormalParticle implements Particle
{
	double xPosition,yPosition,angle,speed;
	color c;
	int id;
	NormalParticle(int x, int y, int z)
	{
		xPosition=x;
		yPosition=y;
		angle=(Math.random()*2)*Math.PI;
		speed=0;
		c=0;
		id=z;
	}
	public void move()
	{
		xPosition=Math.cos(angle)*speed+xPosition;
		yPosition=Math.sin(angle)*speed+yPosition;
		if (xPosition<0 || xPosition>width || yPosition<0 || yPosition>height)
		{
			if(id==1)
			{
				counter1++;	
			}
			if(id==2)
			{
				counter2++;
			}
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
		if(id==1)
		{
			xPosition=((OddballParticle)firework1[num]).xPosition;
			yPosition=((OddballParticle)firework1[num]).yPosition;
		}
		if(id==2)
		{
			xPosition=((OddballParticle)firework2[num]).xPosition;
			yPosition=((OddballParticle)firework2[num]).yPosition;
		}
		speed=Math.random()*8+1;
		c= color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
	}
}
class OddballParticle implements Particle
{
	double xPosition,yPosition,angle,speed;
	color c;
	int id;
	OddballParticle(int x, int y, int z)
	{
		xPosition=x;
		yPosition=y;
		speed=8;
		c= 255;
		id=z;
		if(id==2)
		{
			if(((OddballParticle)firework1[num]).angle > (3*Math.PI/2))
			{
				angle=Math.random()*0.5+4*(Math.PI/3);
			}
			else if (((OddballParticle)firework1[num]).angle < (3*Math.PI/2))
			{
				angle=Math.random()*0.5+4.5*(Math.PI/3);
			}
		}
		else
		{
			angle=Math.random()+4*(Math.PI/3);
		}
	}
	void reset()
	{
		xPosition=width/2;
		yPosition=height;
		angle=Math.random()+4*(Math.PI/3);
		speed=8;
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
		if((yPosition<=height-350) || (xPosition<=100) || (xPosition>=width-100))
		{
			speed=0;
			c=0;
			explode(id);
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
void explode(int x)
{
	int id=x;
	for(int i=0;i<num+1;i++)
	{
		if(id==1)
		{
			if(firework1[i] instanceof NormalParticle)
			{
				((NormalParticle)firework1[i]).fire();
			}	
			launch2=true;
		}
		if(id==2)
		{
			if(firework2[i] instanceof NormalParticle)
			{
				((NormalParticle)firework2[i]).fire();
			}	
		}
	}
}
void startLoop()
{
	if(counter1>=num*20)
	{
		if(launch1==true)
		{
			for(int i=0;i<num+1;i++)
			{
				if(firework1[i] instanceof NormalParticle)
				{
					((NormalParticle)firework1[i]).reCenter();
				}
				if(firework1[i] instanceof OddballParticle)
				{
					((OddballParticle)firework1[i]).c=255;
					if(((OddballParticle)firework1[i]).speed==0)
					{
						((OddballParticle)firework1[i]).angle=Math.random()+4*(Math.PI/3);
					}
					((OddballParticle)firework1[i]).speed=8;
				}
			}
		}
		counter1=0;
		launch1=false;
	}
	if(counter2>=num*20)
	{
		if(launch2==true)
		{
			for(int i=0;i<num+1;i++)
			{
				if(firework2[i] instanceof NormalParticle)
				{
					((NormalParticle)firework2[i]).reCenter();
				}
				if(firework2[i] instanceof OddballParticle)
				{
					((OddballParticle)firework2[i]).c=255;
					if(((OddballParticle)firework2[i]).speed==0)
					{
						if(((OddballParticle)firework1[num]).angle > (3*Math.PI/2))
						{
							((OddballParticle)firework2[num]).angle=Math.random()*0.5+4*(Math.PI/3);
						}
						else if (((OddballParticle)firework1[num]).angle < (3*Math.PI/2))
						{
							((OddballParticle)firework2[num]).angle=Math.random()*0.5+4.5*(Math.PI/3);
						}
					}
					((OddballParticle)firework2[i]).speed=8;
				}
			}
		}
		counter2=0;
		launch2=false;
	}
}
void mouseClicked()
{	
	beginLoop=true;
}
void checkLaunchStatus()
{
	if (beginLoop==true)
	{
		if(launch1==false && launch2==false)
		{
			launch1=true;
		}
	}
}