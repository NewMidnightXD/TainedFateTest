function onCreatePost()
    makeLuaText("stepText", "Step: ?\nBeat: ?", 1280, 2, 678)
    setTextAlignment("stepText", "left")
    setObjectCamera("stepText", "other")
    setTextSize("stepText", 20)
    addLuaText("stepText")
end

function onStepHit()
    setTextString("stepText", "Step: " .. curStep .. " (" .. curBeat * 4 .. ")\nBeat: " .. curBeat)
end
