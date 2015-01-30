package intoTheHat.yoloController.levelSwag ;

import openfl.tiled.FlxTiledMap;
import flixel.FlxG;
import flixel.FlxState;

import intoTheHat.interSwag.MainMenu;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Sjoer extends FlxState
{
	public var level:FlxTiledMap;
	
	override public function create()
	{
		level = FlxTiledMap.fromAssets("assets/levels/Sjoer/level.tmx");
		
		//for (member in level.members)
		//	add(member);
			
		//for (layer in level.layers )
		//	add(layer);
		
		add(level);
		
		
		
		super.create();
		
		//FlxG.camera.setScrollBounds(0, level.totalWidth, 0, level.totalHeight);
		//FlxG.camera.follow(player);
		//FlxG.worldBounds.set(0, 0, level.totalWidth, level.totalHeight);
	}

	override public function update(e:Float)
	{
		if (e == 0) return;
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu());
		
		super.update(e);
	}
}