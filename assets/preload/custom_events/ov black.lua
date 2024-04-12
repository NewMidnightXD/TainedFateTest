start = 0

finish = 0



function onCreate()
	      makeLuaSprite('flashblack', '', 0, 0);
                    makeGraphic('flashblack',1280,720,'000000')
	      addLuaSprite('flashblack', true);
	      setLuaSpriteScrollFactor('flashblack',0,0)
	      setProperty('flashblack.scale.x',2)
	      setProperty('flashblack.scale.y',2)
	      setProperty('flashblack.alpha',0)
                    setProperty('flashblack.alpha',0)
end

function onUpdate()

	if start == 1 then
	doTweenAlpha('alphaTween', 'flashblack', 1, 0.01)
	end

	if downscroll and start == 1 then
	doTweenAlpha('alphaTween', 'flashblack', 1, 0.01)
	end

	if finish == 2 then
	doTweenAlpha('alphaTween', 'flashblack', 0, 0.01)
	end

	if downscroll and finish == 2 then
	doTweenAlpha('alphaTween', 'flashblack', 0, 0.01)
	end

end

function onEvent(name,value1,value2)
	if name == 'ov black' then
		start = tonumber(value1)
		finish = tonumber(value2)
			end
	
		end
