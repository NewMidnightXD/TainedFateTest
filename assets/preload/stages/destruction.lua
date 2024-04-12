local dir = "BG/"
local glitchNote = false
local deathTarget
local defaultTitle = "Vs. Impostor: Tainted Fate"

local function setDeathTarget(target) -- 죽음 대상 설정
	if target == "bf" then
		setProperty("instakillOnMiss", false)
		deathTarget = target
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf_des_p_death')
	elseif target == "black" or target == "black2" then
		setProperty("instakillOnMiss", true)
		deathTarget = target
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'black_des_p')
	elseif target == nil then
		setProperty("instakillOnMiss", false)
		deathTarget = target
	end
end

local function setWindowTitle(title) -- 창 제목 설정
	setPropertyFromClass("openfl.Lib", "application.window.title", title)
end

function onCreate()
	-- addLuaScript("scripts/ex/BeatInfo")
	setDeathTarget("bf")
	addCharacterToList("bf_des3", "dad")
	precacheSound("game_over")
	runHaxeCode([[
        game.initLuaShader('blur');
        game.initLuaShader('glitch');
        game.initLuaShader('chromatic');

		setVar("shaders", {});
		var shaders = getVar("shaders");

		shaders.blur = game.createRuntimeShader('blur');
        shaders.glitch = game.createRuntimeShader("glitch");
        shaders.chromatic = game.createRuntimeShader("chromatic");

        game.camGame.setFilters([new ShaderFilter(shaders.blur), new ShaderFilter(shaders.glitch), new ShaderFilter(shaders.chromatic)]);
		game.camHUD.setFilters([new ShaderFilter(shaders.glitch)]);

        shaders.blur.setFloat('blurAmount', 16);
		shaders.blur.setFloat("iTime", 0);
		shaders.glitch.setFloat("iTime", 0);
        shaders.glitch.setFloat("iMouseX", 0);
        shaders.glitch.setInt("NUM_SAMPLES", 3);
        shaders.glitch.setFloat("glitchMultiply", 0);
        shaders.chromatic.setFloat("amount", 0);
    ]])

	makeLuaSprite('whiteBG', nil, -2000, -2000)
	makeGraphic("whiteBG", 1, 1, "FFFFFF")
	scaleObject("whiteBG", 8000, 4000)

	makeLuaSprite('vicBG', dir .. 'vicBG', -1600, -250)

	makeLuaSprite('vic', dir .. 'vic', 300, -250)
	scaleObject('vic', 1.5, 1.5)

	makeLuaSprite('defBG', dir .. 'defBG', -2600, -400)
	scaleObject('defBG', 2.5, 1.6)

	makeLuaSprite('def', dir .. 'def', 300, -250)
	scaleObject('def', 1.5, 1.5)

	makeLuaSprite('bfStand', dir .. 'BF_1', -400, 270)
	scaleObject('bfStand', 2.2, 2.2)

	makeAnimatedLuaSprite('bfGetdown', dir .. 'BF_3', -1100, 270)
	addAnimationByPrefix('bfGetdown', 'idle', 'BF_3 idle', 12, false)
	scaleObject('bfGetdown', 2.2, 2.2)

	makeAnimatedLuaSprite('bfKill', dir .. 'BF_4', -1150, -1350)
	addAnimationByPrefix('bfKill', 'idle', 'BF_4 idle', 15, false)
	scaleObject('bfKill', 4.5, 4.5)

	makeAnimatedLuaSprite('kill', dir .. 'kill', -1300, -750)
	addAnimationByPrefix('kill', 'emdwkd', 'kill emdwkd', 50, false)
	addAnimationByPrefix('kill', 'idle', 'kill idle', 25, true)
	addAnimationByPrefix('kill', 'xhlwkd', 'kill xhlwkd', 20, false)
	objectPlayAnimation('kill', 'idle', true)
	setScrollFactor('kill', 0, 0)
	scaleObject('kill', 4, 4)

	makeLuaSprite('Q', dir .. 'Q', 20, downscroll and 50 or 480)
	scaleObject("Q", 0.5, 0.5)
	setObjectCamera("Q", "hud")

	makeLuaSprite('P', dir .. 'P', 1080, downscroll and 50 or 440)
	scaleObject("P", 0.5, 0.5)
	setObjectCamera("P", "hud")

	makeLuaSprite('dark')
	makeGraphic("dark", 1, 1, "000000")
	scaleObject("dark", 1280, 720)
	setObjectCamera("dark", "other")

	--피날레
	for i = 1, 8 do
		makeLuaSprite(i, dir .. 'fi/' .. i, -1500, -1000)
		scaleObject(i, 1.2, 1.2)
	end

	--정리
	addLuaSprite('vicBG')
	addLuaSprite('vic')
	addLuaSprite('Q')
	addLuaSprite('P')
	addLuaSprite('dark')

	setProperty('camHUD.alpha', 0)
end

function onDestroy() -- 장면 제거
	setWindowTitle(defaultTitle)
end

local playVideo = true
function onEndSong()
	if playVideo then
		playVideo = false
		startVideo("dumb")
		return Function_Stop
	end
end

local canDeath = false
local stopMusic = false
function onGameOver() -- 뒤졌을 때
	if not canDeath then
		canDeath = true
		stopMusic = true
		setHealth(1)
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
		setProperty('vocals.volume', 0)
		if deathTarget == "bf" then
			triggerEvent("Change Character", "boyfriend", "bf_des_p_death")
			characterPlayAnim("boyfriend", "pre_death")
			doTweenAlpha("camHUDAlphaTW", "camHUD", 0, .5)
			doTweenAlpha("vicAlphaTW", "vic", 0, .5)
			doTweenAlpha("vicBGAlphaTW", "vicBG", 0, .5)
			doTweenAlpha("dadAlphaTW", "dad", 0, .5)
			runTimer("death", 2)
		elseif deathTarget == "black" or deathTarget == "black2" then
			triggerEvent("Change Character", "dad", "bf_des_kill")
			doTweenAlpha("camHUDAlphaTW", "camHUD", 0, .5)
			playSound("game_over")
			if deathTarget == "black" then
				characterPlayAnim("dad", "des_pre_kill")
				runTimer("des_pre_kill", .9)
			else
				characterPlayAnim("dad", "des2_pre_kill")
				cameraSetTarget("boyfriend")
				runTimer("des2_pre_kill", .9)
			end
			runTimer("black_pre_death", .6)
			runTimer("death", 1.3)
		end
		return Function_Stop
	end
end

local writing = {
	sentence = "You never can be me.",
	position = 0,
	running = false
}

function onTimerCompleted(tag)
	if tag == "des_pre_kill" then
		characterPlayAnim("dad", "des_kill")
	end
	if tag == "des2_pre_kill" then
		triggerEvent("Cam Zoom Tween", .7, .5)
		doTweenX("dadXTW", "dad", 500, .2, "quadIn")
		characterPlayAnim("dad", "des2_kill")
	end
	if tag == "black_pre_death" then
		characterPlayAnim("boyfriend", "pre_death")
	end
	if tag == "death" then
		setWindowTitle(defaultTitle)
		setHealth(-1)
	end
	if tag == "writing" then
		writing.position = writing.position + 1
		setWindowTitle(string.sub(writing.sentence, 1, writing.position))
	end
	if tag == "deleteWriting" then
		writing.position = writing.position - 1
		setWindowTitle(string.sub(writing.sentence, 1, writing.position))
	end
end

function onUpdate()
	if deathTarget == nil then
		if getHealth() < 0.2 then
			setHealth(0.2)
		end
	elseif deathTarget == "bf" then
		if 4 <= getMisses() then
			setProperty("instakillOnMiss", true)
		end
	end
	if stopMusic then
		setPropertyFromClass('Conductor', 'songPosition', 0)
		setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
		setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
	end
end

function onBeatHit()
	if curBeat == 4 then
		doTweenAlpha("darkAlphaTween", "dark", 0, .5)
		runHaxeCode([[
			var shaders = getVar("shaders");
			FlxTween.num(16, 0, 5, {ease: FlxEase.sineInOut}, function(num) { shaders.blur.setFloat('blurAmount', num); });
		]])
	end
	if curBeat == 28 then
		doTweenAlpha("camHUDAlphaTween", "camHUD", 1, .5)
	end
	-- 스왑
	if curBeat == 112 then
		setDeathTarget(nil)
		if not middlescroll then
			noteTweenX("NoteTweenX1", 0, 732, .3, "quadInOut")
			noteTweenX("NoteTweenX2", 1, 844, .3, "quadInOut")
			noteTweenX("NoteTweenX3", 2, 956, .3, "quadInOut")
			noteTweenX("NoteTweenX4", 3, 1064, .3, "quadInOut")
			noteTweenX("NoteTweenX5", 4, 92, .3, "quadInOut")
			noteTweenX("NoteTweenX6", 5, 204, .3, "quadInOut")
			noteTweenX("NoteTweenX7", 6, 316, .3, "quadInOut")
			noteTweenX("NoteTweenX8", 7, 428, .3, "quadInOut")
		end
	end
	if curBeat == 182 then -- 페이즈 2
		setDeathTarget("black")
		glitchNote = true
		removeLuaSprite("vicBG", false)
		removeLuaSprite("vic", false)
		addLuaSprite("defBG")
		addLuaSprite("def")
		runHaxeCode([[
			var shaders = getVar("shaders");
			shaders.chromatic.setFloat("amount", 0.5);
			game.camGame.setFilters([new ShaderFilter(shaders.glitch), new ShaderFilter(shaders.chromatic)]);
		]])
	end
	if curBeat == 316 then
		doTweenY("QYTween", "Q", 1200, 3, "quadInOut")
		doTweenY("PYTween", "P", 1500, 3, "quadInOut")
		doTweenAlpha('QAlphaTween', 'Q', 0, 1)
		doTweenAlpha('PAlphaTween', 'P', 0, 1)
	end
	if curBeat == 320 then -- 블랙 혼자
		setDeathTarget(nil)
		glitchNote = false
		addLuaSprite('whiteBG')
		setProperty("dad.alpha", 0)
		runHaxeCode([[
			var shaders = getVar("shaders");
			shaders.chromatic.setFloat("amount", 0);
		]])
	end
	if curBeat == 368 then -- 블러 효과
		addLuaSprite("bfStand")
		doTweenX("TweenTag2", "bfStand", -1100, 4, "quadInOut")
		doTweenX("TweenTag1", "boyfriend", 800, 4, "quadInOut")
		doTweenAlpha("whiteBGAlphaTween", "whiteBG", 0, 4)
	end
	if curBeat == 378 then
		removeLuaSprite("bfStand")
		addLuaSprite("bfGetdown")
		objectPlayAnimation("bfGetdown", "idle")
	end
	if curBeat == 380 then
		removeLuaSprite("bfGetdown")
	end
	if curBeat == 382 then -- 뒤질 준비
		glitchNote = true
		removeLuaSprite("whiteBG")
		addLuaSprite("kill")
		addLuaSprite("bfKill")
		objectPlayAnimation("kill", "idle")
		objectPlayAnimation("bfKill", "idle")
		runHaxeCode([[
			var shaders = getVar("shaders");
			shaders.chromatic.setFloat("amount", 0.5);
		]])
	end
	if curBeat == 384 then -- 페이즈 3 전
		glitchNote = false
		removeLuaSprite("kill")
		removeLuaSprite("bfKill")
		removeLuaSprite("defBG", false)
		removeLuaSprite("def", false)
		addLuaSprite("vicBG")
		addLuaSprite("vic")
		setProperty("dad.alpha", 1)
		runHaxeCode([[
			var shaders = getVar("shaders");
			shaders.chromatic.setFloat("amount", 0);
		]])
	end
	if curBeat == 388 then -- 페이즈 3
		setDeathTarget("black")
		glitchNote = true
		removeLuaSprite("vicBG")
		removeLuaSprite("vic")
		addLuaSprite("defBG")
		addLuaSprite("def")
		runHaxeCode([[
			var shaders = getVar("shaders");
			shaders.chromatic.setFloat("amount", 1);
		]])
	end
	if curBeat == 453 then
		writing.position = string.len(getPropertyFromClass("openfl.Lib", "application.window.title"))
		runTimer("deleteWriting", .02, string.len(writing.sentence))
	end
	if curBeat == 455 then
		writing.position = 0
		runTimer("writing", .1, string.len(writing.sentence))
	end
	if curBeat == 460 then
		setProperty("dark.alpha", 1)
	end
end

function onStepHit()
	if curStep == 1566 then -- 페이즈 3 배경
		setDeathTarget("black2")
		removeLuaSprite("defBG")
		removeLuaSprite("def")
		addLuaSprite('1')
		addLuaSprite('2')
		addLuaSprite('3')
		addLuaSprite('4')
		addLuaSprite('5')
		addLuaSprite('6', true)
		addLuaSprite('7', true)
		addLuaSprite('8')
		setProperty("dad.x", 1000)
	end
end

function opponentNoteHit()
	if not glitchNote then return end
	runHaxeCode([[
		var shaders = getVar("shaders");
		FlxTween.num(]] ..
	getRandomInt(0.1, 7) ..
	[[, 0, 0.1, {ease: FlxEase.linear}, function(num) { shaders.glitch.setFloat("glitchMultiply", num); });
	]])
end
