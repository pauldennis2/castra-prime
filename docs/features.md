# Changes

Document to describe potential changes (features and bug fixes) of the mod.

This is really "working notes" and not necessarily meant to be public facing. Feel free to read if you want to get into my thinking =).
  
## Features

### Enemy Research Fixes

This would be a bigger project, but thinking about some kind of restrictions on what techs the enemy can research. In my current heavily modded game they can only meaningfully use a small fraction of the potential buildings.

In general the concept of blanket tech-copy presents intractable balance problems but also seems core to the mod.

### Expand Planet Briefing

Add screenshot/animation, perhaps be a little more expositive, maybe with spoiler tags. Multiple pages.
-> update screenshot not supported, animation would be cool but requires some work, can't animate some important things

### Other localizations?

### Visuals of tech tree

For the mod portal rather than the mod itself; visual overview of the tech tree would be nice.

### remove quality from enemy bases

This would be a potential user config setting that rebalances the planet. Enemy bases would no longer drop quality ingredients, but also would not themselves benefit from quality. 

### separate "Castra Prime Cleanup" mod

Possibly create a separate mod to have "destructive" buttons to clear all existing enemy artillery/nukes/mines.



### Erro's opinionated balance change

Artillery range restrictions
No mines
No enemy nukes? Or no explosive damage research
Buffed forge
Buffed equip
Harder jammer recipe?
Allow machining assembler to produce Forge, jammer
Generally be more permissive with things currently Forge only, like, assembler CAN make them but why would you when you have the Forge
Reduce forge to a 5x5 or 4x4? Breaking change
Allow beacons to impact speed of data collectors
Allow data collectors to be picked up? Player version is special?

Which setting wins?

### Deathworld settings



### Some use for lithium batteries

Right now if the player disables lithium batteries being used for late-game stuff, they become pretty useless. Maybe consider just allowing user to remove them entirely? If not, possibly change so that there are other uses added?

## Bug Fixes

### clustering of data c cities

Currently there's what seems to be a bug that spawns extra enemy bases within existing ones. However, fixing this would get rid of enemy "cities" which might be a cool feature to some players.

### Igrys

https://mods.factorio.com/mod/castra/discussion/698c369e258fc50a00824e83
Known incompatibility: Igrys uses mutually exclusive tech paths at runtime. Castra's enemy
research AI will bounce between the two techs indefinitely. Both mods do non-standard things
with the technology system and a clean fix would require deeper changes to one or both mods.
No fix planned; document as known incompatibility.

## Ideas

### Enemy Faction

Tentatively decided on SIMULAC as the enemy faction name. It's weird that they don't already have one. Considered the idea they might send the player a message when they land? Just a thought for now.

## Further reported issues/requests

### Look into making forge glow