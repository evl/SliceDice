local addonName, addon = ...

if addon.playerClass == "WARRIOR" then
	
	if config.debug then
		DEFAULT_CHAT_FRAME:AddMessage("> Loaded " .. addon.playerClass .. " module" ,1,0,0)
	end
	
	-- Hamstring
	local hamstringDuration = 15
	local hamstringBar = addon:CreateBar("target", 1715, hamstringDuration, 6)
	hamstringBar.label:Hide()
end
