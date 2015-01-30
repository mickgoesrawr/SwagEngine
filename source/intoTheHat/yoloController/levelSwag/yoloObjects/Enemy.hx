package intoTheHat.yoloController.levelSwag.yoloObjects ;

import flixel.group.FlxGroup;
import intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag.Dove;
import intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag.Rabbit;
import swagEngine.yoloController.levelSwag.yoloObjects.animationSwag.*;
import flixel.FlxSprite;
import intoTheHat.yoloController.playerSwag.PlayerRenderer;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Enemy extends FlxGroup
{
	public function new(_x:Float, _y:Float, _rotation:Float, _name:String, ?_player:PlayerRenderer, ?_min:String, ?_max:String, ?_type:String)
	{
		super();
		
		switch (_name)
		{
			case "bird":
				add(new Dove(_x, _y, _min, _max, _player, _type));
			
			case "rabbit":
				add(new Rabbit(_x, _y, _rotation, _player));
		}
	}
}