package intoTheHat.interSwag.cardSwag;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import flixel.util.FlxColor;

/**
 * ...
 * @author Sjoer van der Ploeg						// SHOULD ADD KEYS HERE
 */

class Card extends FlxSpriteGroup
{
	public var type:String;
	
	private var keyText:FlxText;
	
	private var front:FlxSprite = new FlxSprite(0, 0, "assets/images/card.png");
	private var back:FlxSprite = new FlxSprite(0, 0, "assets/images/cardslot.png");
	private var image:FlxSprite = new FlxSprite(4, 10);
	
	public var ready:Bool = false;
	
	public function new(_x:Float, _y:Float, _type:String, _key:String)
	{
		super(_x, _y);
		
		keyText = new FlxText(4, 2, 0, _key, 16, true);
		keyText.color = FlxColor.BLACK;
		
		setType(type);
		
		add(front);
		add(image);
		add(keyText);
		add(back);
	}
	
	public function setType(_type:String)
	{
		if (type == _type) return;
		
		type = _type;
		
		switch (type)
		{
			case "shrink":
				image.loadGraphic("assets/images/shrink.png");
				
			case "float":
				image.loadGraphic("assets/images/float.png");
				
			case "see":
				image.loadGraphic("assets/images/see.png");
				
			case "shoot":
				image.loadGraphic("assets/images/shoot.png");
				
			case "touch":
				image.loadGraphic("assets/images/touch.png");
				
			case "jump":
				image.loadGraphic("assets/images/jump.png");
		}
	}
	
	override public function update(e:Float)
	{
		if (e == 0) return;
		
		front.visible = image.visible = keyText.visible = ready;
		back.visible = !ready;
		
		super.update(e);
	}
}