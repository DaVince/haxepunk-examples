package entities;

import haxepunk.Entity;
import haxepunk.graphics.Image;
import haxepunk.Sfx;
import haxepunk.input.Input;
import haxepunk.input.Key;
//import entities.Bullet;

class Player extends Entity {

  private var xdir:Int;
  private var ydir:Int;
  private var speed:Int;

  private var shootsound:Sfx;

  public function new(x:Int, y:Int) {
    super(x, y);
    shootsound = new Sfx("audio/RH-Wibble.ogg");
    graphic = new Image("graphics/fallback.png");
    setHitbox(24, 24);
    type = "player";
    speed = 3;
    Input.define("left", [Key.LEFT]);
    Input.define("right", [Key.RIGHT]);
    Input.define("up", [Key.UP]);
    Input.define("down", [Key.DOWN]);
    Input.define("shoot", [Key.SPACE]);
  }

  public override function update() {
    //Input
    //Movement
    xdir = 0;
    ydir = 0;
    if (Input.check("left")) {
      xdir -= 1;
    }
    if (Input.check("right")) {
      xdir += 1;
    }
    if (Input.check("up")) {
      ydir -= 1;
    }
    if (Input.check("down")) {
      ydir += 1;
    }
    if (xdir != 0 || ydir != 0) {
      moveBy(xdir*speed, ydir*speed);
    }

    //Shooting
    if (Input.pressed("shoot")) {
      shoot();
    }

    //Collisions
    var e:Entity = collide("bullet", x, y);
    if (e != null) {
      var b:Bullet = cast(e, Bullet);
      b.destroy();
    }
  }

  public function shoot() {
    if (!shootsound.playing) { //Only allow shooting when sound isn't playing
      shootsound.play();
      //right and centerY are properties of any Entity object
      //Similarly, there are left, centerX, top, and bottom properties.
      var playerbullet:Bullet = new Bullet(Std.int(right), Std.int(centerY));
      playerbullet.type = "playerbullet"; //A "playerbullet" doesn't get destroyed when colliding with the player
      scene.add(playerbullet);
    }
  }
}
