package intoTheHat.yoloController.levelSwag.yoloObjects;

import flixel.FlxSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Portal extends FlxSprite
{
	public var name:String;
	public var destination:String;
	
	public function new(_x:Float = 0, _y:Float = 0, _SimpleGraphic:Dynamic, _name:String, _destination:String)
	{
		super(_x, _y, _SimpleGraphic);
		
		y -= height;
		name = _name;
		destination = _destination;
	}	
}