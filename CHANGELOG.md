# Changelog

## [Unreleased]
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

[unreleased]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.7...HEAD
[1.0.7]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.6...1.0.7
[1.0.6]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.5...1.0.6
[1.0.5]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.4...1.0.5
[1.0.4]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.3...1.0.4
[1.0.3]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.2...1.0.3
[1.0.2]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/excellent-ae/zannc-GodsAPI/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/excellent-ae/zannc-GodsAPI/compare/37dce8e006e86a79e3ba217e81eda0faa9302d22...1.0.0
