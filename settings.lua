
-- settings.lua
data:extend({
    {
        type = "bool-setting",
        name = "castra-prime-disable-artillery",
        setting_type = "startup",
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
        name = "castra-prime-gates-progression",
        setting_type = "startup",
        default_value = true,
        order = "b"
    },
    {
        type = "bool-setting",
        name = "castra-prime-suppress-research-msg",
        setting_type = "runtime-global",
        default_value = false,
        order = "b"
    },
    {
        type = "double-setting",
        name = "castra-prime-research-rate-multiplier",
        setting_type = "runtime-global",
        default_value = 1.0,
        minimum_value = 0.01,
        maximum_value = 100.0,
        order = "c"
    },
    {
        type = "bool-setting",
        name = "castra-prime-disable-enemy-nukes",
        setting_type = "startup",
        default_value = false,
        order = "c"
    },
    {
        type = "bool-setting",
        name = "castra-prime-disable-land-mines",
        setting_type = "startup",
        default_value = false,
        order = "c"
    },
    {
        type = "bool-setting",
        name = "castra-prime-nerf-enemy-bases",
        setting_type = "startup",
        default_value = false,
        order = "c"
    },
    {
        type = "bool-setting",
        name = "castra-prime-nauvis-nukes",
        setting_type = "startup",
        default_value = false,
        order = "d"
    },
    {
        type = "bool-setting",
        name = "castra-prime-buff-equipment",
        setting_type = "startup",
        default_value = false,
        order = "d"
    }
})

