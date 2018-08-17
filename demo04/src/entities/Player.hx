package entities;

import haxepunk.Entity;
import haxepunk.HXP;
import haxepunk.graphics.Image;
import haxepunk.input.Input;
import Std;


class Player extends Entity
{
  private var health:Int = 100;

  private var xLength:Int;
  private var yLength:Int;
  private var origX:Int;
  private var origY:Int;
  private var destX:Int = 300;  //Just temporary until I can make it follow a moving target
  private var destY:Int = 100;
  private var step:Float;             //Current step (in percentages - from 0 to 100)
  private var timeNeeded:Int = 30; //Get there in this many frames
  private var timePassed:Int = 0;   //Just count from 0 to 120, and set step to a percentage (passed*100/needed)

  private var image:Image;

  public function new(x:Float, y:Float) {
    super(x, y);
    image = new Image("graphics/player.png");
    image.centerOrigin();
    graphic = image;
    setHitbox(21, 27);
    type = "player";

    origX = 160;
    origY = 200;
    step = 0;
  }

  private function handleInput() {
    //Movement logic is already handled in move() because the mouse pos doesn't need to be "handled"
    //Todo: shooting logic

  }
  
  private function move() {

    /* The movement logic
     * I think I will somehow need sin() again, because:
     * - Move faster until midpoint is reached
     * - Then slow down
     * = sinus wave.
     *
     * length = destination-origin
     * position = sin(iteration*pi/length)
     * position += origin
     * In this situation, x = a number between 0 and length.
     * To get there in 1 second, set x to (x*length/FPS)
     * 
     */

    //Move that son of a bitch
  
    timePassed += 1;
    if (timePassed > timeNeeded) timePassed = 0;
    step = Std.int((timePassed/timeNeeded)*100);
    yLength = destY-origY;
    y = Math.sin(step/100*Math.PI)*yLength;
    y += origY;
    Log.debug([yLength, origY, step, y]);

    //NOT IMPORTANT RIGHT NOW
    //Reset within bounds
    if (x > HXP.width-20) x = HXP.width-20;
    else if (x < 20) x = 20;
    if (y > HXP.height-30) y = HXP.height-30;
    else if (y < 30) y = 30;
  }

  public override function update() {
    handleInput();
    move();
    super.update();
  }
}
