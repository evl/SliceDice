local addonName, addon = ...

if addon.playerClass == "MONK" then
	local config = addon.config

	if config.debug then
		DEFAULT_CHAT_FRAME:AddMessage("> Loaded " .. addon.playerClass .. " module" ,1,0,0)
	end
	
	-- Tiger Palm/Tiger Power
	local tigerPowerDuration = 20
	local tigerPowerBar = addon:CreateBar("player", 125359, tigerPowerDuration, 19)
	
	-- Shuffle, as applied by Blackout Kick
	local shuffleDuration = 6
	local shuffleBar = addon:CreateBar("player", 115307, shuffleDuration, 6)
	shuffleBar.colors = config.feintColor
	shuffleBar.label:Hide()
	
	-- Vengeance
	local vengeanceDuration = 20
	local vengeanceBar = addon:CreateBar("player", 120267, vengeanceDuration, 6)
	vengeanceBar.colors = config.ruptureColor
	vengeanceBar.label:Hide()
	
	-- Momentum, as applied by Roll/Chi Torpedo
	local momentumDuration = 10
	local momentumBar = addon:CreateBar("player", 119085, momentumDuration, 6)
	momentumBar.colors = config.vanishColor
	momentumBar.label:Hide()
	
	-- Zen Sphere
	local zenSphereDuration = 16
	local zenSphereBar = addon:CreateBar("player", 124081, zenSphereDuration, 6)
	zenSphereBar.colors = config.recuperateColor
	zenSphereBar.label:Hide()
	
	-- Fortifying Brew
	local fortBrewDuration = 20
	local fortBrewBar = addon:CreateBar("player", 126456, fortBrewDuration, 3)
	fortBrewBar.colors = config.closColor
	fortBrewBar.label:Hide()
	
	-- Guard
	local guardDuration = 30
	local guardBar = addon:CreateBar("player", 115295, guardDuration, 9)
	guardBar.colors = config.revealingColor
	guardBar.label:Hide()
	
	-- Avert Harm
	local avertHarmDuration = 6
	local avertHarmBar = addon:CreateBar("player", 115213, avertHarmDuration, 3)
	avertHarmBar.colors = config.envenomColor
	avertHarmBar.label:Hide()
	
	-- Elusive Brew
	local elusiveBrewDuration = 15
	local elusiveBrewBar = addon:CreateBar("player", 115308, elusiveBrewDuration, 3)
	elusiveBrewBar.colors = {{100/255, 100/255, 255/255}}
	elusiveBrewBar.label:Hide()
end