if select(2, UnitClass("player")) == "WARRIOR" then
	local rendGlyph = 58385
	local rendDuration = function()
		local maxValue = 15

		-- Glyph
		if evl_SliceDice:hasGlyph(rendGlyph) then
			maxValue = maxValue + 3
		end

		return maxValue
	end
	
	-- Rend
	local rendBar = evl_SliceDice:CreateBar("target", "Rend", rendDuration, 6)
	rendBar.isDebuff = true
	rendBar.colors = {{255/255, 0/255, 0/255}}
	rendBar.label:Hide()

	-- Hamstring
	local hamstringDuration = 15
	local hamstringBar = evl_SliceDice:CreateBar("target", "Hamstring", hamstringDuration, 6)
	hamstringBar.isDebuff = true
	hamstringBar.label:Hide()	
end