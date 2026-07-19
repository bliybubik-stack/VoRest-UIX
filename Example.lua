-- Example usage of VoRest UIX
local repo = "https://raw.githubusercontent.com/yourusername/VoRest-UIX/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Window = Library:CreateWindow({
    Title = "VoRest UIX",
    Footer = "Custom Dark Theme",
    NotifySide = "Right",
})

local MainTab = Window:AddTab("Main", "home")
local SettingsTab = Window:AddTab("Settings", "settings")

local MainGroup = MainTab:AddLeftGroupbox("Controls")
MainGroup:AddButton({
    Text = "Click Me!",
    Callback = function()
        print("Button clicked!")
    end
})

MainGroup:AddToggle({
    Text = "Enable Feature",
    Default = false,
    Callback = function(value)
        print("Toggle:", value)
    end
})

MainGroup:AddDropdown({
    Text = "Select Option",
    Values = {"Option 1", "Option 2", "Option 3"},
    Default = 1,
    Callback = function(value)
        print("Selected:", value)
    end
})

MainGroup:AddSlider({
    Text = "Speed",
    Min = 1,
    Max = 100,
    Default = 50,
    Increment = 5,
    Callback = function(value)
        print("Speed:", value)
    end
})

MainGroup:AddInput({
    Text = "Enter Name",
    Placeholder = "Type here...",
    Callback = function(value)
        print("Input:", value)
    end
})

MainGroup:AddLabel({
    Text = "This is a label",
    Color = "#FFB300",
    Size = 16,
})

local SettingsGroup = SettingsTab:AddLeftGroupbox("UI Settings")
SettingsGroup:AddButton({
    Text = "Apply Default Theme",
    Callback = function()
        ThemeManager:ApplyTheme(Window, "Default")
    end
})
