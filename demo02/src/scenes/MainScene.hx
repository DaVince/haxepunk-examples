package scenes;
import haxepunk.Scene;
import haxepunk.Entity;
import haxepunk.HXP;
import haxepunk.Sfx;
import entities.Player;
import entities.Bullet;

class MainScene extends Scene {

	private var player:Entity;

	public var music:Sfx;
	private var counter = 0;

	public function new() {
		super();
		HXP.pan = 0.01; //Circumventing a bug where all sound is played through the right channel only
		music = new Sfx("music/picoi1.ogg");
		music.loop();
	}

	public override function begin() {
		player = add(new Player(632,352));
	}

	public override function end() {
		music.stop();
	}

	public override function update() {
		super.update();
		counter++;
		if (counter == 30) {
			counter = 0;
			add(new Bullet(1265, Std.int(Math.random()*720)));
		}
	}
}
