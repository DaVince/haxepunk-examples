import haxepunk.Engine;
import haxepunk.HXP;
import haxepunk.debug.Console;

class Main extends Engine
{

	override public function init()
	{
		#if debug
		Console.enable();
		#end
		HXP.scene = new scenes.GameScene();
	}

	public static function main() {
		new Main();
	}

}