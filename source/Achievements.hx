import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class Achievements {
	public static var achievementsStuff:Array<Dynamic> = [ //Name, Description, Hidden achievement
		["Alone on a Friday Night?",		"Play on a Friday... Night.",									 false],
		["And... cut!",						"Beat the first week of Editor's Cut on HARD.",	 				 false],
		["Insominiac!",						"Beat Insomnia on Hard with no Misses.",						 false],
		["Caffeinated!",					"Beat Caffeine on Hard with no Misses.",						 false],
		["The show is done.",				"Beat Showdown on Hard with no Misses.",						 false],
		["You ANIMAL!",						"Beat Animal on Hard with no Misses.",					   		  true],
		["get BEAThoeven! ...heh",			"Beat Beathoven on Hard with no Misses.",					   	  true],
		["You got a sense of humor.",		"Beat Eruption on Hard with no Misses.",					   	  true],
		["Kaio... what?",              		"Beat Kaio-Ken on Hard with no Misses.",					   	  true],
		["You're gonna need a tylenol..",	"Beat God-Eater on Hard with no Misses.",				 	  	  true],
		["What a funkin' disaster",			"Complete a Song with a rating of 0%.",						   	 false],
		["The messiah",						"You've only got one shot! ... In a thousand",			 		 false],
		["BUTTERFINGERS!!!!",				"Complete a Song with 1000 misses.",							 false],
		["Oversinging Much...?",			"Hold down a note for 10 seconds.",								 false],
		["Toaster Gamer",					"Have you tried to run the game on a toaster?",					 false]
	];

	public static var achievementsUnlocked:Array<Dynamic> = [ //Save string and Achievement tag + is it unlocked?
		['friday_night_play', 	false],		//0
		['week1_nomiss', 		false],		//1
		['insomnia_nomiss', 	false],		//2
		['caffeine_nomiss', 	false],		//3
		['showdown_nomiss', 	false],		//4
		['animal_nomiss',	 	false],		//5
		['beatho_nomiss',		false],		//6
		['eruption_nomiss',	 	false],		//7
		['kaio_nomiss',			false],		//8
		['tyle_nomiss',		 	false],		//9
		['ur_bad',				false],		//10
		['messiah', 			false],		//11
		['butter_fingers', 		false],		//12
		['oversinging', 		false],		//13
		['toastie', 			false],		//15
	];

	public static var henchmenDeath:Int = 0;
	public static function unlockAchievement(id:Int):Void {
		FlxG.log.add('Completed achievement "' + achievementsStuff[id][0] +'"');
		achievementsUnlocked[id][1] = true;
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}

	public static function loadAchievements():Void {
		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsUnlocked != null) {
				FlxG.log.add("Trying to load stuff");
				var savedStuff:Array<String> = FlxG.save.data.achievementsUnlocked;
				for (i in 0...achievementsUnlocked.length) {
					for (j in 0...savedStuff.length) {
						if(achievementsUnlocked[i][0] == savedStuff[j]) {
							achievementsUnlocked[i][1] = true;
						}
					}
				}
			}
			if(henchmenDeath == 0 && FlxG.save.data.henchmenDeath != null) {
				henchmenDeath = FlxG.save.data.henchmenDeath;
			}
		}

		// You might be asking "Why didn't you just fucking load it directly dumbass??"
		// Well, Mr. Smartass, consider that this class was made for Mind Games Mod's demo,
		// i'm obviously going to change the "Psyche" achievement's objective so that you have to complete the entire week
		// with no misses instead of just Psychic once the full release is out. So, for not having the rest of your achievements lost on
		// the full release, we only save the achievements' tag names instead. This also makes me able to rename
		// achievements later as long as the tag names aren't changed of course.

		// Edit: Oh yeah, just thought that this also makes me able to change the achievements orders easier later if i want to.
		// So yeah, if you didn't thought about that i'm smarter than you, i think

		// buffoon
	}
}

class AttachedAchievement extends FlxSprite {
	public var sprTracker:FlxSprite;
	public function new(x:Float = 0, y:Float = 0, id:Int = 0) {
		super(x, y);

		if(Achievements.achievementsUnlocked[id][1]) {
			loadGraphic(Paths.image('achievementgrid'), true, 150, 150);
			animation.add('icon', [id], 0, false, false);
			animation.play('icon');
		} else {
			loadGraphic(Paths.image('lockedachievement'));
		}
		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	override function update(elapsed:Float) {
		if (sprTracker != null)
			setPosition(sprTracker.x - 130, sprTracker.y + 25);

		super.update(elapsed);
	}
}

class AchievementObject extends FlxSpriteGroup {
	public var onFinish:Void->Void = null;
	var alphaTween:FlxTween;
	public function new(id:Int, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();
		var achievementBG:FlxSprite = new FlxSprite(60, 50).makeGraphic(420, 120, FlxColor.BLACK);
		achievementBG.scrollFactor.set();

		var achievementIcon:FlxSprite = new FlxSprite(achievementBG.x + 10, achievementBG.y + 10).loadGraphic(Paths.image('achievementgrid'), true, 150, 150);
		achievementIcon.animation.add('icon', [id], 0, false, false);
		achievementIcon.animation.play('icon');
		achievementIcon.scrollFactor.set();
		achievementIcon.setGraphicSize(Std.int(achievementIcon.width * (2 / 3)));
		achievementIcon.updateHitbox();
		achievementIcon.antialiasing = ClientPrefs.globalAntialiasing;

		var achievementName:FlxText = new FlxText(achievementIcon.x + achievementIcon.width + 20, achievementIcon.y + 16, 280, Achievements.achievementsStuff[id][0], 16);
		achievementName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementName.scrollFactor.set();

		var achievementText:FlxText = new FlxText(achievementName.x, achievementName.y + 32, 280, Achievements.achievementsStuff[id][1], 16);
		achievementText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementText.scrollFactor.set();

		add(achievementBG);
		add(achievementName);
		add(achievementText);
		add(achievementIcon);

		var cam:Array<FlxCamera> = FlxCamera.defaultCameras;
		if(camera != null) {
			cam = [camera];
		}
		alpha = 0;
		achievementBG.cameras = cam;
		achievementName.cameras = cam;
		achievementText.cameras = cam;
		achievementIcon.cameras = cam;
		alphaTween = FlxTween.tween(this, {alpha: 1}, 0.5, {onComplete: function (twn:FlxTween) {
			alphaTween = FlxTween.tween(this, {alpha: 0}, 0.5, {
				startDelay: 2.5,
				onComplete: function(twn:FlxTween) {
					alphaTween = null;
					remove(this);
					if(onFinish != null) onFinish();
				}
			});
		}});
	}

	override function destroy() {
		if(alphaTween != null) {
			alphaTween.cancel();
		}
		super.destroy();
	}
}