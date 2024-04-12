local chromFreq = 0
local chromAmount = 0
function onCreate()
	runHaxeCode([[
		game.initLuaShader('chromabber');
		shader0 = game.createRuntimeShader('chromabber');
		game.camGame.setFilters([new ShaderFilter(shader0)]);
		shader0.setFloat('amount',0);
		]])
end
function onEvent(n,v1,v2)
	if n == 'chromToggle' then
		chromAmount = tonumber(v1)
		chromFreq = tonumber(v2)
		isChrom = true
		if v1 == '0' and v2 == '0' then
			isChrom = false
		end
	end
end
function onBeatHit()
	if curBeat % chromFreq == 0 and isChrom then
		runHaxeCode([[
			var guhTween:FlxTween;

			if (guhTween != null) guhTween.cancel();
		 	guhTween = FlxTween.num(]]..chromAmount..[[, 0, 0.45, {ease: FlxEase.sineOut}, function(num) { shader0.setFloat('amount',num); });
		]])
	end
end