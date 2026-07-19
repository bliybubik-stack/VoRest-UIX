-- VoRest UIX Library v2.0
-- Complete UI framework with smooth animations

local Library = {
    Version = "2.0.0",
    Registry = {},
    Animations = {},
    Theme = {},
    Debug = false,
}

-- ============================================
-- THEME COLORS (Custom Palette)
-- ============================================

Library.Theme.Colors = {
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
    Info = Color3.fromHex("#2196F3"),
    
    -- Borders
    BorderNormal = Color3.fromHex("#3A2C2C"),
    BorderActive = Color3.fromHex("#C62828"),
    BorderImportant = Color3.fromHex("#FFB300"),
}

-- Button States
Library.Theme.Button = {
    Idle = Color3.fromHex("#8B1E1E"),
    Hover = Color3.fromHex("#C62828"),
    Pressed = Color3.fromHex("#E53935"),
    Disabled = Color3.fromHex("#3A2C2C"),
}

-- ============================================
-- ANIMATION ENGINE
-- ============================================

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

Library.Animator = {
    Tweens = {},
    Running = {},
}

-- Easing functions
Library.Animator.Easing = {
    Linear = Enum.EasingStyle.Linear,
    Quad = Enum.EasingStyle.Quad,
    Cubic = Enum.EasingStyle.Cubic,
    Quart = Enum.EasingStyle.Quart,
    Quint = Enum.EasingStyle.Quint,
    Sine = Enum.EasingStyle.Sine,
    Expo = Enum.EasingStyle.Exponential,
    Circ = Enum.EasingStyle.Circular,
    Back = Enum.EasingStyle.Back,
    Bounce = Enum.EasingStyle.Bounce,
    Elastic = Enum.EasingStyle.Elastic,
}

Library.Animator.Direction = {
    In = Enum.EasingDirection.In,
    Out = Enum.EasingDirection.Out,
    InOut = Enum.EasingDirection.InOut,
}

-- Tween creator
function Library.Animator:Tween(object, properties, duration, style, direction)
    duration = duration or 0.2
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    
    local tweenInfo = TweenInfo.new(
        duration,
        style,
        direction,
        0,
        false,
        0
    )
    
    local tween = TweenService:Create(object, tweenInfo, properties)
    return tween
end

-- Play with callback
function Library.Animator:Play(tween, callback)
    tween:Play()
    if callback then
        tween.Completed:Connect(callback)
    end
    return tween
end

-- Smooth value animation
function Library.Animator:AnimateNumber(start, target, duration, callback, update)
    local startTime = tick()
    local diff = target - start
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        local elapsed = tick() - startTime
        local progress = math.min(elapsed / duration, 1)
        local current = start + (diff * progress)
        
        if update then
            update(current)
        end
        
        if progress >= 1 then
            connection:Disconnect()
            if callback then
                callback(target)
            end
        end
    end)
    
    return connection
end

-- ============================================
-- CORE UI CLASSES
-- ============================================

-- Window class
function Library:CreateWindow(config)
    config = config or {}
    config.Title = config.Title or "VoRest UIX"
    config.Size = config.Size or UDim2.new(0, 800, 0, 600)
    config.MinSize = config.MinSize or Vector2.new(500, 350)
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VoRestUIX"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Window
    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Library.Theme.Colors.MainBackground
    MainFrame.BorderSizePixel = 1
    MainFrame.BorderColor3 = Library.Theme.Colors.BorderNormal
    MainFrame.Size = config.Size
    MainFrame.Position = UDim2.new(0.5, -config.Size.X.Offset/2, 0.5, -config.Size.Y.Offset/2)
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    MainFrame.Draggable = false
    
    -- Rounding (very small, sharp look)
    local Corner = Instance.new("UICorner")
    Corner.Parent = MainFrame
    Corner.CornerRadius = UDim.new(0, 3)
    
    -- Drop Shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Parent = MainFrame
    Shadow.BackgroundTransparency = 1
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(-0.025, 0, -0.025, 0)
    Shadow.Image = "rbxasset://textures/ui/FrameShadow.png"
    Shadow.ImageColor3 = Color3.new(0, 0, 0)
    Shadow.ImageTransparency = 0.8
    Shadow.ZIndex = -1
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 10, 10)
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Library.Theme.Colors.DeepRed
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.ClipsDescendants = true
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.Parent = TitleBar
    TitleCorner.CornerRadius = UDim.new(0, 3)
    
    -- Title Text
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = config.Title
    TitleLabel.TextColor3 = Library.Theme.Colors.PrimaryText
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Size = UDim2.new(1, -80, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    
    -- Window Controls
    local ControlsFrame = Instance.new("Frame")
    ControlsFrame.Parent = TitleBar
    ControlsFrame.BackgroundTransparency = 1
    ControlsFrame.Size = UDim2.new(0, 80, 1, 0)
    ControlsFrame.Position = UDim2.new(1, -85, 0, 0)
    
    -- Minimize Button
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Parent = ControlsFrame
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.Text = "─"
    MinimizeBtn.TextColor3 = Library.Theme.Colors.PrimaryText
    MinimizeBtn.TextSize = 18
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Size = UDim2.new(0, 30, 1, 0)
    MinimizeBtn.Position = UDim2.new(0, 0, 0, 0)
    MinimizeBtn.BorderSizePixel = 0
    
    MinimizeBtn.MouseEnter:Connect(function()
        MinimizeBtn.TextColor3 = Library.Theme.Colors.AccentAmber
    end)
    MinimizeBtn.MouseLeave:Connect(function()
        MinimizeBtn.TextColor3 = Library.Theme.Colors.PrimaryText
    end)
    
    local minimized = false
    MinimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            local tween = Library.Animator:Tween(MainFrame, {
                Size = UDim2.new(0, 800, 0, 35)
            }, 0.3)
            Library.Animator:Play(tween)
        else
            local tween = Library.Animator:Tween(MainFrame, {
                Size = config.Size
            }, 0.3)
            Library.Animator:Play(tween)
        end
    end)
    
    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = ControlsFrame
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Library.Theme.Colors.PrimaryText
    CloseBtn.TextSize = 16
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Size = UDim2.new(0, 30, 1, 0)
    CloseBtn.Position = UDim2.new(0, 40, 0, 0)
    CloseBtn.BorderSizePixel = 0
    
    CloseBtn.MouseEnter:Connect(function()
        CloseBtn.TextColor3 = Library.Theme.Colors.Error
    end)
    CloseBtn.MouseLeave:Connect(function()
        CloseBtn.TextColor3 = Library.Theme.Colors.PrimaryText
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        local tween = Library.Animator:Tween(MainFrame, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        tween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
        Library.Animator:Play(tween)
    end)
    
    -- Dragging
    local dragging = false
    local dragStart, startPos
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
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
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Content Structure
    local Container = Instance.new("Frame")
    Container.Parent = MainFrame
    Container.BackgroundColor3 = Library.Theme.Colors.MainBackground
    Container.BorderSizePixel = 0
    Container.Size = UDim2.new(1, 0, 1, -35)
    Container.Position = UDim2.new(0, 0, 0, 35)
    
    -- Tab Bar
    local TabBar = Instance.new("Frame")
    TabBar.Parent = Container
    TabBar.BackgroundColor3 = Library.Theme.Colors.SecondaryBackground
    TabBar.BorderSizePixel = 0
    TabBar.Size = UDim2.new(0, 180, 1, 0)
    TabBar.ClipsDescendants = true
    
    local TabBarCorner = Instance.new("UICorner")
    TabBarCorner.Parent = TabBar
    TabBarCorner.CornerRadius = UDim.new(0, 3)
    
    -- Tab Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Parent = Container
    ContentArea.BackgroundColor3 = Library.Theme.Colors.Panels
    ContentArea.BorderSizePixel = 0
    ContentArea.Size = UDim2.new(1, -180, 1, 0)
    ContentArea.Position = UDim2.new(0, 180, 0, 0)
    
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.Parent = ContentArea
    ContentCorner.CornerRadius = UDim.new(0, 3)
    
    -- Scrollable Content
    local ContentScroller = Instance.new("ScrollingFrame")
    ContentScroller.Parent = ContentArea
    ContentScroller.BackgroundTransparency = 1
    ContentScroller.BorderSizePixel = 0
    ContentScroller.Size = UDim2.new(1, -10, 1, -10)
    ContentScroller.Position = UDim2.new(0, 5, 0, 5)
    ContentScroller.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentScroller.ScrollBarThickness = 4
    ContentScroller.ScrollBarImageColor3 = Library.Theme.Colors.BorderActive
    ContentScroller.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
    
    -- Window Object
    local Window = {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        TitleBar = TitleBar,
        Container = Container,
        TabBar = TabBar,
        ContentArea = ContentArea,
        ContentScroller = ContentScroller,
        Tabs = {},
        CurrentTab = nil,
        TabButtons = {},
        Animations = {},
        Config = config,
    }
    
    -- Tab creation
    function Window:AddTab(config)
        config = config or {}
        config.Title = config.Title or "Tab"
        config.Icon = config.Icon or ""
        
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabBar
        TabBtn.BackgroundColor3 = Library.Theme.Colors.SecondaryBackground
        TabBtn.TextColor3 = Library.Theme.Colors.SecondaryText
        TabBtn.Text = config.Title
        TabBtn.TextSize = 14
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.Size = UDim2.new(1, 0, 0, 45)
        TabBtn.Position = UDim2.new(0, 0, 0, #Window.Tabs * 45)
        TabBtn.BorderSizePixel = 0
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        TabBtn.TextYAlignment = Enum.TextYAlignment.Center
        
        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.Parent = TabBtn
        TabBtnCorner.CornerRadius = UDim.new(0, 2)
        
        -- Tab Content Container
        local TabContent = Instance.new("Frame")
        TabContent.Parent = ContentScroller
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 0, 0)
        TabContent.Position = UDim2.new(0, 0, 0, 0)
        TabContent.Visible = false
        TabContent.ClipsDescendants = true
        
        local Tab = {
            Button = TabBtn,
            Content = TabContent,
            Groups = {},
            CurrentY = 0,
            Objects = {},
        }
        
        -- Groupbox creation
        function Tab:AddGroupbox(config)
            config = config or {}
            config.Title = config.Title or "Group"
            config.Side = config.Side or "left"
            
            local isLeft = config.Side == "left"
            local groupWidth = 0.48
            
            local GroupFrame = Instance.new("Frame")
            GroupFrame.Parent = TabContent
            GroupFrame.BackgroundColor3 = Library.Theme.Colors.CardBackground
            GroupFrame.BorderSizePixel = 1
            GroupFrame.BorderColor3 = Library.Theme.Colors.BorderNormal
            GroupFrame.Size = UDim2.new(groupWidth, 0, 0, 0)
            GroupFrame.Position = UDim2.new(isLeft and 0 or (1 - groupWidth), 0, 0, Tab.CurrentY + 10)
            GroupFrame.ClipsDescendants = true
            
            local GroupCorner = Instance.new("UICorner")
            GroupCorner.Parent = GroupFrame
            GroupCorner.CornerRadius = UDim.new(0, 3)
            
            -- Group Title
            local GroupTitle = Instance.new("Frame")
            GroupTitle.Parent = GroupFrame
            GroupTitle.BackgroundColor3 = Library.Theme.Colors.DeepRed
            GroupTitle.BorderSizePixel = 0
            GroupTitle.Size = UDim2.new(1, 0, 0, 28)
            
            local TitleCorner2 = Instance.new("UICorner")
            TitleCorner2.Parent = GroupTitle
            TitleCorner2.CornerRadius = UDim.new(0, 3)
            
            local TitleText = Instance.new("TextLabel")
            TitleText.Parent = GroupTitle
            TitleText.BackgroundTransparency = 1
            TitleText.Text = config.Title
            TitleText.TextColor3 = Library.Theme.Colors.PrimaryText
            TitleText.TextSize = 13
            TitleText.Font = Enum.Font.GothamBold
            TitleText.Size = UDim2.new(1, -15, 1, 0)
            TitleText.Position = UDim2.new(0, 10, 0, 0)
            TitleText.TextXAlignment = Enum.TextXAlignment.Left
            TitleText.TextYAlignment = Enum.TextYAlignment.Center
            
            -- Group Content
            local GroupContent = Instance.new("Frame")
            GroupContent.Parent = GroupFrame
            GroupContent.BackgroundTransparency = 1
            GroupContent.Size = UDim2.new(1, -10, 0, 0)
            GroupContent.Position = UDim2.new(0, 5, 0, 35)
            
            local Group = {
                Frame = GroupFrame,
                Title = GroupTitle,
                Content = GroupContent,
                Controls = {},
                YPos = 0,
            }
            
            -- ============================================
            -- CONTROL: BUTTON
            -- ============================================
            function Group:AddButton(config)
                config = config or {}
                config.Text = config.Text or "Button"
                
                local Btn = Instance.new("TextButton")
                Btn.Parent = GroupContent
                Btn.Text = config.Text
                Btn.BackgroundColor3 = Library.Theme.Button.Idle
                Btn.TextColor3 = Library.Theme.Colors.PrimaryText
                Btn.TextSize = 14
                Btn.Font = Enum.Font.GothamMedium
                Btn.Size = UDim2.new(1, 0, 0, 32)
                Btn.Position = UDim2.new(0, 0, 0, Group.YPos)
                Btn.BorderSizePixel = 1
                Btn.BorderColor3 = Library.Theme.Colors.BorderNormal
                Btn.AutoButtonColor = false
                
                local BtnCorner = Instance.new("UICorner")
                BtnCorner.Parent = Btn
                BtnCorner.CornerRadius = UDim.new(0, 2)
                
                -- Hover Animation
                Btn.MouseEnter:Connect(function()
                    local tween = Library.Animator:Tween(Btn, {
                        BackgroundColor3 = Library.Theme.Button.Hover,
                        BorderColor3 = Library.Theme.Colors.BorderActive
                    }, 0.15)
                    Library.Animator:Play(tween)
                end)
                
                Btn.MouseLeave:Connect(function()
                    local tween = Library.Animator:Tween(Btn, {
                        BackgroundColor3 = Library.Theme.Button.Idle,
                        BorderColor3 = Library.Theme.Colors.BorderNormal
                    }, 0.15)
                    Library.Animator:Play(tween)
                end)
                
                Btn.MouseButton1Down:Connect(function()
                    local tween = Library.Animator:Tween(Btn, {
                        BackgroundColor3 = Library.Theme.Button.Pressed,
                        Size = UDim2.new(1, -2, 0, 30)
                    }, 0.05)
                    Library.Animator:Play(tween)
                end)
                
                Btn.MouseButton1Up:Connect(function()
                    local tween = Library.Animator:Tween(Btn, {
                        BackgroundColor3 = Library.Theme.Button.Hover,
                        Size = UDim2.new(1, 0, 0, 32)
                    }, 0.1)
                    Library.Animator:Play(tween)
                    if config.Callback then
                        config.Callback()
                    end
                end)
                
                Group.YPos = Group.YPos + 38
                Group.Controls[config.Text] = Btn
                return Btn
            end
            
            -- ============================================
            -- CONTROL: TOGGLE
            -- ============================================
            function Group:AddToggle(config)
                config = config or {}
                config.Text = config.Text or "Toggle"
                config.Default = config.Default or false
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, 35)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Frame
                Label.BackgroundTransparency = 1
                Label.Text = config.Text
                Label.TextColor3 = Library.Theme.Colors.PrimaryText
                Label.TextSize = 14
                Label.Font = Enum.Font.GothamMedium
                Label.Size = UDim2.new(0.7, 0, 1, 0)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                
                local ToggleBtn = Instance.new("Frame")
                ToggleBtn.Parent = Frame
                ToggleBtn.BackgroundColor3 = Library.Theme.Colors.CardBackground
                ToggleBtn.BorderSizePixel = 1
                ToggleBtn.BorderColor3 = Library.Theme.Colors.BorderNormal
                ToggleBtn.Size = UDim2.new(0, 44, 0, 22)
                ToggleBtn.Position = UDim2.new(1, -50, 0.5, -11)
                ToggleBtn.ClipsDescendants = true
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.Parent = ToggleBtn
                ToggleCorner.CornerRadius = UDim.new(1, 0)
                
                local Indicator = Instance.new("Frame")
                Indicator.Parent = ToggleBtn
                Indicator.BackgroundColor3 = Library.Theme.Colors.DisabledText
                Indicator.BorderSizePixel = 0
                Indicator.Size = UDim2.new(0, 18, 0, 18)
                Indicator.Position = UDim2.new(0, 2, 0.5, -9)
                
                local IndicatorCorner = Instance.new("UICorner")
                IndicatorCorner.Parent = Indicator
                IndicatorCorner.CornerRadius = UDim.new(1, 0)
                
                local toggled = config.Default
                if toggled then
                    Indicator.BackgroundColor3 = Library.Theme.Colors.PrimaryRed
                    Indicator.Position = UDim2.new(1, -20, 0.5, -9)
                    ToggleBtn.BorderColor3 = Library.Theme.Colors.BorderActive
                end
                
                local ClickBtn = Instance.new("TextButton")
                ClickBtn.Parent = Frame
                ClickBtn.BackgroundTransparency = 1
                ClickBtn.Size = UDim2.new(1, 0, 1, 0)
                ClickBtn.Text = ""
                
                ClickBtn.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    
                    local targetPos = toggled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
                    local targetColor = toggled and Library.Theme.Colors.PrimaryRed or Library.Theme.Colors.DisabledText
                    local borderColor = toggled and Library.Theme.Colors.BorderActive or Library.Theme.Colors.BorderNormal
                    
                    local tween1 = Library.Animator:Tween(Indicator, {
                        Position = targetPos,
                        BackgroundColor3 = targetColor
                    }, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    Library.Animator:Play(tween1)
                    
                    local tween2 = Library.Animator:Tween(ToggleBtn, {
                        BorderColor3 = borderColor
                    }, 0.2)
                    Library.Animator:Play(tween2)
                    
                    if config.Callback then
                        config.Callback(toggled)
                    end
                end)
                
                Group.YPos = Group.YPos + 40
                Group.Controls[config.Text] = {ToggleBtn, Indicator}
                return ToggleBtn
            end
            
            -- ============================================
            -- CONTROL: SLIDER
            -- ============================================
            function Group:AddSlider(config)
                config = config or {}
                config.Text = config.Text or "Slider"
                config.Min = config.Min or 0
                config.Max = config.Max or 100
                config.Default = config.Default or 50
                config.Increment = config.Increment or 1
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, 50)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Frame
                Label.BackgroundTransparency = 1
                Label.Text = config.Text .. ": " .. config.Default
                Label.TextColor3 = Library.Theme.Colors.PrimaryText
                Label.TextSize = 14
                Label.Font = Enum.Font.GothamMedium
                Label.Size = UDim2.new(1, 0, 0, 25)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Parent = Frame
                SliderFrame.BackgroundColor3 = Library.Theme.Colors.CardBackground
                SliderFrame.BorderSizePixel = 1
                SliderFrame.BorderColor3 = Library.Theme.Colors.BorderNormal
                SliderFrame.Size = UDim2.new(1, 0, 0, 20)
                SliderFrame.Position = UDim2.new(0, 0, 0, 25)
                
                local SliderCorner = Instance.new("UICorner")
                SliderCorner.Parent = SliderFrame
                SliderCorner.CornerRadius = UDim.new(0, 2)
                
                local Fill = Instance.new("Frame")
                Fill.Parent = SliderFrame
                Fill.BackgroundColor3 = Library.Theme.Colors.PrimaryRed
                Fill.BorderSizePixel = 0
                Fill.Size = UDim2.new(0, 0, 1, 0)
                
                local FillCorner = Instance.new("UICorner")
                FillCorner.Parent = Fill
                FillCorner.CornerRadius = UDim.new(0, 2)
                
                local DragBtn = Instance.new("TextButton")
                DragBtn.Parent = SliderFrame
                DragBtn.BackgroundColor3 = Library.Theme.Colors.AccentAmber
                DragBtn.BorderSizePixel = 0
                DragBtn.Size = UDim2.new(0, 12, 1.2, 0)
                DragBtn.Position = UDim2.new(0, -6, -0.1, 0)
                DragBtn.Text = ""
                
                local DragCorner = Instance.new("UICorner")
                DragCorner.Parent = DragBtn
                DragCorner.CornerRadius = UDim.new(0, 2)
                
                local value = config.Default
                local min = config.Min
                local max = config.Max
                local increment = config.Increment
                
                local function updateSlider(val)
                    val = math.max(min, math.min(max, val))
                    val = math.round(val / increment) * increment
                    value = val
                    
                    local percent = (value - min) / (max - min)
                    Fill.Size = UDim2.new(percent, 0, 1, 0)
                    DragBtn.Position = UDim2.new(percent, -6, -0.1, 0)
                    Label.Text = config.Text .. ": " .. value
                    
                    if config.Callback then
                        config.Callback(value)
                    end
                end
                
                updateSlider(value)
                
                local dragging = false
                DragBtn.MouseButton1Down:Connect(function()
                    dragging = true
                    local tween = Library.Animator:Tween(DragBtn, {
                        Size = UDim2.new(0, 16, 1.4, 0)
                    }, 0.1)
                    Library.Animator:Play(tween)
                end)
                
                game:GetService("UserInputService").InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                        local tween = Library.Animator:Tween(DragBtn, {
                            Size = UDim2.new(0, 12, 1.2, 0)
                        }, 0.1)
                        Library.Animator:Play(tween)
                    end
                end)
                
                game:GetService("UserInputService").InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local mousePos = input.Position
                        local sliderPos = SliderFrame.AbsolutePosition
                        local sliderSize = SliderFrame.AbsoluteSize
                        
                        local percent = (mousePos.X - sliderPos.X) / sliderSize.X
                        percent = math.max(0, math.min(1, percent))
                        
                        local val = min + (max - min) * percent
                        updateSlider(val)
                    end
                end)
                
                -- Click to set value
                SliderFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local mousePos = input.Position
                        local sliderPos = SliderFrame.AbsolutePosition
                        local sliderSize = SliderFrame.AbsoluteSize
                        
                        local percent = (mousePos.X - sliderPos.X) / sliderSize.X
                        percent = math.max(0, math.min(1, percent))
                        
                        local val = min + (max - min) * percent
                        updateSlider(val)
                    end
                end)
                
                Group.YPos = Group.YPos + 55
                Group.Controls[config.Text] = SliderFrame
                return SliderFrame
            end
            
            -- ============================================
            -- CONTROL: DROPDOWN
            -- ============================================
            function Group:AddDropdown(config)
                config = config or {}
                config.Text = config.Text or "Dropdown"
                config.Values = config.Values or {"Option 1", "Option 2", "Option 3"}
                config.Default = config.Default or 1
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, 45)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Frame
                Label.BackgroundTransparency = 1
                Label.Text = config.Text
                Label.TextColor3 = Library.Theme.Colors.PrimaryText
                Label.TextSize = 14
                Label.Font = Enum.Font.GothamMedium
                Label.Size = UDim2.new(1, 0, 0, 20)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                
                local DropBtn = Instance.new("TextButton")
                DropBtn.Parent = Frame
                DropBtn.Text = config.Values[config.Default] or config.Values[1]
                DropBtn.BackgroundColor3 = Library.Theme.Colors.CardBackground
                DropBtn.TextColor3 = Library.Theme.Colors.PrimaryText
                DropBtn.TextSize = 13
                DropBtn.Font = Enum.Font.GothamMedium
                DropBtn.Size = UDim2.new(1, 0, 0, 25)
                DropBtn.Position = UDim2.new(0, 0, 0, 22)
                DropBtn.BorderSizePixel = 1
                DropBtn.BorderColor3 = Library.Theme.Colors.BorderNormal
                DropBtn.TextXAlignment = Enum.TextXAlignment.Left
                DropBtn.TextYAlignment = Enum.TextYAlignment.Center
                
                local DropCorner = Instance.new("UICorner")
                DropCorner.Parent = DropBtn
                DropCorner.CornerRadius = UDim.new(0, 2)
                
                local Arrow = Instance.new("TextLabel")
                Arrow.Parent = DropBtn
                Arrow.BackgroundTransparency = 1
                Arrow.Text = "▼"
                Arrow.TextColor3 = Library.Theme.Colors.SecondaryText
                Arrow.TextSize = 10
                Arrow.Font = Enum.Font.GothamBold
                Arrow.Size = UDim2.new(0, 20, 1, 0)
                Arrow.Position = UDim2.new(1, -25, 0, 0)
                Arrow.TextXAlignment = Enum.TextXAlignment.Right
                Arrow.TextYAlignment = Enum.TextYAlignment.Center
                
                local DropdownList = Instance.new("ScrollingFrame")
                DropdownList.Parent = Frame
                DropdownList.BackgroundColor3 = Library.Theme.Colors.CardBackground
                DropdownList.BorderSizePixel = 1
                DropdownList.BorderColor3 = Library.Theme.Colors.BorderNormal
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.Position = UDim2.new(0, 0, 0, 52)
                DropdownList.Visible = false
                DropdownList.ClipsDescendants = true
                DropdownList.ScrollBarThickness = 4
                DropdownList.ScrollBarImageColor3 = Library.Theme.Colors.BorderActive
                DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
                
                local ListCorner = Instance.new("UICorner")
                ListCorner.Parent = DropdownList
                ListCorner.CornerRadius = UDim.new(0, 2)
                
                local selected = config.Default or 1
                local dropdownOpen = false
                
                local function updateDropdownHeight()
                    local count = #config.Values
                    local height = math.min(count * 30, 150)
                    DropdownList.Size = UDim2.new(1, 0, 0, height)
                    DropdownList.CanvasSize = UDim2.new(0, 0, 0, count * 30)
                end
                
                -- Populate dropdown
                for i, option in ipairs(config.Values) do
                    local optBtn = Instance.new("TextButton")
                    optBtn.Parent = DropdownList
                    optBtn.Text = option
                    optBtn.BackgroundColor3 = Library.Theme.Colors.CardBackground
                    optBtn.TextColor3 = Library.Theme.Colors.PrimaryText
                    optBtn.TextSize = 13
                    optBtn.Font = Enum.Font.GothamMedium
                    optBtn.Size = UDim2.new(1, 0, 0, 30)
                    optBtn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
                    optBtn.BorderSizePixel = 0
                    optBtn.TextXAlignment = Enum.TextXAlignment.Left
                    optBtn.TextYAlignment = Enum.TextYAlignment.Center
                    
                    if i == selected then
                        optBtn.BackgroundColor3 = Library.Theme.Colors.DeepRed
                        optBtn.TextColor3 = Library.Theme.Colors.AccentAmber
                    end
                    
                    optBtn.MouseEnter:Connect(function()
                        if i ~= selected then
                            local tween = Library.Animator:Tween(optBtn, {
                                BackgroundColor3 = Library.Theme.Colors.Panels
                            }, 0.1)
                            Library.Animator:Play(tween)
                        end
                    end)
                    
                    optBtn.MouseLeave:Connect(function()
                        if i ~= selected then
                            local tween = Library.Animator:Tween(optBtn, {
                                BackgroundColor3 = Library.Theme.Colors.CardBackground
                            }, 0.1)
                            Library.Animator:Play(tween)
                        end
                    end)
                    
                    optBtn.MouseButton1Click:Connect(function()
                        selected = i
                        DropBtn.Text = option
                        DropdownList.Visible = false
                        dropdownOpen = false
                        
                        -- Update selection highlight
                        for _, btn in ipairs(DropdownList:GetChildren()) do
                            if btn:IsA("TextButton") then
                                btn.BackgroundColor3 = Library.Theme.Colors.CardBackground
                                btn.TextColor3 = Library.Theme.Colors.PrimaryText
                            end
                        end
                        optBtn.BackgroundColor3 = Library.Theme.Colors.DeepRed
                        optBtn.TextColor3 = Library.Theme.Colors.AccentAmber
                        
                        if config.Callback then
                            config.Callback(option)
                        end
                    end)
                end
                
                updateDropdownHeight()
                
                DropBtn.MouseButton1Click:Connect(function()
                    dropdownOpen = not dropdownOpen
                    DropdownList.Visible = dropdownOpen
                    
                    if dropdownOpen then
                        updateDropdownHeight()
                        local tween = Library.Animator:Tween(DropBtn, {
                            BorderColor3 = Library.Theme.Colors.BorderActive
                        }, 0.2)
                        Library.Animator:Play(tween)
                    else
                        local tween = Library.Animator:Tween(DropBtn, {
                            BorderColor3 = Library.Theme.Colors.BorderNormal
                        }, 0.2)
                        Library.Animator:Play(tween)
                    end
                end)
                
                Group.YPos = Group.YPos + 50
                Group.Controls[config.Text] = DropBtn
                return DropBtn
            end
            
            -- ============================================
            -- CONTROL: INPUT
            -- ============================================
            function Group:AddInput(config)
                config = config or {}
                config.Text = config.Text or "Input"
                config.Placeholder = config.Placeholder or "Type here..."
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundColor3 = Library.Theme.Colors.CardBackground
                Frame.BorderSizePixel = 1
                Frame.BorderColor3 = Library.Theme.Colors.BorderNormal
                Frame.Size = UDim2.new(1, 0, 0, 36)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                Frame.ClipsDescendants = true
                
                local FrameCorner = Instance.new("UICorner")
                FrameCorner.Parent = Frame
                FrameCorner.CornerRadius = UDim.new(0, 2)
                
                local InputBox = Instance.new("TextBox")
                InputBox.Parent = Frame
                InputBox.Text = ""
                InputBox.PlaceholderText = config.Placeholder
                InputBox.BackgroundTransparency = 1
                InputBox.TextColor3 = Library.Theme.Colors.PrimaryText
                InputBox.PlaceholderColor3 = Library.Theme.Colors.DisabledText
                InputBox.TextSize = 14
                InputBox.Font = Enum.Font.GothamMedium
                InputBox.Size = UDim2.new(1, -15, 1, 0)
                InputBox.Position = UDim2.new(0, 10, 0, 0)
                InputBox.TextXAlignment = Enum.TextXAlignment.Left
                InputBox.TextYAlignment = Enum.TextYAlignment.Center
                InputBox.ClearTextOnFocus = false
                
                InputBox.Focused:Connect(function()
                    local tween = Library.Animator:Tween(Frame, {
                        BorderColor3 = Library.Theme.Colors.BorderActive
                    }, 0.2)
                    Library.Animator:Play(tween)
                end)
                
                InputBox.FocusLost:Connect(function(enterPressed)
                    local tween = Library.Animator:Tween(Frame, {
                        BorderColor3 = Library.Theme.Colors.BorderNormal
                    }, 0.2)
                    Library.Animator:Play(tween)
                    
                    if config.Callback and enterPressed then
                        config.Callback(InputBox.Text)
                    end
                end)
                
                Group.YPos = Group.YPos + 41
                Group.Controls[config.Text] = InputBox
                return InputBox
            end
            
            -- ============================================
            -- CONTROL: LABEL
            -- ============================================
            function Group:AddLabel(config)
                config = config or {}
                config.Text = config.Text or "Label"
                config.Color = config.Color or Library.Theme.Colors.PrimaryText
                config.Size = config.Size or 14
                
                local Label = Instance.new("TextLabel")
                Label.Parent = GroupContent
                Label.BackgroundTransparency = 1
                Label.Text = config.Text
                Label.TextColor3 = type(config.Color) == "string" and Color3.fromHex(config.Color) or config.Color
                Label.TextSize = config.Size
                Label.Font = config.Font or Enum.Font.GothamMedium
                Label.Size = UDim2.new(1, 0, 0, 25)
                Label.Position = UDim2.new(0, 0, 0, Group.YPos)
                Label.TextXAlignment = config.Alignment or Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                
                Group.YPos = Group.YPos + 30
                Group.Controls[config.Text] = Label
                return Label
            end
            
            -- ============================================
            -- CONTROL: SEPARATOR
            -- ============================================
            function Group:AddSeparator()
                local Separator = Instance.new("Frame")
                Separator.Parent = GroupContent
                Separator.BackgroundColor3 = Library.Theme.Colors.BorderNormal
                Separator.BorderSizePixel = 0
                Separator.Size = UDim2.new(1, 0, 0, 1)
                Separator.Position = UDim2.new(0, 0, 0, Group.YPos + 5)
                
                Group.YPos = Group.YPos + 15
                return Separator
            end
            
            -- ============================================
            -- CONTROL: NOTE
            -- ============================================
            function Group:AddNote(config)
                config = config or {}
                config.Text = config.Text or "Note"
                config.Type = config.Type or "info" -- info, warning, error, success
                
                local colors = {
                    info = Library.Theme.Colors.Info,
                    warning = Library.Theme.Colors.Warning,
                    error = Library.Theme.Colors.Error,
                    success = Library.Theme.Colors.Success,
                }
                
                local bgColors = {
                    info = Color3.fromHex("#1A237E"),
                    warning = Color3.fromHex("#1A237E"),
                    error = Library.Theme.Colors.DeepRed,
                    success = Color3.fromHex("#1B5E20"),
                }
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundColor3 = bgColors[config.Type] or Library.Theme.Colors.CardBackground
                Frame.BorderSizePixel = 1
                Frame.BorderColor3 = colors[config.Type] or Library.Theme.Colors.BorderNormal
                Frame.Size = UDim2.new(1, 0, 0, 0)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                Frame.ClipsDescendants = true
                
                local FrameCorner = Instance.new("UICorner")
                FrameCorner.Parent = Frame
                FrameCorner.CornerRadius = UDim.new(0, 2)
                
                local Icon = Instance.new("TextLabel")
                Icon.Parent = Frame
                Icon.BackgroundTransparency = 1
                Icon.Text = config.Type == "info" and "ℹ" or config.Type == "warning" and "⚠" or config.Type == "error" and "✕" or "✓"
                Icon.TextColor3 = colors[config.Type] or Library.Theme.Colors.PrimaryText
                Icon.TextSize = 16
                Icon.Font = Enum.Font.GothamBold
                Icon.Size = UDim2.new(0, 30, 1, 0)
                Icon.TextXAlignment = Enum.TextXAlignment.Center
                Icon.TextYAlignment = Enum.TextYAlignment.Center
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Frame
                Label.BackgroundTransparency = 1
                Label.Text = config.Text
                Label.TextColor3 = Library.Theme.Colors.PrimaryText
                Label.TextSize = 13
                Label.Font = Enum.Font.GothamMedium
                Label.Size = UDim2.new(1, -40, 1, 0)
                Label.Position = UDim2.new(0, 35, 0, 0)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                Label.TextWrapped = true
                
                -- Auto-height
                local textBounds = game:GetService("TextService"):GetTextSize(
                    config.Text,
                    13,
                    Enum.Font.GothamMedium,
                    Vector2.new(Frame.Size.X.Offset - 40, 1000)
                )
                local height = math.max(40, textBounds.Y + 20)
                Frame.Size = UDim2.new(1, 0, 0, height)
                
                Group.YPos = Group.YPos + height + 10
                Group.Controls[config.Text] = Frame
                return Frame
            end
            
            -- ============================================
            -- CONTROL: COLOR PICKER
            -- ============================================
            function Group:AddColorPicker(config)
                config = config or {}
                config.Text = config.Text or "Color"
                config.Default = config.Default or Color3.fromHex("#C62828")
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, 40)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Frame
                Label.BackgroundTransparency = 1
                Label.Text = config.Text
                Label.TextColor3 = Library.Theme.Colors.PrimaryText
                Label.TextSize = 14
                Label.Font = Enum.Font.GothamMedium
                Label.Size = UDim2.new(0.7, 0, 1, 0)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                
                local ColorBtn = Instance.new("TextButton")
                ColorBtn.Parent = Frame
                ColorBtn.BackgroundColor3 = config.Default
                ColorBtn.BorderSizePixel = 1
                ColorBtn.BorderColor3 = Library.Theme.Colors.BorderNormal
                ColorBtn.Size = UDim2.new(0, 30, 0, 30)
                ColorBtn.Position = UDim2.new(1, -35, 0.5, -15)
                ColorBtn.Text = ""
                
                local ColorCorner = Instance.new("UICorner")
                ColorCorner.Parent = ColorBtn
                ColorCorner.CornerRadius = UDim.new(0, 2)
                
                local selected = config.Default
                
                ColorBtn.MouseButton1Click:Connect(function()
                    -- Simple color cycling for demo
                    local colors = {
                        Color3.fromHex("#C62828"),
                        Color3.fromHex("#E53935"),
                        Color3.fromHex("#FFB300"),
                        Color3.fromHex("#4CAF50"),
                        Color3.fromHex("#2196F3"),
                        Color3.fromHex("#9C27B0"),
                    }
                    
                    local currentIndex
                    for i, c in ipairs(colors) do
                        if c.R == selected.R and c.G == selected.G and c.B == selected.B then
                            currentIndex = i
                            break
                        end
                    end
                    
                    currentIndex = (currentIndex or 1) % #colors + 1
                    selected = colors[currentIndex]
                    
                    local tween = Library.Animator:Tween(ColorBtn, {
                        BackgroundColor3 = selected
                    }, 0.2)
                    Library.Animator:Play(tween)
                    
                    if config.Callback then
                        config.Callback(selected)
                    end
                end)
                
                Group.YPos = Group.YPos + 45
                Group.Controls[config.Text] = ColorBtn
                return ColorBtn
            end
            
            -- ============================================
            -- CONTROL: KEYBIND
            -- ============================================
            function Group:AddKeybind(config)
                config = config or {}
                config.Text = config.Text or "Keybind"
                config.Default = config.Default or Enum.KeyCode.LeftControl
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, 40)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Frame
                Label.BackgroundTransparency = 1
                Label.Text = config.Text
                Label.TextColor3 = Library.Theme.Colors.PrimaryText
                Label.TextSize = 14
                Label.Font = Enum.Font.GothamMedium
                Label.Size = UDim2.new(0.6, 0, 1, 0)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                
                local KeyBtn = Instance.new("TextButton")
                KeyBtn.Parent = Frame
                KeyBtn.Text = config.Default.Name
                KeyBtn.BackgroundColor3 = Library.Theme.Colors.CardBackground
                KeyBtn.TextColor3 = Library.Theme.Colors.PrimaryText
                KeyBtn.TextSize = 13
                KeyBtn.Font = Enum.Font.GothamMedium
                KeyBtn.Size = UDim2.new(0, 100, 0, 30)
                KeyBtn.Position = UDim2.new(1, -105, 0.5, -15)
                KeyBtn.BorderSizePixel = 1
                KeyBtn.BorderColor3 = Library.Theme.Colors.BorderNormal
                
                local KeyCorner = Instance.new("UICorner")
                KeyCorner.Parent = KeyBtn
                KeyCorner.CornerRadius = UDim.new(0, 2)
                
                local key = config.Default
                local listening = false
                
                KeyBtn.MouseButton1Click:Connect(function()
                    listening = not listening
                    if listening then
                        KeyBtn.Text = "..."
                        local tween = Library.Animator:Tween(KeyBtn, {
                            BorderColor3 = Library.Theme.Colors.BorderImportant
                        }, 0.2)
                        Library.Animator:Play(tween)
                    else
                        KeyBtn.Text = key.Name
                        local tween = Library.Animator:Tween(KeyBtn, {
                            BorderColor3 = Library.Theme.Colors.BorderNormal
                        }, 0.2)
                        Library.Animator:Play(tween)
                    end
                end)
                
                game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
                    if listening and not gameProcessed then
                        key = input.KeyCode
                        if key ~= Enum.KeyCode.Unknown then
                            KeyBtn.Text = key.Name
                            listening = false
                            local tween = Library.Animator:Tween(KeyBtn, {
                                BorderColor3 = Library.Theme.Colors.BorderNormal
                            }, 0.2)
                            Library.Animator:Play(tween)
                            
                            if config.Callback then
                                config.Callback(key)
                            end
                        end
                    end
                end)
                
                Group.YPos = Group.YPos + 45
                Group.Controls[config.Text] = KeyBtn
                return KeyBtn
            end
            
            -- ============================================
            -- CONTROL: PROGRESS BAR
            -- ============================================
            function Group:AddProgress(config)
                config = config or {}
                config.Text = config.Text or "Progress"
                config.Value = config.Value or 50
                config.Max = config.Max or 100
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, 45)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Frame
                Label.BackgroundTransparency = 1
                Label.Text = config.Text .. ": " .. config.Value .. "/" .. config.Max
                Label.TextColor3 = Library.Theme.Colors.PrimaryText
                Label.TextSize = 14
                Label.Font = Enum.Font.GothamMedium
                Label.Size = UDim2.new(1, 0, 0, 20)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                
                local BarFrame = Instance.new("Frame")
                BarFrame.Parent = Frame
                BarFrame.BackgroundColor3 = Library.Theme.Colors.CardBackground
                BarFrame.BorderSizePixel = 1
                BarFrame.BorderColor3 = Library.Theme.Colors.BorderNormal
                BarFrame.Size = UDim2.new(1, 0, 0, 20)
                BarFrame.Position = UDim2.new(0, 0, 0, 22)
                
                local BarCorner = Instance.new("UICorner")
                BarCorner.Parent = BarFrame
                BarCorner.CornerRadius = UDim.new(0, 2)
                
                local FillBar = Instance.new("Frame")
                FillBar.Parent = BarFrame
                FillBar.BackgroundColor3 = Library.Theme.Colors.PrimaryRed
                FillBar.BorderSizePixel = 0
                FillBar.Size = UDim2.new(config.Value / config.Max, 0, 1, 0)
                
                local FillCorner2 = Instance.new("UICorner")
                FillCorner2.Parent = FillBar
                FillCorner2.CornerRadius = UDim.new(0, 2)
                
                function Group:UpdateProgress(value)
                    value = math.max(0, math.min(config.Max, value))
                    local percent = value / config.Max
                    
                    local tween = Library.Animator:Tween(FillBar, {
                        Size = UDim2.new(percent, 0, 1, 0)
                    }, 0.3)
                    Library.Animator:Play(tween)
                    
                    Label.Text = config.Text .. ": " .. value .. "/" .. config.Max
                end
                
                Group.YPos = Group.YPos + 50
                Group.Controls[config.Text] = FillBar
                return {
                    Update = function(self, value)
                        Group:UpdateProgress(value)
                    end
                }
            end
            
            -- ============================================
            -- CONTROL: CHECKBOX
            -- ============================================
            function Group:AddCheckbox(config)
                config = config or {}
                config.Text = config.Text or "Checkbox"
                config.Default = config.Default or false
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, 35)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                local CheckboxBtn = Instance.new("TextButton")
                CheckboxBtn.Parent = Frame
                CheckboxBtn.BackgroundColor3 = Library.Theme.Colors.CardBackground
                CheckboxBtn.BorderSizePixel = 1
                CheckboxBtn.BorderColor3 = Library.Theme.Colors.BorderNormal
                CheckboxBtn.Size = UDim2.new(0, 20, 0, 20)
                CheckboxBtn.Position = UDim2.new(0, 0, 0.5, -10)
                CheckboxBtn.Text = ""
                
                local CheckCorner = Instance.new("UICorner")
                CheckCorner.Parent = CheckboxBtn
                CheckCorner.CornerRadius = UDim.new(0, 2)
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Frame
                Label.BackgroundTransparency = 1
                Label.Text = config.Text
                Label.TextColor3 = Library.Theme.Colors.PrimaryText
                Label.TextSize = 14
                Label.Font = Enum.Font.GothamMedium
                Label.Size = UDim2.new(1, -30, 1, 0)
                Label.Position = UDim2.new(0, 30, 0, 0)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                
                local checked = config.Default
                if checked then
                    CheckboxBtn.BackgroundColor3 = Library.Theme.Colors.PrimaryRed
                    CheckboxBtn.BorderColor3 = Library.Theme.Colors.BorderActive
                end
                
                CheckboxBtn.MouseButton1Click:Connect(function()
                    checked = not checked
                    if checked then
                        local tween = Library.Animator:Tween(CheckboxBtn, {
                            BackgroundColor3 = Library.Theme.Colors.PrimaryRed,
                            BorderColor3 = Library.Theme.Colors.BorderActive
                        }, 0.15)
                        Library.Animator:Play(tween)
                    else
                        local tween = Library.Animator:Tween(CheckboxBtn, {
                            BackgroundColor3 = Library.Theme.Colors.CardBackground,
                            BorderColor3 = Library.Theme.Colors.BorderNormal
                        }, 0.15)
                        Library.Animator:Play(tween)
                    end
                    
                    if config.Callback then
                        config.Callback(checked)
                    end
                end)
                
                Group.YPos = Group.YPos + 40
                Group.Controls[config.Text] = CheckboxBtn
                return CheckboxBtn
            end
            
            -- ============================================
            -- CONTROL: RADIO BUTTON
            -- ============================================
            function Group:AddRadio(config)
                config = config or {}
                config.Text = config.Text or "Radio"
                config.Values = config.Values or {"Option 1", "Option 2"}
                config.Default = config.Default or 1
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, 30 + (#config.Values * 35))
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Frame
                Label.BackgroundTransparency = 1
                Label.Text = config.Text
                Label.TextColor3 = Library.Theme.Colors.PrimaryText
                Label.TextSize = 14
                Label.Font = Enum.Font.GothamMedium
                Label.Size = UDim2.new(1, 0, 0, 30)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                
                local radioBtns = {}
                local selected = config.Default
                
                for i, option in ipairs(config.Values) do
                    local RadioFrame = Instance.new("Frame")
                    RadioFrame.Parent = Frame
                    RadioFrame.BackgroundTransparency = 1
                    RadioFrame.Size = UDim2.new(1, 0, 0, 30)
                    RadioFrame.Position = UDim2.new(0, 0, 0, 30 + ((i-1) * 35))
                    
                    local RadioBtn = Instance.new("TextButton")
                    RadioBtn.Parent = RadioFrame
                    RadioBtn.BackgroundColor3 = Library.Theme.Colors.CardBackground
                    RadioBtn.BorderSizePixel = 1
                    RadioBtn.BorderColor3 = Library.Theme.Colors.BorderNormal
                    RadioBtn.Size = UDim2.new(0, 16, 0, 16)
                    RadioBtn.Position = UDim2.new(0, 5, 0.5, -8)
                    RadioBtn.Text = ""
                    
                    local RadioCorner = Instance.new("UICorner")
                    RadioCorner.Parent = RadioBtn
                    RadioCorner.CornerRadius = UDim.new(1, 0)
                    
                    local OptionLabel = Instance.new("TextLabel")
                    OptionLabel.Parent = RadioFrame
                    OptionLabel.BackgroundTransparency = 1
                    OptionLabel.Text = option
                    OptionLabel.TextColor3 = Library.Theme.Colors.PrimaryText
                    OptionLabel.TextSize = 13
                    OptionLabel.Font = Enum.Font.GothamMedium
                    OptionLabel.Size = UDim2.new(1, -30, 1, 0)
                    OptionLabel.Position = UDim2.new(0, 30, 0, 0)
                    OptionLabel.TextXAlignment = Enum.TextXAlignment.Left
                    OptionLabel.TextYAlignment = Enum.TextYAlignment.Center
                    
                    if i == selected then
                        RadioBtn.BackgroundColor3 = Library.Theme.Colors.PrimaryRed
                        RadioBtn.BorderColor3 = Library.Theme.Colors.BorderActive
                    end
                    
                    RadioBtn.MouseButton1Click:Connect(function()
                        selected = i
                        for j, btn in ipairs(radioBtns) do
                            if j == i then
                                local tween = Library.Animator:Tween(btn, {
                                    BackgroundColor3 = Library.Theme.Colors.PrimaryRed,
                                    BorderColor3 = Library.Theme.Colors.BorderActive
                                }, 0.15)
                                Library.Animator:Play(tween)
                            else
                                local tween = Library.Animator:Tween(btn, {
                                    BackgroundColor3 = Library.Theme.Colors.CardBackground,
                                    BorderColor3 = Library.Theme.Colors.BorderNormal
                                }, 0.15)
                                Library.Animator:Play(tween)
                            end
                        end
                        
                        if config.Callback then
                            config.Callback(option, i)
                        end
                    end)
                    
                    radioBtns[i] = RadioBtn
                end
                
                Group.YPos = Group.YPos + 30 + (#config.Values * 35) + 10
                Group.Controls[config.Text] = radioBtns
                return radioBtns
            end
            
            -- ============================================
            -- CONTROL: LIST
            -- ============================================
            function Group:AddList(config)
                config = config or {}
                config.Text = config.Text or "List"
                config.Items = config.Items or {"Item 1", "Item 2", "Item 3"}
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, 35 + (#config.Items * 25))
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Frame
                Label.BackgroundTransparency = 1
                Label.Text = config.Text
                Label.TextColor3 = Library.Theme.Colors.PrimaryText
                Label.TextSize = 14
                Label.Font = Enum.Font.GothamMedium
                Label.Size = UDim2.new(1, 0, 0, 30)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                
                for i, item in ipairs(config.Items) do
                    local ItemLabel = Instance.new("TextLabel")
                    ItemLabel.Parent = Frame
                    ItemLabel.BackgroundTransparency = 1
                    ItemLabel.Text = "• " .. item
                    ItemLabel.TextColor3 = Library.Theme.Colors.SecondaryText
                    ItemLabel.TextSize = 12
                    ItemLabel.Font = Enum.Font.GothamMedium
                    ItemLabel.Size = UDim2.new(1, -20, 0, 20)
                    ItemLabel.Position = UDim2.new(0, 15, 0, 30 + ((i-1) * 25))
                    ItemLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ItemLabel.TextYAlignment = Enum.TextYAlignment.Center
                end
                
                Group.YPos = Group.YPos + 35 + (#config.Items * 25) + 10
                Group.Controls[config.Text] = Frame
                return Frame
            end
            
            -- ============================================
            -- CONTROL: COLLAPSIBLE
            -- ============================================
            function Group:AddCollapsible(config)
                config = config or {}
                config.Title = config.Title or "Collapsible"
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, 35)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                local ToggleBtn = Instance.new("TextButton")
                ToggleBtn.Parent = Frame
                ToggleBtn.Text = "▶ " .. config.Title
                ToggleBtn.BackgroundColor3 = Library.Theme.Colors.CardBackground
                ToggleBtn.TextColor3 = Library.Theme.Colors.PrimaryText
                ToggleBtn.TextSize = 13
                ToggleBtn.Font = Enum.Font.GothamBold
                ToggleBtn.Size = UDim2.new(1, 0, 0, 30)
                ToggleBtn.BorderSizePixel = 1
                ToggleBtn.BorderColor3 = Library.Theme.Colors.BorderNormal
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
                ToggleBtn.TextYAlignment = Enum.TextYAlignment.Center
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.Parent = ToggleBtn
                ToggleCorner.CornerRadius = UDim.new(0, 2)
                
                local Content = Instance.new("Frame")
                Content.Parent = Frame
                Content.BackgroundTransparency = 1
                Content.Size = UDim2.new(1, -20, 0, 0)
                Content.Position = UDim2.new(0, 10, 0, 35)
                Content.Visible = false
                Content.ClipsDescendants = true
                
                local collapsed = true
                local contentHeight = 0
                
                -- Store controls in this collapsible
                local collapsibleControls = {}
                local yPos = 0
                
                function Collapsible:AddButton(cfg)
                    -- Delegate to groupbox style
                    local btn = Instance.new("TextButton")
                    btn.Parent = Content
                    btn.Text = cfg.Text or "Button"
                    btn.BackgroundColor3 = Library.Theme.Button.Idle
                    btn.TextColor3 = Library.Theme.Colors.PrimaryText
                    btn.TextSize = 13
                    btn.Font = Enum.Font.GothamMedium
                    btn.Size = UDim2.new(1, 0, 0, 28)
                    btn.Position = UDim2.new(0, 0, 0, yPos)
                    btn.BorderSizePixel = 1
                    btn.BorderColor3 = Library.Theme.Colors.BorderNormal
                    
                    local btnCorner = Instance.new("UICorner")
                    btnCorner.Parent = btn
                    btnCorner.CornerRadius = UDim.new(0, 2)
                    
                    btn.MouseEnter:Connect(function()
                        local tween = Library.Animator:Tween(btn, {
                            BackgroundColor3 = Library.Theme.Button.Hover
                        }, 0.15)
                        Library.Animator:Play(tween)
                    end)
                    
                    btn.MouseLeave:Connect(function()
                        local tween = Library.Animator:Tween(btn, {
                            BackgroundColor3 = Library.Theme.Button.Idle
                        }, 0.15)
                        Library.Animator:Play(tween)
                    end)
                    
                    btn.MouseButton1Click:Connect(function()
                        if cfg.Callback then
                            cfg.Callback()
                        end
                    end)
                    
                    yPos = yPos + 33
                    contentHeight = yPos + 5
                    Content.Size = UDim2.new(1, -20, 0, contentHeight)
                    return btn
                end
                
                function Collapsible:AddLabel(cfg)
                    local label = Instance.new("TextLabel")
                    label.Parent = Content
                    label.BackgroundTransparency = 1
                    label.Text = cfg.Text or "Label"
                    label.TextColor3 = Library.Theme.Colors.PrimaryText
                    label.TextSize = 13
                    label.Font = Enum.Font.GothamMedium
                    label.Size = UDim2.new(1, 0, 0, 25)
                    label.Position = UDim2.new(0, 0, 0, yPos)
                    label.TextXAlignment = Enum.TextXAlignment.Left
                    label.TextYAlignment = Enum.TextYAlignment.Center
                    
                    yPos = yPos + 30
                    contentHeight = yPos + 5
                    Content.Size = UDim2.new(1, -20, 0, contentHeight)
                    return label
                end
                
                ToggleBtn.MouseButton1Click:Connect(function()
                    collapsed = not collapsed
                    Content.Visible = not collapsed
                    
                    if not collapsed then
                        ToggleBtn.Text = "▼ " .. config.Title
                        local tween = Library.Animator:Tween(ToggleBtn, {
                            BorderColor3 = Library.Theme.Colors.BorderActive
                        }, 0.2)
                        Library.Animator:Play(tween)
                    else
                        ToggleBtn.Text = "▶ " .. config.Title
                        local tween = Library.Animator:Tween(ToggleBtn, {
                            BorderColor3 = Library.Theme.Colors.BorderNormal
                        }, 0.2)
                        Library.Animator:Play(tween)
                    end
                end)
                
                Group.YPos = Group.YPos + 35
                if not collapsed then
                    Group.YPos = Group.YPos + contentHeight + 10
                end
                
                Group.Controls[config.Title] = Collapsible
                return Collapsible
            end
            
            -- ============================================
            -- CONTROL: TAB SEPARATOR
            -- ============================================
            function Group:AddTabSeparator(config)
                config = config or {}
                config.Text = config.Text or ""
                config.Height = config.Height or 20
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, config.Height)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                if config.Text ~= "" then
                    local Label = Instance.new("TextLabel")
                    Label.Parent = Frame
                    Label.BackgroundTransparency = 1
                    Label.Text = config.Text
                    Label.TextColor3 = Library.Theme.Colors.DisabledText
                    Label.TextSize = 10
                    Label.Font = Enum.Font.GothamBold
                    Label.Size = UDim2.new(1, 0, 1, 0)
                    Label.TextXAlignment = Enum.TextXAlignment.Center
                    Label.TextYAlignment = Enum.TextYAlignment.Center
                end
                
                Group.YPos = Group.YPos + config.Height
                return Frame
            end
            
            -- ============================================
            -- CONTROL: IMAGE
            -- ============================================
            function Group:AddImage(config)
                config = config or {}
                config.Image = config.Image or "rbxasset://textures/ui/FrameShadow.png"
                config.Size = config.Size or Vector2.new(100, 100)
                
                local Image = Instance.new("ImageLabel")
                Image.Parent = GroupContent
                Image.BackgroundColor3 = Library.Theme.Colors.CardBackground
                Image.BorderSizePixel = 1
                Image.BorderColor3 = Library.Theme.Colors.BorderNormal
                Image.Size = UDim2.new(0, config.Size.X, 0, config.Size.Y)
                Image.Position = UDim2.new(0.5, -config.Size.X/2, 0, Group.YPos)
                Image.Image = config.Image
                Image.ScaleType = Enum.ScaleType.Fit
                Image.ClipsDescendants = true
                
                local ImageCorner = Instance.new("UICorner")
                ImageCorner.Parent = Image
                ImageCorner.CornerRadius = UDim.new(0, 2)
                
                Group.YPos = Group.YPos + config.Size.Y + 10
                Group.Controls[config.Text] = Image
                return Image
            end
            
            -- ============================================
            -- CONTROL: SCROLLBAR
            -- ============================================
            function Group:AddScrollbar(config)
                config = config or {}
                config.Size = config.Size or UDim2.new(1, 0, 0, 60)
                config.Content = config.Content or "Scrollable content here..."
                
                local ScrollFrame = Instance.new("ScrollingFrame")
                ScrollFrame.Parent = GroupContent
                ScrollFrame.BackgroundColor3 = Library.Theme.Colors.CardBackground
                ScrollFrame.BorderSizePixel = 1
                ScrollFrame.BorderColor3 = Library.Theme.Colors.BorderNormal
                ScrollFrame.Size = config.Size
                ScrollFrame.Position = UDim2.new(0, 0, 0, Group.YPos)
                ScrollFrame.ClipsDescendants = true
                ScrollFrame.ScrollBarThickness = 4
                ScrollFrame.ScrollBarImageColor3 = Library.Theme.Colors.BorderActive
                ScrollFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
                
                local ScrollCorner = Instance.new("UICorner")
                ScrollCorner.Parent = ScrollFrame
                ScrollCorner.CornerRadius = UDim.new(0, 2)
                
                local ContentLabel = Instance.new("TextLabel")
                ContentLabel.Parent = ScrollFrame
                ContentLabel.BackgroundTransparency = 1
                ContentLabel.Text = config.Content
                ContentLabel.TextColor3 = Library.Theme.Colors.SecondaryText
                ContentLabel.TextSize = 13
                ContentLabel.Font = Enum.Font.GothamMedium
                ContentLabel.Size = UDim2.new(1, -10, 0, 0)
                ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
                ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
                ContentLabel.TextWrapped = true
                ContentLabel.TextScaled = false
                
                -- Calculate height
                local textBounds = game:GetService("TextService"):GetTextSize(
                    config.Content,
                    13,
                    Enum.Font.GothamMedium,
                    Vector2.new(config.Size.X.Offset - 10, 1000)
                )
                ContentLabel.Size = UDim2.new(1, -10, 0, textBounds.Y + 20)
                ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, textBounds.Y + 20)
                
                Group.YPos = Group.YPos + config.Size.Y.Offset + 10
                Group.Controls[config.Text] = ScrollFrame
                return ScrollFrame
            end
            
            -- ============================================
            -- CONTROL: TOOLTIP
            -- ============================================
            function Group:AddTooltip(config)
                config = config or {}
                config.Text = config.Text or "Tooltip"
                config.Content = config.Content or "Tooltip content"
                
                local Frame = Instance.new("Frame")
                Frame.Parent = GroupContent
                Frame.BackgroundTransparency = 1
                Frame.Size = UDim2.new(1, 0, 0, 35)
                Frame.Position = UDim2.new(0, 0, 0, Group.YPos)
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Frame
                Label.BackgroundTransparency = 1
                Label.Text = config.Text
                Label.TextColor3 = Library.Theme.Colors.PrimaryText
                Label.TextSize = 14
                Label.Font = Enum.Font.GothamMedium
                Label.Size = UDim2.new(0.7, 0, 1, 0)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextYAlignment = Enum.TextYAlignment.Center
                
                local TooltipBtn = Instance.new("TextButton")
                TooltipBtn.Parent = Frame
                TooltipBtn.Text = "?"
                TooltipBtn.BackgroundColor3 = Library.Theme.Colors.PrimaryRed
                TooltipBtn.TextColor3 = Library.Theme.Colors.PrimaryText
                TooltipBtn.TextSize = 14
                TooltipBtn.Font = Enum.Font.GothamBold
                TooltipBtn.Size = UDim2.new(0, 25, 0, 25)
                TooltipBtn.Position = UDim2.new(1, -30, 0.5, -12.5)
                TooltipBtn.BorderSizePixel = 1
                TooltipBtn.BorderColor3 = Library.Theme.Colors.BorderNormal
                
                local TooltipCorner = Instance.new("UICorner")
                TooltipCorner.Parent = TooltipBtn
                TooltipCorner.CornerRadius = UDim.new(1, 0)
                
                local TooltipPopup = Instance.new("Frame")
                TooltipPopup.Parent = Frame
                TooltipPopup.BackgroundColor3 = Library.Theme.Colors.Panels
                TooltipPopup.BorderSizePixel = 1
                TooltipPopup.BorderColor3 = Library.Theme.Colors.BorderImportant
                TooltipPopup.Size = UDim2.new(1, 0, 0, 0)
                TooltipPopup.Position = UDim2.new(0, 0, 0, 35)
                TooltipPopup.Visible = false
                TooltipPopup.ClipsDescendants = true
                
                local PopupCorner = Instance.new("UICorner")
                PopupCorner.Parent = TooltipPopup
                PopupCorner.CornerRadius = UDim.new(0, 2)
                
                local PopupLabel = Instance.new("TextLabel")
                PopupLabel.Parent = TooltipPopup
                PopupLabel.BackgroundTransparency = 1
                PopupLabel.Text = config.Content
                PopupLabel.TextColor3 = Library.Theme.Colors.SecondaryText
                PopupLabel.TextSize = 12
                PopupLabel.Font = Enum.Font.GothamMedium
                PopupLabel.Size = UDim2.new(1, -10, 0, 0)
                PopupLabel.Position = UDim2.new(0, 5, 0, 5)
                PopupLabel.TextXAlignment = Enum.TextXAlignment.Left
                PopupLabel.TextYAlignment = Enum.TextYAlignment.Top
                PopupLabel.TextWrapped = true
                
                local textBounds = game:GetService("TextService"):GetTextSize(
                    config.Content,
                    12,
                    Enum.Font.GothamMedium,
                    Vector2.new(Frame.Size.X.Offset - 10, 1000)
                )
                local popupHeight = math.max(30, textBounds.Y + 15)
                PopupLabel.Size = UDim2.new(1, -10, 0, popupHeight)
                TooltipPopup.Size = UDim2.new(1, 0, 0, popupHeight + 10)
                
                TooltipBtn.MouseEnter:Connect(function()
                    TooltipPopup.Visible = true
                    local tween = Library.Animator:Tween(TooltipPopup, {
                        Size = UDim2.new(1, 0, 0, popupHeight + 10)
                    }, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    Library.Animator:Play(tween)
                end)
                
                TooltipBtn.MouseLeave:Connect(function()
                    local tween = Library.Animator:Tween(TooltipPopup, {
                        Size = UDim2.new(1, 0, 0, 0)
                    }, 0.2)
                    tween.Completed:Connect(function()
                        TooltipPopup.Visible = false
                    end)
                    Library.Animator:Play(tween)
                end)
                
                Group.YPos = Group.YPos + 40
                Group.Controls[config.Text] = TooltipBtn
                return TooltipBtn
            end
            
            -- ============================================
            -- FINALIZE GROUP
            -- ============================================
            Group.Frame.Size = UDim2.new(groupWidth, 0, 0, Group.YPos + 45)
            
            -- Update content scroller
            local contentHeight = 0
            for _, child in ipairs(TabContent:GetChildren()) do
                if child:IsA("Frame") and child.Visible ~= false then
                    local height = child.Size.Y.Offset + child.Position.Y.Offset + 10
                    if height > contentHeight then
                        contentHeight = height
                    end
                end
            end
            
            TabContent.Size = UDim2.new(1, 0, 0, contentHeight + 50)
            ContentScroller.CanvasSize = UDim2.new(0, 0, 0, contentHeight + 50)
            
            table.insert(Tab.Groups, Group)
            return Group
        end
        
        -- Select first tab by default
        if #Window.Tabs == 0 then
            TabBtn.BackgroundColor3 = Library.Theme.Colors.DeepRed
            TabBtn.TextColor3 = Library.Theme.Colors.PrimaryText
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end
        
        table.insert(Window.Tabs, Tab)
        table.insert(Window.TabButtons, TabBtn)
        
        return Tab
    end
    
    -- Notification system
    function Window:Notify(config)
        config = config or {}
        config.Title = config.Title or "Notification"
        config.Message = config.Message or "Hello!"
        config.Type = config.Type or "info"
        config.Duration = config.Duration or 3
        
        local colors = {
            info = Library.Theme.Colors.Info,
            warning = Library.Theme.Colors.Warning,
            error = Library.Theme.Colors.Error,
            success = Library.Theme.Colors.Success,
        }
        
        local bgColors = {
            info = Color3.fromHex("#1A237E"),
            warning = Color3.fromHex("#1A237E"),
            error = Library.Theme.Colors.DeepRed,
            success = Color3.fromHex("#1B5E20"),
        }
        
        local Notification = Instance.new("Frame")
        Notification.Parent = ScreenGui
        Notification.BackgroundColor3 = bgColors[config.Type] or Library.Theme.Colors.CardBackground
        Notification.BorderSizePixel = 1
        Notification.BorderColor3 = colors[config.Type] or Library.Theme.Colors.BorderNormal
        Notification.Size = UDim2.new(0, 350, 0, 60)
        Notification.Position = UDim2.new(1, 10, 1, -70)
        Notification.ClipsDescendants = true
        Notification.ZIndex = 100
        
        local NotifCorner = Instance.new("UICorner")
        NotifCorner.Parent = Notification
        NotifCorner.CornerRadius = UDim.new(0, 3)
        
        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Parent = Notification
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = config.Title
        TitleLabel.TextColor3 = Library.Theme.Colors.PrimaryText
        TitleLabel.TextSize = 13
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.Size = UDim2.new(1, -10, 0, 25)
        TitleLabel.Position = UDim2.new(0, 10, 0, 2)
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
        
        local MessageLabel = Instance.new("TextLabel")
        MessageLabel.Parent = Notification
        MessageLabel.BackgroundTransparency = 1
        MessageLabel.Text = config.Message
        MessageLabel.TextColor3 = Library.Theme.Colors.SecondaryText
        MessageLabel.TextSize = 12
        MessageLabel.Font = Enum.Font.GothamMedium
        MessageLabel.Size = UDim2.new(1, -10, 0, 30)
        MessageLabel.Position = UDim2.new(0, 10, 0, 28)
        MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
        MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
        MessageLabel.TextWrapped = true
        
        local CloseNotif = Instance.new("TextButton")
        CloseNotif.Parent = Notification
        CloseNotif.BackgroundTransparency = 1
        CloseNotif.Text = "✕"
        CloseNotif.TextColor3 = Library.Theme.Colors.SecondaryText
        CloseNotif.TextSize = 12
        CloseNotif.Font = Enum.Font.GothamBold
        CloseNotif.Size = UDim2.new(0, 25, 0, 25)
        CloseNotif.Position = UDim2.new(1, -30, 0, 2)
        CloseNotif.BorderSizePixel = 0
        
        CloseNotif.MouseEnter:Connect(function()
            CloseNotif.TextColor3 = Library.Theme.Colors.Error
        end)
        CloseNotif.MouseLeave:Connect(function()
            CloseNotif.TextColor3 = Library.Theme.Colors.SecondaryText
        end)
        
        CloseNotif.MouseButton1Click:Connect(function()
            local tween = Library.Animator:Tween(Notification, {
                Position = UDim2.new(1, 10, 1, -70),
                Size = UDim2.new(0, 0, 0, 0)
            }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            tween.Completed:Connect(function()
                Notification:Destroy()
            end)
            Library.Animator:Play(tween)
        end)
        
        -- Animate in
        Notification.Position = UDim2.new(1, 10, 1, 0)
        local tween = Library.Animator:Tween(Notification, {
            Position = UDim2.new(1, -360, 1, -70)
        }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        Library.Animator:Play(tween)
        
        -- Auto dismiss
        game:GetService("Debris"):AddItem(Notification, config.Duration + 0.5)
        
        return Notification
    end
    
    return Window
end

return Library
