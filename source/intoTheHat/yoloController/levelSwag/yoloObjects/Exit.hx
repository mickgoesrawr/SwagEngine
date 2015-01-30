package intoTheHat.yoloController.levelSwag.yoloObjects;

import flixel.FlxSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Exit extends FlxSprite
{
	public function new(_x:Float = 0, _y:Float = 0, _SimpleGraphic:Dynamic) 
	{
		super(_x, _y, _SimpleGraphic);
		
		y -= height;
		exists = false;
	}	
}