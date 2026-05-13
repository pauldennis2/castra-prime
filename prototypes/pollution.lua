-- Castra uses a custom airborne pollutant called "data" (same mechanism as Gleba's spores).
--
-- How it works:
--   1. Data collectors emit "data" pollution into surrounding chunks as they operate.
--   2. Every 10 ticks, build_pollution_cache() (castra-cache.lua) reads the 3x3 chunk pollution
--      sum around each data collector (round-robin) and stores it in
--      storage.castra.dataCollectorsPollution[unit_number].
--   3. When a collector spawns an item, on_data_collector_item_spawned() (control.lua) reads
--      that cached value. If pollution < 50, there is a 90% chance the item is silently
--      destroyed instead of dropped. High pollution = productive collectors.
--   4. Jammer radars emit data = -1000/min (negative), draining pollution and suppressing
--      collector productivity within their range.
--
-- Enemy tank spawning is NOT gated by pollution — only item-type collector spawns are affected.

data:extend(
{
  {
    type = "airborne-pollutant",
    name = "data",
    chart_color = {r = 10, g = 10, b = 240, a = 149},
    icon =
    {
      filename = "__core__/graphics/icons/mip/side-map-menu-buttons.png",
      priority = "high",
      size = 64,
      mipmap_count = 2,
      y = 3 * 64,
      flags = {"gui-icon"}
    },
    affects_evolution = true,
    affects_water_tint = false,
  }
})
