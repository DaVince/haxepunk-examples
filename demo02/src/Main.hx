import haxepunk.Engine;
import haxepunk.HXP;
import scenes.MainScene;

class Main extends Engine {

	/** Where the whole game begins. */
	override public function init() {
		#if debug
		Console.enable();
		#end
		HXP.scene = new MainScene();
	}

	public static function main() {
		new Main();
	}
}
