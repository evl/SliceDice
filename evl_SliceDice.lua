local addonName, addon = ...

addon.config = {
	position = {"TOP", UIParent, "BOTTOM", 0, 180},
	width = 250,
	growUpwards = true,
	tallBarTexture = "Interface\\AddOns\\" .. addonName .. "\\media\\HalT",
	shortBarTexture = "Interface\\AddOns\\" .. addonName .. "\\media\\HalW",
}

addon.playerClass = select(2, UnitClass("player"))

local config = addon.config
local frame = CreateFrame("Frame", nil, UIParent)
local background = CreateFrame("Frame", nil, frame)
local bars = {}

local createGetter = function(property)
	if type(property) == "function" then
		return property
	end
	
	return function() return property end
end

local handler
local onEvent = function(self, event, ...)
	handler = addon[event]
	
	if handler then
		handler(addon, event, ...)
	else
		addon:UpdateMaxValues()
	end
end

local onUpdate = function(self, elapsed)
	addon:UpdateBars(addon, elapsed)
end

local onVisibilityChanged = function(self)
	addon:OrganizeBars()
end

local defaultAuraFunction = function(bar, unit, spellName, rank, filter)
	return UnitAura(unit, spellName, rank, filter)
end

function addon:getTalentRank(tabIndex, talentIndex)
	return select(5, GetTalentInfo(tabIndex, talentIndex))
end

function addon:hasGlyph(id)
	for i = 1, 6 do
		if select(3, GetGlyphSocketInfo(i)) == id then
			return true
		end
	end
	
	return false
end

function addon:getItemSetCount(set)
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

function addon:UNIT_AURA(event, unit)
	self:ScanBars(unit)
end

function addon:PLAYER_ENTERING_WORLD(event)
	frame:SetWidth(config.width)
	frame:SetHeight(20)
	frame:SetPoint(unpack(config.position))

	self:UpdateMaxValues()
	self:ScanBars(UnitInVehicle("player") and "vehicle" or "player")
end

function addon:UNIT_ENTERED_VEHICLE(event, unit)
	self:ScanBars("vehicle")
end

function addon:UNIT_EXITED_VEHICLE(event, unit)
	self:ScanBars("vehicle")
end

function addon:PLAYER_TARGET_CHANGED(event)
	self:ScanBars("target")
end

function addon:UNIT_INVENTORY_CHANGED(event, unit)
	if unit == "player" then
		self:UpdateMaxValues()
	end
end

function addon:UpdateMaxValues()
	for _, bar in ipairs(bars) do
		bar:SetMinMaxValues(0, bar.maxDuration())
	end
end

local timeLeft
local timeFormat = "%.1f"
function addon:UpdateBars(event, elapsed)
	for _, bar in ipairs(bars) do
		if bar:IsVisible() then
			timeLeft = bar:GetValue()

			if timeLeft > 0 then
				bar:SetValue(timeLeft - elapsed)
				
				if bar.label:IsVisible() then
					bar.label:SetText(timeFormat:format(timeLeft))
				end
			else
				bar:Hide()
			end
		end
	end
end

function addon:ScanBars(unit)
	local shown = false

	for _, bar in ipairs(bars) do
		self:ScanBar(bar, unit)

		if not shown then
			shown = bar:IsShown()
		end
	end
	
	if shown then
		frame:Show()
	else
		frame:Hide()
	end
end

local name, count, expirationTime, auraFunction, color
function addon:ScanBar(bar, unit)
	if unit == bar.unit then
		name, _, _, count, _, _, expirationTime = bar.auraFunction(bar, unit, bar.spellName(), nil, bar.auraFilter)
		
		if name then
			color = bar.colors[math.max(1, math.min(#bar.colors, count))]
		
			bar:SetValue(expirationTime - GetTime())
			bar:SetStatusBarColor(unpack(color))
			bar:Show()
		else
			bar:Hide()
		end
	end
end

function addon:OrganizeBars()
	local growUpwards = config.growUpwards
	local topBar
	local bottomBar
	
	for _, bar in ipairs(bars) do
		if bar:IsVisible() then
			bar:ClearAllPoints()
			
			if growUpwards then
				bar:SetPoint("BOTTOMLEFT", topBar or frame, topBar and "TOPLEFT" or "BOTTOMLEFT", 0, topBar and 1 or 0)
			
				topBar = bar
			else
				bar:SetPoint("TOPLEFT", bottomBar or frame, bottomBar and "BOTTOMLEFT" or "TOPLEFT", 0, bottomBar and -1 or 0)
			
				bottomBar = bar
			end

			bar:SetPoint("RIGHT", frame, "RIGHT")
		end
	end
	
	if topBar or bottomBar then
		background:SetPoint("TOPLEFT", topBar or frame, "TOPLEFT", -5, 5)
		background:SetPoint("BOTTOMRIGHT", bottomBar or frame, "BOTTOMRIGHT", 5, -5)
	else
		frame:Hide()
	end		
end

function addon:CreateBar(unit, spellName, maxDuration, height)
	local bar = CreateFrame("StatusBar", nil, frame)

	local label = bar:CreateFontString(nil, "OVERLAY")
	label:SetFont(STANDARD_TEXT_FONT, 11)
	label:SetTextColor(1, 1, 1)
	label:SetShadowOffset(0.7, -0.7)
	label:SetPoint("LEFT", 2, 0)
	label:SetPoint("RIGHT", -2, 0)
	label:SetJustifyH("LEFT")
	
	bar:SetHeight(height)
	bar:SetStatusBarTexture(height > 8 and config.tallBarTexture or config.shortBarTexture)
	bar:Hide()
	bar:SetScript("OnHide", onVisibilityChanged)
	bar:SetScript("OnShow", onVisibilityChanged)
	
	bar.label = label
	bar.unit = unit
	bar.colors = {{130/255, 122/255, 94/255}}
	bar.spellName = createGetter(spellName)
	bar.maxDuration = createGetter(maxDuration)
	bar.auraFunction = defaultAuraFunction
	bar.auraFilter = (unit == "target" and "HARMFUL" or "HELPFUL") .. "|PLAYER"
	
	table.insert(bars, config.growUpwards and 1 or #bars + 1, bar)

	return bar
end

background:SetFrameStrata("BACKGROUND")
background:SetBackdrop({
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
	edgeFile = "Interface\\AddOns\\" .. addonName .. "\\media\\HalBorderSmall", 
	tile = true, tileSize = 8, edgeSize = 8, insets = {left = 4, right = 4, top = 4, bottom = 4}
})
background:SetBackdropColor(0, 0, 0)
background:SetBackdropBorderColor(1, 1, 1, .7)

frame:Hide()
frame:SetScript("OnEvent", onEvent)
frame:SetScript("OnUpdate", onUpdate)

frame:RegisterEvent("UNIT_AURA")
frame:RegisterEvent("UNIT_ENTERED_VEHICLE")
frame:RegisterEvent("UNIT_EXITED_VEHICLE")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_ALIVE")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:RegisterEvent("GLYPH_ADDED")
frame:RegisterEvent("GLYPH_REMOVED")
frame:RegisterEvent("GLYPH_UPDATED")
frame:RegisterEvent("CHARACTER_POINTS_CHANGED")
frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
