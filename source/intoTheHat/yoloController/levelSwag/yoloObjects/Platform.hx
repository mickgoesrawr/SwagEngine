package intoTheHat.yoloController.levelSwag.yoloObjects ;

import flixel.FlxG;
import flixel.FlxSprite;


/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Platform extends FlxSprite
{
	private var min:Int = 0;
	private var max:Int = 0;
	private var xMovement:Float = 0;
	private var yMovement:Float = 0;
	
	public function new(_x:Float = 0, _y:Float = 0, _SimpleGraphic:Dynamic, _min:String, _max:String, _axis:Bool)
	{
		super(_x, _y, _SimpleGraphic);
		
		y -= height;
		
		if (_axis) yMovement = 1;
		else xMovement = 1;
		
		min = Std.parseInt(_min);
		max = Std.parseInt(_max);
		
		immovable = true;
	}
	
	override public function update(e:Float)
	{
		if (e == 0) return;
		
		if (xMovement != 0)
		{
			if (x < min * 32) xMovement = 1;
			else if (x > max * 32) xMovement = -1;
			
			velocity.x = xMovement * 64;
		}
		
		if (yMovement != 0)
		{
			if (y < min * 32) yMovement = 1;
			else if (y > max * 32) yMovement = -1;
			
			velocity.y = yMovement * 64;
		}
		
		super.update(e);
	}
	
	override public function destroy()
	{
		min = 0;
		max = 0;
		xMovement = 0;
		yMovement = 0;
		
		super.destroy();
	}
}