-- Shared constants and data tables used across base-generator.lua and base-upgrades.lua.

local function hyphen_to_underscore(str)
    return string.gsub(str, "-", "_")
end

return {
    hyphen_to_underscore = hyphen_to_underscore,
    -- Radius used when checking whether an entity type is already present near a data collector
    BASE_CHECK_RADIUS = 30,
    -- Radius used when placing new entities near a data collector
    BASE_PLACE_RADIUS = 10,
    -- Radius used when filling turrets with ammo
    TURRET_FILL_RADIUS = 20,

    -- All turret types that can appear in enemy bases, in canonical order.
    -- Used for placement (base-generator.lua) and ammo-filling (base-upgrades.lua).
    -- Each file applies its own research/ammo filtering on top of this list.
    TURRET_TYPES = {
        "gun-turret",
        "laser-turret",
        "rocket-turret",
        "railgun-turret",
        "tesla-turret",
        "combat-roboport",
        "flamethrower-turret",
        "artillery-turret",
    },
}
