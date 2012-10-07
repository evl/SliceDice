local addonName, addon = ...

if addon.playerClass == "ROGUE" then
	local config = addon.config
	local netherbladeSet = {29044, 29045, 29046, 29047, 29048}
	
	-- Slice and Dice
	local sliceAndDiceDuration = function()
		local maxValue = 36
	
		-- Netherblade
		local netherbladeCount = addon:GetItemSetCount(netherbladeSet)
		if netherbladeCount > 1 then
			maxValue = maxValue + 3
		end
	
		return maxValue
	end
	
	-- Vendetta
	local vendettaGlyph = 63249 -- http://www.wowhead.com/spell=63249
	local vendettaDuration = function()
		local maxValue = 20
		
		-- Glyph of Vendetta
		if addon:HasGlyph(vendettaGlyph) then 
			maxValue = maxValue + 10
		end
		
		return maxValue
	end
	
	-- Feint
	local feintGlyph = 56804 -- http://www.wowhead.com/spell=56804
	local feintDuration = function()
		local maxValue = 5
		
		-- Glyph of Feint
		if addon:HasGlyph(feintGlyph) then
			maxValue = maxValue + 2
		end

		return maxValue
	end
	
	-- Slice and Dice
	local sliceAndDiceBar = addon:CreateBar("player", 5171, sliceAndDiceDuration, 19)

	-- Rupture
	local ruptureDuration = 24
	local ruptureBar = addon:CreateBar("target", 1943, ruptureDuration, 6)
	ruptureBar.colors = config.ruptureColor
	ruptureBar.label:Hide()

	-- Envenom
	local envenomDuration = 6
	local envenomBar = addon:CreateBar("player", 32645, envenomDuration, 6)
	envenomBar.colors = config.envenomColor
	envenomBar.label:Hide()

	-- Revealing Strike
	local revealingDuration = 15
	local revealingBar = addon:CreateBar("target", 84617, revealingDuration, 6)
	revealingBar.colors = config.revealingColor
	revealingBar.label:Hide()

	-- Vendetta
	local vendettaDuration = 30
	local vendettaBar = addon:CreateBar("target", 79140, vendettaDuration, 6)
	vendettaBar.colors = config.vendettaColor
	vendettaBar.label:Hide()

	-- Garotte
	local garroteDuration = 18
	local garroteBar = addon:CreateBar("target", 703, garroteDuration, 6)
	garroteBar.colors = config.garotteColor
	garroteBar.label:Hide()
	
	-- Recuperate
	local recuperateDuration = 30
	local recuperateBar = addon:CreateBar("player", 73651, recuperateDuration, 6)
	recuperateBar.colors = config.recuperateColor
	recuperateBar.label:Hide()
	
	-- Feint
	if config.showFeintBar then
		local feintBar = addon:CreateBar("player", 1966, feintDuration, 3)
		feintBar.colors = config.feintColor
		feintBar.label:Hide()
	end

	-- Cloak of Shadows
	if config.showClosBar then
		local closDuration = 5
		local closBar = addon:CreateBar("player", 31224, closDuration, 3)
		closBar.colors = config.closColor
		closBar.label:Hide()
	end

	-- Vanish
	if config.showVanishBar then
		local vanishDuration = 3
		local vanishBar = addon:CreateBar("player", 1856, vanishDuration, 3)
		vanishBar.colors = config.vanishColor
		vanishBar.label:Hide()
	end
end