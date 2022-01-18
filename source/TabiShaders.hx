package;

import flixel.system.FlxAssets.FlxShader;

class ChromaticShader extends FlxShader
{
	@:glFragmentSource('
		#pragma header

		uniform float rOffset;
		uniform float gOffset;
		uniform float bOffset;

		void main()
		{
			vec4 col1 = texture2D(bitmap, openfl_TextureCoordv.st - vec2(rOffset, 0.0));
			vec4 col2 = texture2D(bitmap, openfl_TextureCoordv.st - vec2(gOffset, 0.0));
			vec4 col3 = texture2D(bitmap, openfl_TextureCoordv.st - vec2(bOffset, 0.0));
			vec4 toUse = texture2D(bitmap, openfl_TextureCoordv);
			toUse.r = col1.r;
			toUse.g = col2.g;
			toUse.b = col3.b;
			//float someshit = col4.r + col4.g + col4.b;

			gl_FragColor = toUse;
		}')
	
	public function new(chromeOffset:Float)
		{	
			super();
			this.rOffset.value = [chromeOffset / 1000];
			this.gOffset.value = [0.0];
			this.bOffset.value = [chromeOffset / 1000 * -1];	
		}
}

/* class Shockwave extends FlxShader
{
	@:glFragmentSource('
		#pragma header

		uniform float radius;
		uniform float scale;
		uniform float centerX;
		uniform float centerY;
		uniform float texOffset;
		
		void main()
		{
			//openfl_TextureCoordv.st += vec2(scale, 0.0);
			vec4 daFrag = texture2D(bitmap, openfl_TextureCoordv);
		
			if (radius == 0)
			{
				daFrag.r = -daFrag.r;
				daFrag.g = -daFrag.g;
				daFrag.b = -daFrag.b;
			}
		
			if (daFrag.x > centerX + radius && daFrag.x + openfl_TextureSize.x < daFrag.x + texOffset)
			{
				//daFrag.x += scale;
				daFrag.r = -daFrag.r;
				daFrag.g = -daFrag.g;
				daFrag.b = -daFrag.b;
			}
			
			if (daFrag.x < centerX - radius && daFrag.x - openfl_TextureSize.x > daFrag.x - texOffset)
			{
				//daFrag.x -= scale;
				daFrag.r = -daFrag.r;
				daFrag.g = -daFrag.g;
				daFrag.b = -daFrag.b;
			}
			
			if (daFrag.y > centerY + radius && daFrag.y + openfl_TextureSize.y < daFrag.y + texOffset)
			{
				//daFrag.y += scale;
				daFrag.r = -daFrag.r;
				daFrag.g = -daFrag.g;
				daFrag.b = -daFrag.b;
			}
			
			if (daFrag.y < centerY - radius && daFrag.y - openfl_TextureSize.y > daFrag.y - texOffset)
			{
				//daFrag.y -= scale;
				daFrag.r = -daFrag.r;
				daFrag.g = -daFrag.g;
				daFrag.b = -daFrag.b;
			}
			
			gl_FragColor = daFrag;
		}')
	public function new(valName:String, valueData:Array<Float>)
	{
		super();
			
		switch(valName)
		{
			case "texOffset":
				this.texOffset.value = valueData;
			case "centerX":
				this.centerX.value = valueData;
			case "centerY":
				this.centerY.value = valueData;
			case "radius":
				this.radius.value = valueData;
			case "scale":
				this.scale.value = valueData;
		}
	}
} */