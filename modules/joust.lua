local addonName, addon = ...

if addon.config.debug then
	DEFAULT_CHAT_FRAME:AddMessage("> Loaded joust module" ,1,0,0)
end

-- Defend
local defendDuration = 60
local defendBar = addon:CreateBar("vehicle", 62552, defendDuration, 19)
defendBar.colors = {{200/255, 0/255, 0/255}, {200/255, 200/255, 0/255}, {0/255, 200/255, 0/255}}
