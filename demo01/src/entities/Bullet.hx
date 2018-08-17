package entities;

import haxepunk.Entity;
import haxepunk.graphics.Image;

class Bullet extends Entity
{
  public var speed:Float;
  
  public function new(x:Int, y:Int, _speed:Float)
  {
    super(x, y);
    speed = _speed;
    graphic = new Image("graphics/bullet.png");
    setHitbox(10, 10);
    type = "bullet"; //Necessary for collision detection; defines what you're colliding against.
  }
  
  public override function update() {
    this.moveBy(-speed, 0);
    if (x < 0) destroy();
    super.update();
  }
  
  public function destroy()
  {
    scene.remove(this);
  }
}
