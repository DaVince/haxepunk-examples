import haxepunk.Engine;
import haxepunk.HXP;
import openfl.ui.Mouse;
import haxepunk.debug.Console;

import scenes.MainScene;

class Main extends Engine
{
	override public function init()
	{
		Mouse.hide();
		
		Console.enable();
		Mouse.show();

		HXP.scene = new MainScene();
	}
	
	public static function main() {
		new Main();
	}
}
