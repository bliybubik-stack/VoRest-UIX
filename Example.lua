-- VoRest UIX v2.0 Example
local repo = "https://raw.githubusercontent.com/bliybubik-stack/VoRest-UIX/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()

-- Create main window
local Window = Library:CreateWindow({
    Title = "VoRest UIX v2.0",
    Size = UDim2.new(0, 900, 0, 700),
})

-- ============================================
-- MAIN TAB
-- ============================================
local MainTab = Window:AddTab({
    Title = "Main",
    Icon = "🏠"
})

local ControlsGroup = MainTab:AddGroupbox({
    Title = "Controls",
    Side = "left"
})

-- Buttons
ControlsGroup:AddButton({
    Text = "Click Me!",
    Callback = function()
        Window:Notify({
            Title = "Button Clicked!",
            Message = "You clicked the button!",
            Type = "success"
        })
    end
})

ControlsGroup:AddButton({
    Text = "Danger Button",
    Callback = function()
        Window:Notify({
            Title = "Warning!",
            Message = "This is a dangerous action!",
            Type = "warning"
        })
    end
})

-- Toggle
ControlsGroup:AddToggle({
    Text = "Enable Feature",
    Default = false,
    Callback = function(value)
        print("Feature enabled:", value)
    end
})

-- Slider
ControlsGroup:AddSlider({
    Text = "Volume",
    Min = 0,
    Max = 100,
    Default = 75,
    Increment = 5,
    Callback = function(value)
        print("Volume:", value)
    end
})

-- Dropdown
ControlsGroup:AddDropdown({
    Text = "Theme Selector",
    Values = {"Default", "Dark", "Amber", "Custom"},
    Default = 1,
    Callback = function(value)
        print("Selected theme:", value)
    end
})

-- ============================================
-- ADVANCED TAB
-- ============================================
local AdvancedTab = Window:AddTab({
    Title = "Advanced",
    Icon = "⚙️"
})

local AdvancedGroup = AdvancedTab:AddGroupbox({
    Title = "Advanced Controls",
    Side = "left"
})

-- Input
AdvancedGroup:AddInput({
    Text = "Enter Name",
    Placeholder = "Type your name...",
    Callback = function(value)
        print("Name:", value)
    end
})

-- Color Picker
AdvancedGroup:AddColorPicker({
    Text = "Pick Color",
    Default = Color3.fromHex("#C62828"),
    Callback = function(color)
        print("Color selected:", color)
    end
})

-- Keybind
AdvancedGroup:AddKeybind({
    Text = "Toggle Key",
    Default = Enum.KeyCode.LeftControl,
    Callback = function(key)
        print("Keybind set to:", key.Name)
    end
})

-- Progress Bar
local Progress = AdvancedGroup:AddProgress({
    Text = "Loading",
    Value = 50,
    Max = 100
})

-- Update progress after 2 seconds
task.wait(2)
Progress:Update(75)
task.wait(1)
Progress:Update(100)

-- Checkbox
AdvancedGroup:AddCheckbox({
    Text = "Enable Advanced Mode",
    Default = false,
    Callback = function(value)
        print("Advanced mode:", value)
    end
})

-- Radio Buttons
AdvancedGroup:AddRadio({
    Text = "Choose Option",
    Values = {"Option A", "Option B", "Option C"},
    Default = 2,
    Callback = function(value, index)
        print("Selected:", value, "Index:", index)
    end
})

-- ============================================
-- UTILITY TAB
-- ============================================
local UtilityTab = Window:AddTab({
    Title = "Utility",
    Icon = "🔧"
})

local UtilityGroup = UtilityTab:AddGroupbox({
    Title = "Utility Controls",
    Side = "left"
})

-- List
UtilityGroup:AddList({
    Text = "Installed Plugins",
    Items = {"Plugin A v1.2", "Plugin B v2.0", "Plugin C v1.5"}
})

-- Label
UtilityGroup:AddLabel({
    Text = "This is a custom label",
    Color = "#FFB300",
    Size = 16
})

-- Separator
UtilityGroup:AddSeparator()

-- Note
UtilityGroup:AddNote({
    Text = "This is an informational note about the UI library.",
    Type = "info"
})

UtilityGroup:AddNote({
    Text = "Warning: This action cannot be undone!",
    Type = "warning"
})

UtilityGroup:AddNote({
    Text = "Success: Operation completed successfully!",
    Type = "success"
})

UtilityGroup:AddNote({
    Text = "Error: Something went wrong!",
    Type = "error"
})

-- ============================================
-- COLLAPSIBLE TAB
-- ============================================
local CollapsibleTab = Window:AddTab({
    Title = "Collapsible",
    Icon = "📂"
})

local CollapsibleGroup = CollapsibleTab:AddGroupbox({
    Title = "Collapsible Controls",
    Side = "left"
})

-- Collapsible section
local Collapsible = CollapsibleGroup:AddCollapsible({
    Title = "Advanced Settings"
})

Collapsible:AddButton({
    Text = "Setting 1",
    Callback = function()
        print("Setting 1 clicked")
    end
})

Collapsible:AddButton({
    Text = "Setting 2",
    Callback = function()
        print("Setting 2 clicked")
    end
})

Collapsible:AddLabel({
    Text = "This is inside the collapsible section"
})

-- Another collapsible
local Collapsible2 = CollapsibleGroup:AddCollapsible({
    Title = "Debug Options"
})

Collapsible2:AddButton({
    Text = "Enable Debug Mode",
    Callback = function()
        print("Debug mode enabled")
    end
})

-- ============================================
-- NOTIFICATIONS
-- ============================================
local NotifyGroup = CollapsibleTab:AddGroupbox({
    Title = "Notifications",
    Side = "right"
})

NotifyGroup:AddButton({
    Text = "Info Notification",
    Callback = function()
        Window:Notify({
            Title = "Info",
            Message = "This is an information notification!",
            Type = "info",
            Duration = 3
        })
    end
})

NotifyGroup:AddButton({
    Text = "Success Notification",
    Callback = function()
        Window:Notify({
            Title = "Success",
            Message = "Operation completed successfully!",
            Type = "success",
            Duration = 3
        })
    end
})

NotifyGroup:AddButton({
    Text = "Warning Notification",
    Callback = function()
        Window:Notify({
            Title = "Warning",
            Message = "This is a warning message!",
            Type = "warning",
            Duration = 3
        })
    end
})

NotifyGroup:AddButton({
    Text = "Error Notification",
    Callback = function()
        Window:Notify({
            Title = "Error",
            Message = "An error has occurred!",
            Type = "error",
            Duration = 3
        })
    end
})

-- ============================================
-- TOOLTIP
-- ============================================
local TooltipGroup = CollapsibleTab:AddGroupbox({
    Title = "Tooltips",
    Side = "right"
})

TooltipGroup:AddTooltip({
    Text = "Hover for help",
    Content = "This is a tooltip that provides additional information about this control."
})

TooltipGroup:AddTooltip({
    Text = "Another tooltip",
    Content = "Tooltips are useful for explaining complex features."
})

-- ============================================
-- SCROLLBAR
-- ============================================
local ScrollGroup = CollapsibleTab:AddGroupbox({
    Title = "Scrollable Content",
    Side = "right"
})

ScrollGroup:AddScrollbar({
    Size = UDim2.new(1, 0, 0, 150),
    Content = "This is a scrollable content area. You can put long text here and it will scroll.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
})

-- ============================================
-- IMAGE
-- ============================================
local ImageGroup = CollapsibleTab:AddGroupbox({
    Title = "Images",
    Side = "right"
})

ImageGroup:AddImage({
    Image = "rbxasset://textures/ui/FrameShadow.png",
    Size = Vector2.new(150, 80)
})

ImageGroup:AddLabel({
    Text = "Image above is a shadow texture",
    Size = 12,
    Color = Library.Theme.Colors.SecondaryText
})

-- Demo notification on startup
task.wait(1)
Window:Notify({
    Title = "Welcome!",
    Message = "VoRest UIX v2.0 is ready!",
    Type = "success",
    Duration = 4
})
