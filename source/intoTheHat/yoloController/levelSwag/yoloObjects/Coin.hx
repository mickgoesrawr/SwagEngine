package intoTheHat.yoloController.levelSwag.yoloObjects ;

import flixel.FlxSprite;
import flixel.addons.effects.FlxWaveSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Coin extends FlxSprite
{
	public var wealth:Int = 1;
	
	public function new(_x:Float = 0, _y:Float = 0, _SimpleGraphic:Dynamic, _wealth:String)
	{
		super(_x, _y, _SimpleGraphic);
		y -= height;
		
		wealth = Std.parseInt(_wealth);
	}	
}