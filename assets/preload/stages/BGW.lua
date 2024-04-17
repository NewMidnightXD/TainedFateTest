--Create with TieGuo's Lua Stage Editor
function onCreate()
makeLuaSprite('BG_white', 'BG_white', -1100, -760)
addLuaSprite('BG_white', false)
scaleObject('BG_white', 1, 1)
setScrollFactor('BG_white', 1, 1)
endctor('BG_white', 1, 1)

makeLuaSprite('2', dir .. 'vignette')
	scaleObject('2', 4.5, 4.5)
	screenCenter("2")
end