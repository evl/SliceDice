local addonName, addon = ...

if addon.playerClass == "DEATHKNIGHT" then

	if config.debug then
		DEFAULT_CHAT_FRAME:AddMessage("> Loaded " .. addon.playerClass .. " module" ,1,0,0)
	end
	
	-- Blood Plague
	local bloodPlagueDuration = 30
	local bloodPlagueBar = addon:CreateBar("target", 59879, bloodPlagueDuration, 6)
	bloodPlagueBar.colors = {{200/255, 0/255, 0/255}}
	bloodPlagueBar.label:Hide()

	-- Frost Fever
	local frostFeverDuration = 30
	local frostFeverBar = addon:CreateBar("target", 59921, frostFeverDuration, 6)
	frostFeverBar.colors = {{0/255, 100/255, 150/255}}
	frostFeverBar.label:Hide()
	
	-- Horn of Winter
	local hornOfWinterDuration = 300
	local hornOfWinterBar = addon:CreateBar("player", 57330, hornOfWinterDuration, 3)
	hornOfWinterBar.colors = {{200/255, 200/255, 200/255}}
	hornOfWinterBar.label:Hide()
end
