package entities;

import haxepunk.Entity;
import haxepunk.graphics.Image;
import haxepunk.HXP;
import haxepunk.utils.Log;

class Enemy extends Entity
{
  private var image:Image;
  
  public var health:Int;
  public var enemyType:String;
  public var movementType:String;
  public var movementIntensity:Float;
  public var movementSpeed:Float;
  
  public function new(x:Float, y:Float, a_enemyType:String) {
    super(x, y);
    
    enemyType = a_enemyType;
    
    switch (enemyType) {
      case "1":
        image = new Image("graphics/enemy01.png");
        movementType = "sine";
        movementIntensity = 8+Math.random()*12;
        movementSpeed = 0.5+Math.random();
        health = 3;
      case "2":
        image = new Image("graphics/enemy02.png");
        movementType = "straight";
        movementIntensity = 3;
        movementSpeed = 0.3+Math.random()*1.5;
        health = 5;
      case "3":
        image = new Image("graphics/enemy03.png");
        movementType = "zigzag";
        movementIntensity = 20;
        movementSpeed = 0.5+Math.random();
        health = 5;
      default:
        image = new Image("graphics/enemy01.png");
        movementType = "straight";
        movementIntensity = 3;
        movementSpeed = 1;
        health = 3;
    }
    
    graphic = image;
    setHitbox(image.width, image.height);
    type = "enemy";
  }
  
  private function move() {
    switch (movementType) {
      case "sine":
        moveBy(Math.sin(y/movementIntensity*3)*3, movementSpeed);
      case "swingleft":
        if (y < 100) moveBy(0, movementSpeed);
        else moveBy(-movementIntensity, movementSpeed);
      case "swingright":
        if (y < 100) moveBy(0, movementSpeed);
        else moveBy(movementIntensity, movementSpeed);
      case "zigzag":
        if (Math.floor(y/movementIntensity) % 2 == 0) moveBy(-movementSpeed, movementSpeed);
        else moveBy(movementSpeed, movementSpeed);
      default: //straight
        moveBy(0, movementSpeed);
    }
  }
  
  public override function update() {
    move();
    if (y > HXP.height+image.height) scene.remove(this);
    
    //If colliding with bullet
    var e = collide("bullet", x, y);
    if (e != null) {
      var bu:Bullet = cast(e, Bullet);
			health -= bu.power;
      Log.debug(["Enemy health:", health]);
      scene.remove(e);
      if (health <= 0) die();
		}
    
    super.update();
  }
  
  public function die() {
    //Play destruction sound
    //Spawn explosion
    scene.remove(this);
  }
}
