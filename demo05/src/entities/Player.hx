package entities;

import haxepunk.Entity;
import haxepunk.HXP;
import haxepunk.graphics.Image;
import haxepunk.input.Mouse;
import haxepunk.Sfx;
import haxepunk.utils.Log;

import entities.Bullet;


class Player extends Entity
{
  private var image:Image;
  private var bulletSound:Sfx;
  
  public var maxHealth:Int;
  public var health:Int;
  
  private var xDistance:Float;
  private var yDistance:Float;
  private var distance:Float;
  private var easingAmount:Float = 0.2;
  private var bulletCooldown:Int;

  public function new(x:Float, y:Float) {
    super(x, y);
    image = new Image("graphics/player.png");
    image.centerOrigin();
    graphic = image;
    setHitbox(20, 27, Std.int(width/2), Std.int(height/2));
    type = "player";
    bulletSound = new Sfx("audio/bup.ogg");
    
    maxHealth = 50;
    health = maxHealth;
  }

  private function handleInput() {
    bulletCooldown -= 1;
    if (Mouse.mouseDown && bulletCooldown <= 0) {
      bulletCooldown = 7;
      scene.add(new Bullet(x-2, y - height/2, this, "red"));
      bulletSound.play();
    }
  }
  
  private function move() {
    //Ease to mouse pointer
    xDistance = ((Mouse.mouseX!=0) ? Mouse.mouseX : x) - x;
    yDistance = ((Mouse.mouseY!=0) ? Mouse.mouseY : y) - y;
    distance = Math.sqrt(xDistance*xDistance + yDistance*yDistance);  //How far are we from the target?
    if (distance > 1) {
      moveBy(xDistance*easingAmount, yDistance*easingAmount);
    }
    
    //Reset within bounds
    if (x > HXP.width-15) x = HXP.width-15;
    else if (x < 15) x = 15;
    if (y > HXP.height-20) y = HXP.height-20;
    else if (y < 20) y = 20;
  }
  
  private function handleCollisions() {
    //If colliding with enemy
    var e:Entity = collide("enemy", x, y);
    if (e != null) {
      health -= 10;
      var en:Enemy = cast(e, Enemy); //Ensure that we have access to its public functions and vars
      en.die();
      Log.debug(["Health:", health]);
    }
  }

  public override function update() {
    handleInput();
    handleCollisions();
    move();
    
    if (health <= 0) die();
    
    super.update();
  }
  
  
  public function die() {
    //Play game over music
    //Show game over graphic
    scene.remove(this);
  }
}
