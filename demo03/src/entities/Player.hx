package entities;

import haxepunk.Entity;
import haxepunk.HXP;
import haxepunk.graphics.Image;
import haxepunk.input.Input;
import haxepunk.input.Key;


class Player extends Entity
{
  private var health:Int = 100;
  
  private var maxVelocity:Float = 1;
  private var xVelocity:Float;
  private var yVelocity:Float;
  private var speed:Float = 0;

  public var angle:Float = 270; //to face upward
  public var rotationSpeed:Float = 4;
  public var maxSpeed = 10;

  private var image:Image;

  public function new(x:Float, y:Float) {
    super(x, y);
    image = new Image("graphics/player.png");
    image.centerOrigin();
    graphic = image;
    setHitbox(21, 27);
    type = "player";

    Input.define("left", [Key.LEFT]);
    Input.define("right", [Key.RIGHT]);
    Input.define("up", [Key.UP]);
    Input.define("down", [Key.DOWN]);
  }

  private function handleInput() {
    if (Input.check("left"))
      angle -= rotationSpeed;
    if (Input.check("right"))
      angle += rotationSpeed;
    if (Input.check("up"))
      speed += 1;
    if (Input.check("down"))
      speed -= 1;
  }
  
  private function move() {
    /*
     * Trigonometry
     *
     * Cartesian coordinates
     * Coordinates stored as x,y
     *
     * Polar coordinates
     * Coordinates stored as length and angle
     *
     * sin and cos take 1 parameter: the angle.
     * sin calculates the y vector
     * cos the x vector
     * but sometimes it's opposite, when values are negated.
     *
     * sin and cos functions
     * They return a number between -1 and 1.
     * If you multiply this by the length of the vector, you get the exact cartesian coordinates of the vector.
     * They accept radians, not degrees. There are 2*PI radians in a circle (so ~6.282).
     *
     * Calculating radians
     * degrees = radians * 180 / PI;
     * radians = degrees * PI / 180;
     * So 0.1 radians = 0.1 * 180 / 3.142 = 5.7 degrees
     * 
     */

    if (speed < 0) speed = 0;
    if (speed > maxSpeed) speed = maxSpeed;

    //Calculate what direction to move in
    xVelocity = (speed/10) * Math.cos(angle * Math.PI/180); //Sin and cos expect radians, not degrees
    yVelocity = (speed/10) * Math.sin(angle * Math.PI/180);
    
    //Actually move
    moveBy(xVelocity, yVelocity);

    if (x > HXP.width) x -= HXP.width;
    else if (x < 0) x += HXP.width;
    if (y > HXP.height) y -= HXP.height;
    else if (y < 0) y += HXP.height;
  }

  public override function update() {
    handleInput();
    move();
    image.angle = -angle-90;
    super.update();
  }
}
