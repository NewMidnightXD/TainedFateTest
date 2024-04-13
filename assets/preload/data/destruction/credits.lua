local chartCredtis = {
    composer = {"Seotoo"},
    charter = {"Ent"},
    artist = {"Ent", "SP"},
    animator = {"DC_Gaonuri", "Ent", "Fun5t4r", "Gamemon"},
    programmer = {"bpforest", "Ent"}
}

function onCreate()
    require("mods.scripts.credits")
end

function onSongStart()
    showCredit(chartCredtis)
end