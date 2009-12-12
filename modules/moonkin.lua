if select(2, UnitClass("player")) == "DRUID" then
	local ffDuration = 300
	local insectswarmDuration = 14
	local starfireGlyph = 54845
	local moonfireDuration = function()
		local maxValue = 15

		-- Glyph of Starfire
		if evl_SliceDice:hasGlyph(starfireGlyph) then 
			maxValue = maxValue + 9
		end

		return maxValue
	end	

	-- Insect Swarm
	local isBar = evl_SliceDice:CreateBar("target", "Insect Swarm", insectswarmDuration, 14)
	isBar.colors = {{0/255, 150/255, 0/255}}

	-- Moonfire
	local mfBar = evl_SliceDice:CreateBar("target", "Moonfire", moonfireDuration, 14)
	mfBar.colors = {{150/255, 0/255, 255/255}}

	-- Faerie Fire
	local ffBar = evl_SliceDice:CreateBar("target", "Faerie Fire", ffDuration, 6)
	ffBar.auraFilter = "HARMFUL"
	ffBar.label:Hide()
end