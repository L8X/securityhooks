--- securityhooks.lua ---

--- report any issues to nul#3174 ---

local tostring = tostring
local pcall = pcall
local game = game
local getnamecallmethod = getnamecallmethod
local hookmetamethod = hookmetamethod
local hookfunction = hookfunction
local checkcaller = checkcaller
local newcclosure = newcclosure
local getfenv = getfenv
local setfenv = setfenv
local _G = _G
local shared = shared
local gethui = gethui or gethiddenui or hiddenui
local gethiddengui = gethiddengui
local cloneref = cloneref

local genv = getfenv(0) or _G or shared

local getgenv = getgenv or function()
	return genv
end

if (getgenv().EXPRO_SECURITYHOOKS_LOADED) then return; end

getgenv().EXPRO_SECURITYHOOKS_LOADED = true

if not getnamecallmethod then
    return
end
if not hookmetamethod then
    return
end
if not checkcaller then
    return
end
if not hookfunction then
    return
end
if not newcclosure then
    return
end

local string = string
local string_gsub = string.gsub 

-- SanitizeNamecallMethod is currently unused --
local function SanitizeNamecallMethod(str)
    local tostringed = tostring(str)
    return string_gsub(tostringed, "\0", "")
end

local debug = debug
local debug_getfenv = debug.getfenv
local debug_getmetatable = debug.getmetatable

local getrenv = getrenv

if not getrenv and debug and debug_getmetatable and debug_getfenv then
    getrenv = function()
        if debug and debug_getmetatable and debug_getfenv then
            return debug_getfenv(debug_getmetatable(game).__index)
        end
    end
end


local _ENV
local _Globals

if getrenv then
	local setreadonly = setreadonly or table.freeze
	_Globals = {
        __metatable = "This metatable is locked";
        }
        for i, v in next, getrenv() do
            _Globals[i] = v
        end
        _ENV = {
        __index = _Globals;
        __metatable = "This metatable is locked";
        }
        for i, v in next, getrenv() do
            _ENV[i] = v
        end
        pcall(function() setreadonly(_Globals, true) end)
        pcall(function() setreadonly(_ENV, true) end)
end

local function GetService(s)
    if not type(s) == "string" then
        return
    end
    local success, err = pcall(function() game:GetService(s) end)
    if success and game:GetService(s) ~= nil then 
        return game:GetService(s)
    else 
        return nil
    end
end

local function FindService(s)
    if not type(s) == "string" then
        return
    end
    local success, err = pcall(function() game:FindService(s) end)
    if success and game:FindService(s) ~= nil then 
        return game:FindService(s)
    else 
        return nil
    end
end

local MessageBusService = FindService("MessageBusService")
local FacialAnimationStreamingService = FindService("FacialAnimationStreamingService")
local VoiceChatInternal = FindService("VoiceChatInternal")
local VoiceChatService = FindService("VoiceChatService")
local CoreGui = FindService("CoreGui")
local MarketplaceService = FindService("MarketplaceService")
local RbxAnalyticsService = FindService("RbxAnalyticsService")
local HttpRbxApiService = FindService("HttpRbxApiService")
local AppUpdateService = FindService("AppUpdateService")
local BrowserService = FindService("BrowserService")
local DataModelPatchService = FindService("DataModelPatchService")
local EventIngestService = FindService("EventIngestService")
local FaceAnimatorService = FindService("FaceAnimatorService")
local DeviceIdService = FindService("DeviceIdService")
local HttpService = FindService("HttpService")
local LocalStorageService = FindService("LocalStorageService")
local AppStorageService = FindService("AppStorageService")
local UserStorageService = FindService("UserStorageService")
local LoginService = FindService("LoginService")
local MemStorageService = FindService("MemStorageService")
local MemoryStoreService = FindService("MemoryStoreService")
local PermissionsService = FindService("PermissionsService")
local PlayerEmulatorService = FindService("PlayerEmulatorService")
local RtMessagingService = FindService("RtMessagingService")
local ScriptContext = FindService("ScriptContext")
local SocialService = FindService("SocialService")
local SoundService = FindService("SoundService")
local ThirdPartyUserService = FindService("ThirdPartyUserService")
local TracerService = FindService("TracerService")
local VideoCaptureService = FindService("VideoCaptureService")
local Players = GetService("Players")
local AnimationFromVideoCreatorService = FindService("AnimationFromVideoCreatorService")
local Stats = stats and stats() or Stats and Stats() or GetService("Stats")
local SessionService = FindService("SessionService")
local UserInputService = FindService("UserInputService")
local VirtualInputManager = FindService("VirtualInputManager")
local VirtualUser = FindService("VirtualUser")
local LogService = FindService("LogService")
local GuiService = FindService("GuiService")
local ContentProvider = FindService("ContentProvider")
local MeshContentProvider = FindService("MeshContentProvider")
local LocalizationService = FindService("LocalizationService")
local RunService = FindService("RunService")
local AnalyticsService = FindService("AnalyticsService")
local HapticService = FindService("HapticService")
local FriendService = FindService("FriendService")
local CoreScriptSyncService = FindService("CoreScriptSyncService")
local LocalPlayer = Players.LocalPlayer

-- Begin AllStepped --
local BindableEvent = Instance.new("BindableEvent")
local AllStepped = BindableEvent.Event

RunService.Heartbeat:Connect(function()
    BindableEvent:Fire()
end)
RunService.Stepped:Connect(function()
    BindableEvent:Fire()
end)
RunService.RenderStepped:Connect(function()
    BindableEvent:Fire()
end)
RunService:BindToRenderStep(tostring(math.random(1e9, 2e9)), 0, function()
    BindableEvent:Fire()
end)
task.spawn(function()
    while wait(0) do
        BindableEvent:Fire()
    end
end)
task.spawn(function()
    while task.wait(0) do
        BindableEvent:Fire()
    end
end)

--pcall wrap incase Roblox changes smth with these
pcall(function()
    RunService.PreSimulation:Connect(function()
        BindableEvent:Fire()
    end)
    RunService.PostSimulation:Connect(function()
        BindableEvent:Fire()
    end)
    RunService.PreAnimation:Connect(function()
        BindableEvent:Fire()
    end)
    RunService.PreRender:Connect(function()
        BindableEvent:Fire()
    end)
end)
-- End AllStepped --

-- Begin GFTB Bypassing --
local TextBoxIsInHiddenInstance = false

AllStepped:Connect(function()
    if UserInputService:GetFocusedTextBox() ~= nil and gethiddengui and UserInputService:GetFocusedTextBox():IsDescendantOf(gethiddengui()) or UserInputService:GetFocusedTextBox() ~= nil and gethui and UserInputService.GetFocusedTextBox(UserInputService):IsDescendantOf(gethui()) then
        TextBoxIsInHiddenInstance = true
    else
        if UserInputService:GetFocusedTextBox() ~= nil and gethiddengui and not UserInputService:GetFocusedTextBox():IsDescendantOf(gethiddengui()) or UserInputService:GetFocusedTextBox() ~= nil and gethui and not UserInputService.GetFocusedTextBox(UserInputService):IsDescendantOf(gethui()) then
            TextBoxIsInHiddenInstance = false
        end
    end
end)
UserInputService.TextBoxFocused:Connect(function()
    if UserInputService:GetFocusedTextBox() ~= nil and gethiddengui and UserInputService:GetFocusedTextBox():IsDescendantOf(gethiddengui()) or UserInputService:GetFocusedTextBox() ~= nil and gethui and UserInputService.GetFocusedTextBox(UserInputService):IsDescendantOf(gethui()) then
        TextBoxIsInHiddenInstance = true
    else
        if UserInputService:GetFocusedTextBox() ~= nil and gethiddengui and not UserInputService:GetFocusedTextBox():IsDescendantOf(gethiddengui()) or UserInputService:GetFocusedTextBox() ~= nil and gethui and not UserInputService.GetFocusedTextBox(UserInputService):IsDescendantOf(gethui()) then
            TextBoxIsInHiddenInstance = false
        end
    end
end)
UserInputService.TextBoxFocusReleased:Connect(function()
    if UserInputService:GetFocusedTextBox() ~= nil and gethiddengui and UserInputService:GetFocusedTextBox():IsDescendantOf(gethiddengui()) or UserInputService:GetFocusedTextBox() ~= nil and gethui and UserInputService.GetFocusedTextBox(UserInputService):IsDescendantOf(gethui()) then
        TextBoxIsInHiddenInstance = true
    else
        if UserInputService:GetFocusedTextBox() ~= nil and gethiddengui and not UserInputService:GetFocusedTextBox():IsDescendantOf(gethiddengui()) or UserInputService:GetFocusedTextBox() ~= nil and gethui and not UserInputService.GetFocusedTextBox(UserInputService):IsDescendantOf(gethui()) then
            TextBoxIsInHiddenInstance = false
        end
    end
end)
-- End GFTB Bypassing --

-- Begin GetHui and GetHiddenGui Removal Protection --
task.spawn(function()
    if gethui and gethui() and hookfunction then
        hookfunction(gethui().destroy, newcclosure(function() end))
        hookfunction(gethui().Destroy, newcclosure(function() end))
        hookfunction(gethui().remove, newcclosure(function() end))
        hookfunction(gethui().Remove, newcclosure(function() end))	
    end
end)

task.spawn(function()
    if gethiddengui and gethiddengui() and hookfunction then
        hookfunction(gethiddengui().destroy, newcclosure(function() end))
        hookfunction(gethiddengui().Destroy, newcclosure(function() end))
        hookfunction(gethiddengui().remove, newcclosure(function() end))
        hookfunction(gethiddengui().Remove, newcclosure(function() end))	
    end
end)
-- End GetHui and GetHiddenGui Removal Protection --

local math = math
local math_random = math.random
local math_randomseed = math.randomseed

-- Begin Anti Tracker --
task.spawn(function()
    if hookfunction ~= nil then
        math_randomseed(tick())
        local old_os_clock
        old_os_clock = hookfunction(os.clock, newcclosure(function(...)
            if not checkcaller() then
    		if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
                return math_random(1, 99999)
            end
    	    if checkcaller() then
                return old_os_clock(...)
    	    end
        end)
    end
end)
-- End Anti Tracker --

task.spawn(coroutine.create(function()
-- only hookfunctioning super unsafe and context level restricted stuff for now, will add the rest later --
if hookfunction ~= nil then
    if game ~= nil and pcall(function() tostring(game.Shutdown) end) then
    	local oldShutdown = hookfunction(game.Shutdown, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() and Self == game then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return oldShutdown(Self, ...)
    		end
		end))
    end
    if game ~= nil and pcall(function() tostring(game.ReportInGoogleAnalytics) end) then
    	local ReportInGoogleAnalytics = hookfunction(game.ReportInGoogleAnalytics, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() and Self == game then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return ReportInGoogleAnalytics(Self, ...)
    		end
		end))
    end
    if game ~= nil and pcall(function() tostring(game.OpenScreenshotsFolder) end) then
    	local OpenScreenshotsFolder = hookfunction(game.OpenScreenshotsFolder, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() and Self == game then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return OpenScreenshotsFolder(...)
    		end
		end))
    end
    if game ~= nil and pcall(function() tostring(game.OpenVideosFolder) end) then
    	local OpenVideosFolder = hookfunction(game.OpenVideosFolder, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return OpenVideosFolder(...)
    		end
		end))
    end
    if CoreGui ~= nil and pcall(function() tostring(CoreGui.SetUserGuiRendering) end) then
    	local SetUserGuiRendering = hookfunction(CoreGui.SetUserGuiRendering, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return SetUserGuiRendering(...)
    		end
		end))
    end
    if CoreGui ~= nil and pcall(function() tostring(CoreGui.TakeScreenshot) end) then
    	local TakeScreenshot = hookfunction(CoreGui.TakeScreenshot, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return TakeScreenshot(...)
    		end
		end))
    end
    if CoreGui ~= nil and pcall(function() tostring(CoreGui.ToggleRecording) end) then
    	local ToggleRecording = hookfunction(CoreGui.ToggleRecording, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return ToggleRecording...)
    		end
		end))
    end
    if Players ~= nil and pcall(function() tostring(Players.ReportAbuse) end) then
    	local ReportAbuse = hookfunction(Players.ReportAbuse, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return ReportAbuse(...)
    		end
		end))
    end
    if Players ~= nil and pcall(function() tostring(Players.ReportAbuseV3) end) then
    	local ReportAbuseV3 = hookfunction(Players.ReportAbuseV3, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return ReportAbuseV3(...)
    		end
		end))
    end
    if LocalPlayer ~= nil and pcall(function() tostring(LocalPlayer.Kick) end) then
    	local Kick = hookfunction(LocalPlayer.Kick, newcclosure(function(Self, ...) 
    		if checkcaller() and arg1 == LocalPlayer then
    			return
    		end 
    			elseif not checkcaller() and Self == LocalPlayer and type(...) == "string" or Self == LocalPlayer and (...) == nil then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return
    		end
    		        if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return Kick(Self, ...)
		end))
    end
    if LocalPlayer ~= nil and pcall(function() tostring(LocalPlayer.kick) end) then
    	local kick = hookfunction(LocalPlayer.kick, newcclosure(function(Self, ...) 
    		if checkcaller() and arg1 == LocalPlayer then
    			return
    		end 
    			elseif not checkcaller() and Self == LocalPlayer and type(...) == "string" or Self == LocalPlayer and (...) == nil then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return
    		end
    		        if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return kick(Self, ...)
		end))
    end
    if GuiService ~= nil and pcall(function() tostring(GuiService.ToggleFullscreen) end) then
    	local ToggleFullscreen = hookfunction(GuiService.ToggleFullscreen, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return ToggleFullscreen(...)
    		end
		end))
    end
    if GuiService ~= nil and pcall(function() tostring(GuiService.OpenBrowserWindow) end) then
    	local OpenBrowserWindow = hookfunction(GuiService.OpenBrowserWindow, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return OpenBrowserWindow(...)
    		end
		end))
    end
    if GuiService ~= nil and pcall(function() tostring(GuiService.OpenNativeOverlay) end) then
    	local OpenNativeOverlay = hookfunction(GuiService.OpenNativeOverlay, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return OpenNativeOverlay(...)
    		end
		end))
    end
    if HttpService ~= nil and pcall(function() tostring(HttpService.GetUserAgent) end) then
    	local GetUserAgent = hookfunction(HttpService.GetUserAgent, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return GetUserAgent(...)
    		end
		end))
    end
    if HttpService ~= nil and pcall(function() tostring(HttpService.RequestInternal) end) then
    	local RequestInternal = hookfunction(HttpService.RequestInternal, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return RequestInternal(...)
    		end
		end))
    end
    if ScriptContext ~= nil and pcall(function() tostring(ScriptContext.AddCoreScriptLocal) end) then
    	local AddCoreScriptLocal = hookfunction(ScriptContext.AddCoreScriptLocal, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return AddCoreScriptLocal(...)
    		end
		end))
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetOutputDevice) end) then
    	local GetOutputDevice = hookfunction(SoundService.GetOutputDevice, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return GetOutputDevice(...)
    		end
		end))
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetOutputDevices) end) then
    	local GetOutputDevices = hookfunction(SoundService.GetOutputDevices, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return GetOutputDevices(...)
    		end
		end))
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetOutputDevice) end) then
    	local GetOutputDevice = hookfunction(SoundService.GetOutputDevice, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return GetOutputDevice(...)
    		end
		end))
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetInputDevice) end) then
    	local GetInputDevice = hookfunction(SoundService.GetInputDevice, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return GetInputDevice(...)
    		end
		end))
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetInputDevices) end) then
    	local GetInputDevices = hookfunction(SoundService.GetInputDevices, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return GetInputDevices(...)
    		end
		end))
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.SetInputDevice) end) then
    	local SetInputDevice = hookfunction(SoundService.SetInputDevice, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return SetInputDevice(...)
    		end
		end))
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetRecordingDevices) end) then
    	local GetRecordingDevices = hookfunction(SoundService.GetRecordingDevices, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return GetRecordingDevices(...)
    		end
		end))
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.SetRecordingDevice) end) then
    	local SetRecordingDevice = hookfunction(SoundService.SetRecordingDevice, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return SetRecordingDevice(...)
    		end
		end))
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.BeginRecording) end) then
    	local BeginRecording = hookfunction(SoundService.BeginRecording, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return BeginRecording(...)
    		end
		end))
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.BeginRecording) end) then
    	local BeginRecording = hookfunction(SoundService.EndRecording, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return BeginRecording(...)
    		end
		end))
    end
    if LogService ~= nil and pcall(function() tostring(LogService.GetHttpResultHistory) end) then
    	local GetHttpResultHistory = hookfunction(LogService.GetHttpResultHistory, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return GetHttpResultHistory(...)
    		end
		end))
    end
    if VoiceChatInternal ~= nil and pcall(function() tostring(VoiceChatInternal.GetAudioProcessingSettings) end) then
    	local GetAudioProcessingSettings = hookfunction(VoiceChatInternal.GetAudioProcessingSettings, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return GetAudioProcessingSettings(...)
    		end
		end))
    end
    if VoiceChatInternal ~= nil and pcall(function() tostring(VoiceChatInternal.GetMicDevices) end) then
    	local GetMicDevices = hookfunction(VoiceChatInternal.GetMicDevices, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return GetMicDevices(...)
    		end
		end))
    end
    if VoiceChatInternal ~= nil and pcall(function() tostring(VoiceChatInternal.GetSpeakerDevices) end) then
    	local GetSpeakerDevices = hookfunction(VoiceChatInternal.GetSpeakerDevices, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return GetSpeakerDevices(...)
    		end
		end))
    end
    if VoiceChatInternal ~= nil and pcall(function() tostring(VoiceChatInternal.SetSpeakerDevice) end) then
    	local SetSpeakerDevice = hookfunction(VoiceChatInternal.SetSpeakerDevice, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return SetSpeakerDevice(...)
    		end
		end))
    end
    if VoiceChatInternal ~= nil and pcall(function() tostring(VoiceChatInternal.SetMicDevice) end) then
    	local SetMicDevice = hookfunction(VoiceChatInternal.SetMicDevice, newcclosure(function(...) 
    		if checkcaller() then
    			return
    		end 
    			elseif not checkcaller() then 
    			if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
    			return SetMicDevice(...)
    		end
		end))
    end
end
end))

-- Begin MORE GFTB Bypassing --
local OldGetFocusedTextBox

if gethui ~= nil and hookfunction ~= nil or gethiddengui ~= nil and hookfunction ~= nil then
OldGetFocusedTextBox = hookfunction(UserInputService.GetFocusedTextBox, newcclosure(function(...)		
    if not checkcaller() then
        if TextBoxIsInHiddenInstance then 
            if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
	    return nil
        end
    end
    if not checkcaller() then
        if not TextBoxIsInHiddenInstance then 
            if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
	    return OldGetFocusedTextBox(...)
        end
    end
    if checkcaller() then
        return OldGetFocusedTextBox(...)
    end
    if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
end))
end
-- End MORE GFTB Bypassing --

local OldNameCall = nil

OldNameCall = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
		
        if checkcaller() then
        local NameCallMethod = getnamecallmethod()

        if game ~= nil and Self == game and NameCallMethod == "Shutdown" then
            return
        end

        if game ~= nil and Self == game and NameCallMethod == "ReportInGoogleAnalytics" then
            return
        end

        if game ~= nil and Self == game and NameCallMethod == "OpenScreenshotsFolder" then
            return
        end

        if game ~= nil and Self == game and NameCallMethod == "OpenVideosFolder" then
            return
        end

        if CoreGui ~= nil and Self == CoreGui and NameCallMethod == "SetUserGuiRendering" then
            return
        end

        if CoreGui ~= nil and Self == CoreGui and NameCallMethod == "TakeScreenshot" then
            return
        end

        if CoreGui ~= nil and Self == CoreGui and NameCallMethod == "ToggleRecording" then
            return
        end

        if Players ~= nil and Self == Players and NameCallMethod == "ReportAbuse" then
            return
        end

        if Players ~= nil and Self == Players and NameCallMethod == "ReportAbuseV3" then
            return
        end

        if HttpService ~= nil and Self == HttpService and NameCallMethod == "GetUserAgent" then
            return
        end

        if HttpService ~= nil and Self == HttpService and NameCallMethod == "RequestInternal" then
            return
        end

        if ScriptContext ~= nil and Self == ScriptContext and NameCallMethod == "AddCoreScriptLocal" then
            return
        end

        if SoundService ~= nil and Self == SoundService and NameCallMethod == "BeginRecording" then
            return
        end

        if SoundService ~= nil and Self == SoundService and NameCallMethod == "EndRecording" then
            return
        end

        if SoundService ~= nil and Self == SoundService and NameCallMethod == "GetOutputDevice" then
            return
        end

        if SoundService ~= nil and Self == SoundService and NameCallMethod == "GetOutputDevices" then
            return
        end

        if SoundService ~= nil and Self == SoundService and NameCallMethod == "SetOutputDevice" then
            return
        end
        
        if SoundService ~= nil and Self == SoundService and NameCallMethod == "GetInputDevice" then
            return
        end

        if SoundService ~= nil and Self == SoundService and NameCallMethod == "GetInputDevices" then
            return
        end

        if SoundService ~= nil and Self == SoundService and NameCallMethod == "SetInputDevice" then
            return
        end

        if SoundService ~= nil and Self == SoundService and NameCallMethod == "GetRecordingDevices" then
            return
        end

        if SoundService ~= nil and Self == SoundService and NameCallMethod == "SetRecordingDevice" then
            return
        end

        if SocialService ~= nil and Self == SocialService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if VideoCaptureService ~= nil and Self == VideoCaptureService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if TracerService ~= nil and Self == TracerService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if ThirdPartyUserService ~= nil and Self == ThirdPartyUserService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if AppUpdateService ~= nil and Self == AppUpdateService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if RtMessagingService ~= nil and Self == RtMessagingService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if MemStorageService ~= nil and Self == MemStorageService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if MemoryStoreService ~= nil and Self == MemoryStoreService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if PermissionsService ~= nil and Self == PermissionsService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if PlayerEmulatorService ~= nil and Self == PlayerEmulatorService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if LoginService ~= nil and Self == LoginService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if EventIngestService ~= nil and Self == EventIngestService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if UserStorageService ~= nil and Self == UserStorageService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if LocalStorageService ~= nil and Self == LocalStorageService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if AppStorageService ~= nil and Self == AppStorageService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if DeviceIdService ~= nil and Self == DeviceIdService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if DataModelPatchService ~= nil and Self == DataModelPatchService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if FaceAnimatorService ~= nil and Self == FaceAnimatorService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if BrowserService ~= nil and Self == BrowserService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if RbxAnalyticsService ~= nil and Self == RbxAnalyticsService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if HttpRbxApiService ~= nil and Self == HttpRbxApiService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if MarketplaceService ~= nil and Self == MarketplaceService and NameCallMethod:find("Purchase") then
            return
        end

        if MarketplaceService ~= nil and Self == MarketplaceService and NameCallMethod:find("Prompt") then
            return
        end

        if MessageBusService ~= nil and Self == MessageBusService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if FacialAnimationStreamingService ~= nil and Self == FacialAnimationStreamingService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if VoiceChatInternal ~= nil and Self == VoiceChatInternal and NameCallMethod == "GetAudioProcessingSettings" then
            return
        end

        if VoiceChatInternal ~= nil and Self == VoiceChatInternal and NameCallMethod == "GetMicDevices" then
            return
        end

        if VoiceChatInternal ~= nil and Self == VoiceChatInternal and NameCallMethod == "GetSpeakerDevices" then
            return
        end

        if VoiceChatInternal ~= nil and Self == VoiceChatInternal and NameCallMethod == "SetMicDevice" then
            return
        end

        if VoiceChatInternal ~= nil and Self == VoiceChatInternal and NameCallMethod == "SetSpeakerDevice" then
            return
        end

        if AnimationFromVideoCreatorService ~= nil and Self == AnimationFromVideoCreatorService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if SessionService ~= nil and Self == SessionService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end
        
        if LogService ~= nil and Self == LogService and NameCallMethod == "GetHttpResultHistory" then
            return
        end

        if ContentProvider ~= nil and Self == ContentProvider and NameCallMethod == "GetFailedRequests" then
            return
        end

        if ContentProvider ~= nil and Self == ContentProvider and NameCallMethod == "GetDetailedFailedRequests" then
            return
        end

        if GuiService ~= nil and Self == GuiService and NameCallMethod == "OpenBrowserWindow" then
            return
        end

        if GuiService ~= nil and Self == GuiService and NameCallMethod == "OpenNativeOverlay" then
            return
        end

        if GuiService ~= nil and Self == GuiService and NameCallMethod == "ToggleFullscreen" then
            return
        end

        if AnalyticsService ~= nil and Self == AnalyticsService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if HapticService ~= nil and Self == HapticService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if FriendService ~= nil and Self == FriendService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        if CoreScriptSyncService ~= nil and Self == CoreScriptSyncService and NameCallMethod and not NameCallMethod == "Connect" and not NameCallMethod == "connect" then
            return
        end

        end

        if not checkcaller() then
        local NameCallMethod = getnamecallmethod()
        --local SanitizedNamecallMethod = SanitizeNamecallMethod(NameCallMethod) -- unused

        if UserInputService ~= nil and Self == UserInputService and NameCallMethod == "GetFocusedTextBox" and TextBoxIsInHiddenInstance then -- GFTB Bypassing
    	    if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
            return nil
	end
			
	--[[if UserInputService ~= nil and Self == UserInputService and SanitizedNamecallMethod == "GetFocusedTextBox" and TextBoxIsInHiddenInstance then -- (Unused) GFTB Bypassing
            return nil
	end]]--

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and NameCallMethod == "Kick" then -- hehe
    	    if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
            return
	end

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and NameCallMethod == "kick" then -- hehe
    	    if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
            return
	end

        end

	if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV) end
	return OldNameCall(Self, ...)
end))
