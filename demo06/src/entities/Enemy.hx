package entities;

import haxepunk.Entity;
import haxepunk.graphics.Image;
import haxepunk.graphics.Spritemap;
import haxepunk.HXP;
import haxepunk.debug.Console;
import haxepunk.Sfx;

import entities.Explosion;

class Enemy extends Entity
{
  private var sprite:Spritemap;
  private var hitSound:Sfx;
  
  public var health:Int;
  public var enemyType:String;
  public var movementType:String;
  public var movementIntensity:Float;
  public var movementSpeed:Float;
  private var scrollSpeed:Float;
  private var dying:Bool = false;
  
  public function new(x:Float, y:Float, a_enemyType:String) {
    super(x, y);
    
    enemyType = a_enemyType;
    hitSound = new Sfx("audio/explosion-small.ogg");
    
    switch (enemyType) {
      //TODO: Read movementType/intensity/speed/health from the tmx file instead
      //TODO: use the texture atlas
      
      default:
        sprite = new Spritemap("graphics/enemy01.png", 24, 19);
        sprite.add("idle", [0]);
        sprite.add("left", [7,6,5], 7, false);
        sprite.add("right", [1,2,3], 7, false);
        movementType = "sine";
        movementIntensity = 10+Math.random()*16;
        movementSpeed = Math.random();
        health = 3;
        
      case "2":
        sprite = new Spritemap("graphics/enemy01.png", 24, 19);
        sprite.add("idle", [0]);
        sprite.add("left", [7,6,5], 7, false);
        sprite.add("right", [1,2,3], 7, false);
        movementType = "straight";
        movementIntensity = 3;
        movementSpeed = 1+Math.random();
        health = 4;
        
      case "3":
        sprite = new Spritemap("graphics/enemy02.png", 24, 21);
        sprite.add("idle", [0,1,2,3,4,5,6,7], 20);
        movementType = "straight";
        movementIntensity = 3;
        movementSpeed = -0.3+Math.random()*1.5;
        health = 5;
        
      case "4":
        sprite = new Spritemap("graphics/enemy03.png", 25, 28);
        sprite.add("idle", [0]);
        sprite.add("left", [2]);
        sprite.add("right", [1]);
        movementType = "zigzag";
        movementIntensity = 80;
        movementSpeed = 0.5+Math.random();
        health = 6;
    }
    
    graphic = sprite;
    setHitbox(sprite.width, sprite.height);
    type = "enemy";
  }
  
  private function move() {
    switch (movementType) {
      case "sine":
        var x = Math.sin(y/movementIntensity*3)*3;
        moveBy(x, movementSpeed);
        if (x < 0) sprite.play("left");
        else sprite.play("right");
        
      case "swingleft":
        if (y < 100) {
          moveBy(0, movementSpeed);
          sprite.play("idle");
        }
        else {
          moveBy(-movementIntensity, movementSpeed);
          sprite.play("left");
        }
        
      case "swingright":
        if (y < 100) {
          moveBy(0, movementSpeed);
          sprite.play("idle");
        }
        else {
          moveBy(movementIntensity, movementSpeed);
          sprite.play("right");
        }
        
      case "zigzag":
        if (Math.floor(y/movementIntensity) % 2 == 0) {
          moveBy(-movementSpeed, movementSpeed);
          sprite.play("left");
        }
        else {
          moveBy(movementSpeed, movementSpeed);
          sprite.play("right");
        }
      default: //straight
        moveBy(0, movementSpeed);
        sprite.play("idle");
    }
  }
  
  public override function update() {
    move();
    if (y > HXP.height+sprite.height) scene.remove(this);
    
    //If colliding with bullet
    var e = collide("bullet", x, y);
    if (e != null) {
      var bu:Bullet = cast(e, Bullet);
			health -= bu.power;
      //Console.log(["Enemy health:", health]);
      scene.add(new Explosion(bu, "small"));
      scene.remove(e);
      if (health <= 0) die();
		}
    
    super.update();
  }
  
  public function die() {
    hitSound.play();
    scene.add(new Explosion(this, "big"));
    scene.remove(this);
  }
}
