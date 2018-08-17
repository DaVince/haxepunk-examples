package entities;

import haxepunk.Entity;
import haxepunk.graphics.Spritemap;

class Explosion extends Entity {
  private var sprite:Spritemap;
  private var explosionType:String;
  private var origin:Entity;
  private var animation:Array<Int>;
  
  public function new(a_origin:Entity, a_explosionType:String) {
    super(a_origin.x, a_origin.y);
    type = "explosion";
    origin = a_origin;
    explosionType = a_explosionType;
    
    switch (a_explosionType) {
      default: //small
        animation = [0,1,2,1,0,0];
        sprite = new Spritemap("graphics/explosion-small.png", 8, 8);
        sprite.add("exploding", animation, 10, false);
      case "big":
        animation = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,16];
        sprite = new Spritemap("graphics/explosion-big.png", 24, 24);
        sprite.add("exploding", animation, 30, false);
    }
    sprite.centerOrigin();
    graphic = sprite;
  }
  
  public override function update() {
    sprite.play("exploding");
    if (sprite.index == animation.length-1) {
      scene.remove(this);
    }
    super.update();
  }
}
