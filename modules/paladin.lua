local addonName, addon = ...

if addon.playerClass == "PALADIN" then
	-- Sacred Duty
	local sacredDutyDuration = 15
	local sacredDutyBar = addon:CreateBar("player", 85433, sacredDutyDuration, 6)
	sacredDutyBar.colors = {{200/255, 0/255, 0/255}}
	sacredDutyBar.label:Hide()
end