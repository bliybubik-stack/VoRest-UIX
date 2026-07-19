-- Notification Manager
local NotificationManager = {}

local Notifications = {}

function NotificationManager:Show(message, type, duration)
    type = type or "info"
    duration = duration or 3
    
    -- Implementation uses the window's notify method
    return {
        Message = message,
        Type = type,
        Duration = duration,
        Dismiss = function()
            -- Dismiss notification
        end
    }
end

function NotificationManager:ClearAll()
    for _, notif in ipairs(Notifications) do
        notif:Dismiss()
    end
    Notifications = {}
end

return NotificationManager
