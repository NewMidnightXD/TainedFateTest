function onEvent(name, v1, v2)
	if name == "Flash Red" then
		if v1 == "" then
			v1 = .5
		end
		setProperty("redFlash.alpha", .5)
		doTweenAlpha("redFlashAlphaTW", "redFlash", 0, v1)
	end
end

function onCreate()
	makeLuaSprite("redFlash")
	makeGraphic("redFlash", 1, 1, "E90000")
	scaleObject("redFlash", 1280, 720)
	setBlendMode("redFlash", "add")
	setObjectCamera("redFlash", "other")
	setProperty("redFlash.alpha", 0)
	addLuaSprite("redFlash")
end
