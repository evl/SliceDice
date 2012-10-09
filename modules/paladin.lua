local addonName, addon = ...

if addon.playerClass == "PALADIN" then

	if config.debug then
		DEFAULT_CHAT_FRAME:AddMessage("> Loaded " .. addon.playerClass .. " module" ,1,0,0)
	end

	-- Sacred Duty
	local sacredDutyDuration = 15
	local sacredDutyBar = addon:CreateBar("player", 85433, sacredDutyDuration, 6)
	sacredDutyBar.colors = {{200/255, 0/255, 0/255}}
	sacredDutyBar.label:Hide()
	
	-- Art of War
	local artOfWarDuration = 15
	local artOfWarBar = addon:CreateBar("player", 59578, artOfWarDuration, 6)
	artOfWarBar.colors = {{200/255, 0/255, 0/255}}
	artOfWarBar.label:Hide()
end
