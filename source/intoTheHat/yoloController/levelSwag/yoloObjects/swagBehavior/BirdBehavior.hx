package intoTheHat.yoloController.levelSwag.yoloObjects.swagBehavior;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import intoTheHat.yoloController.playerSwag.PlayerRenderer;

/**
 * ...
 * @author Tagor
 * 
 * Modified by Sjoer van der Ploeg
 * 
 */

class BirdBehavior
{
	private var parent:FlxSprite;
	private var player:PlayerRenderer;
	private var xMovement:Float = 1;
	private var min:Int = 0;
	private var max:Int = 0;
	private var retreat:FlxPoint;
	
	public var type:String;
	
	public function new(_type:String, _parent:FlxSprite, _player:PlayerRenderer, _min:Int, _max:Int) 
	{
		parent = _parent;
		player = _player;
		type = _type;
		min = _min;
		max = _max;
		
		retreat = new FlxPoint(parent.x, parent.y);
	}
	
	public function update()
	{
		parent.acceleration.x = parent.acceleration.y = 0;
		
		var xDistance:Float = player.x - parent.x;										// distance on x axis to player
		var yDistance:Float = player.y - parent.y;										// distance on y axis to player
		var distance:Float = xDistance * xDistance + yDistance * yDistance;				// distance to player
		
		switch (type)
		{
			case "passive":
				if (distance < 75000) aggressive(distance);
				else passive();
			
			case "aggressive":
				if (distance < 150000) aggressive(distance);
				else passive();
		}
	}
	
	private function passive()
	{
		// passive behavior: move horizontal and go back to y position
		
		parent.velocity.y = 0;
		
		Math.round(parent.y);
		
		if (parent.x < min * 32) xMovement = 1;
		else if (parent.x > max * 32) xMovement = -1;
		
		parent.velocity.x = xMovement * 64;
		
		if 		(retreat.y < parent.y) parent.y -= 2;
		else if (retreat.y > parent.y) parent.y += 2;
		
		if (retreat.y - parent.y < 1 && retreat.y - parent.y > -1) parent.y = retreat.y;
		
		parent.animation.curAnim.frameRate = 30;
	}
	
	private function aggressive(_distance:Float)
	{
		// aggressive behavior: follow the player
		
		if 		(player.x < parent.x) parent.acceleration.x = (_distance < 50000) ? -parent.drag.x * 0.5 : -parent.drag.x;
		else if (player.x > parent.x) parent.acceleration.x = (_distance < 50000) ?  parent.drag.x * 0.5 :  parent.drag.x;
		
		if 		(player.y < parent.y) parent.acceleration.y = (_distance < 50000) ? -parent.drag.y * 0.5 : -parent.drag.y;
		else if (player.y > parent.y) parent.acceleration.y = (_distance < 50000) ?  parent.drag.y * 0.5 :  parent.drag.y;
		
		parent.animation.curAnim.frameRate = 60;
	}
	
	public function destroy()
	{
		parent = null;
		player = null;
		xMovement = 0;
		min = 0;
		max = 0;
		retreat = null;
		type = null;
	}
}