package intoTheHat.interSwag ;

import flixel.addons.ui.FlxButtonPlus;          // had to program the outro and winning message
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import openfl.system.System;
import intoTheHat.swagHandler.Settings;
import intoTheHat.yoloController.levelSwag.*;
import intoTheHat.interSwag.MainMenu;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.display.BitmapData;
import openfl.Lib;


/**
 * ...
 * @author Radoslav Dimitrov
 */

class Outro extends FlxState
{
	private var _outro:Array<FlxSprite> = new Array (); // this is where i create an array which will contain the images for the outro
	
	var _timer:Float = 0; //declaring the timer that will change the pictures 
	
	var _text:FlxText;   // the text to say you can skip the end credits


	override public function create()
	{
		super.create();
		// WRITE DOWN HERE
		
		_outro.push(new FlxSprite( 0, 0, "assets/images/made.png"));						//first the same as the main menu but saying YOU MADE IT BRUUUUH
		_outro.push(new FlxSprite( 0, 0, "assets/images/sophie.png"));
		_outro.push(new FlxSprite( 0, 0, "assets/images/rado.png"));						//adding the images to the array
		_outro.push(new FlxSprite( 0, 0, "assets/images/sjoer.png"));
		_outro.push(new FlxSprite( 0, 0, "assets/images/tagor.png"));
		_outro.push(new FlxSprite( 0, 0, "assets/images/mieke.png"));
		
		for (image in _outro)
		{
			add(image);
			image.visible = false;      //this puts image on the screen as long as its in the outro array and makes it not visible because will show al images at once if so
		}
		
		_text = new FlxText(545, 680, 0, "Press Esc to Skip", 15, true); //show that people can skip
		_text.color = FlxColor.BLACK;
		add(_text);
		_text.visible = false;				
		
	}
	
	override public function update(e:Float)    //update function
	{
		_timer += e;
		trace(_timer);
		
		if (Std.int(_timer) == 1)           // makes only one picture visible when the time strikes the wanted seconds
		{
			_outro[0].visible = true;
			FlxG.sound.play("assets/music/applause.wav");   // plays an applause sound

		}
		
		if (Std.int(_timer) == 6)
		{
		    _outro[1].visible = true;
			_text.visible = true; // using boolean 
			
		}
		
		if (Std.int(_timer) == 8)
		{
			_outro[2].visible = true;
			_text.visible = true;
		}
		
		if (Std.int(_timer) == 10)
		{
			_outro[3].visible = true;
			_text.visible = true;
		}
		
		if (Std.int(_timer) == 12)
		{
			_outro[4].visible = true;
			_text.visible = true;
		}
		
		if (Std.int(_timer) == 14)
		{
			_outro[5].visible = true;
			_text.visible = true;
		}
		
		if (Std.int(_timer) == 17)
		{
			FlxG.switchState(new MainMenu());   // switches to main menu when the end credits are over
		}
		
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());   // makes the outro skippable by pressing ESCAPE
		
		super.update(e);
	}	
}
