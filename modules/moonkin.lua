if select(2, UnitClass("player")) == "DRUID" then
	-- Eclipse
	local eclipseDuration = 15
	local eclipseCooldown = 15
	local eclipseColor
	local eclipseExpiration = 0
	local eclipseOrangeBuff = 48517 -- http://www.wowhead.com/?spell=48517
	local eclipseBlueBuff = 48518 -- http://www.wowhead.com/?spell=48518
	local eclipseAuraFunction = function(unit, spellName, rank, filter)
		local name, _, _, _, _, _, expirationTime, _, _, _, spellId = UnitAura(unit, spellName, nil, filter)
		
		if name then
			eclipseColor = spellId == eclipseOrangeBuff and 1 or 2
			eclipseExpiration = expirationTime + eclipseCooldown
		end
		
		local timeLeft = eclipseExpiration - GetTime()
		
		if timeLeft > 0 then
			return spellName, _, _, eclipseColor + (timeLeft <= eclipseCooldown and 2 or 0), _, _, (timeLeft > eclipseDuration and eclipseExpiration - eclipseDuration or eclipseExpiration)
		end
		
		return nil
	end

	local eclipseBar = evl_SliceDice:CreateBar("player", "Eclipse", eclipseDuration, 14)
	eclipseBar.auraFunction = eclipseAuraFunction
	eclipseBar.colors = {
		{255/255, 150/255, 0/255}, 
		{0/255, 150/255, 255/255},
		{150/255, 100/255, 0/255}, 
		{0/255, 100/255, 150/255},
	}

	-- Insect Swarm
	local insectSwarmDuration = 14
	local insectSwarmBar = evl_SliceDice:CreateBar("target", "Insect Swarm", insectSwarmDuration, 14)
	insectSwarmBar.colors = {{0/255, 150/255, 0/255}}

	-- Moonfire
	local starfireGlyph = 54845
	local moonfireDuration = function()
		local maxValue = 15

		-- Glyph of Starfire
		if evl_SliceDice:hasGlyph(starfireGlyph) then 
			maxValue = maxValue + 9
		end

		return maxValue
	end	
	
	local moonfireBar = evl_SliceDice:CreateBar("target", "Moonfire", moonfireDuration, 14)
	moonfireBar.colors = {{150/255, 0/255, 255/255}}

	-- Faerie Fire
	local faerieFireDuration = 300
	local faerieFireBar = evl_SliceDice:CreateBar("target", "Faerie Fire", faerieFireDuration, 6)
	faerieFireBar.auraFilter = "HARMFUL"
	faerieFireBar.label:Hide()
end