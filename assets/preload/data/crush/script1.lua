local chartCredtis = {
    composer = {"Ra_TanG"},
    charter = {"bpforest", "Ent"},
    artist = {"Ent"},
    animator = {"Ent"},
    programmer = {"bpforest", "Ent"}
}

function onCreate()
    require("mods.scripts.credits")
end

function onSongStart()
    showCredit(chartCredtis)
end
