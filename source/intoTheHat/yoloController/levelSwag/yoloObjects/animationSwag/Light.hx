package intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag;

import flixel.FlxSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Light extends FlxSprite
{
	public function new(_x:Float = 0, _y:Float = 0) 
	{
		super(_x, _y);
		
		loadGraphic("assets/animations/light.png", true, 256, 256);
		y -= height;
		
		var framesArray = new Array();
			for (i in 0...62) framesArray[i] = i;
		
		for (i in 0...Std.random(framesArray.length))
			framesArray.push(framesArray.shift());		
		
		animation.add("default", framesArray, 10, true);
		animation.play("default", false, false, -1); 
	}
}