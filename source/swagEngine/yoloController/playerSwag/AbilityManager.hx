package swagEngine.yoloController.playerSwag;

import flixel.FlxObject;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import swagEngine.swagHandler.Settings;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class AbilityManager
{
	private var player:PlayerRenderer;
	private var shots:FlxGroup;
	
	private var timer:Timer = new Timer(2500);
	private var activeTimer:Timer = new Timer(5000);
	
	public var scaled:Bool = false;
	public var jumping:Bool = false;
	public var floating:Bool = false;
	public var deadly:Int = 0;
	public var ammo:Int = 0;
	
	public var cards:CardManager;
	
	public var diamonds:Void->Void;
	public var clubs:Void->Void;
	public var hearts:Void->Void;
	public var spades:Void->Void;
	
	private var map:Map<String, Void->Void> = new Map<String, Void->Void>();
	
	public function new(_player:PlayerRenderer, _shots:FlxGroup) 
	{
		player = _player;
		shots = _shots;
		
		cards = new CardManager();
		
		cards.slots[0].push("float");
		cards.slots[1].push("shrink");
		cards.slots[2].push("shoot");
		cards.slots[2].push("touch");
		cards.slots[3].push("jump");
		
		map.set("float", float);
		map.set("shrink", shrink);
		map.set("shoot", shoot);
		map.set("jump", jump);
		map.set("touch", touchOfDeath);
		
		for (i in 0...4) setAbilities(i);
	}
	
	public function rotate(_suit:Int)
	{
		cards.slots[_suit].push(cards.slots[_suit].shift());
		
		setAbilities(_suit);
	}
	
	public function setAbilities(_suit:Int)
	{
		switch (_suit)
		{
			case 0:
				diamonds = map.get(cards.slots[0][0]);
			case 1:
				clubs = map.get(cards.slots[1][0]);
			case 2:
				hearts = map.get(cards.slots[2][0]);
			case 3:
				spades = map.get(cards.slots[3][0]);
		}
	}
	
	private function touchOfDeath()
	{
		if (cards.energy[2] > 0 && deadly == 0)
		{
			cards.energy[2]--;
			
			deadly = 3;
		}
	}
	
	private function shoot()
	{
		if (cards.energy[2] > 0 && ammo == 0)
		{
			cards.energy[2]--;
			
			ammo = 8;
		}
		
		if (ammo > 0)
		{
			ammo--;
			
			var shot:FlxSprite = cast(shots.recycle(), FlxSprite);
				shot.reset(player.x + player.width * 0.5, player.y + player.height * 0.25);
				
			switch (player.facing)
			{
				case FlxObject.LEFT:
					shot.velocity.x = -Settings.maxVelocity * 2;
					
				case FlxObject.RIGHT:
					shot.velocity.x = Settings.maxVelocity * 2;
			}
		}
	}
	
	private function jump()
	{
		if (player.isTouching(FlxObject.FLOOR))	player.velocity.y -= scaled ? 500 : 400;
		else if (cards.energy[3] > 0 && !player.isTouching(FlxObject.FLOOR) && !floating)
		{
			cards.energy[3]--;
			
			cards.timer.reset();
			cards.timer.start();
			
			player.velocity.y = 0;
			player.velocity.y -= scaled ? 400 : 300;
		}
	}
	
	private function float()
	{
		if (scaled || floating) return;
		else if (cards.energy[0] > 0)
		{
			cards.energy[0]--;
			
			player.acceleration.y = 250;
			
			floating = true;
			
			timer.addEventListener(TimerEvent.TIMER, normalGravity);
			timer.reset();
			timer.start();
		}
	}
	
	private function normalGravity(e)
	{
		timer.removeEventListener(TimerEvent.TIMER, normalGravity);
		timer.stop();
		
		player.acceleration.y = 1000;
		
		floating = false;
	}
	
	private function shrink()
	{
		if (jumping || scaled) return;
		else if (cards.energy[1] > 0)
		{
			cards.energy[1]--;
			
			player.maxVelocity.x += 50;
			player.y += player.frameHeight * 0.5;
			player.x += player.frameWidth * 0.25;
			player.scale.set(0.5, 0.5);
			player.updateHitbox();
			
			scaled = true;
				
			timer.addEventListener(TimerEvent.TIMER, growUp);
			timer.reset();
			timer.start();
		}
	}
	
	private function growUp(e)
	{
		timer.removeEventListener(TimerEvent.TIMER, growUp);
		timer.stop();
		
		player.maxVelocity.x -= 50;
		player.y -= player.frameHeight * 0.5;
		player.x -= player.frameWidth * 0.25;
		player.scale.set(1, 1);
		player.updateHitbox();
		
		scaled = false;
	}
	
	public function destroy()
	{
		timer.removeEventListener(TimerEvent.TIMER, growUp);
		
		cards.destroy();
		
		player = null;
		timer = null;
		scaled = false;
		jumping = false;
		floating = false;
		
		cards = null;
		
		diamonds = null;
		clubs = null;
		hearts = null;
		spades = null;
	}
}