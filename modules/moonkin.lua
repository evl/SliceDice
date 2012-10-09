local addonName, addon = ...

if addon.playerClass == "DRUID" then

	if addon.config.debug then
		DEFAULT_CHAT_FRAME:AddMessage("> Loaded " .. addon.playerClass .. " module" ,1,0,0)
	end

	-- Moonfire
	local moonfireDuration = 14
	local moonfireBar = addon:CreateBar("target", 8921, moonfireDuration, 14)
	moonfireBar.colors = {{150/255, 0/255, 255/255}}

	-- Faerie Fire
	local faerieFireDuration = 300
	local faerieFireBar = addon:CreateBar("target", 770, faerieFireDuration, 6)
	faerieFireBar.auraFilter = "HARMFUL"
	faerieFireBar.label:Hide()

	-- Entangling Roots
	local rootsDuration = 30
	local rootsBar = addon:CreateBar("target", 339, rootsDuration, 6)
	rootsBar.colors = {{0/255, 150/255, 0/255}}

	-- Barkskin
	local barkskinDuration = 14
	local barkskinBar = addon:CreateBar("player", 22812, barkskinDuration, 3)
	barkskinBar.colors = {{255/255, 150/255, 0/255}}
end