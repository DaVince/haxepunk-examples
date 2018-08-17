package scenes;
import haxepunk.Scene;
import haxepunk.Entity;
import haxepunk.Sfx;

import entities.Player;

class MainScene extends Scene
{
	private var player:Entity;
	public var music:Sfx;

	public function new() {
		super();
		//music = new Sfx("music.ogg");
	}
	
	public override function begin()
	{
		//music.loop();
		player = add(new Player(160, 200));
	}

	public override function end() {
		//music.stop();
	}

	public override function update() {
		super.update();
	}
}
