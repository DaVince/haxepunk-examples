package scenes;

import Std;
import haxepunk.Scene;
import entities.Block;
import entities.Bullet;

class GameScene extends Scene
{
  private var balls:Int;
  private var ballmax:Int;
  private var timer:Int;
  private var time_limit:Int;
  
  public function new()
  {
    super();
    balls = 0;
    ballmax = 100; //How many balls to spawn
    timer = 0;
    time_limit = 10; //How often to spawn a new ball
  }

  public override function begin()
  {
    //Add the entity Block from entities/Block.hx
    add(new Block(30, 50));
  }
  
  public override function update()
  {
    timer++;
    
    if (timer == time_limit && balls < ballmax) {
      balls++;
      timer = 0;
      add(new Bullet(640, Std.int(Math.random()*480), Math.random()*4));
    }
    super.update(); //Will call the update() function from the class this is overloading (Scene).
  }
}
