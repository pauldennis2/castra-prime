# Changes

Document to describe potential changes (features and bug fixes) of the mod.

## Non-Configurable Balance/Behavior Changes

Changes made from the original mod that affect gameplay and are not toggleable by settings.
Listed here so they can be documented, justified, or reverted if needed.

- **Forge prerequisites**: Removed `quality-module-2` requirement. The forge grants a built-in
  quality bonus, so this might have been the reasoning. Requiring quality modules does not seem balance-crucial, and may have created issues with the trigger tech.
- **Starting Area**: Properly giving the player a starter area on new maps with all resources except Uranium.

## Known Limitations / Won't Fix

- **Third-party achievement popups from enemy research**: When Castra enemies research a
  technology, this may trigger achievements and planetary briefings. So far, this seems like an inherent limitation of the Castra concept that cannot be fixed without compromising the mod.
- **Current Gamestate**: There are a few issues of current game-state I'm not ready to tackle, including resource generation and potential removal of existing artillery and land mines (e.g.). These features should be improved for fresh games.
  
## Features

### Forge Quality

Consider removing the 10% quality boost of the Forge. It seems actively bad, not sure the intent.

### Enemy Research Fixes

This would be a bigger project, but thinking about some kind of restrictions on what techs the enemy can research. In my current heavily modded game they can only meaningfully use a small fraction of the potential buildings.

In general the concept of blanket tech-copy presents intractable balance problems but also seems core to the mod.

### Expand Planet Briefing

Add screenshot/animation, perhaps be a little more expositive, maybe with spoiler tags. Multiple pages.

### German Localization

There was a PR for this from Schlumpf and he created his own mod. If this mod is taken up, it would make sense to merge that in.

### Other localizations?


### Visuals of tech tree

### Spoilability of Battlefield Data

OK first, I hate spoiling, and I've installed Freezer mods to cheese it. I'm a little hesitant to mess with this because this was clearly part of the original author's intent for the challenge, and most planet mods that add some kind of spoilable resource do NOT give you this option. 

https://mods.factorio.com/mod/castra/discussion/686eae4105d87e3cab4b6a59

Distant possibility: add a settings flag to change battlefield data not to spoil.


## Bug Fixes


### Igrys

https://mods.factorio.com/mod/castra/discussion/698c369e258fc50a00824e83
Sounds like a weird potential interaction because Igrys has exclusive tech paths? Low prio but on the list.

Update: loaded Igrys, no immediate crash (expected). Hope to circle back soon.

## Ideas

### Enemy Faction

Tentatively decided on SIMULAC as the enemy faction name. It's weird that they don't already have one. Considered the idea they might send the player a message when they land? Just a thought for now.

## Further reported issues/requests

### Look into making forge glow