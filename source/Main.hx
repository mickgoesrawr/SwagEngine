package;

import flixel.FlxGame;
import flixel.FlxState;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import intoTheHat.interSwag.Intro;
import intoTheHat.swagHandler.Settings;


/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Main extends Sprite 
{
	private var initialState:Class<FlxState> = Intro;
	private var gameWidth:Int = Settings.gameWidth;
	private var gameHeight:Int = Settings.gameHeight;
	private var stageWidth:Int;
	private var stageHeight:Int;
	
	public static function main()
	{		
		Lib.current.addChild(new Main());
	}
	
	public function new() 
	{
		super();
		
		if (stage != null) 
		{
			init();
		}
		else 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
	
	private function init(?E:Event)
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		setupGame();
	}
	
	/**
	 * Initializes the game, putting it on the screen.
	 */
	
	private function setupGame()
	{
		stageWidth = Lib.current.stage.stageWidth;
		stageHeight = Lib.current.stage.stageHeight;
		
		if (Settings.zoom == -1)
		{
			var ratioX:Float = stageWidth / Settings.gameWidth;
			var ratioY:Float = stageHeight / Settings.gameHeight;
			var zoom:Float = Math.min(ratioX, ratioY);
			
			gameWidth = Math.ceil(stageWidth / Settings.zoom);
			gameHeight = Math.ceil(stageHeight / Settings.zoom);
		}
		
		var game:FlxGame = new FlxGame(gameWidth, gameHeight, initialState, Settings.zoom, 60, 60, true, Settings.fullscreen);
		addChild(game);
	}
}