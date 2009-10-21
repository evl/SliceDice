if select(2, UnitClass("player")) == "DRUID" then
	local heroesDreamwalkerSet = {39557, 39553, 39555, 39554, 39556}
	local valorousDreamwalkerSet = {40472, 40473, 40493, 40471, 40494}
	local ripGlyph = 54818
	local ripDuration = function()
		local maxValue = 12

		-- Glyph
		if evl_SliceDice:hasGlyph(ripGlyph) then -- http://www.wowhead.com/?spell=54818
			maxValue = maxValue + 4
		end

		-- Dreamwalker set(s)
		local dreamwalkerCount = evl_SliceDice:getItemSetCount(heroesDreamwalkerSet) + evl_SliceDice:getItemSetCount(valorousDreamwalkerSet)
		if dreamwalkerCount > 1 then
			maxValue = maxValue + 3
		end	

		return maxValue
	end
	
	-- Savage Roar
	local savageRoarDuration = 34
	local savageRoarBar = evl_SliceDice:CreateBar("player", "Savage Roar", savageRoarDuration, 19)
	savageRoarBar:SetStatusBarTexture("Interface\\AddOns\\evl_SliceDice\\media\\HalT")

	-- Rip
	local ripBar = evl_SliceDice:CreateBar("target", "Rip", ripDuration, 6)
	ripBar.isDebuff = true
	ripBar.colors = {{255/255, 0/255, 0/255}}
	ripBar.label:Hide()

	-- Rake
	local rakeDuration = 9
	local rakeBar = evl_SliceDice:CreateBar("target", "Rake", rakeDuration, 6)
	rakeBar.isDebuff = true
	rakeBar.label:Hide()	
end