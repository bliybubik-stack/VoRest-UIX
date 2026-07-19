-- VoRest UIX v2.0 Entry Point
local Library = require(script.Library)

local addons = {
    ThemeManager = pcall(function() return require(script.addons.ThemeManager) end),
    SaveManager = pcall(function() return require(script.addons.SaveManager) end),
    Animator = pcall(function() return require(script.addons.Animator) end),
    NotificationManager = pcall(function() return require(script.addons.NotificationManager) end),
}

return {
    Library = Library,
    ThemeManager = addons.ThemeManager,
    SaveManager = addons.SaveManager,
    Animator = addons.Animator,
    NotificationManager = addons.NotificationManager,
}
