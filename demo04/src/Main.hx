import haxepunk.Engine;
import haxepunk.HXP;
import haxepunk.debug.Console;

import scenes.MainScene;

class Main extends Engine
{

	override public function init()
	{
		Console.enable();
		HXP.scene = new MainScene();
	}

	public static function main() { new Main(); }

}
