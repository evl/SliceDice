local addonName, addon = ...

if addon.playerClass == "DRUID" then
	-- Eclipse
	local eclipseDuration = 15
	local eclipseCooldown = 15
	local eclipseAuraFunction = function(bar, unit, spellName, rank, filter)
		local name, _, _, _, _, _, expirationTime, _, _, _, spellId = UnitAura(unit, spellName, nil, filter)
		
		if name then
			bar.eclipseExpiration = expirationTime + eclipseCooldown
		end
		
		local timeLeft = (bar.eclipseExpiration or 0) - GetTime()
		
		if timeLeft > 0 then
			return spellName, _, _, timeLeft <= eclipseCooldown and 1 or 2, _, _, bar.eclipseExpiration - (timeLeft > eclipseDuration and eclipseDuration or 0)
		end
		
		return nil
	end
	
	local solarEclipseBar = addon:CreateBar("player", "Eclipse (Solar)", eclipseDuration, 14)
	solarEclipseBar.auraFunction = eclipseAuraFunction
	solarEclipseBar.colors = {
		{150/255, 100/255, 0/255},
		{255/255, 150/255, 0/255},
	}

	local lunarEclipseBar = addon:CreateBar("player", "Eclipse (Lunar)", eclipseDuration, 14)
	lunarEclipseBar.auraFunction = eclipseAuraFunction
	lunarEclipseBar.colors = {
		{0/255, 100/255, 150/255},
		{0/255, 150/255, 255/255},
	}

	-- Insect Swarm
	local insectSwarmDuration = 14
	local insectSwarmBar = addon:CreateBar("target", "Insect Swarm", insectSwarmDuration, 14)
	insectSwarmBar.colors = {{0/255, 150/255, 0/255}}

	-- Moonfire
	local starfireGlyph = 54845
	local moonfireDuration = function()
		local maxValue = 15

		-- Glyph of Starfire
		if addon:hasGlyph(starfireGlyph) then 
			maxValue = maxValue + 9
		end

		return maxValue
	end	
	
	local moonfireBar = addon:CreateBar("target", "Moonfire", moonfireDuration, 14)
	moonfireBar.colors = {{150/255, 0/255, 255/255}}

	-- Faerie Fire
	local faerieFireDuration = 300
	local faerieFireBar = addon:CreateBar("target", "Faerie Fire", faerieFireDuration, 6)
	faerieFireBar.auraFilter = "HARMFUL"
	faerieFireBar.label:Hide()
end