# Changes

Document to describe potential changes (features and bug fixes) of the mod.

## Non-Configurable Balance/Behavior Changes

Changes made from the original mod that affect gameplay and are not toggleable by settings.
Listed here so they can be documented, justified, or reverted if needed.

- **Forge prerequisites**: Removed `quality-module-2` requirement. The forge grants a built-in
  quality bonus, so this might have been the reasoning. Requiring quality modules does not seem balance-crucial, and may have created issues with the trigger tech.

## Known Limitations / Won't Fix

- **Third-party achievement popups from enemy research**: When Castra enemies research a
  technology, this may trigger achievements and planetary briefings. So far, this seems like an inherent limitation of the Castra concept that cannot be fixed without compromising the mod.
- **Current Gamestate**: There are a few issues of current game-state I'm not ready to tackle, including resource generation and potential removal of existing artillery and land mines (e.g.). These features should be improved for fresh games.
  

## Features

There's a strong general sense that the military aspect of the original mod is not well-balanced in the late-game. 
https://mods.factorio.com/mod/castra/discussion/69c3dfe7b88d320fa3d0e412
https://mods.factorio.com/mod/castra/discussion/69b52c99f3cedd8c3319bb84

Enemy artillery, land mines, and nukes are generally seen as the most problematic. I'm not sure what the original mod author intended, but it's unclear how you're supposed to defend your base in the long term (potentially over 100s of hours of play) against enemies that can keep getting range and damage upgrades, even out-ranging modded Radar.

### Enemy Nukes Nerfs

This fits with the uranium on the planet, but particularly in combination with invisible mines that root you, these just feel unfair. Probably will be a configurable option to disable enemy nukes.

### Enemy Land Mines Nerfs

These seem to be everywhere, invisible, and completely root you. Potential fixes: remove entirely; make them visible; change the root to a % slow.

### Enemy Artillery Nerfs

Added a setting flag to prevent enemy from having artillery. Solution for existing artillery still possible?

Also possibly setting a cap on range and damage research.

### Enemy Railgun Nerfs

Also mentioned as a problem. Fundamentally the players defenses have no way of scaling infinitely but the enemy damage does. The long range and projectile travel speed make these a dangerous obstacle.
Possible cap on damage research.

### Forge Buff

The Forge feels a bit underwhelming for being the main planetary reward and being as large as it is. Added a setting flag to buff the Forge.

Crafting speed 3.0 (was 2.0)
Base productivity +50% (was +25%)
Base energy consumption: 2.5 MW (was 3.6 MW)

Honestly this was an easy change to make early, but I think this brings it more in line with buildings like the Foundry as a game-changer. The productivity bonus in particular really makes it more of an interesting option.

Note: Partly for balance, might also be inclined to remove the 10% quality base buff. I'm not sure how this was intended, but in practice unless you have speed mods to offset this,it can actually make things more challenging. Quality was clearly *meant* to be part of the challenge on Maraxsis. Less clear here.

### Requirement for Promethium Science/Research

A lot of planet mods by default include their research pack in the "Late game" Research productivity line, but give users the option to opt out. I see both sides here; you want your science pack to be of ongoing value and the planet to feel important as a designer. But as a player I might be hesitant to try a mod that doesn't give me this option because of a situation like Castra.

Added settings flag to toggle this. Default is on.

### Enemy Research Fixes

High priority is adding a feature flag to hide the messages about enemy research. This seems to annoy a lot of players and should be configurable for sure.

This would be a bigger project, but thinking about some kind of restrictions on what techs the enemy can research. In my current heavily modded game they can only meaningfully use a small fraction of the potential buildings.

Potential feature to be able to configure (maybe even stop?) the rate of enemy research.

In general the concept of blanket tech-copy presents intractable balance problems but also seems core to the mod.

### Review of Addons

Notes:
Shield HP mk1/mk2/mk3 (new): 50/150/275, rate 12/12/16
The rate jump is cool but this is a lower percentage jump. Certainly compared to Bob's warfare it feels underwhelming.

Also consider for battery and shield changing them from mk3 to be something Castra specific to be more distinct from Bobs or other mods that add mk3?

Battery: 20/100/250 MJ of storage, again smaller % increase and blown away by Bob's. 

The carbon fiber wall is pricey at 5 carbon fiber each, but the health jump from 350 for the basic wall to 1200 for CF wall is notable and it gains more resistances.

Military belts: They are slower than the highest tier of unmodded belts but:
1. Relatively cheap to build, at least on Castra
2. Have around 5x as much health
3. Go further underground
Seems balanced as is. More of a convenience for this planet, since they're probably much easier to make than blue belts?

Combat roboport - it would be nice if quality did something.

Quality supposedly increases number of robots; to be tested, but isn't documented/visible to user.

1st changes with the feature "Buff Castra equipment" setting on:
The Mk3 Battery goes from 250->300MJ
The Mk3 shield has
HP increased 275->450
Regen rate 16->18
Power consumption 800kw -> 300kw

The balance goal is to make these feel like more meaningful upgrades. In particular, I wanted them to be somewhat better than the equivalent Bob's Equipment mk3s, but still substantially below the mk6s.

My eventual goal is to differentiate at least one piece of Castra gear to be more niche, likely the shield - possibly a smaller (or larger) size, lower HP but increased regen. 

### Make Other Castra Tech Tree Changes Optional

Right now it's modifying a bunch of stuff including railgun, nukes. It looks like in some cases it's substituting battlefield science for something else like Gleba's Ag science.

### Resource Patch Fix

Players sometimes report struggling to find particular resources - I think I remember the nearest serviceable patches of some things being pretty far away. 

https://mods.factorio.com/mod/castra/discussion/67fe7100d2422549284bacd3

Update: hopefully addressed for new games, to be tested

### Mod Ease of Use

A help page is requested. There is a "planetary briefing" but it's pretty sparse. I remember struggling to figure out how everything worked when I arrived.
https://mods.factorio.com/mod/castra/discussion/68f3c3400c9f0aea6b244556

### Consider expanding planet briefing

Add screenshot/animation, perhaps be a little more expositive, maybe with spoiler tags.

### German Localization

There was a PR for this from Schlumpf and he created his own mod. If this mod is taken up, it would make sense to merge that in.


### Visuals of tech tree

### Spoilability of Battlefield Data

OK first, I hate spoiling, and I've installed Freezer mods to cheese it. I'm a little hesitant to mess with this because this was clearly part of the original author's intent for the challenge, and most planet mods that add some kind of spoilable resource do NOT give you this option. 

https://mods.factorio.com/mod/castra/discussion/686eae4105d87e3cab4b6a59

Distant possibility: add a settings flag to change battlefield data not to spoil.

### Nickel Battery Issues

This is another way Castra inserts itself; promethium science now requires these batteries.

OK, I tend to think that if the other issues with the mod are fixed, this is less of a problem. Adding a flag for this starts to get very "opinionated".

### Castra Ignore Flag

"Hi! Would you please add a check for some sort of ignore flag (e.g., recipe.castra_ignore or whatever you want to call it) and then not make changes to any recipes with this property set to true?

Other mods having compatibility issues will then be able to set it in their own recipes, which would help to solve this problem and potentially others."
https://mods.factorio.com/mod/castra/discussion/67f56c326247759f06f690c9

Relates to Voidcraft?

### Voidcraft Compatibility

https://mods.factorio.com/mod/voidcraft-planetary-compatibility
https://mods.factorio.com/mod/castra/discussion/67c9c4ff6ae0b4a9e813439f

### No Enemies Mode issue

Apparently this game setting can make it impossible to access planet's resources (enemy based). Mixed feels here; this is a military planet. Potentially could make it so that the mod attempts to override the setting for Castra only, so that someone who wants to add the planet can, but they'll need to bring their turrets.
https://mods.factorio.com/mod/castra/discussion/681377305edc99508351d51d

### Asset Separation

Possibly separate the assets out into their own mod, especially convenient if we're doing frequent updates. It's a pain to have to redownload the same assets. Mod isn't gigantic though and is largely using existing assets, I think?
Update:done

## Bug Fixes

### Voidcraft

https://mods.factorio.com/mod/castra/discussion/67c9c4ff6ae0b4a9e813439f

This generated a lot of discussion, so probably a lot of people use this 

### Igrys

https://mods.factorio.com/mod/castra/discussion/698c369e258fc50a00824e83
Sounds like a weird potential interaction because Igrys has exclusive tech paths? Low prio but on the list.

Update: loaded Igrys, no immediate crash (expected). Hope to circle back soon.

### Trigger tech

https://mods.factorio.com/mod/castra/discussion/69865ac748e1dd9239e738a6
Trigger tech refusing to fire?

Update: likely solved?

### Battlefield Data missing
https://mods.factorio.com/mod/castra/discussion/694f51a82e325adf887d9713
"Battlefield Data Packets in item lists it appears to be missing. It'll show in recipes, but in places like setting a logistics request it will not."

I think I ran into this myself - I worked around by using a constant combinator.

Update: looks fixed

### Fatal Crash with jammer radar
https://mods.factorio.com/mod/castra/discussion/692df0452d36c7c294803e2a

Fatal is bad.

### Enemy Research Triggers Achievements and Briefings

Honestly not my highest prio because modded achievements...
https://mods.factorio.com/mod/castra/discussion/69387c80ae76b3cf2f8aee29

But I also ran into this and it is annoying.

### Krastorio Compatibility

https://mods.factorio.com/mod/castra/discussion/68916885d0e50c47357a910d
Incompatible for some ammo related reason. 2 players reported this so would love to fix it, but involves figuring out an interaction with a mod I've never used.

### Enemy Base Health

I believe enemy base health scales with evolution factor, which can make for some crazy high numbers at high evo factor - I saw one with 148k. I don't *think* this was the intent, so I'm calling this a bug and will take a look at how to change this without nerfing it to the ground.

Update: setting change to reduce health and all resistances by 50%

### Lag Situation?
Translated from simple Chinese by google translate: 
Is anyone else experiencing stuttering? Ever since landing on a planet—regardless of which one—the game stutters every two seconds. Even starting a brand-new save and flying directly here results in the same lag.

https://mods.factorio.com/mod/castra/discussion/6a02b26ef5fdeaa6102cc4ff

Update: investigated, nothing obvious found. Hope to circle back.

### Castra landing animation feels different

## Ideas

### Enemy Tanks

I always thought this looked a little weird/placeholder-y. Maybe switching to a mini spidertron would be cooler and more thematic? Or a massive UPS headache because of legs?