package intoTheHat.yoloController.playerSwag;

import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
* ...
* @author Sjoer van der Ploeg
*/

class CardManager
{
	public var slots:Array<Array<String>> =			[[],	// 0 = Diamonds
													 [],	// 1 = Clubs
													 [],	// 2 = Hearts
													 []];	// 3 = Spades
	
	public var energy:Array<Int> = [1, 1, 1, 1];
	
	public var collected:Array<Int> = [0, 0, 0];
	
	public var diamondTimer:Timer = new Timer(5000);
	public var clubTimer:Timer = new Timer(5000);
	public var heartTimer:Timer = new Timer(2500);
	public var spadeTimer:Timer = new Timer(1250);
	
	/**
	 * Increases the players health. 
	 */
	
	public function new() 
	{
		diamondTimer.addEventListener(TimerEvent.TIMER, powerUpDiamonds);
		diamondTimer.start();
		
		clubTimer.addEventListener(TimerEvent.TIMER, powerUpClubs);
		clubTimer.start();
		
		heartTimer.addEventListener(TimerEvent.TIMER, powerUpHearts);
		heartTimer.start();
		
		spadeTimer.addEventListener(TimerEvent.TIMER, powerUpSpades);
		spadeTimer.start();
	}
	
	public function collect(_suit:String)
	{
	/*	switch (_suit)				// HACK ENERGY, ONLY ONE CARD ATM MIGHT BE ADDED LATER FOR NOW JUST TIMERS
		{
			case "diamond":
				energy[0]++;
				
			case "club":
				energy[1]++;
				
			case "heart":
				energy[2]++;
				
			case "spade":
				energy[3]++;
		}	*/
		
		collected[0]++;
		
		if (collected[0] == 10)
		{
			collected[0] = 0;
			collected[1]++;
		}
		if (collected[1] == 3)
		{
			collected[1] = 0;
			collected[2]++;
		}
		if (collected[2] == 1)
		{
			trace("GAME OVER!");
		}
	}
	
	private function powerUpDiamonds(e:TimerEvent)
	{
		if (energy[0] == 0) energy[0]++;
	}
	
	private function powerUpClubs(e:TimerEvent)
	{
		if (energy[1] == 0) energy[1]++;
	}
	
	private function powerUpHearts(e:TimerEvent)
	{
		if (energy[2] == 0) energy[2]++;
	}
	
	private function powerUpSpades(e:TimerEvent)
	{
		if (energy[3] == 0) energy[3]++;
	}
	
	public function destroy()
	{
		diamondTimer.removeEventListener(TimerEvent.TIMER, powerUpDiamonds);
		clubTimer.removeEventListener(TimerEvent.TIMER, powerUpClubs);
		heartTimer.removeEventListener(TimerEvent.TIMER, powerUpHearts);
		spadeTimer.removeEventListener(TimerEvent.TIMER, powerUpSpades);
		
		slots = null;
		energy = null;
		
		diamondTimer = null;
		clubTimer = null;
		heartTimer = null;
		spadeTimer = null;
	}
}