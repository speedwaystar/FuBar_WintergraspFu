WintergraspFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0")
WintergraspFu:RegisterDB("WintergraspFuDB");
local L = AceLibrary("AceLocale-2.2"):new("WintergraspFu")

WintergraspFu.title = "WintergraspFu " ..  GetAddOnMetadata("WintergraspFu", "Version") 
WintergraspFu.hasIcon = "Interface\\Icons\\INV_Jewelry_Ring_66"
WintergraspFu.defaultPosition = "LEFT"
WintergraspFu.cannotDetachTooltip = true
WintergraspFu.canHideText = false
WintergraspFu.hasNoColor = true
WintergraspFu.cannotAttachToMinimap = true

--
-- Startup, enabling and disabling
--

function WintergraspFu:OnEnable()
	self:ScheduleRepeatingEvent(self.UpdateText, 1, self)
end

--
-- Periodic updates of text + delayed state check
--

function WintergraspFu:EverySecond()
	self:UpdateText()
end

function WintergraspFu:OnTextUpdate()
	if self:IsTextColored() then
		self:SetText("|cffffffff"..L["WG"]..":|r |cffffff00" .. self:CreateStatusText() .. "|r")
	else
		self:SetText(L["WG"]..": " .. self:CreateStatusText())
	end
end

function WintergraspFu:GetTimeText(seconds)
	local timeText = ""
	if (seconds == nil) or (seconds <= 0) then 
		timeText = L["Active"] -- game in progress
	else
		local h = math.floor(seconds / 3600)
		local m = math.floor(seconds % 3600 / 60)
		local s = seconds % 60
		if h > 0 then
			timeText = timeText .. h .. L["h"].." "
		end
		if m > 0 then
			timeText = timeText .. m .. L["m"].." "
		end
		-- only show seconds in last 10 minutes
		if h == 0 and m < 10 and s > 0 then
			timeText = timeText .. s .. L["s"]
		end
	end
	return timeText
end

function WintergraspFu:CreateStatusText()
	return self:GetTimeText(GetWintergraspWaitTime())
end
