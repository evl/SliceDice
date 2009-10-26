evl_SliceDice = CreateFrame("Frame", nil, UIParent)
evl_SliceDice.config = {
	position = {"TOP", UIParent, "BOTTOM", 0, 180},
	width = 250,
	growUpwards = true,
	barTexture = "Interface\\AddOns\\evl_SliceDice\\media\\HalW",
}

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
	self:ScanBars(unit)
end

function evl_SliceDice:PLAYER_ENTERING_WORLD(event)
	self:SetWidth(self.config.width)
	self:SetHeight(20)

	self:SetPoint(self.config.position[1], self.config.position[2], self.config.position[3], self.config.position[4], self.config.position[5])
	self:UpdateMaxValues()
	self:ScanBars(UnitInVehicle("player") and "vehicle" or "player")
end

function evl_SliceDice:UNIT_ENTERED_VEHICLE(event, unit)
	self:ScanBars("vehicle")
end

function evl_SliceDice:UNIT_EXITED_VEHICLE(event, unit)
	self:ScanBars("vehicle")
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

function evl_SliceDice:ScanBars(unit)
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
			
			if (source == "player" or source == "vehicle") and name == bar.spellName() then
				color = bar.colors[math.max(1, math.min(#bar.colors, count))]
			
				bar:SetValue(expirationTime - GetTime())
				bar:SetStatusBarColor(color[1], color[2], color[3])
				bar:Show()		
				return
			end
		end
	end
end

function evl_SliceDice:OrganizeBars()
	local growUpwards = self.config.growUpwards
	local topBar
	local bottomBar
	
	for _, bar in ipairs(self.bars) do
		if bar:IsVisible() then
			bar:ClearAllPoints()
			
			if growUpwards then
				bar:SetPoint("BOTTOMLEFT", topBar or self, topBar and "TOPLEFT" or "BOTTOMLEFT", 0, topBar and 1 or 0)
			
				topBar = bar
			else
				bar:SetPoint("TOPLEFT", bottomBar or self, bottomBar and "BOTTOMLEFT" or "TOPLEFT", 0, bottomBar and -1 or 0)
			
				bottomBar = bar
			end

			bar:SetPoint("RIGHT", self, "RIGHT")
		end
	end
	
	if topBar or bottomBar then
		self.background:SetPoint("TOPLEFT", topBar or self, "TOPLEFT", -5, 5)
		self.background:SetPoint("BOTTOMRIGHT", bottomBar or self, "BOTTOMRIGHT", 5, -5)
	else
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
	bar:SetPoint("RIGHT", self, "RIGHT")
	bar:SetStatusBarTexture(self.config.barTexture)
	bar:Hide()
	bar:SetScript("OnHide", onVisibilityChanged)
	bar:SetScript("OnShow", onVisibilityChanged)
	
	bar.label = label
	bar.unit = unit
	bar.colors = {{130/255, 122/255, 94/255}}
	bar.spellName = createGetter(spellName)
	bar.maxDuration = createGetter(maxDuration)
	bar.isDebuff = false
	
	table.insert(self.bars, self.config.growUpwards and 1 or #self.bars + 1, bar)

	return bar
end

local background = CreateFrame("Frame", nil, evl_SliceDice)
background:SetFrameStrata("BACKGROUND")
background:SetBackdrop({
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
	edgeFile = "Interface\\AddOns\\evl_SliceDice\\media\\HalBorderSmall", 
	tile = true, tileSize = 8, edgeSize = 8, insets = {left = 4, right = 4, top = 4, bottom = 4}
})
background:SetBackdropColor(0, 0, 0)
background:SetBackdropBorderColor(1, 1, 1, .7)

evl_SliceDice.bars = {}
evl_SliceDice.background = background

evl_SliceDice:Hide()
evl_SliceDice:SetScript("OnEvent", onEvent)
evl_SliceDice:SetScript("OnUpdate", onUpdate)

evl_SliceDice:RegisterEvent("UNIT_AURA")
evl_SliceDice:RegisterEvent("UNIT_ENTERED_VEHICLE")
evl_SliceDice:RegisterEvent("UNIT_EXITED_VEHICLE")
evl_SliceDice:RegisterEvent("PLAYER_TARGET_CHANGED")
evl_SliceDice:RegisterEvent("PLAYER_ENTERING_WORLD")
evl_SliceDice:RegisterEvent("PLAYER_ALIVE")
evl_SliceDice:RegisterEvent("PLAYER_TALENT_UPDATE")
evl_SliceDice:RegisterEvent("GLYPH_ADDED")
evl_SliceDice:RegisterEvent("GLYPH_REMOVED")
evl_SliceDice:RegisterEvent("GLYPH_UPDATED")
evl_SliceDice:RegisterEvent("CHARACTER_POINTS_CHANGED")
evl_SliceDice:RegisterEvent("UNIT_INVENTORY_CHANGED")
