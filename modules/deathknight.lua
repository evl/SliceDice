local addonName, addon = ...

if addon.playerClass == "DEATHKNIGHT" then
	-- local scourgeStrikeGlyph = 58723
	-- local diseaseDurationBonus = (addon:GetTalentRank(3, 4) * 3) + (addon:HasGlyph(scourgeStrikeGlyph) and 9 or 0)
	-- TODO doublecheck
	local diseaseDurationBonus = 0
	
	-- Blood Plague
	local bloodPlagueDuration = 30
	local bloodPlagueBar = addon:CreateBar("target", 59879, bloodPlagueDuration + diseaseDurationBonus, 6)
	bloodPlagueBar.colors = {{200/255, 0/255, 0/255}}
	bloodPlagueBar.label:Hide()

	-- Frost Fever
	local frostFeverDuration = 30 + diseaseDurationBonus
	local frostFeverBar = addon:CreateBar("target", 59921, frostFeverDuration + diseaseDurationBonus, 6)
	frostFeverBar.colors = {{0/255, 100/255, 150/255}}
	frostFeverBar.label:Hide()
	
	-- Horn of Winter
	local hornOfWinterDuration = 300
	local hornOfWinterBar = addon:CreateBar("player", 57330, hornOfWinterDuration, 3)
	hornOfWinterBar.colors = {{200/255, 200/255, 200/255}}
	hornOfWinterBar.label:Hide()
end