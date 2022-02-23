package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

class OutdatedSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";

	override function create()
	{
		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('updateBG'));
		add(bg);
		
		var editorLogo:FlxSprite = new FlxSprite(FlxG.width, 0).loadGraphic(Paths.image('editorLogo'));
		editorLogo.screenCenter();
		editorLogo.alpha = 0.1;
		add(editorLogo);
		
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"The version you're currently running is outdated!\nYou're using v" + Application.current.meta.get('version') + ", while the most recent version is v" + needVer + "."
			+ "\n\nWhat's new:\n\n"
			+ currChanges
			+ "\n\n more changes and bugfixes in the full changelog"
			+ "\n\n\nPress Space to view the full changelog and update\nor ESCAPE to ignore this",
			32);
		
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		add(txt);
		
		FlxTween.angle(editorLogo, editorLogo.angle, -10, 2, {ease: FlxEase.quartInOut});
	
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			if(editorLogo.angle == -10) FlxTween.angle(editorLogo, editorLogo.angle, 10, 2, {ease: FlxEase.quartInOut});
			else FlxTween.angle(editorLogo, editorLogo.angle, -10, 2, {ease: FlxEase.quartInOut});
		}, 0);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			FlxG.openURL("https://kadedev.github.io/Kade-Engine/changelogs/changelog-" + needVer);
		}
		if (controls.BACK)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
