local addonName, addon = ...

if addon.playerClass == "DEATHKNIGHT" then
	local scourgeStrikeGlyph = 58723
	local diseaseDurationBonus = (addon:getTalentRank(3, 4) * 3) + (addon:hasGlyph(scourgeStrikeGlyph) and 9 or 0)
	
	-- Blood Plague
	local bloodPlagueDuration = 15
	local bloodPlagueBar = addon:CreateBar("target", "Blood Plague", bloodPlagueDuration + diseaseDurationBonus, 6)
	bloodPlagueBar.colors = {{200/255, 0/255, 0/255}}
	bloodPlagueBar.label:Hide()

	-- Frost Fever
	local frostFeverDuration = 15 + diseaseDurationBonus
	local frostFeverBar = addon:CreateBar("target", "Frost Fever", frostFeverDuration + diseaseDurationBonus, 6)
	frostFeverBar.colors = {{0/255, 100/255, 150/255}}
	frostFeverBar.label:Hide()
	
	-- Horn of Winter
	local hornOfWinterDuration = 180
	local hornOfWinterBar = addon:CreateBar("player", "Horn of Winter", hornOfWinterDuration, 3)
	hornOfWinterBar.colors = {{200/255, 200/255, 200/255}}
	hornOfWinterBar.label:Hide()
end