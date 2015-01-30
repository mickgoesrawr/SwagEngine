package intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag ;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import intoTheHat.swagHandler.Settings;
import intoTheHat.yoloController.playerSwag.PlayerRenderer;
import intoTheHat.yoloController.levelSwag.yoloObjects.swagBehavior.BirdBehavior;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Dove extends FlxSprite
{
	private var behavior:BirdBehavior;
	private var player:PlayerRenderer;
	
	public var type:String;
	
	public function new(_x:Float = 0, _y:Float = 0, _min:String, _max:String, _player:PlayerRenderer, _type:String)
	{
		super(_x, _y);
		
		loadGraphic("assets/animations/dove.png", true, 64, 64);
		y -= height;
		
		var framesArray = new Array();
			for (i in 0...27) framesArray[i] = i;
		
		for (i in 0...Std.random(framesArray.length))
			framesArray.push(framesArray.shift());
		
		animation.add("fly", framesArray, 30, true);
		animation.play("fly", false, false, -1);
		
		facing = FlxObject.RIGHT;
		
		type = _type;
		player = _player;
		
		drag.x = drag.y = Settings.drag * 2;
		
		maxVelocity.x = maxVelocity.y = (_type == "aggressive") ? Settings.maxVelocity + 50 : Settings.maxVelocity - 50;
		
		behavior = new BirdBehavior(type, this, player, Std.parseInt(_min), Std.parseInt(_max));
	}
	
	override public function destroy()
	{
		behavior.destroy();
		
		behavior = null;
		player = null;
		type = null;
		
		super.destroy();
	}
	
	override public function update(e:Float)
	{
		if (e == 0.0) return;
		
		behavior.type = type;
		behavior.update();
		
		if (overlaps(player) && player.abilities.deadly > 0)
		{
			kill();
			
			player.abilities.deadly--;
		}
		else if (overlaps(player) && player.abilities.deadly == 0)	player.hurt(10);
		
		if (velocity.x > 0)
		{
			flipX = false;
			facing = FlxObject.RIGHT;
		}
		else
		{
			flipX = true;
			facing = FlxObject.LEFT;
		}
		
		super.update(e);
	}
}