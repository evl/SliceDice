evl_SliceDice = CreateFrame("Frame", nil, UIParent)

local createGetter = function(property)
	if type(property) == "function" then
		return property
	end
	
	return function() return property end
end

local handler
local onEvent = function(self, event, ...)
	handler = self[event]
	
	if handler then
		handler(self, event, ...)
	else
		self:UpdateMaxValues()
	end
end

local onUpdate = function(self, elapsed)
	self:UpdateBars(self, elapsed)
end

local onVisibilityChanged = function(self)
	evl_SliceDice:OrganizeBars()
end

function evl_SliceDice:getTalentRank(tabIndex, talentIndex)
	return select(5, GetTalentInfo(tabIndex, talentIndex))
end

function evl_SliceDice:hasGlyph(id)
	for i = 1, 6 do
		local _, _, glyphSpell = GetGlyphSocketInfo(i)
		
		if glyphSpell == id then
			return true
		end
	end
	
	return false
end

function evl_SliceDice:getItemSetCount(set)
	local count = 0
	local link
	
	for i = 1,10 do
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

function evl_SliceDice:UNIT_AURA(event, unit)
	local shown = false

	for _, bar in ipairs(self.bars) do
		self:ScanBar(bar, unit)
		
		if bar:IsShown() then
			shown = true
		end
	end
	
	if shown then
		self:Show()
	else
		self:Hide()
	end
end

function evl_SliceDice:PLAYER_TARGET_CHANGED(event)
	for _, bar in ipairs(self.bars) do
		local unit = bar.unit

		if unit == "target" then
			if UnitExists(unit) then
				self:ScanBar(bar, unit)
			else
				bar:Hide()
			end
		end
	end
end

function evl_SliceDice:UNIT_INVENTORY_CHANGED(event, unit)
	if unit == "player" then
		self:UpdateMaxValues()
	end
end

function evl_SliceDice:UpdateMaxValues()
	for _, bar in ipairs(self.bars) do
		bar:SetMinMaxValues(0, bar.maxDuration())
	end
end

local timeLeft
local timeFormat = "%.1f"
function evl_SliceDice:UpdateBars(event, elapsed)
	for _, bar in ipairs(self.bars) do
		if bar:IsVisible() then
			timeLeft = bar:GetValue()

			if timeLeft > 0 then
				bar:SetValue(timeLeft - elapsed)
				
				if bar.label:IsVisible() then
					bar.label:SetText(timeFormat:format(timeLeft))
				end
			end
		end
	end
end

local name, count, expirationTime, source, auraFunction, color
function evl_SliceDice:ScanBar(bar, unit)
	if unit == bar.unit then
		auraFunction = bar.isDebuff and UnitDebuff or UnitBuff
		
		for i = 1, 32 do
			name, _, _, count, _, _, expirationTime, source = auraFunction(unit, i)
			
			if not name then
				bar:Hide()
				break
			end
			
			if source == "player" and name == bar.spellName() then
				color = bar.colors[math.max(1, count)]
			
				bar:SetValue(expirationTime - GetTime())
				bar:SetStatusBarColor(color[1], color[2], color[3])
				bar:Show()		
				return
			end
		end
	end
end

function evl_SliceDice:OrganizeBars()
	local previousBar
	
	for _, bar in ipairs(self.bars) do
		if bar:IsVisible() then
			if previousBar then
				bar:SetPoint("TOPLEFT", previousBar, "BOTTOMLEFT", 0, -1)
				bar:SetPoint("RIGHT", previousBar, "RIGHT")
			else
				bar:SetPoint("TOPLEFT", self, "TOPLEFT")
				bar:SetPoint("RIGHT", self, "RIGHT")
			end
			
			self.background:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 5, -5)
			
			previousBar = bar
		end
	end
	
	if not previousBar then
		self:Hide()
	end
end

function evl_SliceDice:CreateBar(unit, spellName, maxDuration, height)
	local bar = CreateFrame("StatusBar", nil, self)

	local label = bar:CreateFontString(nil, "OVERLAY")
	label:SetFont(STANDARD_TEXT_FONT, 11)
	label:SetTextColor(1, 1, 1)
	label:SetShadowOffset(0.7, -0.7)
	label:SetPoint("LEFT", 2, 0)
	label:SetPoint("RIGHT", -2, 0)
	label:SetJustifyH("LEFT")
	
	bar:SetHeight(height)
	bar:SetStatusBarTexture("Interface\\AddOns\\evl_SliceDice\\media\\HalW")
	bar:Hide()
	bar:SetScript("OnHide", onVisibilityChanged)
	bar:SetScript("OnShow", onVisibilityChanged)
	
	bar.label = label
	bar.unit = unit
	bar.colors = {{130/255, 122/255, 94/255}}
	bar.spellName = createGetter(spellName)
	bar.maxDuration = createGetter(maxDuration)
	bar.isDebuff = false
	
	table.insert(self.bars, bar)

	return bar
end

local background = CreateFrame("Frame", nil, evl_SliceDice)
background:SetFrameStrata("BACKGROUND")
background:SetPoint("TOPLEFT", evl_SliceDice, "TOPLEFT", -5, 5)
background:SetBackdrop({
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
	edgeFile = "Interface\\AddOns\\evl_SliceDice\\media\\HalBorderSmall", 
	tile = true, tileSize = 8, edgeSize = 8, insets = {left = 4, right = 4, top = 4, bottom = 4}
})
background:SetBackdropColor(0, 0, 0)
background:SetBackdropBorderColor(1, 1, 1, .7)

evl_SliceDice.bars = {}
evl_SliceDice.background = background

evl_SliceDice:SetWidth(250)
evl_SliceDice:SetPoint("TOP", UIParent, "BOTTOM", 0, 180)
evl_SliceDice:SetPoint("BOTTOM", UIParent, "BOTTOM")
evl_SliceDice:Hide()

evl_SliceDice:SetScript("OnEvent", onEvent)
evl_SliceDice:SetScript("OnUpdate", onUpdate)

evl_SliceDice:RegisterEvent("UNIT_AURA")
evl_SliceDice:RegisterEvent("PLAYER_TARGET_CHANGED")
evl_SliceDice:RegisterEvent("PLAYER_ENTERING_WORLD")
evl_SliceDice:RegisterEvent("PLAYER_ALIVE")
evl_SliceDice:RegisterEvent("GLYPH_ADDED")
evl_SliceDice:RegisterEvent("GLYPH_REMOVED")
evl_SliceDice:RegisterEvent("GLYPH_UPDATED")
evl_SliceDice:RegisterEvent("CHARACTER_POINTS_CHANGED")
evl_SliceDice:RegisterEvent("UNIT_INVENTORY_CHANGED")
