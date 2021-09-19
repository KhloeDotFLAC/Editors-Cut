package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var powerup:Bool = false;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);
				animation.addByPrefix('kill', 'GF Kill', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);
				addOffset('kill', 0, -5);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('shaggy');
				frames = tex;
				animation.addByPrefix('idle', 'shaggy_idle', 24);
				animation.addByPrefix('idle2', 'shaggy_idle2', 24);
				animation.addByPrefix('singUP', 'shaggy_up', 20);
				animation.addByPrefix('singRIGHT', 'shaggy_right', 20);
				animation.addByPrefix('singDOWN', 'shaggy_down', 24);
				animation.addByPrefix('singLEFT', 'shaggy_left', 24);
				animation.addByPrefix('catch', 'shaggy_catch', 30);
				animation.addByPrefix('hold', 'shaggy_hold', 30);
				animation.addByPrefix('h_half', 'shaggy_h_half', 30);
				animation.addByPrefix('fall', 'shaggy_fall', 30);
				animation.addByPrefix('kneel', 'shaggy_half_ground', 30);

				animation.addByPrefix('power', 'shaggy_powerup', 30);
				animation.addByPrefix('idle_s', 'shaggy_super_idle', 24);
				animation.addByPrefix('singUP_s', 'shaggy_sup2', 20);
				animation.addByPrefix('singRIGHT_s', 'shaggy_sright', 20);
				animation.addByPrefix('singDOWN_s', 'shaggy_sdown', 24);
				animation.addByPrefix('singLEFT_s', 'shaggy_sleft', 24);

				addOffset('idle');
				addOffset('idle2');
				addOffset("singUP", -6, 0);
				addOffset("singRIGHT", -20, -40);
				addOffset("singLEFT", 100, -120);
				addOffset("singDOWN", 0, -170);
				addOffset("catch", 140, 90);
				addOffset("hold", 90, 100);
				addOffset("h_half", 90, 0);
				addOffset("fall", 130, 0);
				addOffset("kneel", 110, -123);

				addOffset('idle_s');
				addOffset('power', 10, 0);
				addOffset("singUP_s", -6, 0);
				addOffset("singRIGHT_s", -20, -40);
				addOffset("singLEFT_s", 100, -120);
				addOffset("singDOWN_s", 0, -170);

				playAnim('idle');

			case 'scooby':
				tex = Paths.getSparrowAtlas('scooby');
				frames = tex;
				animation.addByPrefix('walk', 'scoob_walk', 30, false);
				animation.addByPrefix('idle', 'scoob_idle', 30, false);
				animation.addByPrefix('scare', 'scoob_scare', 24, false);
				animation.addByPrefix('blur', 'scoob_blur', 30, false);
				animation.addByPrefix('half', 'scoob_half', 30, false);
				animation.addByPrefix('fall', 'scoob_fall', 30, false);

				addOffset("walk", 100, 60);
				addOffset("idle");
				addOffset("scare", 40);
				addOffset("blur");
				addOffset("half");
				addOffset("fall", 420, 0);

				playAnim('walk', true);
			case 'pshaggy':
				tex = Paths.getSparrowAtlas('pshaggy');
				frames = tex;
				animation.addByPrefix('idle', 'pshaggy_idle', 7, false);
				animation.addByPrefix('singUP', 'pshaggy_up', 28, false);
				animation.addByPrefix('singDOWN', 'pshaggy_down', 28, false);
				animation.addByPrefix('singLEFT', 'pshaggy_left', 28, false);
				animation.addByPrefix('singRIGHT', 'pshaggy_right', 28, false);
				animation.addByPrefix('back', 'pshaggy_back', 28, false);
				animation.addByPrefix('snap', 'pshaggy_snap', 7, false);
				animation.addByPrefix('snapped', 'pshaggy_did_snap', 28, false);
				animation.addByPrefix('smile', 'pshaggy_smile', 7, false);
				animation.addByPrefix('stand', 'pshaggy_stand', 7, false);

				addOffset("idle");
				addOffset("smile");
				var sOff = 20;
				addOffset("back", 0, -20 + sOff);
				addOffset("stand", 0, -20 + sOff);
				addOffset("snap", 10, 72 + sOff);
				addOffset("snapped", 0, 60 + sOff);
				addOffset("singUP", -6, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 10, 0);
				addOffset("singDOWN", 60, -100);

				playAnim('idle', true);

			case 'bf':
				var tex = Paths.getSparrowAtlas('BOYFRIEND');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				//animation.addByPrefix('hit', 'BF hit', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				//animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -38, 46);
				addOffset("singRIGHT", -38, -10);
				addOffset("singLEFT", 12, -1);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -28, 37);
				addOffset("singRIGHTmiss", -31, 1);
				addOffset("singLEFTmiss", 12, 4);
				addOffset("singDOWNmiss", -34, -41);
				addOffset("hey", -3, 4);
				//addOffset("hit", 20, 20);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				//addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			
			case 'keko':
				var tex = Paths.getSparrowAtlas('Keko_assets');
				frames = tex;
				animation.addByPrefix('idle', 'Keko Idle dance', 24, false);
				animation.addByPrefix('singUP', 'Keko Sing note UP', 24, false);
				animation.addByPrefix('singLEFT', 'Keko Sing note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Keko Sing note RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'Keko Sing note DOWN', 24, false);

				addOffset('idle', 0,0);
				addOffset("singUP", 169, 10);
				addOffset("singRIGHT", 128, -42);
				addOffset("singLEFT", 21, -23);
				addOffset("singDOWN", 0, -156);
		
				playAnim('idle');

				flipX = false;
		
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
			{
				dadVar = 6.1;
			}
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				case 'dad':
					if (!powerup)
					{
						danced = !danced;
						if (danced)
							playAnim('idle2', true);
						else
							playAnim('idle', true);
					}
					else
					{
						playAnim('idle_s');
					}
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (curCharacter == 'dad')
		{
			if (powerup && AnimName != 'idle_s' && AnimName != 'idle')
			{
				AnimName += '_s';
			}
		}
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
