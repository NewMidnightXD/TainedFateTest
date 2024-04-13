local creditBox = {
    text = "",
    width = 600,
    height = 720,
    padding = 10
}

function onCreate()
    makeLuaSprite("creditBG", nil, (1280 - creditBox.width) / 2, 0)
    makeGraphic("creditBG", creditBox.width, creditBox.height, "000000")
    setProperty("creditBG.alpha", 0)
    setObjectCamera("creditBG", "other")
    makeLuaText("credit", nil, creditBox.width, (1280 - creditBox.width) / 2, creditBox.padding)
    setTextSize("credit", 24)
    setTextAlignment("credit", "center")
    setObjectCamera("credit", "other")
    setProperty("credit.y", -creditBox.height + creditBox.padding)

    addLuaSprite("creditBG")
    addLuaText("credit")
end

function showCredit(creditArray)
    local creditNames = {
        ["composer"] = "Composer",
        ["charter"] = "Charter",
        ["artist"] = "Artist",
        ["animator"] = "Animator",
        ["programmer"] = "Programmer"
    }
    for job, people in pairs(creditArray) do
        creditBox.text = creditBox.text .. "\n" .. creditNames[job] .. "\n"
        for _, person in pairs(people) do
            creditBox.text = creditBox.text .. "\n" .. person
        end
        creditBox.text = creditBox.text .. "\n\n"
    end
    setTextString("credit", creditBox.text)
    doTweenAlpha("creditBGAlphaTween", "creditBG", .5, 1.5, "quadOut")
    doTweenY("creditYTween", "credit", creditBox.padding, 1.5, "quadOut")
    runTimer("creditEnd", 5)
end

function onTimerCompleted(tag)
    if tag == "creditEnd" then
        doTweenAlpha("creditBGAlphaTween", "creditBG", 0, 1.5, "quadIn")
        doTweenY("creditYTween", "credit", creditBox.height + creditBox.padding, 1.5, "quadIn")
    end
end
