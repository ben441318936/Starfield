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

/*@pjs preload="att-park.jpg";*/
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
public void setup()
{
	//frameRate(1);
    img=loadImage("att-park.jpg");
    size(640,427);
    background(0);
    for(int i=0;i<num;i++)
    {
        firework1[i]=new NormalParticle(1);
    }
    firework1[num]=new OddballParticle(width/2,height,1);
    //firework1[1]=new jumbo(1);
    for(int i=0;i<num;i++)
    {
        firework2[i]=new NormalParticle(2);
    }
    firework2[num]=new OddballParticle(width/2,height,2);
    //firework2[1]=new jumbo(2);
    image(img,0,0);
    textAlign(CENTER);
    textSize(36);
    text("Click on the screen!", width/2, height/2);
}
public void draw()
{
    if(beginLoop==true)
    {
        startLoop();
        noStroke();
        image(img,0,0);
        tint(255,opac);
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
    }
}
class NormalParticle implements Particle
{
    double xPosition,yPosition,angle,speed;
    int c;
    int id;
    NormalParticle()
    {
        xPosition=width/2;
        yPosition=height;
        angle=(Math.random()*2)*Math.PI;
        speed=0;
        c=0;
    }
    NormalParticle(int z)
    {
        xPosition=width/2;
        yPosition=height;
        angle=(Math.random()*2)*Math.PI;
        speed=0;
        c=0;
        id=z;
    }
    public void move()
    {
        xPosition=Math.cos(angle)*speed+xPosition;
        yPosition=Math.sin(angle)*speed+yPosition;
        if (xPosition<0 || xPosition>width || yPosition<0)
        {
            if(launch1==true)
            {
            	if(id==1)
            	{
               	 	counter1++;    
            	}	
            }
            if(launch2==true)
            {
            	if(id==2)
            	{
                	counter2++;
            	}
            }
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
        yPosition=height+500;
        angle=(Math.random()*2)*Math.PI;
        speed=0;
        c=0;
    }
    public void fire()
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
    int c;
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
                angle=Math.random()*0.5f+4*(Math.PI/3);
            }
            else if (((OddballParticle)firework1[num]).angle < (3*Math.PI/2))
            {
                angle=Math.random()*0.5f+4.5f*(Math.PI/3);
            }
        }
        else
        {
            angle=Math.random()+4*(Math.PI/3);
        }
    }
    public void move()
    {
        xPosition=Math.cos(angle)*speed+xPosition;
        yPosition=Math.sin(angle)*speed+yPosition;
        if(speed != 0)
        {
            if (angle<(3*Math.PI/2))
            {
                angle=angle-0.005f;
            }
            else if (angle>(3*Math.PI/2))
            {
                angle=angle+0.005f;
            }
        }
    }
    public void show()
    {
        noStroke();
        fill(c);
        ellipse((float)(xPosition),(float)(yPosition),10,10);
    }
    public void reachCenter()
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
public void explode(int x)
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
public void startLoop()
{
    if(counter1>=num*30)
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
        launch2=true;
    }
    if(counter2>=num*30)
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
                            ((OddballParticle)firework2[num]).angle=Math.random()*0.5f+4*(Math.PI/3);
                        }
                        else if (((OddballParticle)firework1[num]).angle < (3*Math.PI/2))
                        {
                            ((OddballParticle)firework2[num]).angle=Math.random()*0.5f+4.5f*(Math.PI/3);
                        }
                    }
                    ((OddballParticle)firework2[i]).speed=8;
                }
            }
        }
        counter2=0;
        launch2=false;
        launch1=true;
    }
}
class jumbo extends NormalParticle
{
    jumbo(int z)
    {
        xPosition=width;
        yPosition=height+500;
        id=z;
    }
    public void show()
    {
        noStroke();
        fill(255);
        ellipse((float)(xPosition),(float)(yPosition),30,30);
    }
}
public void mouseClicked()
{    
    beginLoop=true;
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
