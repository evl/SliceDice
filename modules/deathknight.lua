if select(2, UnitClass("player")) == "DEATHKNIGHT" then
	local scourgeStrikeGlyph = 58723
	local diseaseDurationBonus = (evl_SliceDice:getTalentRank(3, 4) * 3) + (evl_SliceDice:hasGlyph(scourgeStrikeGlyph) and 9 or 0)
	
	-- Blood Plague
	local bloodPlagueDuration = 15
	local bloodPlagueBar = evl_SliceDice:CreateBar("target", "Blood Plague", bloodPlagueDuration + diseaseDurationBonus, 9)
	bloodPlagueBar.colors = {{200/255, 0/255, 0/255}}
	bloodPlagueBar.label:Hide()

	-- Frost Fever
	local frostFeverDuration = 15 + diseaseDurationBonus
	local frostFeverBar = evl_SliceDice:CreateBar("target", "Frost Fever", frostFeverDuration + diseaseDurationBonus, 9)
	frostFeverBar.colors = {{0/255, 100/255, 150/255}}
	frostFeverBar.label:Hide()
end