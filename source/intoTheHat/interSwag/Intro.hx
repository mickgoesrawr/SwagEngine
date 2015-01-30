package intoTheHat.interSwag ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import intoTheHat.interSwag.MainMenu;
import flixel.FlxState;
import openfl.display.BitmapData;
import openfl.Lib;
import intoTheHat.swagHandler.Settings;
import motion.Actuate;
import flixel.util.FlxColor;

/**
 * ...
 * @author Sophie Walker
 */

class Intro extends FlxState
{
	var skip:FlxText;
	
	var counter:Float = 0;

	var titleim:FlxSprite;
	
	private var story:Array<FlxSprite> = new Array();
	
	override public function create()
	{
		super.create();
		//WRITE DOWN BELOW
		
		var bg:FlxSprite = new FlxSprite(0, 0); //fancy white background so you dont see the black parts in transitions
			bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
			add(bg);
			

		
		FlxG.sound.play("assets/music/storysound.wav"); //plays sound
		
		story.push(new FlxSprite(0, 0, "assets/images/titleimage.png")); //push image into array
		story.push(new FlxSprite(0, 0, "assets/images/nr1teatru.png"));
		story.push(new FlxSprite(0, 0, "assets/images/nr2txt.png"));
		story.push(new FlxSprite(0, 0, "assets/images/nr3txt.png"));
		story.push(new FlxSprite(0, 0, "assets/images/nr4txt.png"));
		story.push(new FlxSprite(0, 0, "assets/images/nr5txt.png"));
		story.push(new FlxSprite(0, 0, "assets/images/nr6txt.png"));
		story.push(new FlxSprite(0, 0, "assets/images/nr7txt.png"));
		story.push(new FlxSprite(0, 0, "assets/images/nr8txt.png"));
		story.push(new FlxSprite(0, 0, "assets/images/nr9txt.png"));
		story.push(new FlxSprite(0, 0, "assets/images/nr910txt.png"));
		story.push(new FlxSprite(0, 0, "assets/images/nr911txt.png"));
		
		for (image in story)
		{
			add(image);
			image.visible = false; //make images invisible
		}
		
		skip = new FlxText(0, 0, 200, "press Esc to skip", 10, true); //show that people can skip
		skip.color = FlxColor.RED;
		add(skip);
		skip.visible = false;
		
	}
	
	override public function update(e:Float)
	{
		super.update(e);
		
		counter += e;
		
		
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenu()); //skips to menu if escape is pressed
		
		if (Std.int(counter) == 0 )
		{
			story[0].visible = true;
		}
		
		if (Std.int(counter) == 6 )
		{
			story[1].visible = true;
			story[0].visible = true;
			
			story[1].scale.x = 1.2;
			story[1].scale.y = 1.2;
			
			//1appears/moves
			story[1].alpha = 0;
			Actuate.tween (story[1], 4, { alpha: 1 } );
			Actuate.tween (story[1], 35, { x: 100 } ); 
			
			//0disappears
			Actuate.tween (story[0], 2, { alpha: 0 } );
			
			skip.visible = true; //skip message on screen
		}	
		
		if (Std.int(counter) == 12 )
		{
			story[2].visible = true;
			story[1].visible = true;
			story[2].y = 55;
			
			//zoom
			story[2].scale.x = 1.15;
			story[2].scale.y = 1.15;
			
			//2 appears/moves
			story[2].alpha = 0;
			Actuate.tween (story[2], 3, { alpha: 1 } );
			Actuate.tween (story[2], 35, { x: -100 } );
			
			//1 disappears
			Actuate.tween (story[1], 5, { alpha: 0 } );
			
			skip.visible = false; //skip message gone
		}	
		
		if (Std.int(counter) == 19 )
		{
			story[3].visible = true;
			story[2].visible = true;
			story[3].y = -35;
			
			//3 appears/moves
			story[3].alpha = 0;
			Actuate.tween (story[3], 3, { alpha: 1 } );
			Actuate.tween (story[3], 50, { y: 50 } );
			
			//zoom
			story[3].scale.x = 1.1;
			story[3].scale.y = 1.1;
			
			//2 disappears
			Actuate.tween (story[2], 5, { alpha: 0 } );
		}	
		
		
		if (Std.int(counter) == 25 )//26
		{
			story[4].visible = true;
			story[3].visible = true;
			story[4].y = 60;
			
			//zoom
			story[4].scale.x = 1.15;
			story[4].scale.y = 1.15;
			
			//4 appears/moves
			story[4].alpha = 0;
			Actuate.tween (story[4], 4, { alpha: 1 } );
			Actuate.tween (story[4], 60, { x: -120 } );
			Actuate.tween (story[4], 60, { y: -120 } );
			
			//3 disappears
			Actuate.tween (story[3], 40, { x: -100 } ); 
			Actuate.tween (story[3], 5, { alpha: 0 } );
		}	
		
		if (Std.int(counter) == 34 )
		{
			story[5].visible = true;
			story[4].visible = true;
			story[5].y = -50;
			story[5].x = -50;
			
			//zoom
			story[5].scale.x = 1.1;
			story[5].scale.y = 1.1;
			
			//5 appears/moves
			story[5].alpha = 0;
			Actuate.tween (story[5], 3, { alpha: 1 } );
			Actuate.tween (story[5], 50, { y: 100 } );
			
			//4 disappears
			Actuate.tween (story[4], 5, { alpha: 0 } );
		}	
		
		if (Std.int(counter) == 40 )
		{
			story[6].visible = true;
			story[5].visible = true;
			story[6].x = -35;
			
			//zoom
			story[6].scale.x = 1.15;
			story[6].scale.y = 1.15;
			
			//6 appears/moves
			story[6].alpha = 0;
			Actuate.tween (story[6], 3, { alpha: 1 } );
			Actuate.tween (story[6], 50, { x: 100 } );
			
			//5 disappears
			Actuate.tween (story[5], 50, { x: -100 } ); 
			Actuate.tween (story[5], 5, { alpha: 0 } );
		}	
		
		if (Std.int(counter) == 47 )
		{
			story[7].visible = true;
			story[6].visible = true;
			story[7].x = -100;
			
			//zoom
			story[7].scale.x = 1.15;
			story[7].scale.y = 1.15;
			
			//7 appears/move
			story[7].alpha = 0;
			Actuate.tween (story[7], 3, { alpha: 1 } );
			Actuate.tween (story[7], 60, { y: -100 } );
			
			//6 disappears
			Actuate.tween (story[6], 50, { x: -100 } ); 
			Actuate.tween (story[6], 5, { alpha: 0 } );
		}	
		
		if (Std.int(counter) == 54 )
		{
			story[8].visible = true;
			story[7].visible = true;
			story[8].y = 70;
			story[8].x = 70;
			
			//zoom
			story[8].scale.x = 1.2;
			story[8].scale.y = 1.2;
			
			//8 appears/moves
			story[8].alpha = 0;
			Actuate.tween (story[8], 4, { alpha: 1 } );
			Actuate.tween (story[8], 60, { x: -100 } );
			
			//7 disappears
			Actuate.tween (story[7], 40, { x: -100 } ); 
			Actuate.tween (story[7], 5, { alpha: 0 } );
		}	
		
		if (Std.int(counter) == 60 )
		{
			story[9].visible = true;
			story[8].visible = true;
			story[9].y = 20;
			//story[9].x = 50;
			
			//zoom
			story[9].scale.x = 1.05;
			story[9].scale.y = 1.05;
			
			//9 appears/moves
			story[9].alpha = 0;
			Actuate.tween (story[9], 3, { alpha: 1 } );
			Actuate.tween (story[9], 100, { y: -100});
			
			//8 disappears
			Actuate.tween (story[8], 5, { alpha: 0 } );
		}	
		
		if (Std.int(counter) == 67 ) 
		{
			story[10].visible = true;
			story[9].visible = true;
			story[10].y = -50;
			
			//zoom
			story[10].scale.x = 1.1;
			story[10].scale.y = 1.1;
			
			//10 appears/moves
			story[10].alpha = 0;
			Actuate.tween (story[10], 3, { alpha: 1 } );
			Actuate.tween (story[10], 50, { y: 100 } );
			
			//9 disappears
			Actuate.tween (story[9], 50, { x: -100 } ); 
			Actuate.tween (story[9], 5, { alpha: 0 } );
		}	
		
		if (Std.int(counter) == 73 ) 
		{
			story[11].visible = true;
			story[10].visible = true;
			
			//11 appears/moves
			story[11].alpha = 0;
			Actuate.tween (story[11], 3, { alpha: 1 } );
			
			//zoom
			story[11].scale.x = 1.1;
			story[11].scale.y = 1.1;
			
			//10 disappears
			Actuate.tween (story[10], 20, { x: -100 } ); 
			Actuate.tween (story[10], 5, { alpha: 0 } );
		}
		
		if (Std.int(counter) == 80) FlxG.switchState(new MainMenu());
	}
}