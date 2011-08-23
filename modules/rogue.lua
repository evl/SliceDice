local addonName, addon = ...

if addon.playerClass == "ROGUE" then
	local config = addon.config
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
		
		return maxValue
	end
	
	local garroteGlyph = 56812 -- http://www.wowhead.com/spell=56812
	local garroteDuration = function()
		local maxValue = 18
		
		-- Glyph of Garrote
		if addon:HasGlyph(garroteGlyph) then 
			maxValue = maxValue + 2
		end

		return maxValue
	end
	
	-- Slice and Dice
	local sliceAndDiceBar = addon:CreateBar("player", 5171, sliceAndDiceDuration, 19)

	-- Rupture
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
		local feintDuration = 6
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
	
	local feintCooldown = 10
	local feintCooldownBar = addon:CreateCooldownBar(1966, feintCooldown, 12)
	feintCooldownBar.color = config.feintColor
	feintCooldownBar.label:Show()
	
	local vendettaCooldown = 120
	local vendettaCooldownBar = addon:CreateCooldownBar(79140, vendettaCooldown, 12)
	vendettaCooldownBar.color = config.vendettaColor
	vendettaCooldownBar.label:Show()
end