package intoTheHat.interSwag;

import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;
import intoTheHat.interSwag.cardSwag.Card;
import intoTheHat.yoloController.playerSwag.PlayerRenderer;
import openfl.system.System;

/**
* ...
* @author Sjoer van der Ploeg
*/

class Interface	extends FlxSpriteGroup
{
	private var player:PlayerRenderer;
	
	private var cardOverlay:FlxSprite = new FlxSprite();
	public var escapeMenu:FlxSprite = new FlxSprite();
	public var menuBG:FlxSprite = new FlxSprite();
	
#if !FLX_NO_DEBUG
	private var healthText:FlxText;
	
	private var diamondText:FlxText;
	private var clubText:FlxText;
	private var heartText:FlxText;
	private var spadeText:FlxText;
	
	private var cardsText:FlxText;	
	
	private var diamondsText:FlxText;
	private var clubsText:FlxText;
	private var heartsText:FlxText;
	private var spadesText:FlxText;
#end
	
	private var red:FlxSprite = new FlxSprite(FlxG.width * 0.5 - 32, FlxG.height - 128, "assets/images/red_ball.png");
	private var silver:FlxSprite = new FlxSprite(FlxG.width * 0.5, FlxG.height - 128, "assets/images/silver_ball.png");
	private var gold:FlxSprite = new FlxSprite(FlxG.width * 0.5 - 16, FlxG.height - 128, "assets/images/gold_ball.png");
	
	private var A:FlxSprite = new FlxSprite(FlxG.width * 0.5 -	128, FlxG.height - 96, "assets/images/A.png");
	private var S:FlxSprite = new FlxSprite(FlxG.width * 0.5 -	64, FlxG.height - 96, "assets/images/S.png");
	private var D:FlxSprite = new FlxSprite(FlxG.width * 0.5, FlxG.height - 96, "assets/images/D.png");
	private var F:FlxSprite = new FlxSprite(FlxG.width * 0.5 +	64, FlxG.height - 96, "assets/images/F.png");
	
	private var resumeButton:FlxButtonPlus;
	private var saveButton:FlxButtonPlus;
	private var exitButton:FlxButtonPlus;
	
	private var diamonds:Card;
	private var clubs:Card;
	private var hearts:Card;
	private var spades:Card;
	
	private var healthBar:FlxSprite = new FlxSprite();
	
	public function new(_player:PlayerRenderer) 
	{
		super();
		
		player = _player;
		
		scrollFactor.set(0, 0);
		
		#if !FLX_NO_DEBUG		
			cardOverlay.makeGraphic(384, 128, FlxColor.BLACK);
			cardOverlay.x = FlxG.width - cardOverlay.width;
			cardOverlay.y = FlxG.height - cardOverlay.height;
		add(cardOverlay);
		
			healthText = 	new FlxText(cardOverlay.x + 8,	cardOverlay.y + 8,	368, null, 16, true);
		add(healthText);
		
			diamondText = 	new FlxText(healthText.x,		healthText.y + 28,	368, null, 16, true);
		add(diamondText);
		
			clubText = 		new FlxText(healthText.x,		diamondText.y + 20,	368, null, 16, true);
		add(clubText);
		
			heartText = 	new FlxText(healthText.x,		clubText.y + 20,	368, null, 16, true);
		add(heartText);
		
			spadeText = 	new FlxText(healthText.x,		heartText.y + 20,	368, null, 16, true);
		add(spadeText);
		
			cardsText = 	new FlxText(cardOverlay.x + 8,	cardOverlay.y + 8,	368, null, 16, true);
			cardsText.alignment = "right";
		add(cardsText);
		
			diamondsText = 	new FlxText(healthText.x,		healthText.y + 28,	368, null, 16, true);
			diamondsText.alignment = "right";
		add(diamondsText);
		
			clubsText = 	new FlxText(healthText.x,		diamondText.y + 20,	368, null, 16, true);
			clubsText.alignment = "right";
		add(clubsText);
		
			heartsText = 	new FlxText(healthText.x,		clubText.y + 20,	368, null, 16, true);
			heartsText.alignment = "right";
		add(heartsText);
		
			spadesText = 	new FlxText(healthText.x,		heartText.y + 20,	368, null, 16, true);
			spadesText.alignment = "right";
		add(spadesText);
		#end
		
		add(red);
		add(silver);
		add(gold);
		
		diamonds =	new Card(480, FlxG.height - 72, player.abilities.cards.slots[0][0], "A");
		clubs =		new Card(560, FlxG.height - 72, player.abilities.cards.slots[1][0], "S");
		hearts =	new Card(640, FlxG.height - 72, player.abilities.cards.slots[2][0], "D");
		spades =	new Card(720, FlxG.height - 72, player.abilities.cards.slots[3][0], "F");
		
		add(diamonds);
		add(clubs);
		add(hearts);
		add(spades);
		
			healthBar.makeGraphic(312, 8, FlxColor.RED);
			healthBar.x = FlxG.width * 0.5 - healthBar.width * 0.5 - 4;
			healthBar.y = FlxG.height - 72 - healthBar.height * 2;
		add(healthBar);
		
			menuBG.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(menuBG);
		
			escapeMenu.loadGraphic("assets/images/pause_menu.png");
			escapeMenu.x = (FlxG.width * 0.5) - (escapeMenu.width * 0.5);
			escapeMenu.y = (FlxG.height * 0.5) - (escapeMenu.height * 0.5);
			escapeMenu.visible = false;
		add(escapeMenu);
		
			resumeButton = new FlxButtonPlus(FlxG.width * 0.5 - 64, FlxG.height * 0.5, resume, null, 128, 32);
			resumeButton.loadButtonGraphic(new FlxSprite(0, 0, "assets/buttons/resume.png"), new FlxSprite(0, 0, "assets/buttons/resume_hl.png"));
		add(resumeButton);
		
			saveButton = new FlxButtonPlus(FlxG.width * 0.5 - 64, FlxG.height * 0.5 + 32, save, null, 128, 32);
			saveButton.loadButtonGraphic(new FlxSprite(0, 0, "assets/buttons/save.png"), new FlxSprite(0, 0, "assets/buttons/save_hl.png"));
		add(saveButton);
		
			exitButton = new FlxButtonPlus(FlxG.width * 0.5 - 64, FlxG.height * 0.5 + 64, exit, null, 128, 32);
			exitButton.loadButtonGraphic(new FlxSprite(0, 0, "assets/buttons/0.png"), new FlxSprite(0, 0, "assets/buttons/0_hl.png"));
		add(exitButton);
	}
	
	private function resume()
	{
		escapeMenu.visible = false;
	}
	
	private function save()
	{
		// does nothing atm, should go over the state and save all stuff that was in the state
	}
	
	private function exit()
	{
		FlxG.switchState(new MainMenu());
	}
	
	override public function update(e:Float)
	{
		#if !FLX_NO_DEBUG
		healthText.text =	"Health: " +		Std.string((player.health < 0) ? 0 : player.health);
		
		cardsText.text =	"Collection: " +	"B: " + Std.string(player.abilities.cards.collected[0]) + " S: " + Std.string(player.abilities.cards.collected[1]) + " G: " + Std.string(player.abilities.cards.collected[2]);
		
		diamondText.text =	"Diamonds: " +		Std.string(player.abilities.cards.energy[0]);
		clubText.text =		"Clubs: " +			Std.string(player.abilities.cards.energy[1]);
		heartText.text =	"Hearts: " +		Std.string(player.abilities.cards.energy[2]);
		spadeText.text =	"Spades: " +		Std.string(player.abilities.cards.energy[3]);
		
		diamondsText.text =	player.abilities.cards.slots[0].toString();
		clubsText.text =	player.abilities.cards.slots[1].toString();
		heartsText.text =	player.abilities.cards.slots[2].toString();
		spadesText.text =	player.abilities.cards.slots[3].toString();
		#end
		
		red.alpha = (player.abilities.cards.collected[2] >= 1) ? 0 : 1 - (10 - player.abilities.cards.collected[0]) / 10;
		silver.alpha = (player.abilities.cards.collected[2] >= 1) ? 0 : 1 - (3 - player.abilities.cards.collected[1]) / 3;
		gold.alpha = (player.abilities.cards.collected[2] >= 1) ? 1 : 0;
		
		diamonds.ready =	(player.abilities.cards.energy[0] > 0);
		clubs.ready =		(player.abilities.cards.energy[1] > 0);
		hearts.ready =		(player.abilities.cards.energy[2] > 0);
		spades.ready =		(player.abilities.cards.energy[3] > 0);
		
		if (diamonds.type !=	player.abilities.cards.slots[0][0]) diamonds.setType(player.abilities.cards.slots[0][0]);
		if (clubs.type !=		player.abilities.cards.slots[1][0]) clubs.setType(player.abilities.cards.slots[1][0]);
		if (hearts.type !=		player.abilities.cards.slots[2][0]) hearts.setType(player.abilities.cards.slots[2][0]);
		if (spades.type !=		player.abilities.cards.slots[3][0]) spades.setType(player.abilities.cards.slots[3][0]);
		
		if (FlxG.keys.justPressed.ESCAPE && escapeMenu.visible) FlxG.switchState(new MainMenu());
		else if (FlxG.keys.justPressed.ESCAPE) escapeMenu.visible = !escapeMenu.visible;
		
		menuBG.visible = resumeButton.visible = saveButton.visible = exitButton.visible = escapeMenu.visible;
		
		healthBar.scale.x = (player.health < 0.1) ? 0 : player.health / 1000;
		
		super.update(e);
	}
}