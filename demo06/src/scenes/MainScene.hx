package scenes;

import haxepunk.Scene;
import haxepunk.Entity;
import haxepunk.HXP;
import haxepunk.Sfx;
import haxepunk.graphics.Image;
import haxepunk.graphics.text.Text;
//import flash.text.TextFormatAlign;
import haxepunk.graphics.text.TextAlignType;

import haxepunk.tmx.TmxEntity;
import haxepunk.tmx.TmxMap;

import entities.Player;
import entities.Enemy;

class MainScene extends Scene
{
	public var music:Sfx;
	
	private var map:TmxMap;
	private var mape:TmxEntity;
	private var overhang:TmxEntity; //Overhang layer
	public var player:Player;
	public var scrollSpeed:Float = 0.5;
	
	private var spawnTimer:Float;
	private var difficulty:Int;
	
	public function new() {
		super();
		music = new Sfx("audio/music.ogg");
		createMap();
	}
	
	public override function begin()
	{
		music.loop();
		player = new Player(160, 200);
		
		add(mape);
		add(player);
		add(overhang);
		
		mape.layer = 3;
		player.layer = 2;
		overhang.layer = 1;
	}

	public override function end() {
		music.stop();
	}
	
	public function createMap() {
		map = TmxMap.loadFromFile("maps/test1.tmx");
		mape = new TmxEntity(map);
		mape.loadGraphic("maps/tileset-pokemon.png", ["1", "2"]); //Load layers with this tileset
		mape.loadMask("collision", "walls"); //Load collisions from this tile layer, give it an entity type "walls"
		mape.graphic.pixelSnapping = true; //REQUIRED because without this, tiles won't align quite right and look ugly.
		
		overhang = new TmxEntity(map);
		overhang.loadGraphic("maps/tileset-pokemon.png", ["overhang"]);
		
		//NOTE: ALWAYS make sure the width and height of your map objects are above 0, or the game will crash in debug mode!
		for (object in map.getObjectGroup("objects").objects) {
			if (object.name == "startpoint") {
				mape.x = -object.x+HXP.halfWidth;
				mape.y = -object.y+HXP.height;
			}
		}
	}

	public override function update() {
		spawnTimer -= HXP.elapsed;
		if (spawnTimer < 0) {
			spawn();
		}
		updatePosition();
		super.update();
	}
	
	private function updatePosition() {
		//x pos
		var mapcenter = (mape.width-HXP.width)/2;
		var deviation = player.x/(HXP.width/mapcenter)-(mapcenter/2);
		mape.x = -mapcenter-deviation*2;
		
		//y scrolling
		mape.y += scrollSpeed;
		if (mape.y > 0) mape.y = 0; //TODO: End the level sometime after this
		
		overhang.x = mape.x;
		overhang.y = mape.y;
		if (typeCount("enemy") > 0) {
			for (e in entitiesForType("enemy")) {
				e.y += scrollSpeed;
			}
		}
	}
	
	private function spawn() {
		//This spawns random enemies randomly
		difficulty += 1;
		var enemyX = (HXP.width/4)+(Math.random()*HXP.halfWidth);
		var enemyY = -30;
		var enemyType = Std.string(Math.round(Math.random()*difficulty/10)); //After every 10 spawns, add another possible enemy type
		var enemy = new Enemy(enemyX, enemyY, enemyType);
		enemy.layer = 2;
		add(enemy);
		spawnTimer = 0.2+Math.random()*1.8;
	}
	
	public function gameOver() {
		var got = new Text("Game Over", HXP.halfWidth-40, 80);
		got.align = TextAlignType.CENTER;
		add(new Entity(got));
		music.stop();
		music = new Sfx("audio/gameover.ogg");
		music.loop();
	}
}
