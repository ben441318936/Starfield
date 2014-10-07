int num=200;
NormalParticle storm[]=new NormalParticle[num];
void setup()
{
	size(500,500);
	background(0);
	for(int i=0;i<num;i++)
	{
		//storm[i]=new NormalParticle((int)(Math.random()*51)+225,(int)(Math.random()*51)+225);
		storm[i]=new NormalParticle(250,250);
	}
}
void draw()
{
	//background(0);
	noStroke();
	//fill(0, 10);
	//rect(0,0,500,500);
	for(int i=0;i<num;i++)
	{
		storm[i].move();
		storm[i].show();
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
		angle=(Math.random()*2)*PI;
		speed=1;
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
		ellipse((float)(xPosition),(float)(yPosition),5,5);
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