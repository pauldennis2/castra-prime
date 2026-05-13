-- data-final-fixes.lua

-- Recycling recipes are auto-generated before our data-updates.lua ingredient changes take
-- effect, so we patch them here after everything else has run.

-- battery-mk3-equipment: we replaced supercapacitor with lithium-battery in the recipe
local battery_recycling = data.raw["recipe"]["battery-mk3-equipment-recycling"]
if battery_recycling and battery_recycling.results then
    for _, result in ipairs(battery_recycling.results) do
        if result.name == "supercapacitor" then
            result.name = "lithium-battery"
            break
        end
    end
end

-- railgun and railgun-turret: we added lithium-battery when gates-progression is ON
if settings.startup["castra-prime-gates-progression"].value then
    local railgun_recycling = data.raw["recipe"]["railgun-recycling"]
    if railgun_recycling and railgun_recycling.results then
        table.insert(railgun_recycling.results, {type="item", name="lithium-battery", amount=1}) -- 25% of 5
    end

    local turret_recycling = data.raw["recipe"]["railgun-turret-recycling"]
    if turret_recycling and turret_recycling.results then
        table.insert(turret_recycling.results, {type="item", name="lithium-battery", amount=5}) -- 25% of 20
    end
end

if settings.startup["castra-prime-buffed-forge"].value then
    local forge = data.raw["assembling-machine"]["forge"]
    if forge then
        forge.crafting_speed = 3.0
        forge.effect_receiver = { base_effect = { productivity = 0.5, quality = 1 } }
        forge.energy_usage = "2.5MW"
    end
end

if settings.startup["castra-prime-buff-equipment"].value then
    local battery = data.raw["battery-equipment"]["battery-mk3-equipment"]
    if battery then
        battery.energy_source.buffer_capacity = "300MJ"
    end

    local shield = data.raw["energy-shield-equipment"]["energy-shield-mk3-equipment"]
    if shield then
        shield.max_shield_value = 450
        shield.energy_source.input_flow_limit = "300kW"
        shield.energy_per_shield = "16667J"
    end
end

local base_nerf_rate = 0.5
if settings.startup["castra-prime-nerf-enemy-bases"].value then
    local dc = data.raw["unit-spawner"]["data-collector"]
    if dc then
        dc.max_health = dc.max_health * base_nerf_rate
        dc.healing_per_tick = dc.healing_per_tick * base_nerf_rate
        
        for _, resistance in ipairs(dc.resistances) do
            if resistance.type == "physical" or 
               resistance.type == "explosion" or 
               resistance.type == "laser" then
                if resistance.decrease then
                    resistance.decrease = resistance.decrease * base_nerf_rate
                end
                if resistance.percent then
                    resistance.percent = resistance.percent * base_nerf_rate
                end
            end
        end
    end
end