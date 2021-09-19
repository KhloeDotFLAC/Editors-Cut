package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;

class ClaqueteTransition extends FlxState
{
    var claquete:FlxSprite;

    override public function create():Void
    {
        super.create();

        claquete.frames = Paths.getSparrowAtlas('intro/ClaqueteSpriteSheet');
        claquete.animation.addByPrefix('In', "ClaqueteIn", 24, false);
        claquete.animation.addByPrefix('Loop', "ClaqueteLoop", 24, true);
        claquete.animation.addByPrefix('Out', "ClaqueteOut", 24, false);

        add(claquete);
    }

    public function TransIn()
    {
        claquete.animation.play('In');

        if (claquete.animation.curAnim.finished) {
            claquete.animation.play('Loop');
        }
    }

    public function TransOut()
        {
            claquete.animation.play('Out');
        }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}