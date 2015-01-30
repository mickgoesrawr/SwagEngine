package intoTheHat.yoloController.levelSwag.yoloObjects;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Shot extends FlxSprite
{
	private var travel:Int = 0;
	
	public var timer:Timer = new Timer(10);
	
	public function new(_x:Float=0, _y:Float=0, _SimpleGraphic:Dynamic) 
	{
		super(_x, _y, _SimpleGraphic);
		
		exists = false;
		
		timer.addEventListener(TimerEvent.TIMER, stop);
		
		scale.x = 1 / (frameWidth / 64);
		scale.y = 1 / (frameHeight / 32);
		
		updateHitbox();
		
		health = 4;
	}
	
	private function stop(e)
	{
		if (travel == 100)
		{
			timer.stop();
			timer.reset();
			
			travel = 0;
			
			kill();
		}
		
		alpha *= 0.98;
		
		travel++;
	}
	
	override public function update(e)
	{
		if (health == 0)
			kill();
		
		super.update(e);
	}
}