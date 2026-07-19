-- VoRest UIX Library
-- Dark themed UI library inspired by Obsidian

local Library = {
    Version = "1.0.0",
    Registry = {},
    Options = {},
    Scheme = {},
    Templates = {},
}

-- Theme Colors (Your custom palette)
Library.Theme = {
    -- Backgrounds
    MainBackground = Color3.fromHex("#151313"),
    SecondaryBackground = Color3.fromHex("#1C1818"),
    Panels = Color3.fromHex("#262020"),
    CardBackground = Color3.fromHex("#312626"),
    
    -- Reds
    PrimaryRed = Color3.fromHex("#C62828"),
    BrightRed = Color3.fromHex("#E53935"),
    DeepRed = Color3.fromHex("#8B1E1E"),
    DarkWine = Color3.fromHex("#5C1B1B"),
    HoverRed = Color3.fromHex("#D84343"),
    
    -- Accents
    AccentAmber = Color3.fromHex("#FFB300"),
    DarkAmber = Color3.fromHex("#C98A00"),
    SoftOrange = Color3.fromHex("#FF8F00"),
    
    -- Text
    PrimaryText = Color3.fromHex("#F5F1EC"),
    SecondaryText = Color3.fromHex("#C6BDBD"),
    DisabledText = Color3.fromHex("#7D7070"),
    
    -- Status
    Success = Color3.fromHex("#4CAF50"),
    Warning = Color3.fromHex("#FFC107"),
    Error = Color3.fromHex("#EF5350"),
    
    -- Borders
    BorderNormal = Color3.fromHex("#3A2C2C"),
    BorderActive = Color3.fromHex("#C62828"),
    BorderImportant = Color3.fromHex("#FFB300"),
}

-- Button states
Library.ButtonColors = {
    Idle = Color3.fromHex("#8B1E1E"),
    Hover = Color3.fromHex("#C62828"),
    Pressed = Color3.fromHex("#E53935"),
}

-- Default Scheme (for theme system)
Library.Scheme = {
    FontColor = Color3.fromHex("#F5F1EC"),
    MainColor = Color3.fromHex("#1C1818"),
    AccentColor = Color3.fromHex("#C62828"),
    BackgroundColor = Color3.fromHex("#151313"),
    OutlineColor = Color3.fromHex("#3A2C2C"),
}

-- Create Window
function Library:CreateWindow(data)
    data = data or {}
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VoRestUIX"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = screenGui
    mainFrame.BackgroundColor3 = Library.Theme.MainBackground
    mainFrame.BorderSizePixel = 0
    mainFrame.Size = UDim2.new(0, 600, 0, 450)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
    mainFrame.ClipsDescendants = true
    
    -- Title bar (draggable)
    local titleBar = Instance.new("Frame")
    titleBar.Parent = mainFrame
    titleBar.BackgroundColor3 = Library.Theme.DeepRed
    titleBar.BorderSizePixel = 0
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = titleBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = data.Title or "VoRest UIX"
    titleLabel.TextColor3 = Library.Theme.PrimaryText
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Size = UDim2.new(1, -40, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = titleBar
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Library.Theme.PrimaryText
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Size = UDim2.new(0, 30, 1, 0)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.BorderSizePixel = 0
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Tabs container
    local tabsContainer = Instance.new("Frame")
    tabsContainer.Parent = mainFrame
    tabsContainer.BackgroundColor3 = Library.Theme.SecondaryBackground
    tabsContainer.BorderSizePixel = 0
    tabsContainer.Size = UDim2.new(0, 150, 1, -30)
    tabsContainer.Position = UDim2.new(0, 0, 0, 30)
    
    local contentContainer = Instance.new("Frame")
    contentContainer.Parent = mainFrame
    contentContainer.BackgroundColor3 = Library.Theme.Panels
    contentContainer.BorderSizePixel = 0
    contentContainer.Size = UDim2.new(1, -150, 1, -30)
    contentContainer.Position = UDim2.new(0, 150, 0, 30)
    
    local window = {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        TitleBar = titleBar,
        TabsContainer = tabsContainer,
        ContentContainer = contentContainer,
        Tabs = {},
        CurrentTab = nil,
    }
    
    -- Make window draggable
    local dragging = false
    local dragStart, startPos
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Tab function
    function window:AddTab(name, icon)
        local tabBtn = Instance.new("TextButton")
        tabBtn.Parent = tabsContainer
        tabBtn.BackgroundColor3 = Library.Theme.SecondaryBackground
        tabBtn.TextColor3 = Library.Theme.SecondaryText
        tabBtn.Text = name
        tabBtn.TextSize = 14
        tabBtn.Font = Enum.Font.GothamMedium
        tabBtn.Size = UDim2.new(1, 0, 0, 40)
        tabBtn.Position = UDim2.new(0, 0, 0, #window.Tabs * 40)
        tabBtn.BorderSizePixel = 1
        tabBtn.BorderColor3 = Library.Theme.BorderNormal
        
        local tabContent = Instance.new("Frame")
        tabContent.Parent = contentContainer
        tabContent.BackgroundTransparency = 1
        tabContent.Size = UDim2.new(1, -20, 1, -10)
        tabContent.Position = UDim2.new(0, 10, 0, 5)
        tabContent.Visible = false
        
        local tab = {
            Button = tabBtn,
            Content = tabContent,
            LeftGroupboxes = {},
            RightGroupboxes = {},
        }
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(window.Tabs) do
                t.Content.Visible = false
                t.Button.BackgroundColor3 = Library.Theme.SecondaryBackground
                t.Button.TextColor3 = Library.Theme.SecondaryText
            end
            tabContent.Visible = true
            tabBtn.BackgroundColor3 = Library.Theme.DeepRed
            tabBtn.TextColor3 = Library.Theme.PrimaryText
            window.CurrentTab = tab
        end)
        
        table.insert(window.Tabs, tab)
        
        -- Groupbox function
        function tab:AddLeftGroupbox(title)
            return createGroupbox(tabContent, title, "left")
        end
        
        function tab:AddRightGroupbox(title)
            return createGroupbox(tabContent, title, "right")
        end
        
        -- Alias for compatibility
        function tab:AddGroupbox(title)
            return tab:AddLeftGroupbox(title)
        end
        
        return tab
    end
    
    function createGroupbox(parent, title, side)
        local isLeft = side == "left"
        local group = Instance.new("Frame")
        group.Parent = parent
        group.BackgroundColor3 = Library.Theme.CardBackground
        group.BorderSizePixel = 1
        group.BorderColor3 = Library.Theme.BorderNormal
        group.Size = UDim2.new(0.48, 0, 0, 400)
        group.Position = isLeft and UDim2.new(0, 0, 0, 0) or UDim2.new(0.52, 0, 0, 0)
        group.ClipsDescendants = true
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Parent = group
        titleLabel.BackgroundColor3 = Library.Theme.DeepRed
        titleLabel.TextColor3 = Library.Theme.PrimaryText
        titleLabel.Text = title or "Group"
        titleLabel.TextSize = 13
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Size = UDim2.new(1, 0, 0, 25)
        titleLabel.BorderSizePixel = 0
        
        local content = Instance.new("Frame")
        content.Parent = group
        content.BackgroundTransparency = 1
        content.Size = UDim2.new(1, 0, 1, -25)
        content.Position = UDim2.new(0, 0, 0, 25)
        
        local groupbox = {
            Frame = group,
            Content = content,
            Controls = {},
        }
        
        local yPos = 0
        
        function groupbox:AddButton(data)
            local btn = Instance.new("TextButton")
            btn.Parent = content
            btn.Text = data.Text or "Button"
            btn.BackgroundColor3 = Library.ButtonColors.Idle
            btn.TextColor3 = Library.Theme.PrimaryText
            btn.TextSize = 14
            btn.Font = Enum.Font.GothamMedium
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Position = UDim2.new(0, 5, 0, yPos + 5)
            btn.BorderSizePixel = 1
            btn.BorderColor3 = Library.Theme.BorderNormal
            
            btn.MouseEnter:Connect(function()
                btn.BackgroundColor3 = Library.ButtonColors.Hover
                btn.BorderColor3 = Library.Theme.BorderActive
            end)
            
            btn.MouseLeave:Connect(function()
                btn.BackgroundColor3 = Library.ButtonColors.Idle
                btn.BorderColor3 = Library.Theme.BorderNormal
            end)
            
            btn.MouseButton1Down:Connect(function()
                btn.BackgroundColor3 = Library.ButtonColors.Pressed
            end)
            
            btn.MouseButton1Up:Connect(function()
                btn.BackgroundColor3 = Library.ButtonColors.Hover
                if data.Callback then
                    data.Callback()
                end
            end)
            
            yPos = yPos + 35
            groupbox.Controls[data.Text] = btn
            return btn
        end
        
        function groupbox:AddToggle(data)
            local frame = Instance.new("Frame")
            frame.Parent = content
            frame.BackgroundTransparency = 1
            frame.Size = UDim2.new(1, -10, 0, 30)
            frame.Position = UDim2.new(0, 5, 0, yPos + 5)
            
            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.BackgroundTransparency = 1
            label.Text = data.Text or "Toggle"
            label.TextColor3 = Library.Theme.PrimaryText
            label.TextSize = 14
            label.Font = Enum.Font.GothamMedium
            label.Size = UDim2.new(0.7, 0, 1, 0)
            label.TextXAlignment = Enum.TextXAlignment.Left
            
            local toggleBtn = Instance.new("TextButton")
            toggleBtn.Parent = frame
            toggleBtn.Text = ""
            toggleBtn.BackgroundColor3 = Library.Theme.CardBackground
            toggleBtn.BorderSizePixel = 1
            toggleBtn.BorderColor3 = Library.Theme.BorderNormal
            toggleBtn.Size = UDim2.new(0, 40, 0, 20)
            toggleBtn.Position = UDim2.new(1, -45, 0.5, -10)
            
            local indicator = Instance.new("Frame")
            indicator.Parent = toggleBtn
            indicator.BackgroundColor3 = Library.Theme.DisabledText
            indicator.BorderSizePixel = 0
            indicator.Size = UDim2.new(0, 16, 0, 16)
            indicator.Position = UDim2.new(0, 2, 0.5, -8)
            
            local toggled = data.Default or false
            if toggled then
                indicator.BackgroundColor3 = Library.Theme.PrimaryRed
                indicator.Position = UDim2.new(1, -18, 0.5, -8)
            end
            
            toggleBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                if toggled then
                    indicator.BackgroundColor3 = Library.Theme.PrimaryRed
                    indicator.Position = UDim2.new(1, -18, 0.5, -8)
                else
                    indicator.BackgroundColor3 = Library.Theme.DisabledText
                    indicator.Position = UDim2.new(0, 2, 0.5, -8)
                end
                if data.Callback then
                    data.Callback(toggled)
                end
            end)
            
            yPos = yPos + 35
            return toggleBtn
        end
        
        function groupbox:AddDropdown(data)
            local frame = Instance.new("Frame")
            frame.Parent = content
            frame.BackgroundTransparency = 1
            frame.Size = UDim2.new(1, -10, 0, 40)
            frame.Position = UDim2.new(0, 5, 0, yPos + 5)
            
            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.BackgroundTransparency = 1
            label.Text = data.Text or "Dropdown"
            label.TextColor3 = Library.Theme.PrimaryText
            label.TextSize = 13
            label.Font = Enum.Font.GothamMedium
            label.Size = UDim2.new(1, 0, 0, 20)
            label.TextXAlignment = Enum.TextXAlignment.Left
            
            local dropdownBtn = Instance.new("TextButton")
            dropdownBtn.Parent = frame
            dropdownBtn.Text = data.Values and data.Values[1] or "Select"
            dropdownBtn.BackgroundColor3 = Library.Theme.CardBackground
            dropdownBtn.TextColor3 = Library.Theme.PrimaryText
            dropdownBtn.TextSize = 13
            dropdownBtn.Font = Enum.Font.GothamMedium
            dropdownBtn.Size = UDim2.new(1, 0, 0, 25)
            dropdownBtn.Position = UDim2.new(0, 0, 0, 20)
            dropdownBtn.BorderSizePixel = 1
            dropdownBtn.BorderColor3 = Library.Theme.BorderNormal
            
            local selected = data.Default or 1
            
            dropdownBtn.MouseButton1Click:Connect(function()
                -- Simple dropdown: cycle through values on click
                local values = data.Values or {}
                if #values > 0 then
                    selected = selected % #values + 1
                    dropdownBtn.Text = values[selected]
                    if data.Callback then
                        data.Callback(values[selected])
                    end
                end
            end)
            
            yPos = yPos + 45
            return dropdownBtn
        end
        
        function groupbox:AddSlider(data)
            local frame = Instance.new("Frame")
            frame.Parent = content
            frame.BackgroundTransparency = 1
            frame.Size = UDim2.new(1, -10, 0, 45)
            frame.Position = UDim2.new(0, 5, 0, yPos + 5)
            
            local label = Instance.new("TextLabel")
            label.Parent = frame
            label.BackgroundTransparency = 1
            label.Text = (data.Text or "Slider") .. ": " .. (data.Default or 0)
            label.TextColor3 = Library.Theme.PrimaryText
            label.TextSize = 13
            label.Font = Enum.Font.GothamMedium
            label.Size = UDim2.new(1, 0, 0, 20)
            label.TextXAlignment = Enum.TextXAlignment.Left
            
            -- Simple slider representation (buttons for increment/decrement)
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Parent = frame
            sliderFrame.BackgroundColor3 = Library.Theme.CardBackground
            sliderFrame.BorderSizePixel = 1
            sliderFrame.BorderColor3 = Library.Theme.BorderNormal
            sliderFrame.Size = UDim2.new(1, 0, 0, 20)
            sliderFrame.Position = UDim2.new(0, 0, 0, 20)
            
            local minusBtn = Instance.new("TextButton")
            minusBtn.Parent = sliderFrame
            minusBtn.Text = "-"
            minusBtn.BackgroundColor3 = Library.Theme.DeepRed
            minusBtn.TextColor3 = Library.Theme.PrimaryText
            minusBtn.TextSize = 14
            minusBtn.Font = Enum.Font.GothamBold
            minusBtn.Size = UDim2.new(0, 30, 1, 0)
            minusBtn.BorderSizePixel = 0
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Parent = sliderFrame
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(data.Default or 0)
            valueLabel.TextColor3 = Library.Theme.PrimaryText
            valueLabel.TextSize = 13
            valueLabel.Font = Enum.Font.GothamMedium
            valueLabel.Size = UDim2.new(1, -60, 1, 0)
            valueLabel.Position = UDim2.new(0, 30, 0, 0)
            
            local plusBtn = Instance.new("TextButton")
            plusBtn.Parent = sliderFrame
            plusBtn.Text = "+"
            plusBtn.BackgroundColor3 = Library.Theme.PrimaryRed
            plusBtn.TextColor3 = Library.Theme.PrimaryText
            plusBtn.TextSize = 14
            plusBtn.Font = Enum.Font.GothamBold
            plusBtn.Size = UDim2.new(0, 30, 1, 0)
            plusBtn.Position = UDim2.new(1, -30, 0, 0)
            plusBtn.BorderSizePixel = 0
            
            local value = data.Default or 0
            local min = data.Min or 0
            local max = data.Max or 100
            
            minusBtn.MouseButton1Click:Connect(function()
                value = math.max(min, value - (data.Increment or 1))
                valueLabel.Text = tostring(value)
                label.Text = (data.Text or "Slider") .. ": " .. value
                if data.Callback then
                    data.Callback(value)
                end
            end)
            
            plusBtn.MouseButton1Click:Connect(function()
                value = math.min(max, value + (data.Increment or 1))
                valueLabel.Text = tostring(value)
                label.Text = (data.Text or "Slider") .. ": " .. value
                if data.Callback then
                    data.Callback(value)
                end
            end)
            
            yPos = yPos + 50
            return sliderFrame
        end
        
        function groupbox:AddLabel(data)
            local label = Instance.new("TextLabel")
            label.Parent = content
            label.BackgroundTransparency = 1
            label.Text = data.Text or "Label"
            label.TextColor3 = data.Color and Color3.fromHex(data.Color) or Library.Theme.PrimaryText
            label.TextSize = data.Size or 14
            label.Font = data.Font or Enum.Font.GothamMedium
            label.Size = UDim2.new(1, -10, 0, 25)
            label.Position = UDim2.new(0, 5, 0, yPos + 5)
            label.TextXAlignment = data.Alignment or Enum.TextXAlignment.Left
            
            yPos = yPos + 30
            return label
        end
        
        function groupbox:AddInput(data)
            local frame = Instance.new("Frame")
            frame.Parent = content
            frame.BackgroundColor3 = Library.Theme.CardBackground
            frame.BorderSizePixel = 1
            frame.BorderColor3 = Library.Theme.BorderNormal
            frame.Size = UDim2.new(1, -10, 0, 35)
            frame.Position = UDim2.new(0, 5, 0, yPos + 5)
            frame.ClipsDescendants = true
            
            local input = Instance.new("TextBox")
            input.Parent = frame
            input.Text = data.Default or ""
            input.PlaceholderText = data.Placeholder or "Enter text..."
            input.BackgroundTransparency = 1
            input.TextColor3 = Library.Theme.PrimaryText
            input.PlaceholderColor3 = Library.Theme.DisabledText
            input.TextSize = 14
            input.Font = Enum.Font.GothamMedium
            input.Size = UDim2.new(1, -10, 1, 0)
            input.Position = UDim2.new(0, 10, 0, 0)
            input.TextXAlignment = Enum.TextXAlignment.Left
            input.TextYAlignment = Enum.TextYAlignment.Center
            
            input.Focused:Connect(function()
                frame.BorderColor3 = Library.Theme.BorderActive
                input.TextColor3 = Library.Theme.AccentAmber
            end)
            
            input.FocusLost:Connect(function()
                frame.BorderColor3 = Library.Theme.BorderNormal
                input.TextColor3 = Library.Theme.PrimaryText
                if data.Callback then
                    data.Callback(input.Text)
                end
            end)
            
            yPos = yPos + 40
            return input
        end
        
        return groupbox
    end
    
    return window
end

-- Utility function to load the library
local function loadstringFunc(url)
    return loadstring(game:HttpGet(url))
end

return Library
