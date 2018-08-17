package scenes;

import haxepunk.Scene;
import haxepunk.HXP;
import haxepunk.Sfx;
import haxepunk.graphics.Image;

import entities.Player;

class MainScene extends Scene
{
	public var music:Sfx;
	private var spawnTimer:Float;
	private var difficulty:Int;
	
	public function new() {
		super();
		music = new Sfx("audio/music.ogg");
	}
	
	public override function begin()
	{
		music.loop();
		add(new entities.Player(160, 200));
	}

	public override function end() {
		music.stop();
	}

	public override function update() {
		spawnTimer -= HXP.elapsed;
		if (spawnTimer < 0) {
			spawn();
		}
		super.update();
	}
	
	private function spawn() {
		difficulty += 1;
		
		add(new entities.Enemy((HXP.width/4)+(Math.random()*HXP.halfWidth), -30, Std.string(Math.round(Math.random()*difficulty/5)))); //New enemy type every 5 levels
		spawnTimer = Math.random()*1.6;
	}
}
