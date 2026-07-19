-- VoRest UIX Entry Point
local Library = require(script.Library)

-- Addon support
local addons = {
    ThemeManager = pcall(function() return require(script.addons.ThemeManager) end),
    SaveManager = pcall(function() return require(script.addons.SaveManager) end),
}

return {
    Library = Library,
    ThemeManager = addons.ThemeManager,
    SaveManager = addons.SaveManager,
}
