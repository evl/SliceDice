local addonName, addon = ...

if addon.playerClass == "WARRIOR" then
	
	-- Hamstring
	local hamstringDuration = 15
	local hamstringBar = addon:CreateBar("target", 1715, hamstringDuration, 6)
	hamstringBar.label:Hide()
end