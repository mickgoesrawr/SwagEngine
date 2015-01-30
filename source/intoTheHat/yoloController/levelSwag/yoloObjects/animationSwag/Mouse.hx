package intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag;

import flixel.FlxSprite;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Mouse extends FlxSprite
{
	private var min:Int = 0;
	private var max:Int = 0;
	
	public function new(_x:Float = 0, _y:Float = 0, _min:String, _max:String) 
	{
		super(_x, _y);
		
		loadGraphic("assets/animations/mouse.png", true, 64, 32);
		y -= height;
		
		var framesArray = new Array();
			for (i in 0...4) framesArray[i] = i;
		
		for (i in 0...Std.random(framesArray.length))
			framesArray.push(framesArray.shift());
		
		animation.add("dribble", framesArray, 10, true);
		animation.play("dribble", false, false, -1);
		
		min = Std.parseInt(_min);
		max = Std.parseInt(_max);
		
		velocity.x = 64;
	}
	
	override public function update(e:Float)
	{
		if (e == 0) return;
		
		if (x < min * 32)
		{
			velocity.x = 64;
			flipX = false;
		}
		else if (x > max * 32)
		{
			velocity.x = -64;
			flipX = true;
		}
		
		super.update(e);
	}
}