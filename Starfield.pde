int num=200;
NormalParticle firework[]=new NormalParticle[num];
void setup()
{
	size(500,500);
	background(0);
	for(int i=0;i<num;i++)
	{
		//firework[i]=new NormalParticle((int)(Math.random()*51)+225,(int)(Math.random()*51)+225);
		firework[i]=new NormalParticle(250,250);
	}
}
void draw()
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
	color c;
	NormalParticle(int x, int y)
	{
		xPosition=x;
		yPosition=y;
		angle=(Math.random()*2)*Math.PI;
		speed=Math.random()*3;
		c= color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
	}
	void move()
	{
		xPosition=Math.cos(angle)*speed+xPosition;
		yPosition=Math.sin(angle)*speed+yPosition;
	}
	void show()
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
	void reCenter()
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