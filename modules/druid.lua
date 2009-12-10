if select(2, UnitClass("player")) == "DRUID" then
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

-- FERAL
	
	local ripGlyph = 54818
	local shredGlyph = 54815
	local ripDuration = function()
		local maxValue = 12

		-- Glyph of Rip
		if evl_SliceDice:hasGlyph(ripGlyph) then -- http://www.wowhead.com/?spell=54818
			maxValue = maxValue + 4
		end
		
		-- Glyph of Shred
		if evl_SliceDice:hasGlyph(shredGlyph) then -- http://www.wowhead.com/?spell=54815
			maxValue = maxValue + 6
		end

		-- Dreamwalker set(s)
		local dreamwalkerCount = evl_SliceDice:getItemSetCount(heroesDreamwalkerSet) + evl_SliceDice:getItemSetCount(valorousDreamwalkerSet)
		if dreamwalkerCount > 1 then
			maxValue = maxValue + 3
		end	

		return maxValue
	end
	
	local rakeDuration = function()
		local maxValue = 9
		
		-- Tier9 set(s)
		local tier9Count = evl_SliceDice:getItemSetCount(conquerorsMalfurionSet) + evl_SliceDice:getItemSetCount(conquerorsRunetotemsSet) + evl_SliceDice:getItemSetCount(triumphantMalfurion245) + evl_SliceDice:getItemSetCount(triumphantMalfurion258) + evl_SliceDice:getItemSetCount(triumphantRunetotems245) + evl_SliceDice:getItemSetCount(triumphantRunetotems258)
		if tier9Count > 1 then
			maxValue = maxValue + 3
		end	
		
		return maxValue
	end
	
	local savageRoarDuration = function()
		local maxValue = 34
		
		-- Nightsong set(s)
		local nightsongCount = evl_SliceDice:getItemSetCount(valorousNightsongSet) + evl_SliceDice:getItemSetCount(conquerorsNightsongSet)
		if nightsongCount > 3 then
			maxValue = maxValue + 8
		end
		
		return maxValue
	end	
	
	-- Savage Roar
	local savageRoarBar = evl_SliceDice:CreateBar("player", "Savage Roar", savageRoarDuration, 19)
	savageRoarBar:SetStatusBarTexture("Interface\\AddOns\\evl_SliceDice\\media\\HalT")

	-- Rip
	local ripBar = evl_SliceDice:CreateBar("target", "Rip", ripDuration, 6)
	ripBar.colors = {{255/255, 0/255, 0/255}}
	ripBar.label:Hide()

	-- Rake
	local rakeBar = evl_SliceDice:CreateBar("target", "Rake", rakeDuration, 6)
	rakeBar.label:Hide()	
	
-- MOONKIN

	local ffDuration = 300
	local insectswarmDuration = 14
	local starfireGlyph = 54845 -- http://www.wowhead.com/?spell=54845
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
--	isBar.label:Hide()
	
	-- Moonfire
	local mfBar = evl_SliceDice:CreateBar("target", "Moonfire", moonfireDuration, 14)
	mfBar.colors = {{150/255, 0/255, 255/255}}
--	mfBar.label:Hide()

	-- Faerie Fire
	local ffBar = evl_SliceDice:CreateBar("target", "Faerie Fire", ffDuration, 6)
	ffBar.auraFilter = "HARMFUL"
	ffBar.label:Hide()

end