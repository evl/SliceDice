local addonName, addon = ...

if addon.playerClass == "WARRIOR" then
	local rendGlyph = 58385
	local rendDuration = function()
		local maxValue = 15

		-- Glyph
		if addon:hasGlyph(rendGlyph) then
			maxValue = maxValue + 3
		end

		return maxValue
	end
	
	-- Rend
	local rendBar = addon:CreateBar("target", 772, rendDuration, 6)
	rendBar.colors = {{255/255, 0/255, 0/255}}
	rendBar.label:Hide()

	-- Hamstring
	local hamstringDuration = 15
	local hamstringBar = addon:CreateBar("target", 1715, hamstringDuration, 6)
	hamstringBar.label:Hide()	
end