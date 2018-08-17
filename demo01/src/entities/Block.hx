package entities;

import haxepunk.Entity;
import haxepunk.graphics.Image;
import haxepunk.input.Input;
import haxepunk.input.Key;


class Block extends Entity
{
  public var health:Int = 20;
  public var score:Int = 0;
  
  /** Constructor **/
  public function new(x:Int, y:Int) {
    super(x, y);
    graphic = new Image("graphics/block.png"); //Assign an image to "graphic".
    setHitbox(32, 32);
    Input.define("left", [Key.LEFT]);
    Input.define("right", [Key.RIGHT]);
    Input.define("up", [Key.UP]);
    Input.define("down", [Key.DOWN]);
  }
  
  /** Update **/
  public override function update() {
    if (Input.check("left"))
      moveBy(-2, 0);

    if (Input.check("right"))
      moveBy(2, 0);
    
    if (Input.check("up"))
      moveBy(0, -2);

    if (Input.check("down"))
      moveBy(0, 2);
    
    var e:Entity = collide("bullet", x, y); //Returns the specific Bullet instance that collided with you
    if (e != null) //There's an instance that's colliding
    {
      health--;
      var b:Bullet = cast(e, Bullet); //This is not just an Entity, but one of type Bullet. Necessary because we added the method destroy(), which doesn't exist in Entity.
      b.destroy(); //call destroy() method in Bullet entity
    }
        
    super.update();
  }
}
