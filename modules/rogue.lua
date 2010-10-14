local addonName, addon = ...

if addon.playerClass == "ROGUE" then
	local netherbladeSet = {29044, 29045, 29046, 29047, 29048}
	local sliceAndDiceGlyph = 56810 -- http://www.wowhead.com/?spell=56810
	local sliceAndDiceDuration = function()
		local maxValue = 21
	
		-- Glyph
		if addon:HasGlyph(sliceAndDiceGlyph) then
			maxValue = maxValue + 3 
		end
	
		-- Netherblade
		local netherbladeCount = addon:GetItemSetCount(netherbladeSet)
		if netherbladeCount > 1 then
			maxValue = maxValue + 3
		end
	
		-- Talent
		local rank = addon:GetTalentRank(2, 4)
		maxValue = maxValue * (1 + (rank * 0.25))
	
		return maxValue
	end
	
	local ruptureGlyph = 56801 -- http://www.wowhead.com/?spell=56801
	local ruptureDuration = function()
		local maxValue = 16

		-- Glyph of Rupture
		if addon:HasGlyph(ruptureGlyph) then 
			maxValue = maxValue + 4
		end
		
		return maxValue
	end
	
	local vendettaGlyph = 63249 -- http://www.wowhead.com/spell=63249
	local vendettaDuration = function()
		local maxValue = 30
		
		-- Glyph of Vendetta
		if addon:HasGlyph(vendettaGlyph) then 
			maxValue = maxValue * 1.2
		end
	end
	
	-- Slice and Dice
	local sliceAndDiceBar = addon:CreateBar("player", 5171, sliceAndDiceDuration, 19)

	-- Rupture
	local ruptureBar = addon:CreateBar("target", 1943, ruptureDuration, 6)
	ruptureBar.colors = {{200/255, 0/255, 0/255}}
	ruptureBar.label:Hide()
	
	-- Revealing Strike
	local revealingDuration = 15
	local revealingBar = addon:CreateBar("target", 84617, revealingDuration, 6)
	revealingBar.colors = {{100/255, 0/255, 0/255}}
	revealingBar.label:Hide()

	-- Vendetta
	local vendettaDuration = 30
	local vendettaBar = addon:CreateBar("target", 79140, vendettaDuration, 6)
	vendettaBar.colors = {{100/255, 0/255, 0/255}}
	vendettaBar.label:Hide()
end