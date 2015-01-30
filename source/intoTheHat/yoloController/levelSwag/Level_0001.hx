package intoTheHat.yoloController.levelSwag ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag.Light;
import intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag.LightBowl;
import intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag.Mouse;
import intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag.Rabbit;
import intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag.Spider;
import intoTheHat.yoloController.levelSwag.yoloObjects.Card;
import intoTheHat.yoloController.levelSwag.yoloObjects.Enemy;
import intoTheHat.yoloController.levelSwag.yoloObjects.Exit;
import intoTheHat.yoloController.levelSwag.yoloObjects.Platform;
import intoTheHat.yoloController.levelSwag.yoloObjects.Portal;
import intoTheHat.yoloController.levelSwag.yoloObjects.Shot;
import openfl.tiled.FlxTile;
import format.SVG;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.TimerEvent;
import openfl.tiled.FlxLayer;
import openfl.tiled.FlxTiledMap;
import openfl.utils.Timer;
import intoTheHat.interSwag.Interface;
import intoTheHat.interSwag.MainMenu;
import intoTheHat.yoloController.levelSwag.yoloObjects.*;
import intoTheHat.yoloController.levelSwag.yoloObjects.animationSwag.*;
import intoTheHat.yoloController.playerSwag.PlayerRenderer;
import intoTheHat.interSwag.Outro;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class Level_0001 extends FlxState
{
	private var map:String = "Level_0001";
	private var level:FlxTiledMap;
	
	private var UI:Interface;
	private var player:PlayerRenderer;
	
	private var solid:FlxLayer;
	private var invisibles:FlxLayer;
	private var visibles:FlxLayer;
	private var falling:FlxLayer;
	
	private var foreground:FlxLayer;
	private var background:FlxLayer;
	private var fluffTiles:FlxLayer;
	
	private var shots:FlxGroup = new FlxGroup();
	private var portals:FlxGroup = new FlxGroup();
	private var cards:FlxGroup = new FlxGroup();
	private var platforms:FlxGroup = new FlxGroup();
	private var exits:FlxGroup = new FlxGroup();
	private var enemies:FlxGroup = new FlxGroup();
	private var fluffObjects:FlxGroup = new FlxGroup();
	private var lightBowls:FlxGroup = new FlxGroup();
	private var light:FlxGroup = new FlxGroup();
	private var wizzard:FlxGroup = new FlxGroup();
	
	private var fireball:BitmapData;
	
	override public function create()
	{
		super.create();
		
		FlxG.debugger.drawDebug = true;
		
		level = FlxTiledMap.fromAssets("assets/levels/" + map + "/level.tmx");
		
		loadLayers();							// Parse layers
		loadObjects();							// Parse objects
		
		add(new FlxSprite(0, 0, level._map.imageLayers[0].image.texture));		// Background_image
		
		add(lightBowls);														// LightBowls
		add(cards);																// Cards
		add(background);														// Background
		add(exits);																// Exits
		add(portals);															// Portals
		add(shots);								// Objects the player emits
		add(player);															// Player
		
		add(falling);															// Falling
		
		add(invisibles);														// Invicible
		add(visibles);															// Invicible
		
		add(solid);																// Level
		add(platforms);															// Platforms
		add(enemies);															// Enemies
		
		add(fluffObjects);						// Add some fluff animations
		add(fluffTiles);						// Add some tiles belonging to fluff animations
		add(light);								// Add some lights
		
		add(foreground);														// Foreground
		add(wizzard);							// Wizzard

		UI = new Interface(player);
		add(UI);								// Interface
		
		FlxG.camera.setScrollBounds(0, level.totalWidth, 0, level.totalHeight);
		FlxG.camera.follow(player);
		FlxG.worldBounds.set(0, 0, level.totalWidth, level.totalHeight);
		
		player.health = 1000;
		
		fireball = SVGToBitmapData("assets/images/Fireball.svg");
		
		shots.maxSize = 16;
		
		for (i in 0...shots.maxSize)
			shots.add(new Shot( -64, -64, fireball));
		
		FlxG.sound.play("assets/music/intro.wav", 1, false, true, playMusicLoop);
	}
	
	private function playMusicLoop()
	{
		FlxG.sound.play("assets/music/loop.wav", 1, true, true);
	}
	
	private function SVGToBitmapData(_assetPath:String):BitmapData
	{
		var sprite:Sprite = new Sprite();
		
		var svg:SVG = new SVG(Assets.getText(_assetPath));
			svg.render(sprite.graphics, 0, 0, Std.int(svg.data.width), Std.int(svg.data.height));
		
		var bitmap:BitmapData = new BitmapData(Std.int(sprite.width), Std.int(sprite.height), true, 0x0);
			bitmap.draw(sprite);
		
		return bitmap;
	}
	
	private function loadLayers()
	{
		solid = level.getLayerByName("Level");
		solid.setActive(true);
		
		invisibles = level.getLayerByName("Invisible");
		invisibles.setActive(true);
		
		visibles = level.getLayerByName("Visible");
		visibles.setActive(true);
		
		falling = level.getLayerByName("Falling");
		falling.setActive(true);
		
		foreground = level.getLayerByName("Foreground");
		foreground.setActive(true);
		
		background = level.getLayerByName("Background");
		background.setActive(true);
		
		fluffTiles = level.getLayerByName("FluffTiles");
		fluffTiles.setActive(true);
	}
	
	private function loadObjects()
	{
		for (_fluff in level._map.getObjectGroupByName("FluffObjects").objects)
		{
			switch (_fluff.type)
			{
				case "spider":
					fluffObjects.add(new Spider(_fluff.x, _fluff.y));
					
				case "wizzard":															
					wizzard.add(new Trollwizard(_fluff.x, _fluff.y, _fluff.properties.get("X"), _fluff.properties.get("Y")));
					
				case "light":
					light.add(new Light(_fluff.x, _fluff.y));
					
				case "lightbowl":
					lightBowls.add(new LightBowl(_fluff.x, _fluff.y));
					
				case "mouse":
					fluffObjects.add(new Mouse(_fluff.x, _fluff.y, _fluff.properties.get("min"), _fluff.properties.get("max")));
			}
		}
		
		var _player = level._map.getObjectByName("player_start", level._map.getObjectGroupByName("Player"));
			 player = new PlayerRenderer(_player.x + 16, _player.y, shots);
		
		for (card in level._map.getObjectGroupByName("Cards").objects)
			cards.add(new Card(card.x, card.y, level._map.getTilesetByGID(card.gid).image.texture, card.type));
		
		var _level_exit = level._map.getObjectByName("level_exit", level._map.getObjectGroupByName("Exits"));
			exits.add(new Exit(_level_exit.x, _level_exit.y, level._map.getTilesetByGID(_level_exit.gid).image.texture));
			
		for (portal in level._map.getObjectGroupByName("Portals").objects)
			portals.add(new Portal(portal.x, portal.y, level._map.getTilesetByGID(portal.gid).image.texture, portal.name, portal.type));
			
		for (_platform in level._map.getObjectGroupByName("Platforms").objects)
		{
			switch (_platform.type)
			{
				case "vertical":
					platforms.add(new Platform(_platform.x, _platform.y, level._map.getTilesetByGID(_platform.gid).image.texture, _platform.properties.get("min"), _platform.properties.get("max"), true));
					
				case "horizontal":
					platforms.add(new Platform(_platform.x, _platform.y, level._map.getTilesetByGID(_platform.gid).image.texture, _platform.properties.get("min"), _platform.properties.get("max"), false));
			}
		}
		
		for (_enemy in level._map.getObjectGroupByName("Enemies").objects)
		{	
			switch (_enemy.name)
			{
				case "bird":
					enemies.add(new Enemy(_enemy.x, _enemy.y, _enemy.rotation, _enemy.name, player, _enemy.properties.get("min"), _enemy.properties.get("max"), _enemy.type));
					
				case "rabbit":
					enemies.add(new Enemy(_enemy.x, _enemy.y, _enemy.rotation, _enemy.name, player));
			}
		}
	}
	
	private function getCard(_card:Card, _player:FlxObject)
	{
		_card.kill();
		
		player.abilities.cards.collect(_card.type);
		
		//if (cards.countLiving() == 0) exits.members[0].exists = true;
		if (player.abilities.cards.collected[2] > 0) exits.members[0].exists = true;		// IF GOLD CARD, ALLOW EXIT.
	}
	
	private function doExit(_exit:FlxObject, _player:FlxObject)
	{	
		if (_exit.exists && FlxG.keys.justPressed.SPACE) FlxG.switchState(new Outro());
	}
	
	private function doPortal(_portal:Portal, _player:FlxObject)
	{
		if (FlxG.keys.justPressed.SPACE && !player.portaling)
		{
			player.portaling = true;
			
			for (portal in portals.members)
			{
				var temp:Portal = cast(portal, Portal);
				
				if (temp.name == _portal.destination)
				{
					player.x = temp.x + 16;			// FIX SOMETHING FOR THE DELAY WITH DOOR OPEN SOUND
					player.y = temp.y + 64;
					
					player.portalTimer.reset();
					player.portalTimer.start();
					
					break;
				}
			}
		}
	}
	
	private function shotEnemy(_shot:FlxObject, _enemy:FlxObject)
	{
		if (Type.getClass(_enemy) == Rabbit)
		{
			_shot.hurt(4);
			
			if (cast(_enemy, Rabbit).animation.curAnim.name == "pop")
			{
				_enemy.kill();
			}
			else cast(_enemy, Rabbit).animation.play("pop");
		}
		else
		{
			_shot.hurt(2);
			
			_enemy.kill();
		}
	}
	
	private function shotLevel(_shot:FlxObject, _tile:FlxTile)
	{
		if (visibles.members.indexOf(_tile) != -1 || invisibles.members.indexOf(_tile) != -1)
			_shot.hurt(1);
		else 
			_shot.hurt(2);
		
		_tile.kill();
	}
	
	private function shotFluff(_shot:FlxObject, _tile:FlxObject)
	{
		_tile.kill();
	}

	private function fallTile(_player:FlxObject, _tile:FlxObject)
	{
		_tile.immovable = false;
		
		FlxObject.separateY(_player, _tile);
		
		_tile.drag.y = 200;
	}
	
	private function FML(_player:FlxObject, _tile:FlxObject)
	{
		// FIX ONE WAY PLATFORMS!
		
		FlxObject.separate(_tile, _player);
	}
	
	override public function destroy()
	{	
		map = null;
		level = null;
		UI = null;
		player = null;
		solid = null;
		portals = null;
		cards = null;
		platforms = null;
		exits = null;
		enemies = null;
		
		FlxG.debugger.drawDebug = false;
	}
	
	override public function update(e:Float)
	{
		if (UI.escapeMenu.visible) e = 0;
		else
		{
			FlxG.collide(player, platforms);
			
			FlxG.overlap(player, solid, FlxObject.separate);
			
			if (visibles.exists) FlxG.overlap(player, visibles, FML);
			
			FlxG.overlap(player, falling, fallTile);
			
			FlxG.overlap(cards, player, getCard);
			FlxG.overlap(exits, player, doExit);
			FlxG.overlap(portals, player, doPortal);
			
			FlxG.overlap(shots, enemies, shotEnemy);
			
			FlxG.overlap(shots, solid, shotLevel);
			
			FlxG.overlap(shots, visibles, shotLevel);
			FlxG.overlap(shots, invisibles, shotLevel);
			
			FlxG.overlap(shots, foreground, shotFluff);
			FlxG.overlap(shots, background, shotFluff);
			//FlxG.overlap(shots, fluffTiles, shotFluff);
			FlxG.overlap(shots, fluffObjects, shotFluff);
			
			invisibles.exists = !player.abilities.seeing;
			visibles.exists = player.abilities.seeing;
			
			if (!player.isOnScreen() && !player.portaling) player.health = 0;
			if (!player.alive || player.health <= 0) FlxG.resetState();
		}
		
		super.update(e);
	}
}