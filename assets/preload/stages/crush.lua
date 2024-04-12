local dir = "BG/crush/"
local bgLoc = {-1550, -600}

function onCreate()
	runHaxeCode([[
        game.initLuaShader('blur');

		setVar("shaders", {});
		var shaders = getVar("shaders");

		shaders.blur = game.createRuntimeShader('blur');

        game.camGame.setFilters([new ShaderFilter(shaders.blur)]);

        shaders.blur.setFloat('blurAmount', 0);
		shaders.blur.setFloat("iTime", 0);
    ]])
	makeLuaSprite("1", dir .. "1", bgLoc[1], bgLoc[2])
	scaleObject("1", 1.5, 1.5)
	setScrollFactor("1", 0.4, 0.4)

	makeAnimatedLuaSprite("2", dir .. "2", bgLoc[1], bgLoc[2])
	addAnimationByPrefix("2", "idle", "2 idle", 2)
	scaleObject("2", 1.5, 1.5)
	setScrollFactor("2", 0.8, 0.8)

	makeLuaSprite("3", dir .. "3", bgLoc[1], bgLoc[2])
	scaleObject("3", 1.5, 1.5)

	makeLuaSprite("4", dir .. "4", bgLoc[1], bgLoc[2])
	scaleObject("4", 1.5, 1.5)

	makeLuaSprite("5", dir .. "5", bgLoc[1], bgLoc[2])
	scaleObject("5", 1.5, 1.5)

	makeLuaSprite("6", dir .. "6", bgLoc[1], bgLoc[2])
	scaleObject("6", 1.5, 1.5)
	setProperty("6.alpha", 1)
	setBlendMode("6", "add")

	makeLuaSprite("7", dir .. "5", bgLoc[1], bgLoc[2])
	scaleObject("7", 1.5, 1.5)

	makeLuaSprite("logo", dir .. "logo")
	setObjectCamera("logo", "hud")
	scaleObject("logo", 0.6, 0.6)
	setProperty("logo.alpha", 0)
	screenCenter("logo")

	makeAnimatedLuaSprite("white", dir .. "wd")
	addAnimationByPrefix("white", "idle", "wd idle", 24, false)
	scaleObject("white", 2, 2)
	setObjectCamera("white", "hud")
	screenCenter("white")

	makeAnimatedLuaSprite("boom", dir .. "p")
	addAnimationByPrefix("boom", "idle", "p idle", 24, false)
	scaleObject("boom", 15, 15)
	setProperty("boom.antialiasing", false)
	setObjectCamera("boom", "hud")
	screenCenter("boom")

	--정리
	addLuaSprite("1")
	addLuaSprite("2")
	addLuaSprite("3")
	addLuaSprite("4")
	addLuaSprite("5", true)
	addLuaSprite("6", true)
	addLuaSprite("7", true)
	addLuaSprite("logo")
	for i = 0, 19 do
		local leaveName = "leave" .. i
		makeLuaSprite(leaveName, dir .. "leave", -2000)
		setScrollFactor(leaveName, .4, .4)
		setObjectOrder(leaveName, 2)
		scaleObject(leaveName, .05, .05)
		setProperty(leaveName .. ".color", getColorFromHex("ff9100"))
		addLuaSprite(leaveName)
		runTimer(leaveName, getRandomFloat(0.2, 2))
	end
end

function onTimerCompleted(tag)
	if stringStartsWith(tag, "leave") then
		setProperty(tag .. ".x", getRandomInt(-1280, 640))
		setProperty(tag .. ".y", -500)
		setProperty(tag .. ".angle", 0)
		local leaveTime = getRandomInt(7, 12)
		doTweenX(tag .. "XTW", tag, getProperty(tag .. ".x") + getRandomInt(1500, 2000), leaveTime)
		doTweenY(tag .. "YTW", tag, 500, leaveTime)
		doTweenAngle(tag .. "AngleTW", tag, getRandomInt(50, 230), leaveTime)
		runTimer(tag, leaveTime)
	end
end

function onStepHit()
	if curStep == 1 then
		doTweenAlpha("logoAlphaTween", "logo", 1, 1, "sineOut")
		runHaxeCode([[
			var shaders = getVar("shaders");
			FlxTween.num(0, 16, 1, {ease: FlxEase.linear}, function(num) { shaders.blur.setFloat("blurAmount", num); });
		]])
	end
	if curStep == 20 then
		doTweenAlpha("logoAlphaTween", "logo", 0, 1, "sineIn")
		runHaxeCode([[
			var shaders = getVar("shaders");
			FlxTween.num(16, 0, 1, {ease: FlxEase.linear}, function(num) { shaders.blur.setFloat("blurAmount", num); });
		]])
	end
	if curStep == 568 then
		addLuaSprite("white")
		objectPlayAnimation("white", "idle")
	end
	if curStep == 572 then
		removeLuaSprite("white")
		addLuaSprite("boom")
		objectPlayAnimation("boom", "idle")
	end
end