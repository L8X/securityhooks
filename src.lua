--- securityhooks.lua ---

--- report any issues to nul#3174 ---

local tostring = tostring
local pcall = pcall
local game = game
local getnamecallmethod = getnamecallmethod
local hookmetamethod = hookmetamethod
local hookfunction = hookfunction
local checkcaller = checkcaller
local getfenv = getfenv
local setfenv = setfenv
local _G = _G
local shared = shared
local type = type
local gethui = gethui or gethiddenui or hiddenui
local gethiddengui = gethiddengui

local genv = getfenv(0) or _G or shared

local getgenv = getgenv or function()
	return genv
end

if identifyexecutor and identifyexecutor() == "ScriptWare" then
	getrawmetatable(getfenv(0)).__index = getgenv()
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

if getrenv then
	task.spawn(function()
	local setreadonly = setreadonly or table.freeze
	_ENV = {
		assert = getrenv().assert;
		collectgarbage = getrenv().collectgarbage;
		error = getrenv().error;
		getfenv = getrenv().getfenv;
		getmetatable = getrenv().metatable;
		ipairs = getrenv().ipairs;
		loadstring = getrenv().loadstring;
		newproxy = getrenv().newproxy;
		next = getrenv().next;
		pairs = getrenv().pairs;
		ypcall = getrenv().ypcall;
		pcall = getrenv().pcall;
		print = getrenv().print;
		rawequal = getrenv().rawequal;
		rawget = getrenv().rawget;
		rawset = getrenv().rawset;
		select = getrenv().select;
		setfenv = getrenv().setfenv;
		setmetatable = getrenv().setmetatable;
		tonumber = getrenv().tonumber;
		tostring = getrenv().tostring;
		type = getrenv().type;
		unpack = getrenv().unpack;
		xpcall = getrenv().xpcall;
		_G = getrenv()._G;
		_VERSION = getrenv()._VERSION;
		delay = getrenv().delay;
		Delay = getrenv().Delay;
		DebuggerManager = getrenv().DebuggerManager;
		elapsedTime = getrenv().elapsedTime;
		gcinfo = getrenv().gcinfo;
		PluginManager = getrenv().PluginManager;
		printidentity = getrenv().printidentity;
		require = getrenv().require;
		settings = getrenv().settings;
		spawn = getrenv().spawn;
		Spawn = getrenv().Spawn;
		stats = getrenv().stats;
		Stats = getrenv().Stats;
		tick = getrenv().tick;
		time = getrenv().time;
		typeof = getrenv().typeof;
		UserSettings = getrenv().UserSettings;
		version = getrenv().version;
		Version = getrenv().Version;
		wait = getrenv().wait;
		Wait = getrenv().Wait;
		warn = getrenv().warn;
		Enum = getrenv().Enum;
		game = getrenv().game;
		Game = getrenv().Game;
		plugin = getrenv().plugin;
		shared = getrenv().shared;
		task = getrenv().task;
		coroutine = getrenv().coroutine;
		debug = getrenv().debug;
		os = getrenv().os;
		string = getrenv().string;
		math = getrenv().math;
		bit32 = getrenv().bit32;
		table = getrenv().table;
		utf8 = getrenv().utf8;
		TweenInfo = getrenv().TweenInfo;
		CFrame = getrenv().CFrame;
		Vector2 = getrenv().Vector2;
		Vector3 = getrenv().Vector3;
		UDim2 = getrenv().UDim2;
		Axes = getrenv().Axes;
		BrickColor = getrenv().BrickColor;
		CatalogSearchParams = getrenv().CatalogSearchParams;
		Color3 = getrenv().Color3;
		ColorSequence = getrenv().ColorSequence;
		ColorSequenceKeypoint = getrenv().ColorSequenceKeypoint;
		DateTime = getrenv().DateTime;
		DockWidgetPluginGuiInfo = getrenv().DockWidgetPluginGuiInfo;
		Faces = getrenv().Faces;
		FloatCurveKey = getrenv().FloatCurveKey;
		Font = getrenv().Font;
		Instance = getrenv().Instance;
		NumberRange = getrenv().NumberRange;
		NumberSequence = getrenv().NumberSequence;
		NumberSequenceKeypoint = getrenv().NumberSequenceKeypoint;
		OverlapParams = getrenv().OverlapParams;
		PathWaypoint = getrenv().PathWaypoint;
		PhysicalProperties = getrenv().PhysicalProperties;
		Random = getrenv().Random;
		Ray = getrenv().Ray;
		RaycastParams = getrenv().RaycastParams;
		Rect = getrenv().Rect;
		Region3 = getrenv().Region3;
		Region3int16 = getrenv().Region3int16;
		UDim = getrenv().UDim;
		Vector2int16 = getrenv().Vector2int16;
		Vector3int16 = getrenv().Vector3int16;
		script = nil;
		workspace = getrenv().workspace;
		Workspace = getrenv().Workspace;
		__metatable = "This metatable is locked";
	}
	pcall(function() setreadonly(_ENV, true) end)
	end)
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

local MessageBusService = GetService("MessageBusService")
local FacialAnimationStreamingService = FindService("FacialAnimationStreamingService")
local VoiceChatInternal = GetService("VoiceChatInternal")
local VoiceChatService = GetService("VoiceChatService")
local CoreGui = GetService("CoreGui")
local MarketplaceService = GetService("MarketplaceService")
local RbxAnalyticsService = GetService("RbxAnalyticsService")
local HttpRbxApiService = GetService("HttpRbxApiService")
local AppUpdateService = GetService("AppUpdateService")
local BrowserService = GetService("BrowserService")
local DataModelPatchService = GetService("DataModelPatchService")
local EventIngestService = GetService("EventIngestService")
local FaceAnimatorService = GetService("FaceAnimatorService")
local DeviceIdService = GetService("DeviceIdService")
local HttpService = GetService("HttpService")
local LocalStorageService = GetService("LocalStorageService")
local AppStorageService = GetService("AppStorageService")
local UserStorageService = GetService("UserStorageService")
local LoginService = GetService("LoginService")
local MemStorageService = GetService("MemStorageService")
local MemoryStoreService = GetService("MemoryStoreService")
local PermissionsService = GetService("PermissionsService")
local PlayerEmulatorService = GetService("PlayerEmulatorService")
local RtMessagingService = GetService("RtMessagingService")
local ScriptContext = GetService("ScriptContext")
local SocialService = GetService("SocialService")
local SoundService = GetService("SoundService")
local ThirdPartyUserService = GetService("ThirdPartyUserService")
local TracerService = GetService("TracerService")
local VideoCaptureService = GetService("VideoCaptureService")
local Players = GetService("Players")
local AnimationFromVideoCreatorService = FindService("AnimationFromVideoCreatorService")
local Stats = stats and stats() or Stats and Stats() or GetService("Stats")
local SessionService = GetService("SessionService")
local UserInputService = GetService("UserInputService")
local VirtualInputManager = FindService("VirtualInputManager")
local VirtualUser = FindService("VirtualUser")
local LogService = GetService("LogService")
local GuiService = GetService("GuiService")
local ContentProvider = GetService("ContentProvider")
local MeshContentProvider = GetService("MeshContentProvider")
local LocalizationService = GetService("LocalizationService")
local RunService = GetService("RunService")
local AnalyticsService = GetService("AnalyticsService")
local HapticService = GetService("HapticService")
local FriendService = GetService("FriendService")
local CoreScriptSyncService = GetService("CoreScriptSyncService")
local LocalPlayer = Players.LocalPlayer

local function IsTextBoxInGetHiddenUi()
    if not gethui then
        return
    end
    local TextBox = UserInputService:GetFocusedTextBox()
    if TextBox ~= nil and TextBox:IsDescendantOf(gethui()) then 
        return true
    else 
        return false
    end
end

local function IsTextBoxInGetHiddenGui()
    if not gethiddengui then
        return
    end
    local TextBox = UserInputService:GetFocusedTextBox()
    if TextBox ~= nil and TextBox:IsDescendantOf(gethiddengui()) then  
        return true
    else 
        return false
    end
end

task.spawn(coroutine.create(function()
-- wait until game is loaded to ensure error 268 doesn't occur
if not game:IsLoaded() then
    game.Loaded:Wait()
end
-- only hookfunctioning super unsafe and context level restricted stuff for now, will add the rest later --
if hookfunction ~= nil then
    if game ~= nil and pcall(function() tostring(game.Shutdown) end) then
        hookfunction(game.Shutdown, function() end)
    end
    if game ~= nil and pcall(function() tostring(game.ReportInGoogleAnalytics) end) then
        hookfunction(game.ReportInGoogleAnalytics, function() end)
    end
    if game ~= nil and pcall(function() tostring(game.OpenScreenshotsFolder) end) then
        hookfunction(game.OpenScreenshotsFolder, function() end)
    end
    if game ~= nil and pcall(function() tostring(game.OpenVideosFolder) end) then
        hookfunction(game.OpenVideosFolder, function() end)
    end
    if CoreGui ~= nil and pcall(function() tostring(CoreGui.SetUserGuiRendering) end) then
        hookfunction(CoreGui.SetUserGuiRendering, function() end)
    end
    if CoreGui ~= nil and pcall(function() tostring(CoreGui.TakeScreenshot) end) then
        hookfunction(CoreGui.TakeScreenshot, function() end)
    end
    if CoreGui ~= nil and pcall(function() tostring(CoreGui.ToggleRecording) end) then
        hookfunction(CoreGui.SetUserGuiRendering, function() end)
    end
    if Players ~= nil and pcall(function() tostring(Players.ReportAbuse) end) then
        hookfunction(Players.ReportAbuse, function() end)
    end
    if Players ~= nil and pcall(function() tostring(Players.ReportAbuseV3) end) then
        hookfunction(Players.ReportAbuseV3, function() end)
    end
    if GuiService ~= nil and pcall(function() tostring(GuiService.ToggleFullscreen) end) then
        hookfunction(GuiService.ToggleFullscreen, function() end)
    end
    if GuiService ~= nil and pcall(function() tostring(GuiService.OpenBrowserWindow) end) then
        hookfunction(GuiService.OpenBrowserWindow, function() end)
    end
    if GuiService ~= nil and pcall(function() tostring(GuiService.OpenNativeOverlay) end) then
        hookfunction(GuiService.OpenNativeOverlay, function() end)
    end
    if HttpService ~= nil and pcall(function() tostring(HttpService.GetUserAgent) end) then
        hookfunction(HttpService.GetUserAgent, function() end)
    end
    if HttpService ~= nil and pcall(function() tostring(HttpService.RequestInternal) end) then
        hookfunction(HttpService.RequestInternal, function() end)
    end
    if ScriptContext ~= nil and pcall(function() tostring(ScriptContext.AddCoreScriptLocal) end) then
        hookfunction(ScriptContext.AddCoreScriptLocal, function() end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetOutputDevice) end) then
        hookfunction(SoundService.GetOutputDevice, function() end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetOutputDevices) end) then
        hookfunction(SoundService.GetOutputDevices, function() end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.SetOutputDevice) end) then
        hookfunction(SoundService.SetOutputDevice, function() end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetRecordingDevices) end) then
        hookfunction(SoundService.GetRecordingDevices, function() end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.SetRecordingDevice) end) then
        hookfunction(SoundService.SetRecordingDevice, function() end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.BeginRecording) end) then
        hookfunction(SoundService.BeginRecording, function() end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.EndRecording) end) then
        hookfunction(SoundService.EndRecording, function() end)
    end
    if LogService ~= nil and pcall(function() tostring(LogService.GetHttpResultHistory) end) then
        hookfunction(LogService.GetHttpResultHistory, function() end)
    end
end
end))]]--

if gethui ~= nil or gethiddengui ~= nil and hookfunction then
local OldGetFocusedTextBox = nil
OldGetFocusedTextBox = hookfunction(UserInputService.GetFocusedTextBox, function()
    local Is_TB_In_gethui = IsTextBoxInGetHiddenUi
    local Is_TB_In_gethiddengui = IsTextBoxInGetHiddenGui		
    if not checkcaller() then
        if gethui ~= nil and UserInputService ~= nil and Is_TB_In_gethui() then
	    return nil
        end
        if gethiddengui ~= nil and UserInputService ~= nil and Is_TB_In_gethiddengui() then
            return nil
        end
        if gethui ~= nil and UserInputService ~= nil and not Is_TB_In_gethui() then
            return UserInputService:GetFocusedTextBox()
        end
        if gethiddengui ~= nil and UserInputService ~= nil and not Is_TB_In_gethiddengui() then
            return UserInputService:GetFocusedTextBox()
        end
    end
    if checkcaller() then
        return UserInputService:GetFocusedTextBox()
    end
end)
end

if hookfunction and gethui and gethui() then
    hookfunction(gethui().destroy, function() end)
    hookfunction(gethui().Destroy, function() end)
    hookfunction(gethui().remove, function() end)
    hookfunction(gethui().Remove, function() end)
end

if hookfunction and gethiddengui and gethiddengui() then
    hookfunction(gethiddengui().destroy, function() end)
    hookfunction(gethiddengui().Destroy, function() end)
    hookfunction(gethiddengui().remove, function() end)
    hookfunction(gethiddengui().Remove, function() end)
end

local OldNameCall = nil

OldNameCall =
    hookmetamethod(
    game,
    "__namecall",
    function(Self, ...)
	local Is_TB_In_gethui = IsTextBoxInGetHiddenUi
        local Is_TB_In_gethiddengui = IsTextBoxInGetHiddenGui
        if checkcaller() then
        
        local NameCallMethod = getnamecallmethod()

	if game ~= nil and Self == game and tostring(NameCallMethod) == "Shutdown" then
            return
        end		
	
        if game ~= nil and Self == game and tostring(NameCallMethod) == "ReportInGoogleAnalytics" then
            return
        end

        if game ~= nil and Self == game and tostring(NameCallMethod) == "OpenScreenshotsFolder" then
            return
        end

        if game ~= nil and Self == game and tostring(NameCallMethod) == "OpenVideosFolder" then
            return
        end

        if CoreGui ~= nil and Self == CoreGui and tostring(NameCallMethod) == "SetUserGuiRendering" then
            return
        end

        if CoreGui ~= nil and Self == CoreGui and tostring(NameCallMethod) == "TakeScreenshot" then
            return
        end

        if CoreGui ~= nil and Self == CoreGui and tostring(NameCallMethod) == "ToggleRecording" then
            return
        end

        if Players ~= nil and Self == Players and tostring(NameCallMethod) == "ReportAbuse" then
            return
        end

        if Players ~= nil and Self == Players and tostring(NameCallMethod) == "ReportAbuseV3" then
            return
        end

        if HttpService ~= nil and Self == HttpService and tostring(NameCallMethod) == "GetUserAgent" then
            return
        end

        if HttpService ~= nil and Self == HttpService and tostring(NameCallMethod) == "RequestInternal" then
            return
        end

        if ScriptContext ~= nil and Self == ScriptContext and tostring(NameCallMethod) == "AddCoreScriptLocal" then
            return
        end

        if SoundService ~= nil and Self == SoundService and tostring(NameCallMethod) == "BeginRecording" then
            return
        end

        if SoundService ~= nil and Self == SoundService and tostring(NameCallMethod) == "EndRecording" then
            return
        end

        if SoundService ~= nil and Self == SoundService and tostring(NameCallMethod) == "GetOutputDevice" then
            return
        end

        if SoundService ~= nil and Self == SoundService and tostring(NameCallMethod) == "GetOutputDevices" then
            return
        end

        if SoundService ~= nil and Self == SoundService and tostring(NameCallMethod) == "GetRecordingDevices" then
            return
        end

        if SoundService ~= nil and Self == SoundService and tostring(NameCallMethod) == "SetOutputDevice" then
            return
        end

        if SoundService ~= nil and Self == SoundService and tostring(NameCallMethod) == "SetRecordingDevice" then
            return
        end

        if SocialService ~= nil and Self == SocialService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if VideoCaptureService ~= nil and Self == VideoCaptureService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if TracerService ~= nil and Self == TracerService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if ThirdPartyUserService ~= nil and Self == ThirdPartyUserService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if AppUpdateService ~= nil and Self == AppUpdateService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if RtMessagingService ~= nil and Self == RtMessagingService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if MemStorageService ~= nil and Self == MemStorageService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if MemoryStoreService ~= nil and Self == MemoryStoreService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if PermissionsService ~= nil and Self == PermissionsService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if PlayerEmulatorService ~= nil and Self == PlayerEmulatorService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if LoginService ~= nil and Self == LoginService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if EventIngestService ~= nil and Self == EventIngestService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if UserStorageService ~= nil and Self == UserStorageService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if LocalStorageService ~= nil and Self == LocalStorageService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if AppStorageService ~= nil and Self == AppStorageService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if DeviceIdService ~= nil and Self == DeviceIdService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if DataModelPatchService ~= nil and Self == DataModelPatchService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if FaceAnimatorService ~= nil and Self == FaceAnimatorService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if BrowserService ~= nil and Self == BrowserService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if RbxAnalyticsService ~= nil and Self == RbxAnalyticsService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if HttpRbxApiService ~= nil and Self == HttpRbxApiService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if MarketplaceService ~= nil and Self == MarketplaceService and tostring(NameCallMethod):find("Purchase") then
            return
        end
            
        if MarketplaceService ~= nil and Self == MarketplaceService and tostring(NameCallMethod):find("Prompt") then
            return
        end
            
        if MessageBusService ~= nil and Self == MessageBusService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if FacialAnimationStreamingService ~= nil and Self == FacialAnimationStreamingService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if VoiceChatInternal ~= nil and Self == VoiceChatInternal and tostring(NameCallMethod) == "GetAudioProcessingSettings" then
            return
        end
        
        if VoiceChatInternal ~= nil and Self == VoiceChatInternal and tostring(NameCallMethod) == "GetMicDevices" then
            return
        end
        
        if VoiceChatInternal ~= nil and Self == VoiceChatInternal and tostring(NameCallMethod) == "GetSpeakerDevices" then
            return
        end
        
        if VoiceChatInternal ~= nil and Self == VoiceChatInternal and tostring(NameCallMethod) == "SetMicDevice" then
            return
        end
        
        if VoiceChatInternal ~= nil and Self == VoiceChatInternal and tostring(NameCallMethod) == "SetSpeakerDevice" then
            return
        end
        
        if AnimationFromVideoCreatorService ~= nil and Self == AnimationFromVideoCreatorService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end
        
        if Stats ~= nil and Self == Stats and tostring(NameCallMethod) == "GetBrowserTrackerId" then
            return
        end
        
        if Stats ~= nil and Self == Stats and tostring(NameCallMethod) == "GetPaginatedMemoryByTexture" then
            return
        end
        
        if SessionService ~= nil and Self == SessionService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end
        
        if UserInputService ~= nil and Self == UserInputService and tostring(NameCallMethod) == "GetDeviceType" then
            return
        end
        
        if UserInputService ~= nil and Self == UserInputService and tostring(NameCallMethod) == "GetPlatform" then
            return
        end
        
        if UserInputService ~= nil and Self == UserInputService and tostring(NameCallMethod) == "SendAppUISizes" then
            return
        end
        
        if VirtualInputManager ~= nil and Self == VirtualInputManager and tostring(NameCallMethod) == "Dump" then
            return
        end
        
        if VirtualInputManager ~= nil and Self == VirtualInputManager and tostring(NameCallMethod) == "StartPlaying" then
            return
        end
        
        if VirtualInputManager ~= nil and Self == VirtualInputManager and tostring(NameCallMethod) == "StartPlayingJSON" then
            return
        end
        
        if VirtualInputManager ~= nil and Self == VirtualInputManager and tostring(NameCallMethod) == "StopPlaying" then
            return
        end
        
        if VirtualInputManager ~= nil and Self == VirtualInputManager and tostring(NameCallMethod) == "sendRobloxEvent" then
            return
        end
        
        if VirtualInputManager ~= nil and Self == VirtualInputManager and tostring(NameCallMethod) == "sendThemeChangeEvent" then
            return
        end

        if VirtualUser ~= nil and Self == VirtualUser and tostring(NameCallMethod) == "CaptureController" then
            return
        end

        if LogService ~= nil and Self == LogService and tostring(NameCallMethod) == "GetHttpResultHistory" then
            return
        end

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and tostring(NameCallMethod) == "GetGameSessionID" then
            return
        end

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and tostring(NameCallMethod) == "SetExperienceSettingsLocaleId" then
            return
        end

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and tostring(NameCallMethod) == "SetUnder13" then
            return
        end

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and tostring(NameCallMethod) == "GetUnder13" then
            return
        end

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and tostring(NameCallMethod) == "SetModerationAccessKey" then
            return
        end

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and tostring(NameCallMethod) == "RevokeFriendship" then
            return
        end

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and tostring(NameCallMethod) == "RequestFriendship" then
            return
        end

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and tostring(NameCallMethod) == "UpdatePlayerBlocked" then
            return
        end

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and tostring(NameCallMethod) == "SetSuperSafeChat" then
            return
        end

        if Players ~= nil and LocalPlayer ~= nil and Self == LocalPlayer and tostring(NameCallMethod) == "AddToBlockList" then
            return
        end

        if ContentProvider ~= nil and Self == ContentProvider and tostring(NameCallMethod) == "SetBaseUrl" then
            return
        end

        if ContentProvider ~= nil and Self == ContentProvider and tostring(NameCallMethod) == "GetFailedRequests" then
            return
        end

        if ContentProvider ~= nil and Self == ContentProvider and tostring(NameCallMethod) == "GetDetailedFailedRequests" then
            return
        end

        if MeshContentProvider ~= nil and Self == MeshContentProvider and tostring(NameCallMethod) == "PromptDownloadGameTableToCSV" then
            return
        end

        if LocalizationService ~= nil and Self == LocalizationService and tostring(NameCallMethod) == "PromptExportToCSVs" then
            return
        end

        if LocalizationService ~= nil and Self == LocalizationService and tostring(NameCallMethod) == "PromptImportFromCSVs" then
            return
        end

        if LocalizationService ~= nil and Self == LocalizationService and tostring(NameCallMethod) == "PromptUploadCSVToGameTable" then
            return
        end

        if LocalizationService ~= nil and Self == LocalizationService and tostring(NameCallMethod) == "SetExperienceSettingsLocaleId" then
            return
        end

        if LocalizationService ~= nil and Self == LocalizationService and tostring(NameCallMethod) == "SetRobloxLocaleId" then
            return
        end

        if LocalizationService ~= nil and Self == LocalizationService and tostring(NameCallMethod) == "StartTextScraper" then
            return
        end

        if GuiService ~= nil and Self == GuiService and tostring(NameCallMethod) == "OpenBrowserWindow" then
            return
        end

        if GuiService ~= nil and Self == GuiService and tostring(NameCallMethod) == "OpenNativeOverlay" then
            return
        end

        if GuiService ~= nil and Self == GuiService and tostring(NameCallMethod) == "ToggleFullscreen" then
            return
        end

        if GuiService ~= nil and Self == GuiService and tostring(NameCallMethod) == "SetHardwareSafeAreaInsets" then
            return
        end

        if RunService ~= nil and Self == RunService and tostring(NameCallMethod) == "Pause" then
            return
        end

        if RunService ~= nil and Self == RunService and tostring(NameCallMethod) == "Reset" then
            return
        end

        if RunService ~= nil and Self == RunService and tostring(NameCallMethod) == "Run" then
            return
        end

        if RunService ~= nil and Self == RunService and tostring(NameCallMethod) == "Stop" then
            return
        end

        if RunService ~= nil and Self == RunService and tostring(NameCallMethod) == "SetRobloxGuiFocused" then
            return
        end

        if RunService ~= nil and Self == RunService and tostring(NameCallMethod) == "setThrottleFramerateEnabled" then
            return
        end

        if AnalyticsService ~= nil and Self == AnalyticsService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if HapticService ~= nil and Self == HapticService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if FriendService ~= nil and Self == FriendService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end

        if CoreScriptSyncService ~= nil and Self == CoreScriptSyncService and tostring(NameCallMethod) and not tostring(NameCallMethod) == "Connect" and not tostring(NameCallMethod) == "connect" then
            return
        end
	
	if gethui ~= nil and type(gethui) == "function" and typeof(gethui()) == "Instance" and Self == gethui() and tostring(NameCallMethod) == "destroy" then
	    return
        end
			
	if gethui ~= nil and type(gethui) == "function" and typeof(gethui()) == "Instance" and Self == gethui() and tostring(NameCallMethod) == "Destroy" then
	    return
        end
			
	if gethui ~= nil and type(gethui) == "function" and typeof(gethui()) == "Instance" and Self == gethui() and tostring(NameCallMethod) == "remove" then
	    return
        end
			
	if gethui ~= nil and type(gethui) == "function" and typeof(gethui()) == "Instance" and Self == gethui() and tostring(NameCallMethod) == "Remove" then
	    return
        end
			
	if gethiddengui ~= nil and type(gethiddengui) == "function" and typeof(gethiddengui()) == "Instance" and Self == gethiddengui() and tostring(NameCallMethod) == "destroy" then
	    return
        end
			
	if gethiddengui ~= nil and type(gethiddengui) == "function" and typeof(gethiddengui()) == "Instance" and Self == gethiddengui() and tostring(NameCallMethod) == "Destroy" then
	    return
        end
			
	if gethiddengui ~= nil and type(gethiddengui) == "function" and typeof(gethiddengui()) == "Instance" and Self == gethiddengui() and tostring(NameCallMethod) == "remove" then
	    return
        end
			
	if gethiddengui ~= nil and type(gethiddengui) == "function" and typeof(gethiddengui()) == "Instance" and Self == gethiddengui() and tostring(NameCallMethod) == "Remove" then
	    return
        end

        if not checkcaller() then
	
        if gethui ~= nil and UserInputService ~= nil and Self == UserInputService and tostring(NameCallMethod) == "GetFocusedTextBox" and Is_TB_In_gethui() then
            return nil
        end

        if gethiddengui ~= nil and UserInputService ~= nil and Self == UserInputService and tostring(NameCallMethod) == "GetFocusedTextBox" and Is_TB_In_gethiddengui() then
            return nil
        end

        end

	if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV or {}) end
        return OldNameCall(Self, ...)
    end
)
