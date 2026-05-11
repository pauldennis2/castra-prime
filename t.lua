local function update_castra_enemy_data()
    storage.castra = storage.castra or {}
    local enemy_storage = storage.castra.enemy or {}

    update_item_cache()

    -- Helper: check module tier generically
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

    -- Module tiers
    enemy_storage.speed_module_tier = get_module_tier("speed-module")
    enemy_storage.productivity_module_tier = get_module_tier("productivity-module")
    enemy_storage.quality_module_tier = get_module_tier("quality-module")

    -- Best power pole: sequential upgrade check
    local power_pole_tiers = {
        "small-electric-pole",
        "medium-electric-pole",
        "substation"
    }
    enemy_storage.best_power_pole = nil
    for _, pole in ipairs(power_pole_tiers) do
        if has_castra_researched_item(pole) then
            enemy_storage.best_power_pole = pole
        end
    end

    -- Best wall tier
    local wall_tiers = { "stone-wall", "carbon-fiber-wall" }
    enemy_storage.wall_tier = nil
    for _, wall in ipairs(wall_tiers) do
        if has_castra_researched_item(wall) then
            enemy_storage.wall_tier = wall
        end
    end

    -- Ammo tiers: highest researched in each category
    local function get_highest_ammo_tier(ammo_list)
        local tier = nil
        for _, ammo in ipairs(ammo_list) do
            if has_castra_researched_item(ammo) then
                tier = ammo
            end
        end
        return tier
    end

    enemy_storage.ammo_tier = get_highest_ammo_tier(sorted_ammo_types.bullet)
    enemy_storage.rocket_tier = get_highest_ammo_tier(sorted_ammo_types.rocket)
    enemy_storage.railgun_tier = get_highest_ammo_tier(sorted_ammo_types.railgun)
    enemy_storage.artillery_tier = get_highest_ammo_tier(sorted_ammo_types.artillery_shell)

    -- Best combat robot
    local combat_robot_tiers = {
        "defender-capsule",
        "distractor-capsule",
        "destroyer-capsule"
    }
    enemy_storage.combat_robot = nil
    for _, robot in ipairs(combat_robot_tiers) do
        if has_castra_researched_item(robot) then
            enemy_storage.combat_robot = robot
        end
    end

    -- Highest unlocked quality tier
    enemy_storage.quality_tier = prototypes.quality["normal"]
    for _, quality in pairs(prototypes.quality) do
        if quality and not quality.hidden and 
           game.forces["enemy"].is_quality_unlocked(quality) and
           quality.level > enemy_storage.quality_tier.level then
            enemy_storage.quality_tier = quality
        end
    end

    -- Disabled entities from mod settings
    -- Add any entity name to this table to prevent enemies from using it,
    -- regardless of whether they've researched it.
    local disabled_entities = {}
    if settings.startup["castra-prime-disable-artillery"] and
       settings.startup["castra-prime-disable-artillery"].value then
        table.insert(disabled_entities, "artillery-turret")
    end

    -- Land mines: check by entity type to catch mod-added variants
    local disable_land_mines = settings.startup["castra-prime-disable-land-mines"] and
                               settings.startup["castra-prime-disable-land-mines"].value

    -- Simple boolean entity checks
    local entity_flags = {
        "gun-turret",
        "laser-turret",
        "flamethrower-turret",
        "rocket-turret",
        "railgun-turret",
        "solar-panel",
        "repair-pack",
        "big-electric-pole",
        "roboport",
        "construction-robot",
        "tank",
        "artillery-turret",
        "spidertron",
        "land-mine",
        "tesla-turret",
        "combat-roboport"
    }

    local function is_disabled(entity_name)
        for _, disabled in ipairs(disabled_entities) do
            if disabled == entity_name then
                return true
            end
        end
        return false
    end

    for _, entity_name in ipairs(entity_flags) do
        local key = hyphen_to_underscore(entity_name)
        if is_disabled(entity_name) then
            enemy_storage[key] = false
        else
            enemy_storage[key] = has_castra_researched_item(entity_name)
        end
    end

    -- Land mines: broader check by entity type to catch mod-added variants
    if disable_land_mines then
        enemy_storage.land_mine = false
    else
        local has_land_mines = false
        for item_name, _ in pairs(has_item_cache) do
            local entity = prototypes.entity[item_name]
            if entity and entity.type == "land-mine" then
                has_land_mines = true
                break
            end
        end
        enemy_storage.land_mine = has_land_mines
    end

    storage.castra.enemy = enemy_storage
end