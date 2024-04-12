function onEvent(n,v1,v2)


	if n == 'add Flash' then

	   makeLuaSprite('flash', '', 0, 0);
        makeGraphic('flash',1280,720,'ffffff')
	      addLuaSprite('flash', true);
	      setLuaSpriteScrollFactor('flash',0,0)
	      setProperty('flash.scale.x',2)
	      setProperty('flash.scale.y',2)
	      setProperty('flash.alpha',0)
	      setBlendMode('flash', 'add')
		setProperty('flash.alpha',0.3)
		doTweenAlpha('flTw','flash',0,v1,'linear')
		setObjectCamera('flash', 'other')
	end



end