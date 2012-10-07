local addonName, addon = ...

function addon:GetTalentRank(tabIndex, talentIndex)
	return select(5, GetTalentInfo(tabIndex, talentIndex))
end

function addon:HasTalentRank(tabIndex, talentIndex, rankRequired)
	return self:GetTalentRank(tabIndex, talentIndex) >= (rankRequired or 1)
end

function addon:HasGlyph(id)
	for i = 1, GetNumGlyphSockets() do
		if select(4, GetGlyphSocketInfo(i)) == id then
			return true
		end
	end
	
	return false
end

function addon:GetItemSetCount(set)
	local count = 0
	local link
	
	for i = 1, 10 do
		link = GetInventoryItemLink("player", i)

		if link then
			for _, itemId in pairs(set) do
				if link:find(itemId) then
					count = count + 1
				end
			end
		end
	end
	
	return count
end