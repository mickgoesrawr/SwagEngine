package intoTheHat.yoloController.playerSwag;

import flixel.FlxObject;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import intoTheHat.swagHandler.Settings;
import flixel.group.FlxGroup;
import intoTheHat.yoloController.levelSwag.yoloObjects.Shot;

/**
 * ...
 * @author Sjoer van der Ploeg
 */

class AbilityManager
{
	private var player:PlayerRenderer;
	private var shots:FlxGroup;
	
	private var floatTimer:Timer = new Timer(2500);
	private var shrinkTimer:Timer = new Timer(2500);
	private var seeTimer:Timer = new Timer(5000);
	
	public var scaled:Bool = false;
	public var jumping:Bool = false;
	public var floating:Bool = false;
	public var seeing:Bool = false;
	
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
		
		cards.slots[0].push("shrink");
		cards.slots[0].push("float");
		
		cards.slots[1].push("see");
		
		cards.slots[2].push("shoot");
		cards.slots[2].push("touch");
		
		cards.slots[3].push("jump");
		
		map.set("float", float);
		map.set("shrink", shrink);
		map.set("shoot", shoot);
		map.set("jump", jump);
		map.set("touch", touchOfDeath);
		map.set("see", see);
		
		for (i in 0...4) setAbilities(i);
		
		floatTimer.addEventListener(TimerEvent.TIMER, normalGravity);
		seeTimer.addEventListener(TimerEvent.TIMER, unsee);
		shrinkTimer.addEventListener(TimerEvent.TIMER, growUp);
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
	
	private function see()
	{
		//if (cards.energy[1] > 0 && !seeing)
		if (!seeing)
		{
			cards.energy[1]--;
			
			seeing = true;
			
			seeTimer.start();
		}
	}
	
	private function unsee(e)
	{
		seeing = false;
		
		seeTimer.reset();
	}
	
	private function touchOfDeath()
	{
		//if (cards.energy[2] > 0 && deadly < 2)
		if (deadly < 2)
		{
			cards.energy[2] --;
			
			deadly++;
		}
	}
	
	private function shoot()
	{
		//if (cards.energy[2] > 0 && ammo == 0)
		if (ammo == 0)
		{
			cards.energy[2]--;
			
			ammo = 2;
		}
		
		if (ammo > 0)
		{
			ammo--;
			
			var shot:Shot = cast(shots.recycle(), Shot);
				shot.reset(player.x, player.y + player.height * 0.25);
				
			switch (player.facing)
			{
				case FlxObject.LEFT:
					shot.flipX = true;
					shot.x -= player.width;
					shot.velocity.x = -Settings.maxVelocity * 2 + player.velocity.x;
					
				case FlxObject.RIGHT:
					shot.flipX = false;
					shot.x += player.width;
					shot.velocity.x = Settings.maxVelocity * 2 + player.velocity.x;
			}
			
			shot.timer.start();
			
			shot.alpha = 1;
			shot.health = 4;
		}
	}
	
	private function jump()
	{
		if (!jumping)
		{
			jumping = true;
			player.velocity.y -= scaled ? 500 : 400;
		}
		//else if (cards.energy[3] > 0 && jumping && !floating)
		else if (jumping && !floating)
		{
			jumping = true;
			cards.energy[3]--;
			
			cards.spadeTimer.reset();
			cards.spadeTimer.start();
			
			player.velocity.y = 0;
			player.velocity.y -= scaled ? 400 : 300;
		}
	}
	
	private function float()
	{
		if (floating) return;
		
		//if (cards.energy[0] > 0)
		//{
			cards.energy[0]--;
			
			floating = true;
			
			floatTimer.start();
		//}
	}
	
	private function normalGravity(e)
	{
		floatTimer.reset();
		
		floating = false;
	}
	
	private function shrink()
	{
		if (scaled) return;
		
		//if (cards.energy[0] > 0)
		//{
			cards.energy[0]--;
			
			player.maxVelocity.x += 50;
			player.y += player.frameHeight * 0.5;
			player.scale.set(0.5, 0.5);
			player.updateHitbox();
			
			scaled = true;
				
			shrinkTimer.start();
//		}
	}
	
	private function growUp(e)
	{
		shrinkTimer.reset();
		
		player.maxVelocity.x -= 50;
		player.y -= player.frameHeight * 0.5;
		player.scale.set(1, 1);
		player.updateHitbox();
		
		scaled = false;
	}
	
	public function destroy()
	{
		player = null;
		shots = null;
		
		floatTimer.removeEventListener(TimerEvent.TIMER, normalGravity);
		floatTimer = null;
		
		shrinkTimer.removeEventListener(TimerEvent.TIMER, growUp);
		shrinkTimer = null;
		
		seeTimer.removeEventListener(TimerEvent.TIMER, unsee);
		seeTimer = null;
		
		scaled = false;
		jumping = false;
		floating = false;
		seeing = false;
		
		deadly = 0;
		ammo = 0;
		
		cards.destroy();
		cards = null;
		
		diamonds = null;
		clubs = null;
		hearts = null;
		spades = null;
		
		map = null;
	}
}