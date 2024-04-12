function onUpdate()
	if start == 1 then
		setProperty("healthBar.alpha", 0)
		setProperty("iconP1.alpha", 0)
		setProperty("iconP2.alpha", 0)
		setProperty("timeBar.alpha", 0)
		setProperty("timeTxt.alpha", 0)
	end

	if finish == 2 then
		setProperty("healthBar.alpha", 1)
		setProperty("iconP1.alpha", 1)
		setProperty("iconP2.alpha", 1)
		setProperty("timeBar.alpha", 1)
		setProperty("timeTxt.alpha", 1)
	end
end

function onEvent(name, value1, value2)
	if name == 'healt' then
		start = tonumber(value1)
		finish = tonumber(value2)
	end
end
