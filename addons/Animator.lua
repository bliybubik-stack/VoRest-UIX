-- Standalone Animation Manager
local Animator = {}

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

function Animator:Create(object, properties, duration, style, direction)
    duration = duration or 0.2
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    
    return TweenService:Create(object, TweenInfo.new(duration, style, direction, 0, false, 0), properties)
end

function Animator:Play(tween, callback)
    tween:Play()
    if callback then
        tween.Completed:Connect(callback)
    end
    return tween
end

function Animator:Sequence(object, sequence)
    -- Sequence of tweens
    for _, tweenData in ipairs(sequence) do
        -- tweenData = {Properties, Duration, Style, Direction}
    end
end

return Animator
