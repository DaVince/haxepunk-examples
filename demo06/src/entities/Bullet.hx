package entities;

import haxepunk.Entity;
import haxepunk.graphics.Image;

class Bullet extends Entity
{
  private var image:Image;
  
  public var bulletType:String;
  public var origin:Entity;
  public var level:Int;  //Bullet level determines power, amount of shots, etc.
  public var power:Int = 1;
  
  public function new(x:Float, y:Float, a_origin:Entity, a_bulletType:String) {
    super(x, y);
    
    origin = a_origin;
    bulletType = (a_bulletType != "") ? a_bulletType : "red";
    
    switch(bulletType) {
      case "red": image = new Image("graphics/bullet-red.png");
      default:    image = new Image("graphics/bullet-red.png");
    }
    
    graphic = image;
    setHitbox(image.width, image.height);
    type = "bullet";
  }
  
  public override function update() {
    moveBy(0, -7);  //Third arg defines what type of entity to check collisions with.
    if (y < -5) scene.remove(this);
    super.update();
  }
}
