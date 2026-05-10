
-- settings.lua
data:extend({
    {
        type = "bool-setting",
        name = "castra-prime-disable-artillery",
        setting_type = "runtime-global", -- Todo likely  change to startup
        default_value = false,
        order = "a"
    },
    {
        type = "bool-setting",
        name = "castra-prime-buffed-forge",
        setting_type = "startup",
        default_value = false,
        order = "b"
    },
    {
        type = "bool-setting",
        name = "castra-prime-include-promsci",
        setting_type = "startup",
        default_value = true,
        order = "b"
    }
})

