local addonName, addon = ...

if addon.playerClass == "DRUID" then
	local heroesDreamwalkerSet = {39557, 39553, 39555, 39554, 39556} 	-- Tier7 10m
	local valorousDreamwalkerSet = {40472, 40473, 40493, 40471, 40494}	-- Tier7 25m
	local valorousNightsongSet = {45356, 45359, 45358, 45355, 45357}	-- Tier8 10m
	local conquerorsNightsongSet = {46161, 46157, 46159, 46158, 46160}	-- Tier8 25m
	local conquerorsMalfurionSet = {48214, 48217, 48216, 48213, 48215}	-- Tier9 iLvl232 Alliance
	local conquerorsRunetotemsSet = {48188, 48191, 48189, 48192, 48190}	-- Tier9 iLvl232 Horde
	local triumphantMalfurion245 = {48211, 48208, 48209, 48212, 48210}	-- Tier9 iLvl245 Alliance
	local triumphantMalfurion258 = {48204, 48207, 48206, 48203, 48205}	-- Tier9 iLvl258 Alliance
	local triumphantRunetotems245  = {48194, 48197, 48196, 48193, 48195}	-- Tier9 iLvl245 Horde
	local triumphantRunetotems258 = {48201, 48198, 48199, 48202, 48200}	-- Tier9 iLvl258 Horde

	local ripGlyph = 54818
	local shredGlyph = 54815
	local ripDuration = function()
		local maxValue = 12

		-- Glyph of Rip
		if addon:HasGlyph(ripGlyph) then -- http://www.wowhead.com/?spell=54818
			maxValue = maxValue + 4
		end
		
		-- Glyph of Shred
		if addon:HasGlyph(shredGlyph) then -- http://www.wowhead.com/?spell=54815
			maxValue = maxValue + 6
		end

		-- Dreamwalker set(s)
		local dreamwalkerCount = addon:GetItemSetCount(heroesDreamwalkerSet) + addon:GetItemSetCount(valorousDreamwalkerSet)
		if dreamwalkerCount > 1 then
			maxValue = maxValue + 3
		end	

		return maxValue
	end
	
	local rakeDuration = function()
		local maxValue = 9
		
		-- Tier9 set(s)
		local tier9Count = addon:GetItemSetCount(conquerorsMalfurionSet) + addon:GetItemSetCount(conquerorsRunetotemsSet) + addon:GetItemSetCount(triumphantMalfurion245) + addon:GetItemSetCount(triumphantMalfurion258) + addon:GetItemSetCount(triumphantRunetotems245) + addon:GetItemSetCount(triumphantRunetotems258)
		if tier9Count > 1 then
			maxValue = maxValue + 3
		end	
		
		return maxValue
	end
	
	local savageRoarDuration = function()
		local maxValue = 34
		
		-- Nightsong set(s)
		local nightsongCount = addon:GetItemSetCount(valorousNightsongSet) + addon:GetItemSetCount(conquerorsNightsongSet)
		if nightsongCount > 3 then
			maxValue = maxValue + 8
		end
		
		return maxValue
	end	
	
	-- Savage Roar
	local savageRoarBar = addon:CreateBar("player", 52610, savageRoarDuration, 19)

	-- Rip
	local ripBar = addon:CreateBar("target", 1079, ripDuration, 6)
	ripBar.colors = {{255/255, 0/255, 0/255}}
	ripBar.label:Hide()

	-- Rake
	local rakeBar = addon:CreateBar("target", 1822, rakeDuration, 6)
	rakeBar.colors = {{255/255, 50/255, 50/255}}
	rakeBar.label:Hide()	
	
	-- Lacerate
	local lacerateDuration = 15
	local lacerateBar = addon:CreateBar("target", 33745, lacerateDuration, 16)
	lacerateBar.colors = {{200/255, 0/255, 0/255}, {200/255, 200/255, 0/255}, {0/255, 200/255, 0/255}}
	
	-- Demoralizing Roar
	local demoDuration = 30
	local demoBar = addon:CreateBar("target", 99, demoDuration, 6)
	demoBar.colors = {{200/255, 200/255, 0/255}}
	demoBar.label:Hide()
	
	-- Mangle (Bear)
	local mangleDuration = 60
	local mangleBearBar = addon:CreateBar("target", 33878, mangleDuration, 6)
	mangleBearBar.colors = {{100/255, 0/255, 0/255}}
	mangleBearBar.auraFilter = "HARMFUL"
	mangleBearBar.label:Hide()

	-- Mangle (Cat)
	local mangleCatBar = addon:CreateBar("target", 33983, mangleDuration, 6)
	mangleCatBar.colors = {{100/255, 0/255, 0/255}}
	mangleCatBar.auraFilter = "HARMFUL"
	mangleCatBar.label:Hide()
	
	-- Faerie Fire (Feral)
	local faerieFireDuration = 300
	local faerieFireBar = addon:CreateBar("target", 16857, faerieFireDuration, 6)
	faerieFireBar.auraFilter = "HARMFUL"
	faerieFireBar.label:Hide()
end