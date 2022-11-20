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
local gethui = gethui or gethiddenui or hiddenui
local gethiddengui = gethiddengui
local cloneref = cloneref

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

local string = string
local string_gsub = string.gsub 

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

local MessageBusService = FindService("MessageBusService")
local FacialAnimationStreamingService = FindService("FacialAnimationStreamingService")
local VoiceChatInternal = FindService("VoiceChatInternal")
local VoiceChatService = FindService("VoiceChatService")
local CoreGui = GetService("CoreGui")
local MarketplaceService = GetService("MarketplaceService")
local RbxAnalyticsService = FindService("RbxAnalyticsService")
local HttpRbxApiService = FindService("HttpRbxApiService")
local AppUpdateService = FindService("AppUpdateService")
local BrowserService = FindService("BrowserService")
local DataModelPatchService = FindService("DataModelPatchService")
local EventIngestService = FindService("EventIngestService")
local FaceAnimatorService = FindService("FaceAnimatorService")
local DeviceIdService = FindService("DeviceIdService")
local HttpService = GetService("HttpService")
local LocalStorageService = FindService("LocalStorageService")
local AppStorageService = FindService("AppStorageService")
local UserStorageService = FindService("UserStorageService")
local LoginService = FindService("LoginService")
local MemStorageService = FindService("MemStorageService")
local MemoryStoreService = FindService("MemoryStoreService")
local PermissionsService = FindService("PermissionsService")
local PlayerEmulatorService = FindService("PlayerEmulatorService")
local RtMessagingService = FindService("RtMessagingService")
local ScriptContext = GetService("ScriptContext")
local SocialService = FindService("SocialService")
local SoundService = GetService("SoundService")
local ThirdPartyUserService = FindService("ThirdPartyUserService")
local TracerService = FindService("TracerService")
local VideoCaptureService = FindService("VideoCaptureService")
local Players = GetService("Players")
local AnimationFromVideoCreatorService = FindService("AnimationFromVideoCreatorService")
local Stats = stats and stats() or Stats and Stats() or GetService("Stats")
local SessionService = FindService("SessionService")
local UserInputService = GetService("UserInputService")
local VirtualInputManager = FindService("VirtualInputManager")
local VirtualUser = FindService("VirtualUser")
local LogService = GetService("LogService")
local GuiService = GetService("GuiService")
local ContentProvider = GetService("ContentProvider")
local MeshContentProvider = FindService("MeshContentProvider")
local LocalizationService = GetService("LocalizationService")
local RunService = GetService("RunService")
local AnalyticsService = GetService("AnalyticsService")
local HapticService = FindService("HapticService")
local FriendService = FindService("FriendService")
local CoreScriptSyncService = FindService("CoreScriptSyncService")
local LocalPlayer = Players.LocalPlayer


local BindableEvent = Instance.new("BindableEvent")
local AllStepped = BindableEvent.Event

RunService.Heartbeat:Connect(function()
    BindableEvent:Fire()
end)

RunService.Stepped:Connect(function()
    BindableEvent:Fire()
end)

RunService.Stepped:Connect(function()
    BindableEvent:Fire()
end)

RunService.RenderStepped:Connect(function()
    BindableEvent:Fire()
end)

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

task.spawn(function()
if gethui and gethui() and hookfunction then
hookfunction(gethui().destroy, function() end)
hookfunction(gethui().Destroy, function() end)
hookfunction(gethui().remove, function() end)
hookfunction(gethui().Remove, function() end)	
end
end)

task.spawn(function()
if gethiddengui and gethiddengui() and hookfunction then
hookfunction(gethiddengui().destroy, function() end)
hookfunction(gethiddengui().Destroy, function() end)
hookfunction(gethiddengui().remove, function() end)
hookfunction(gethiddengui().Remove, function() end)	
end
end)


task.spawn(coroutine.create(function()
-- potential 268 fix
if not game:IsLoaded() then
    game.Loaded:Wait()
end
-- only hookfunctioning super unsafe and context level restricted stuff for now, will add the rest later --
if hookfunction ~= nil then
    if game ~= nil and pcall(function() tostring(game.Shutdown) end) then
    	local oldShutdown = hookfunction(game.Shutdown, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return oldShutdown(arg1)
    		end
		end)
    end
    if game ~= nil and pcall(function() tostring(game.ReportInGoogleAnalytics) end) then
    	local ReportInGoogleAnalytics = hookfunction(game.ReportInGoogleAnalytics, function(arg1, arg2, arg3, arg4) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return ReportInGoogleAnalytics(arg1, arg2, arg3, arg4)
    		end
		end)
    end
    if game ~= nil and pcall(function() tostring(game.OpenScreenshotsFolder) end) then
    	local OpenScreenshotsFolder = hookfunction(game.OpenScreenshotsFolder, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return OpenScreenshotsFolder(arg1)
    		end
		end)
    end
    if game ~= nil and pcall(function() tostring(game.OpenVideosFolder) end) then
    	local OpenVideosFolder = hookfunction(game.OpenVideosFolder, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return OpenVideosFolder(arg1)
    		end
		end)
    end
    if CoreGui ~= nil and pcall(function() tostring(CoreGui.SetUserGuiRendering) end) then
    	local SetUserGuiRendering = hookfunction(CoreGui.SetUserGuiRendering, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return SetUserGuiRendering(arg1)
    		end
		end)
    end
    if CoreGui ~= nil and pcall(function() tostring(CoreGui.TakeScreenshot) end) then
    	local TakeScreenshot = hookfunction(CoreGui.TakeScreenshot, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return TakeScreenshot(arg1)
    		end
		end)
    end
    if CoreGui ~= nil and pcall(function() tostring(CoreGui.ToggleRecording) end) then
    	local ToggleRecording = hookfunction(CoreGui.ToggleRecording, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return ToggleRecording(arg1)
    		end
		end)
    end
    if Players ~= nil and pcall(function() tostring(Players.ReportAbuse) end) then
    	local ReportAbuse = hookfunction(Players.ReportAbuse, function(arg1, arg2, arg3) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return ReportAbuse(arg1, arg2, arg3)
    		end
		end)
    end
    if Players ~= nil and pcall(function() tostring(Players.ReportAbuseV3) end) then
    	local ReportAbuseV3 = hookfunction(Players.ReportAbuseV3, function(arg1, arg2) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return ReportAbuseV3(arg1, arg2)
    		end
		end)
    end
    if GuiService ~= nil and pcall(function() tostring(GuiService.ToggleFullscreen) end) then
    	local ToggleFullscreen = hookfunction(GuiService.ToggleFullscreen, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return ToggleFullscreen(arg1)
    		end
		end)
    end
    if GuiService ~= nil and pcall(function() tostring(GuiService.OpenBrowserWindow) end) then
    	local OpenBrowserWindow = hookfunction(GuiService.OpenBrowserWindow, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return OpenBrowserWindow(arg1)
    		end
		end)
    end
    if GuiService ~= nil and pcall(function() tostring(GuiService.OpenNativeOverlay) end) then
    	local OpenNativeOverlay = hookfunction(GuiService.OpenNativeOverlay, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return OpenNativeOverlay(arg1)
    		end
		end)
    end
    if HttpService ~= nil and pcall(function() tostring(HttpService.GetUserAgent) end) then
    	local GetUserAgent = hookfunction(HttpService.GetUserAgent, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return GetUserAgent(arg1)
    		end
		end)
    end
    if HttpService ~= nil and pcall(function() tostring(HttpService.RequestInternal) end) then
    	local RequestInternal = hookfunction(HttpService.RequestInternal, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return RequestInternal(arg1)
    		end
		end)
    end
    if ScriptContext ~= nil and pcall(function() tostring(ScriptContext.AddCoreScriptLocal) end) then
    	local AddCoreScriptLocal = hookfunction(ScriptContext.AddCoreScriptLocal, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return AddCoreScriptLocal(arg1)
    		end
		end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetOutputDevice) end) then
    	local GetOutputDevice = hookfunction(SoundService.GetOutputDevice, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return GetOutputDevice(arg1)
    		end
		end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetOutputDevices) end) then
    	local GetOutputDevices = hookfunction(SoundService.GetOutputDevices, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return GetOutputDevices(arg1)
    		end
		end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetOutputDevice) end) then
    	local GetOutputDevice = hookfunction(SoundService.GetOutputDevice, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return GetOutputDevice(arg1)
    		end
		end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetInputDevice) end) then
    	local GetInputDevice = hookfunction(SoundService.GetInputDevice, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return GetInputDevice(arg1)
    		end
		end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetInputDevices) end) then
    	local GetInputDevices = hookfunction(SoundService.GetInputDevices, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return GetInputDevices(arg1)
    		end
		end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.SetInputDevice) end) then
    	local SetInputDevice = hookfunction(SoundService.SetInputDevice, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return SetInputDevice(arg1)
    		end
		end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.GetRecordingDevices) end) then
    	local GetRecordingDevices = hookfunction(SoundService.GetRecordingDevices, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return GetRecordingDevices(arg1)
    		end
		end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.SetRecordingDevice) end) then
    	local SetRecordingDevice = hookfunction(SoundService.SetRecordingDevice, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return SetRecordingDevice(arg1)
    		end
		end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.BeginRecording) end) then
    	local BeginRecording = hookfunction(SoundService.BeginRecording, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return BeginRecording(arg1)
    		end
		end)
    end
    if SoundService ~= nil and pcall(function() tostring(SoundService.BeginRecording) end) then
    	local BeginRecording = hookfunction(SoundService.EndRecording, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return BeginRecording(arg1)
    		end
		end)
    end
    if LogService ~= nil and pcall(function() tostring(LogService.GetHttpResultHistory) end) then
    	local GetHttpResultHistory = hookfunction(LogService.GetHttpResultHistory, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return GetHttpResultHistory(arg1)
    		end
		end)
    end
    if VoiceChatInternal ~= nil and pcall(function() tostring(VoiceChatInternal.GetAudioProcessingSettings) end) then
    	local GetAudioProcessingSettings = hookfunction(VoiceChatInternal.GetAudioProcessingSettings, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return GetAudioProcessingSettings(arg1)
    		end
		end)
    end
    if VoiceChatInternal ~= nil and pcall(function() tostring(VoiceChatInternal.GetMicDevices) end) then
    	local GetMicDevices = hookfunction(VoiceChatInternal.GetMicDevices, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return GetMicDevices(arg1)
    		end
		end)
    end
    if VoiceChatInternal ~= nil and pcall(function() tostring(VoiceChatInternal.GetSpeakerDevices) end) then
    	local GetSpeakerDevices = hookfunction(VoiceChatInternal.GetSpeakerDevices, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return GetSpeakerDevices(arg1)
    		end
		end)
    end
    if VoiceChatInternal ~= nil and pcall(function() tostring(VoiceChatInternal.SetSpeakerDevice) end) then
    	local SetSpeakerDevice = hookfunction(VoiceChatInternal.SetSpeakerDevice, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return SetSpeakerDevice(arg1)
    		end
		end)
    end
    if VoiceChatInternal ~= nil and pcall(function() tostring(VoiceChatInternal.SetMicDevice) end) then
    	local SetMicDevice = hookfunction(VoiceChatInternal.SetMicDevice, function(arg1) 
    		if checkcaller() then
    			return function()
    		end 
    			elseif not checkcaller() then
    			return SetMicDevice(arg1)
    		end
		end)
    end
end
end))


task.spawn(function()
if gethui ~= nil and hookfunction ~= nil or gethiddengui ~= nil and hookfunction ~= nil then
OldGetFocusedTextBox = hookfunction(UserInputService.GetFocusedTextBox, function(arg1)		
    if not checkcaller() then
        if TextBoxIsInHiddenInstance then 
	    return nil
        end
    end
    if checkcaller() then
        return OldGetFocusedTextBox(arg1)
    end
end)
end
end)

local OldNameCall = nil

OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
		
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
        local SanitizedNamecallMethod = SanitizeNamecallMethod(NameCallMethod)


        if UserInputService ~= nil and Self == UserInputService and NameCallMethod == "GetFocusedTextBox" and TextBoxIsInHiddenInstance then
            return nil
	end
			
	if UserInputService ~= nil and Self == UserInputService and SanitizedNamecallMethod == "GetFocusedTextBox" and TextBoxIsInHiddenInstance then
            return nil
	end

        end

	if identifyexecutor and not identifyexecutor():find("Synapse") then setfenv(1, _ENV or {}) end
	return OldNameCall(Self, ...)
end)
