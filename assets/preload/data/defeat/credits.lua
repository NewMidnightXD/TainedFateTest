local chartCredtis = {
    composer = {"Choma41"},
    charter = {"Reied"},
    artist = {"Ent"},
    animator = {"DC_Gaonuri", "Ent", "Fun5t4r", "Gamemon", "Ra_TanG"},
    programmer = {"bpforest", "Ent"}
}

function onCreate()
    require("mods.scripts.credits")
end

function onSongStart()
    showCredit(chartCredtis)
end