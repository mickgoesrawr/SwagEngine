package intoTheHat.yoloController.levelSwag.yoloObjects ;

import flixel.FlxSprite;
import flixel.addons.effects.FlxWaveSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Card extends FlxSprite
{
	public var type:String;
	
	public function new(_x:Float = 0, _y:Float = 0, _SimpleGraphic:Dynamic, _type:String )
	{
		super(_x, _y, _SimpleGraphic);
		
		y -= height;
		
		type = _type;
	}	
}