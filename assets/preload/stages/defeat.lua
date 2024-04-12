local dir = "BG/defeat/"

function onCreate()
	-- addLuaScript("scripts/ex/BeatInfo")
	runHaxeCode([[
        game.initLuaShader('blur');

		setVar("shaders", {});
		var shaders = getVar("shaders");

		shaders.blur = game.createRuntimeShader('blur');

        game.camGame.setFilters([new ShaderFilter(shaders.blur)]);

        shaders.blur.setFloat('blurAmount', 16);
		shaders.blur.setFloat("iTime", 0);
    ]])

	makeLuaSprite('defBG', 'BG/defBG', -2600, -400)
	scaleObject('defBG', 2.5, 1.6)
	setBlendMode('defBG', 'add')

	makeLuaSprite('def', 'BG/def', 300, -250)
	scaleObject('def', 1.5, 1.5)

	makeLuaSprite('1')
	makeGraphic("1", 1, 1)
	scaleObject("1", 2560, 1440)
	setScrollFactor("1", 0, 0)
	screenCenter("1")

	makeLuaSprite('2', dir .. 'vignette')
	scaleObject('2', 4.5, 4.5)
	screenCenter("2")

	--연출
	makeLuaSprite('D1', dir .. 'sceneBkBg', -640)
	setObjectCamera("D1", "hud")

	makeAnimatedLuaSprite('BK', dir .. 'sceneBk', -640 - 440, 20)
	addAnimationByPrefix('BK', 'i', 'black_rad idle', 10, false)
	addAnimationByPrefix('BK', '0', 'black_rad left', 10, false)
	addAnimationByPrefix('BK', '1', 'black_rad down', 10, false)
	addAnimationByPrefix('BK', '2', 'black_rad up', 10, false)
	addAnimationByPrefix('BK', '3', 'black_rad right', 10, false)
	objectPlayAnimation('BK', 'i', true)
	setObjectCamera("BK", "hud")
	scaleObject('BK', 1.5, 1.5)

	makeLuaSprite('D2', dir .. 'sceneBfBg', 1280)
	setObjectCamera("D2", "hud")

	makeAnimatedLuaSprite('BB', dir .. 'sceneBf', 1280 - 380, 0)
	addAnimationByPrefix('BB', 'i', 'BF_blue idle', 10, false)
	addAnimationByPrefix('BB', '0', 'BF_blue left', 10, false)
	addAnimationByPrefix('BB', '1', 'BF_blue down', 10, false)
	addAnimationByPrefix('BB', '2', 'BF_blue up', 10, false)
	addAnimationByPrefix('BB', '3', 'BF_blue right', 10, false)
	objectPlayAnimation('BB', 'i', true)
	setObjectCamera("BB", "hud")
	scaleObject('BB', 1.5, 1.5)

	-- 페이즈 2
	makeLuaSprite('parBG', dir .. 'parBG', -1200, -400)
	scaleObject('parBG', 3, 2.3)
	setBlendMode('parBG', 'add')

	makeLuaSprite('par', 'BG/fi/8', -400, -250)
	scaleObject('par', 0.5, 0.5)

	--정리
	addLuaSprite('1')
	addLuaSprite('2', true)
	-- setProperty('camHUD.alpha', 0)
end

function onUpdate()
	if 5 <= misses then
		setProperty("health", -1)
	end
end

function onStepHit()
	if curStep == 1 then
		runHaxeCode([[
			var shaders = getVar("shaders");
			FlxTween.num(16, 0, 5, {ease: FlxEase.sineInOut}, function(num) { shaders.blur.setFloat('blurAmount', num); });
		]])
	end
	if curStep == 27 then
		doTweenAlpha('camhudreturn', 'camHUD', 1, 0.2)
	end
	if curStep == 120 then
		addLuaSprite('D1')
		addLuaSprite('BK')
		addLuaSprite('D2')
		addLuaSprite('BB')
		doTweenX("TweenTag", "D1", 0, 1, "cubeOut")
		doTweenX("TweenTag1", "BK", 0 - 440, 1, "cubeOut")
		doTweenX("TweenTag2", "D2", 640, 1, "cubeOut")
		doTweenX("TweenTag4", "BB", 640 - 380, 1, "cubeOut")
	end
	if curStep == 144 then
		addLuaSprite('def')
		addLuaSprite('defBG', true)
		setProperty("1.alpha", 0)
		setProperty("2.alpha", 0)
		doTweenX("TweenTag", "D1", -640, 2, "cubeOut")
		doTweenX("TweenTag1", "BK", -640 - 440, 2, "cubeOut")
		doTweenX("TweenTag2", "D2", 1280, 2, "cubeOut")
		doTweenX("TweenTag4", "BB", 1280 - 380, 2, "cubeOut")
		runHaxeCode([[
			game.camGame.setFilters([]);
		]])
	end
	if curStep == 176 then
		removeLuaSprite("D1")
		removeLuaSprite("BK")
		removeLuaSprite("D2")
		removeLuaSprite("BB")
	end
	if curStep == 1040 then
		setProperty("boyfriend.color", getColorFromHex("000000"))
		setProperty("dad.color", getColorFromHex("000000"))
		setProperty("defBG.alpha", 0)
		setProperty("def.alpha", 0)
		setProperty("1.alpha", 1)
		runHaxeCode([[
			var shaders = getVar("shaders");
			game.camGame.setFilters([new ShaderFilter(shaders.blur)]);
		]])
		runTimer("blurEffect2", 0)
	end
	if curStep == 1296 then
		setProperty("boyfriend.color", getColorFromHex("ffffff"))
		setProperty("dad.color", getColorFromHex("ffffff"))
		setProperty("defBG.alpha", 1)
		setProperty("def.alpha", 1)
		removeLuaSprite("1")
		runHaxeCode([[
			game.camGame.setFilters([]);
		]])
		cancelTimer("blurEffect")
		cancelTimer("blurEffect2")
	end
	if curStep == 1360 then
		removeLuaSprite("defBG")
		removeLuaSprite("def")
		addLuaSprite("par")
		addLuaSprite("parBG", true)
	end
end

function onTimerCompleted(tag)
	if tag == "blurEffect" then
		runHaxeCode([[
			var shaders = getVar("shaders");
			FlxTween.num(32, 0, 3, {ease: FlxEase.sineIn}, function(num) { shaders.blur.setFloat('blurAmount', num); });
		]])
		runTimer("blurEffect2", 3)
	end
	if tag == "blurEffect2" then
		runHaxeCode([[
			var shaders = getVar("shaders");
			FlxTween.num(0, 32, 3, {ease: FlxEase.sineOut}, function(num) { shaders.blur.setFloat('blurAmount', num); });
		]])
		runTimer("blurEffect", 3)
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	objectPlayAnimation('BK', tostring(direction))
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	objectPlayAnimation('BB', tostring(direction))
end
