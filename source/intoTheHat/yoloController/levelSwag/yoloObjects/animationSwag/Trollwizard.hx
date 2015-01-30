package intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag;

import flixel.FlxSprite;

/**
* ...
* @author Mieke Verschuren :-)
*/

class Trollwizard extends FlxSprite														//This is the class for our trollwizard 
{
	private var X:Int = 0;																//
	private var Y:Int = 0;																//
	
	public function new(_x:Float = 0, _y:Float = 0, _X:String, _Y:String) 				//
	{
		super(_x, _y);																	//
	
		X = Std.parseInt(_X);															//
		Y = Std.parseInt(_Y);															//
		
		loadGraphic("assets/animations/wizzard.png", true, 108, 120);					//Here we are loading the tilesheet
		y -= height;																	//Offset
		
		var framesArray = new Array();													//
			for (i in 0...13) framesArray[i] = i;										//
		
		for (i in 0...Std.random(framesArray.length))									//
			framesArray.push(framesArray.shift());										//
		
		animation.add("wizzard", framesArray, 10, true);								//
		animation.play("wizzard", false, false, -1); 									//
	}
		
	override public function update(e:Float)											//A new public function is made to 
	{
		if (Y*32 > y) y++;																//If the y-position is higher than y, then increase the position
		else if (Y*32 < y) y--;															//Else, if the y-position is lower than y, decrease the position
		
		if (X*32 > x) x = x + 4 ;														//If the x-position is higher than x, then increase the position + how fast the wizard is going forward
		else if (X*32 < x) x = x - 4;													//Else, if the x-position is lower than x, decrease the position + how fast the wizard is going forward
		
		super.update(e);																
	}
}