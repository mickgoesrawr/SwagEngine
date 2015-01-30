package intoTheHat.interSwag ;

import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import intoTheHat.yoloController.levelSwag.Level_0001;
import openfl.system.System;
import intoTheHat.swagHandler.Settings;
import swagEngine.yoloController.levelSwag.*;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class MainMenu extends FlxState
{
	private var levelButton:Array<FlxButtonPlus> = new Array();
	
	override public function create()
	{
		super.create();
		
		FlxG.mouse.useSystemCursor = false;
		
		add(new FlxSprite((Settings.gameWidth / 4), 0, "assets/images/main_menu.png"));
		
		for (i in Settings.levels)
		{
			levelButton[i] = new FlxButtonPlus((Settings.gameWidth * 0.5) - 64, 500 + (i * 32 + 4), startLevel.bind(i), null, 128, 32);
			levelButton[i].loadButtonGraphic(new FlxSprite(0, 0, FlxAssets.getBitmapData("assets/buttons/" + i + ".png")), new FlxSprite(0, 0, FlxAssets.getBitmapData("assets/buttons/" + i + "_hl.png")));
			add(levelButton[i]);
		}
		
		FlxG.fixedTimestep = false;
		
	}
		
	private function startLevel(level:Int)
	{
		switch (level)
		{
			case 0: System.exit(0);
			case 1:	FlxG.switchState(new Level_0001());
		}
	}
	
	override public function destroy()
	{
		super.destroy();
	}

	override public function update(e:Float)
	{
		super.update(e);
		
		if (FlxG.keys.justPressed.ESCAPE) System.exit(0);
	}	
}