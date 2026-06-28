local function castra_exists()
    return game.surfaces["castra"] ~= nil
end

local has_item_cache = nil

local power_pole_tiers = {
    "small-electric-pole",
    "medium-electric-pole", 
    "big-electric-pole",
    "substation"
}

local wall_tiers = { "stone-wall", "carbon-fiber-wall" }

local combat_robot_tiers = {
    "defender-capsule",
    "distractor-capsule",
    "destroyer-capsule"
}

local function update_item_cache()
    has_item_cache = {}
    for _, recipe in pairs(game.forces["enemy"].recipes) do
        if recipe.category and string.find(recipe.category, "recycling") or recipe.hidden then
            goto skip_item_check
        end

        if recipe.enabled and recipe.products then
            for _, product in pairs(recipe.products) do
                if product.name then
                    has_item_cache[product.name] = true
                end
            end
        end

        ::skip_item_check::
    end
end

local function has_castra_researched_item(item_name)
    if not has_item_cache then
        update_item_cache()
    end

    return has_item_cache[item_name]
end

local function does_module_exist(module_type, tier)
    if tier == 1 then
        -- Special case for tier 1 modules, which are not named with a number, 
        -- but just in case, also check in the numbered version exists
        return prototypes.item[module_type] ~= nil or prototypes.item[module_type .. "-1"] ~= nil
    end

    return prototypes.item[module_type .. "-" .. tier] ~= nil
end

local function get_highest_module_tier(module_type)
    -- Increment a number until the module does not exist as an item
    local i = 1
    while does_module_exist(module_type, i) do
        i = i + 1
    end
    return i - 1
end

-- List order defines tier: get_best_tier() walks forward and returns the last match,
-- so items must be ordered weakest → strongest. Reordering silently breaks tier caps
-- (e.g. the disable-enemy-nukes setting relies on atomic-bomb and hydrogen-bomb being last).
local default_sorted_ammo_types = {
    bullet = {"firearm-magazine", "piercing-rounds-magazine", "uranium-rounds-magazine", "plutonium-rounds-magazine"},
    rocket = {"rocket", "explosive-rocket", "atomic-bomb", "hydrogen-bomb"},
    railgun = {"railgun-ammo" },
    artillery_shell = {"artillery-shell", "cerys-neutron-bomb", "maraxsis-fat-man" },
}

local function get_sorted_ammo_types(category)
    local overrides = storage.castra
        and storage.castra.compatibility
        and storage.castra.compatibility.sorted_ammo_types

    return overrides and overrides[category] or default_sorted_ammo_types[category]
end

local function set_sorted_ammo_types(category, ammo_list)
    storage.castra = storage.castra or {}
    storage.castra.compatibility = storage.castra.compatibility or {}
    storage.castra.compatibility.sorted_ammo_types = storage.castra.compatibility.sorted_ammo_types or {}

    storage.castra.compatibility.sorted_ammo_types[category] = ammo_list

    return true
end

-- Returns the highest tier of a module type the enemy has researched
local function get_module_tier(module_type)
    local tier = 0
    for i = 1, get_highest_module_tier(module_type) do
        if (i == 1 and has_castra_researched_item(module_type)) or
           has_castra_researched_item(module_type .. "-" .. i) then
            tier = i
        end
    end
    return tier
end

-- Returns the highest tier item from an ordered list that the enemy has researched
local function get_best_tier(tier_list)
    local best = nil
    for _, item in ipairs(tier_list) do
        if has_castra_researched_item(item) then
            best = item
        end
    end
    return best
end

-- Returns true if the enemy has researched any item that places an entity of the given type
local function has_any_entity_type(entity_type)
    for item_name, _ in pairs(has_item_cache) do
        local entity = prototypes.entity[item_name]
        if entity and entity.type == entity_type then
            return true
        end
    end
    return false
end
-- Configuration table defining what the enemy can research and use.
-- Each entry: { key, check_fn, disabled_setting }
-- key: storage key (snake_case)
-- check_fn: function returning true if enemy has access
-- disabled_setting: optional startup setting name that blocks this
local enemy_capabilities = {
    -- Modules
    { key = "speed_module_tier",        check_fn = function() return get_module_tier("speed-module") end },
    { key = "productivity_module_tier", check_fn = function() return get_module_tier("productivity-module") end },
    { key = "quality_module_tier",      check_fn = function() return get_module_tier("quality-module") end },

    -- Power
    { key = "best_power_pole", check_fn = function() return get_best_tier(power_pole_tiers) end },

    -- Walls
    { key = "wall_tier", check_fn = function() return get_best_tier(wall_tiers) end },

    -- Ammo
    { key = "ammo_tier",      check_fn = function() return get_best_tier(get_sorted_ammo_types("bullet")) end },
    { key = "rocket_tier",    check_fn = function() return get_best_tier(get_sorted_ammo_types("rocket")) end },
    { key = "railgun_tier",   check_fn = function() return get_best_tier(get_sorted_ammo_types("railgun")) end },
    { key = "artillery_tier", check_fn = function() return get_best_tier(get_sorted_ammo_types("artillery_shell")) end },

    -- Combat robots
    { key = "combat_robot", check_fn = function() return get_best_tier(combat_robot_tiers) end },

    -- Simple entity flags
    { key = "gun_turret",        check_fn = function() return has_castra_researched_item("gun-turret") end },
    { key = "laser_turret",      check_fn = function() return has_castra_researched_item("laser-turret") end },
    { key = "flamethrower_turret", check_fn = function() return has_castra_researched_item("flamethrower-turret") end },
    { key = "rocket_turret",     check_fn = function() return has_castra_researched_item("rocket-turret") end },
    { key = "railgun_turret",    check_fn = function() return has_castra_researched_item("railgun-turret") end },
    { key = "solar_panel",       check_fn = function() return has_castra_researched_item("solar-panel") end },
    { key = "repair_pack",       check_fn = function() return has_castra_researched_item("repair-pack") end },
    { key = "roboport",          check_fn = function() return has_castra_researched_item("roboport") end },
    { key = "construction_robot", check_fn = function() return has_castra_researched_item("construction-robot") end },
    { key = "tank",              check_fn = function() return has_castra_researched_item("tank") end },
    { key = "spidertron",        check_fn = function() return has_castra_researched_item("spidertron") end },
    { key = "tesla_turret",      check_fn = function() return has_castra_researched_item("tesla-turret") end },
    { key = "combat_roboport",   check_fn = function() return has_castra_researched_item("combat-roboport") end },
    { key = "big_electric_pole", check_fn = function() return has_castra_researched_item("big-electric-pole") end },

    -- Settings-gated entries
    { key = "artillery_turret", check_fn = function() return has_castra_researched_item("artillery-turret") end,
      disabled_setting = "castra-prime-disable-artillery", tech_name = "artillery" },
    { key = "land_mine",        check_fn = function() return has_any_entity_type("land-mine") end,
      disabled_setting = "castra-prime-disable-land-mines", tech_name = "land-mine" },
}

local function update_castra_enemy_data()
    storage.castra = storage.castra or {}
    local enemy_storage = {}

    update_item_cache()

    for _, capability in ipairs(enemy_capabilities) do
        local disabled = capability.disabled_setting and
                        settings.startup[capability.disabled_setting] and
                        settings.startup[capability.disabled_setting].value
        -- BELT AND SUSPENDERS: placement is also blocked in base-generator/base-upgrades via this cache value.
        -- Primary block is now the tech disable below.
        -- Note: cannot use "disabled and false or check_fn()" here — Lua's ternary idiom breaks when the truthy branch is `false`.
        if disabled then
            enemy_storage[capability.key] = false
        else
            enemy_storage[capability.key] = capability.check_fn()
        end
    end

    -- BELT AND SUSPENDERS (primary block): disable the tech entirely so the enemy never researches it.
    -- The cache check above is a secondary fallback in case tech_name is missing or a modded variant slips through.
    for _, capability in ipairs(enemy_capabilities) do
        if capability.disabled_setting and capability.tech_name then
            local disabled = capability.disabled_setting and
                            settings.startup[capability.disabled_setting] and
                            settings.startup[capability.disabled_setting].value
            if disabled then
                local tech = game.forces["enemy"].technologies[capability.tech_name]
                if tech then
                    if tech.researched then tech.researched = false end
                    tech.enabled = false
                end
            end
        end
    end

    -- Quality tier requires special handling (iterates prototypes, not items)
    enemy_storage.quality_tier = prototypes.quality["normal"]
    for _, quality in pairs(prototypes.quality) do
        if quality and not quality.hidden and
           game.forces["enemy"].is_quality_unlocked(quality) and
           quality.level > enemy_storage.quality_tier.level then
            enemy_storage.quality_tier = quality
        end
    end

    storage.castra.enemy = enemy_storage
end

local function build_cache_if_needed()
    if not storage.castra or not storage.castra.enemy or (not storage.castra.enemy.gun_turret and has_castra_researched_item("gun-turret")) then
        update_castra_enemy_data()
    end
end

local function build_pollution_cache()    
    if not castra_exists() then
        return
    end

    storage.castra = storage.castra or {}
    storage.castra.dataCollectors = storage.castra.dataCollectors or {}
    storage.castra.dataCollectorsPollution = storage.castra.dataCollectorsPollution or {}
    if #storage.castra.dataCollectors == 0 then
        return
    end
    storage.castra.pollution_iterator = storage.castra.pollution_iterator or 0

    storage.castra.pollution_iterator = storage.castra.pollution_iterator + 1
    if storage.castra.pollution_iterator > #storage.castra.dataCollectors then
        storage.castra.pollution_iterator = 1
    end
    local dataCollector = storage.castra.dataCollectors[storage.castra.pollution_iterator]
    if dataCollector.valid then
        local pollution = 0
        -- Get 3x3 chunk pollution sum
        for x = -1, 1 do
            for y = -1, 1 do
                pollution = pollution + dataCollector.surface.get_pollution { x = dataCollector.position.x + x * 32, y = dataCollector.position.y + y * 32 }
            end
        end
        -- Update pollution in storage
        storage.castra.dataCollectorsPollution[dataCollector.unit_number] = pollution
    end
end

return {
    update_castra_enemy_data = update_castra_enemy_data,
    has_castra_researched_item = has_castra_researched_item,
    build_cache_if_needed = build_cache_if_needed,
    castra_exists = castra_exists,
    build_pollution_cache = build_pollution_cache,

    set_sorted_ammo_types = set_sorted_ammo_types,
    get_sorted_ammo_types = get_sorted_ammo_types,
}
