local angleshit = 0.5;
local anglevar = 0.3;
local highlight = false;
local xx = 1200;
local yy = 360;

function onStepHit()
	if curBeat > 63.8 and curBeat < 95.1 then
	for i = 0,7 do
		if curStep % 4 == 0 then
			--noteTweenY('balls'..i, i, 0, stepCrochet*0.002, 'circOut')
			doTweenY("beep", "camHUD", 0, stepCrochet*0.002, 'circOut')
		end
		if curStep % 4 == 2 then
			--noteTweenY('ballsthesecond'..i, i, 25, stepCrochet*0.002, 'sineIn')
			doTweenY("beep2", "camHUD", 25, stepCrochet*0.002, 'sineIn')
		end
	end
	end
end

function onBeatHit()
	if curBeat > 63.8 and curBeat < 95.1 then
		triggerEvent('Add Camera Zoom', 0.04,0.05)

	    	if curBeat % 2 == 0 then
			angleshit = anglevar;
	    	else
			angleshit = -anglevar;
	    	end
	    	setProperty('camHUD.angle',angleshit*7)
	    	setProperty('camGame.angle',angleshit*7)
	    	doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
	    	doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.001, 'linear')
	    	doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut')
	    	doTweenX('ttrn', 'camGame', -angleshit*8, crochet*0.001, 'linear')
	    else
	    	setProperty('camHUD.angle',0)
	    	setProperty('camHUD.x',0)
	    	setProperty('camHUD.x',0)
		doTweenY("cam", "camHUD", 0, stepCrochet*0.002, 'circOut')
	   end
	end

function onUpdate()
    --setPropertyFromClass("openfl.Lib", "application.window.y", getPropertyFromGroup('playerStrums', 0, 'y') + 150)
end
