package intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag;

import flixel.FlxSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Spider extends FlxSprite
{
	public function new(_x:Float = 0, _y:Float = 0) 
	{
		super(_x, _y);
		
		loadGraphic("assets/animations/spider.png", true, 64, 64);
		y -= height;
		
		var framesArray = new Array();
			for (i in 0...24) framesArray[i] = i;
		
		for (i in 0...Std.random(framesArray.length))
			framesArray.push(framesArray.shift());
		
		animation.add("dangle", framesArray, 10, true);
		animation.play("dangle", false, false, -1); 
	}
}