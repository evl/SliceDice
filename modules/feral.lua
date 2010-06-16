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
		if addon:hasGlyph(ripGlyph) then -- http://www.wowhead.com/?spell=54818
			maxValue = maxValue + 4
		end
		
		-- Glyph of Shred
		if addon:hasGlyph(shredGlyph) then -- http://www.wowhead.com/?spell=54815
			maxValue = maxValue + 6
		end

		-- Dreamwalker set(s)
		local dreamwalkerCount = addon:getItemSetCount(heroesDreamwalkerSet) + addon:getItemSetCount(valorousDreamwalkerSet)
		if dreamwalkerCount > 1 then
			maxValue = maxValue + 3
		end	

		return maxValue
	end
	
	local rakeDuration = function()
		local maxValue = 9
		
		-- Tier9 set(s)
		local tier9Count = addon:getItemSetCount(conquerorsMalfurionSet) + addon:getItemSetCount(conquerorsRunetotemsSet) + addon:getItemSetCount(triumphantMalfurion245) + addon:getItemSetCount(triumphantMalfurion258) + addon:getItemSetCount(triumphantRunetotems245) + addon:getItemSetCount(triumphantRunetotems258)
		if tier9Count > 1 then
			maxValue = maxValue + 3
		end	
		
		return maxValue
	end
	
	local savageRoarDuration = function()
		local maxValue = 34
		
		-- Nightsong set(s)
		local nightsongCount = addon:getItemSetCount(valorousNightsongSet) + addon:getItemSetCount(conquerorsNightsongSet)
		if nightsongCount > 3 then
			maxValue = maxValue + 8
		end
		
		return maxValue
	end	
	
	-- Savage Roar
	local savageRoarBar = addon:CreateBar("player", "Savage Roar", savageRoarDuration, 19)

	-- Rip
	local ripBar = addon:CreateBar("target", "Rip", ripDuration, 6)
	ripBar.colors = {{255/255, 0/255, 0/255}}
	ripBar.label:Hide()

	-- Rake
	local rakeBar = addon:CreateBar("target", "Rake", rakeDuration, 6)
	rakeBar.label:Hide()	
	
	-- Lacerate
	local lacerateDuration = 15
	local lacerateBar = addon:CreateBar("target", "Lacerate", lacerateDuration, 16)
	lacerateBar.colors = {{200/255, 0/255, 0/255}, {200/255, 100/255, 0/255}, {200/255, 200/255, 0/255}, {150/255, 200/255, 0/255}, {0/255, 200/255, 0/255}}
	
	-- Demoralizing Roar
	local demoDuration = 30
	local demoBar = addon:CreateBar("target", "Demoralizing Roar", demoDuration, 6)
	demoBar.colors = {{200/255, 200/255, 0/255}}
	demoBar.label:Hide()
	
	-- Mangle (Bear)
	local mangleDuration = 60
	local mangleBearBar = addon:CreateBar("target", "Mangle (Bear)", mangleDuration, 6)
	mangleBearBar.colors = {{100/255, 0/255, 0/255}}
	mangleBearBar.auraFilter = "HARMFUL"
	mangleBearBar.label:Hide()

	-- Mangle (Cat)
	local mangleCatBar = addon:CreateBar("target", "Mangle (Cat)", mangleDuration, 6)
	mangleCatBar.colors = {{100/255, 0/255, 0/255}}
	mangleCatBar.auraFilter = "HARMFUL"
	mangleCatBar.label:Hide()
	
	-- Faerie Fire (Feral)
	local faerieFireDuration = 300
	local faerieFireBar = addon:CreateBar("target", "Faerie Fire (Feral)", faerieFireDuration, 6)
	faerieFireBar.auraFilter = "HARMFUL"
	faerieFireBar.label:Hide()
end