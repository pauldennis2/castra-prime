-- Enemy expansion built vanilla biter spawners and worms on Castra: remove them and the units they spawned.
local surface = game.surfaces["castra"]
if surface then
    for _, entity in pairs(surface.find_entities_filtered { type = { "unit-spawner", "turret", "unit" } }) do
        if entity.valid then
            local castra_unit = entity.name == "castra-enemy-tank" or string.find(entity.name, "data%-collector%-") == 1
            if (entity.type == "unit-spawner" and entity.name ~= "data-collector") or entity.type == "turret"
                or (entity.type == "unit" and not castra_unit) then
                entity.destroy()
            end
        end
    end
end
