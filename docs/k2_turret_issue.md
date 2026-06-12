# Krastorio 2 Turret Ammo Compatibility Issue

**Author:** Claude Sonnet 4.6  
**Status:** Deferred — revisit if more users report this  
**Threshold:** ~3 additional users before treating as a priority fix

---

## Problem

Krastorio 2 replaces vanilla bullet ammo (firearm-magazine, piercing-rounds-magazine, etc.) with its own equivalents (kr-rifle-magazine, etc.). Castra's enemy turret-filling logic uses a hardcoded list of item names in `castra-cache.lua` to determine what ammo the enemy has researched and should load. Because vanilla ammo names are hardcoded and KR2's ammo names are not present, enemy gun turrets never get filled and never fire — giving players an unintended easy mode on the planet.

The original reporter claimed this was "impossible to fix from another mod without hurting performance." This is not quite accurate. The real limitation is that `sorted_ammo_types` is a `local` variable, so external mods cannot modify it. It's a scoping issue, not a performance one.

---

## Relevant Code

**`castra-cache.lua` lines ~71–76** — the hardcoded ammo list:

```lua
-- List order defines tier: get_best_tier() walks forward and returns the last match,
-- so items must be ordered weakest → strongest. Reordering silently breaks tier caps
-- (e.g. the disable-enemy-nukes setting relies on atomic-bomb and hydrogen-bomb being last).
local sorted_ammo_types = {
    bullet = {"firearm-magazine", "piercing-rounds-magazine", "uranium-rounds-magazine", "plutonium-rounds-magazine"},
    rocket = {"rocket", "explosive-rocket", "atomic-bomb", "hydrogen-bomb"},
    railgun = {"railgun-ammo"},
    artillery_shell = {"artillery-shell", "cerys-neutron-bomb", "maraxsis-fat-man"},
}
```

`get_best_tier(list)` walks the list and returns the last item the enemy has researched (via `has_castra_researched_item`). `has_castra_researched_item` checks the enemy force's enabled recipes at runtime to see if any produce the named item.

---

## Option 1: Original Submitted Fix (NOT production-ready)

The reporter submitted this replacement:

```lua
local sorted_ammo_types = {
    bullet = {"kr-rifle-magazine", "kr-armor-piercing-rifle-magazine", "kr-uranium-rifle-magazine", "kr-plutonium-rifle-magazine"},
    rocket = {"rocket", "explosive-rocket", "kr-nuclear-turret-rocket", "cerys-hydrogen-bomb"},
    railgun = {"railgun-ammo"},
    artillery_shell = {"artillery-shell", "cerys-neutron-bomb", "maraxsis-fat-man"},
}
```

**Problems:**
- Completely removes vanilla bullet ammo — breaks all non-KR2 users (ammo_tier would always be nil)
- Rocket list drops `atomic-bomb` and `hydrogen-bomb` — unverified whether KR2 actually replaces these
- Reporter acknowledged "it still needs a trigger to activate it"

**To make this work**, wrap in `if script.active_mods["Krastorio2"]`, and preserve vanilla rocket ammo:

```lua
local sorted_ammo_types = {
    bullet = {"firearm-magazine", "piercing-rounds-magazine", "uranium-rounds-magazine", "plutonium-rounds-magazine"},
    rocket = {"rocket", "explosive-rocket", "atomic-bomb", "hydrogen-bomb"},
    railgun = {"railgun-ammo"},
    artillery_shell = {"artillery-shell", "cerys-neutron-bomb", "maraxsis-fat-man"},
}

if script.active_mods["Krastorio2"] then
    sorted_ammo_types.bullet = {"kr-rifle-magazine", "kr-armor-piercing-rifle-magazine", "kr-uranium-rifle-magazine", "kr-plutonium-rifle-magazine"}
    -- rocket list needs verification: does KR2 actually replace atomic-bomb/hydrogen-bomb?
    -- sorted_ammo_types.rocket = {"rocket", "explosive-rocket", "kr-nuclear-turret-rocket", "cerys-hydrogen-bomb"}
end
```

**Concern:** Couples us to KR2's internal item names. Any rename or rebalance on their end silently breaks our mod. Not desirable for a mod we don't control and can't easily test against.

---

## Option 2: Append Both (No `if` Required — Preferred if referencing KR2 at all)

Because `has_castra_researched_item` checks runtime recipe output, items from uninstalled mods are simply never produced by any recipe and silently return false. This means you can include both vanilla and KR2 item names in the same list — in a vanilla game KR2 items return false, in a KR2 game vanilla items return false (KR2 replaced their recipes). No conditional needed.

```lua
local sorted_ammo_types = {
    bullet = {
        "firearm-magazine",        "kr-rifle-magazine",
        "piercing-rounds-magazine","kr-armor-piercing-rifle-magazine",
        "uranium-rounds-magazine", "kr-uranium-rifle-magazine",
        "plutonium-rounds-magazine","kr-plutonium-rifle-magazine"
    },
    rocket = {"rocket", "explosive-rocket", "atomic-bomb", "hydrogen-bomb"},  -- KR2 rocket mapping unverified
    railgun = {"railgun-ammo"},
    artillery_shell = {"artillery-shell", "cerys-neutron-bomb", "maraxsis-fat-man"},
}
```

**Still couples us to KR2 item names.** Still requires someone to verify the rocket/nuke tier mapping in KR2.

---

## Option 3: Dynamic Ammo Discovery (No KR2 Reference at All — Cleanest Long-Term)

Instead of matching researched items against a hardcoded name list, derive ammo tiers dynamically from what the enemy force has actually researched, using the ammo item's `ammo_category` to bucket them.

Rough approach in `update_item_cache` or a new function:

```lua
-- Instead of/in addition to has_item_cache, build ammo_by_category:
-- ammo_by_category["bullet"] = list of bullet ammo item names the enemy can produce
-- Then get_best_tier works over that dynamic list
```

**Challenge:** The current tier ordering (weakest → strongest) is load-bearing — `disable-enemy-nukes` relies on `atomic-bomb` and `hydrogen-bomb` being last in the rocket list so it can cap at the item before them. A dynamic approach needs a different mechanism to enforce that cap, e.g. an explicit blocklist of nuke items rather than relying on list position.

**This is the most robust long-term solution** — works with any mod automatically — but is a meaningful refactor, not a quick fix.

---

## Decision

Not implementing now. Revisit if ~3 more users report the same KR2 + Castra Prime friction. If/when revisiting, Option 3 is the preferred direction; Option 2 is acceptable as a quick fix if a KR2 user can verify the full item name mapping (especially rockets/nukes) and test it.
