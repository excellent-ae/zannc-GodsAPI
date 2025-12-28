# Changelog

## [Unreleased]
Fix issue where trait index's weren't being created for default game gods (Selene for some reason).

## [2.1.0] - 2025-12-22

- Added `customGiftData` to `CreateKeepsake`
- Fix `internalKeepsakeName`.
- Fix `RarityLevel Multiplier`.
- Added `ExtraFields` to CreateKeepsake because I missed it somehow.
- Fixed `Min/MaxRequirements` for Keepsakes.
- Added new function, `CreateCustomRarity` to be used with `CreateBoon`.
- Update `customStatLine` to support multiple statlines.
- Slight ReadME/Dev/Params update.

## [2.0.7] - 2025-12-10

- Fix `ConsumableData` issue with Shop of Hermes?
- Fix ConsumableData maximum spawn chance in shops to adhere to normnal spawn chance of god.

## [2.0.6] - 2025-12-09

- Add `ExtraFields` param to `CreateGod`.
- Remove Dash from `Shop .. godName` due to it not adhering to StoreLogic discounts (Travel Deal).
- Added option for `SpawnLikeHermes` to be a table containing `maximumSpawns`, with a value of **1** being **2** natural spawns maximum per run.
- Change `SurfaceIcon` for boons to be the **IconPreview** of boons.
- Small def/params update.
- Added `OverlayAnim` to PortraitData.

## [2.0.5] - 2025-12-08

- Fix issue with NPC God spawning in Shops.
- Naming Convention for Shop var in NPC.
- Fix InheritFrom nil check in CreateBoon.
- Relaxed need to define plugin.guid for trait requirements, it will try to fall back to `_PLUGIN.guid-internalboonname`, or else throw a warning and remove it from the list.
- Added `customGUID` to `addToExistingGod` to allow for insertions into god not using your `GUID`.
- Allow for `godtype = god` and still limit spawns to function like hermes
- Touched up on docs.
- DEV: Added Boon Population for `EnemyData` after game loads, makes it easier to add boons to NPCs too.
- Hopefully fixed issue which was causing NPC/Spawn Limited gods to constantly appear.

## [2.0.4] - 2025-12-02

- Slight change to defs.
- Update README.

## [2.0.3] - 2025-12-01

## [2.0.2] - 2025-12-01

- Fix addToExistingGod.

## [2.0.1] - 2025-12-01

- Add missing GodLoot, usefule for other mods to check if GodLoot or not.

## [2.0.0] - 2025-12-01

- Add Data Inheritence to functions // cuts down on params (though can still be changed)
- Use `InheritFrom` in creation of Boons instead of `isLegendary` // `Elements`
- No longer need to pass in `_PLUGIN.guid`.
- Append `_PLUGIN.guid` to Gods/Keepsakes/Boons to allow for multiple people to create Gods/Keepsakes/Boons of same name.
- No longer need to define `FlavourText` if you have created Descriptions for them, though it still remains a param if you want to reuse any.

## [1.0.9] - 2025-11-28

- Changed how `RarityLevels` can be passed in (you can now pass in Multipliers/tables or just a number)
- Added Default Boon Icon and Keepsake Icon.
- Fixed Disappearing Icons?
- Added params to Keepsake and Boons to create CustomStatLines
- Fix Codex Population
- Fix TraitSortOrder being populated as an empty table
- Fix Boon Inheritance
- Fix Portrait Inheritance
- Fix Slotted Trait inserts
- Added ability to create custom text for codex & images.

## [1.0.8] - 2025-11-19

- Added `iconPathOverrides` (table) to `CreateOlympianSJSONData` allow for reuse of any Icons in the game.
- Added `portraitPathOverrides` (table) to `CreateOlympianSJSONData` allow for reuse of any Portraits in the game.
- Added `iconPathOverrides` (table) to `CreateKeepsake` allow for reuse of any Icons in the game.
- Added `reuseBaseIcons` (bool) to `CreateBoon` allow for reuse of any Icons in the game.
- Fix Codex "Entity Name".
- More info in DEV.
- DEV: Reworked iconPathing - and cleanIconPath func, no longer combines automatically but does a check and combines if needed

## [1.0.7] - 2025-11-18

- Added `addToExistingGod` paramater.
- Moved code around to do traitdict and traitsortorder to work after all mods loaded.

## [1.0.6] - 2025-11-17

- Readme update.

## [1.0.5] - 2025-11-17

- Add Default Values to Keepsake Description/Display
- Slight updates to Params/Dev.
- Added basic dirty work for Traits/Boons.

## [1.0.4] - 2025-11-11

- Fixed Upgrade Choice Screen Text `Boons of GodName`
- Fixed Icon Pathing being broken
- Added Scale and OffsetX/Y to portraits
- Added optional BoonDrop frames - so you dont have to do 50 frames to get the icon spin
- DEV: Cleaned up code

## [1.0.3] - 2025-11-10

- Added support for Keepsakes.
- Add check for paths to remove `_PLUGIN.guid` if passed in the file paths.
- Added missed flavour text for SJSON.
- Defs.
- Update ReadME.

## [1.0.2] - 2025-11-09

- No longer need to call `gods.Initialize()`, just pass the `_PLUGIN.guid` into SJSON creation.

## [1.0.1] - 2025-11-07

- Update ReadME/Params

## [1.0.0] - 2025-11-07

- Initial Release.

[unreleased]: https://github.com/excellent-ae/zannc-GodsAPI/compare/2.1.0...HEAD
[2.1.0]: https://github.com/excellent-ae/zannc-GodsAPI/compare/2.0.7...2.1.0
[2.0.7]: https://github.com/excellent-ae/zannc-GodsAPI/compare/2.0.6...2.0.7
[2.0.6]: https://github.com/excellent-ae/zannc-GodsAPI/compare/2.0.5...2.0.6
[2.0.5]: https://github.com/excellent-ae/zannc-GodsAPI/compare/2.0.4...2.0.5
[2.0.4]: https://github.com/excellent-ae/zannc-GodsAPI/compare/2.0.3...2.0.4
[2.0.3]: https://github.com/excellent-ae/zannc-GodsAPI/compare/2.0.2...2.0.3
[2.0.2]: https://github.com/excellent-ae/zannc-GodsAPI/compare/2.0.1...2.0.2
[2.0.1]: https://github.com/excellent-ae/zannc-GodsAPI/compare/2.0.0...2.0.1
[2.0.0]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.9...2.0.0
[1.0.9]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.8...1.0.9
[1.0.8]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.7...1.0.8
[1.0.7]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.6...1.0.7
[1.0.6]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.5...1.0.6
[1.0.5]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.4...1.0.5
[1.0.4]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.3...1.0.4
[1.0.3]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.2...1.0.3
[1.0.2]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/excellent-ae/zannc-GodsAPI/compare/37dce8e006e86a79e3ba217e81eda0faa9302d22...1.0.0
