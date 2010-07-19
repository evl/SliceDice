local addonName, addon = ...

-- Defend
local defendDuration = 60
local defendBar = addon:CreateBar("vehicle", 62552, defendDuration, 19)
defendBar.colors = {{200/255, 0/255, 0/255}, {200/255, 200/255, 0/255}, {0/255, 200/255, 0/255}}
