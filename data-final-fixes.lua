-- data-final-fixes.lua

if settings.startup["castra-prime-buffed-forge"].value then
    local forge = data.raw["assembling-machine"]["forge"]
    if forge then
        forge.crafting_speed = 3.0
        forge.effect_receiver = { base_effect = { productivity = 0.5, quality = 1 } }
        forge.energy_usage = "2.5MW"
    end
end