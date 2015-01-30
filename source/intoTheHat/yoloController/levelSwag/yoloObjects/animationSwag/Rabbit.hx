package intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import intoTheHat.yoloController.playerSwag.PlayerRenderer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Rabbit extends FlxSprite
{
	private var player:PlayerRenderer;
	private var originalY:Float = 0;
	
	public function new(_x:Float = 0, _y:Float = 0, _rotation:Float, _player:PlayerRenderer)
	{
		super(_x, _y);
		
		player = _player;
		
		loadGraphic("assets/animations/rabbit.png", true, 64, 128);
		
		angle = _rotation;
		
		switch (angle)
		{
			case 0:
				y -= height;
			
			case 180:
				x -= width;
		}
		
		originalY = y;
		
		var framesArray = new Array();
			for (i in 5...135) framesArray[i - 5] = i;
			
		animation.add("pop", framesArray, 45, false);
		
		framesArray = [0, 1, 2, 3, 4, 135, 136, 137];
		animation.add("inside", framesArray, 2, false);
		
		animation.play("pop", false, false, -1);
		
		immovable = true;
	}
	
	override public function destroy()
	{
		player = null;
	}
	
	override public function update(e)
	{
		if (e == 0.0) return;
		
		switch (animation.name)
		{
			case "pop":
				if (animation.finished) animation.play("inside");
				
				height = 128;
				offset.y = 0;
				y = originalY;
				
				if (overlaps(player))
				{
					height = 64;
					offset.y = (angle == 180) ? 0 : 64;
					y = (angle == 180) ? originalY : originalY + 64;
					
					FlxG.overlap(player, this, FlxObject.separate);
					
					player.hurt(20);
				}
			
			case "inside":
				if (animation.finished && !overlaps(player)) animation.play("pop");
				
				height = 64;
				offset.y = (angle == 180) ? 0 : 64;
				y = (angle == 180) ? originalY : originalY + 64;
					
				FlxG.overlap(player, this, FlxObject.separate);
		}
		
		super.update(e);
	}
}