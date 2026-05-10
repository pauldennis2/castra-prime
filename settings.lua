
-- settings.lua
data:extend({
    {
        type = "bool-setting",
        name = "castra-prime-disable-artillery",
        setting_type = "runtime-global",
        default_value = false,
        order = "a"
    },
    {
    type = "bool-setting",
    name = "castra-prime-buffed-forge",
    setting_type = "startup",
    default_value = false,
    order = "b"
    }
})

