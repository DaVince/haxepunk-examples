package entities;

import haxepunk.Entity;
import haxepunk.graphics.Image;
import haxepunk.HXP;


class Bullet extends Entity
{
    public function new(x:Int, y:Int)
    {
        super(x+20, y);
        graphic = new Image("graphics/bullet.png");
        setHitbox(10, 10);
        type = "bullet";
    }

    public function shoot(x:Int, y:Int) {

    }

    public override function update() {
        if (type == "playerbullet") {
            moveBy(10, 0);
        }
        else {
            moveBy(-5, 0);
        }
        if (x > 1280 || x < 0) destroy();
        super.update();
    }

    public function destroy() {
      scene.remove(this);
    }
}
