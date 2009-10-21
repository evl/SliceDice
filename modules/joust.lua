-- Defend
local defendDuration = 60
local defendBar = evl_SliceDice:CreateBar("vehicle", "Defend", defendDuration, 19)
defendBar:SetStatusBarTexture("Interface\\AddOns\\evl_SliceDice\\media\\HalT")
defendBar.colors = {{200/255, 0/255, 0/255}, {200/255, 200/255, 0/255}, {0/255, 200/255, 0/255}}
