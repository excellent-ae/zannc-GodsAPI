A library to make it easy for developers to add new Gods/NPC Gods/NPCs. It does nothing by itself.
You should only install it if another mod requires it, or if you will be using this library to create Gods.

>[!IMPORTANT]
> *Currently, this library only supports adding in **Olympian** Gods eg. Zeus and **NPC**-type Gods eg. Hermes.* <br>
> NPC Type means that they will not fill up the `MetGods` table during a run - meaning you can have `Zeus, Aphrodite, Hera, Hestia` and meet `Hermes` and `Your God`.

> I would like to add Spells and proper NPC's such as Dionysus/Athena/Arachne during runs, and Hub NPCS such as Hecate/Hypnos.
> However, there are a lot of functions that are hard-coded to `SpellDrop`.

# Developer Documentation

1. Create a dependency in `manifest.json` (if testing locally) by adding `"zannc-GodsAPI-1.0.0"` and in `thunderstore.toml` by adding `zannc-GodsAPI = "1.0.0"` if publishing the mod by adding to respective files.

2. In `main.lua`, add:
    ```lua
    --@module 'zannc-GodsAPI'
    gods = mods['zannc-GodsAPI']
    ```
    So that it looks like this as an example:
    ```lua
    _PLUGIN = PLUGIN
    game = rom.game

    --@module 'SGG_Modding-ModUtil'
    modutil = mods["SGG_Modding-ModUtil"]
    --@module 'SGG_Modding-ReLoad'
    reload = mods["SGG_Modding-ReLoad"]
    --@module 'SGG_Modding-SJSON'
    sjson = mods["SGG_Modding-SJSON"]
    --@module 'zannc-GodsAPI'
    gods = mods["zannc-GodsAPI"]
    ```

3. In a file called through `on_ready()` or in `modutil.once_loaded.game()` (or directly in those), call `gods.Initialize(_PLUGIN.guid)`. This will allow for the API to use your plugin guid for SJSON hooks for Portraits/Icons.

4. To create a god, you must call `gods.InitializeGod(params)`, followed by `gods.CreateOlympianSJSONData(sjsonData)` and provide the required paramaters / sjson paramaters. <br>

### Parameters
While this is not a definitive list, these are the most common that will need to be changed.

* `params` (table) - A set of options to create the name, colour, text, gender, spawn sound etc.
    * `godName` (string) **(required)** - The name of the God | eg "Ares", "Zeus" etc.
    * `godType` (string) **(required)** - The type of God | eg "god" or "npcgod" (God = Zeus, NPC = Hermes)
    * `SpawnLikeHermes` (boolean) **(optional)** - Commonly used with a NPCGod, which creates requirements for the god to spawn, just like Hermes.

    <details>
    <summary><strong>Optional Parameters</strong></summary>

    * `GameStateRequirements` (table)
    * `Gender` (string)
    * `LoadPackages` (table)
    * `FlavorTextIds` (table)
    * `SFX_Portrait` (string)
    * `UpgradeSelectedSound` (string)
    * `WeaponUpgrades` (table)
    * `Traits` (table)

    <details>
    <summary><strong>Colours</strong></summary>

    * `Color` (table)
    * `NarrativeTextColor` (table)
    * `NameplateSpeakerNameColor` (table)
    * `NameplateDescriptionColor` (table)
    * `LightingColor` (table)
    * `LootColor` (table)
    * `SubtitleColor` (table)
    </details>

    <details>
    <summary><strong>Dialogue/Text</strong></summary>

    * `FirstSpawnVoiceLines` (table)
    * `OnSpawnVoiceLines` (table)
    * `UpgradeMenuOpenVoiceLines` (table)
    * `DuoPickupTextLines` (table)
    * `InteractTextLineSets` (table)
    * `BoughtTextLines` (table)
    * `BoughtTextLinesRequirements` (table)
    * `RejectionTextLines` (table)
    * `RejectionVoiceLines` (table)
    * `MakeUpTextLines` (table)
    * `GiftTextLineSets` (table)
    * `GiftGivenVoiceLines` (table)
    * `FullSuperActivatedVoiceLines` (table)
    * `DeathTauntVoiceLines` (table)
    * `RarityUpgradeVoiceLines` (table)
    * `BlindBoxOpenedVoiceLines` (table)
    </details>
    </details>

### SJSON Paramaters
If you wish to add SJSON content, such as the boon drop icons, door preview icons or portraits, you must call `gods.CreateOlympianSJSONData(sjsonData)`

* `sjsonData` (table) - A set of options to create the name, colour, text, gender, spawn sound etc.
    * `godName` (string) **(required)** - The name of the God | eg "Ares", "Zeus" etc.
    * `godType` (string) **(required)** - The type of God | eg "god" or "npcgod" (God = Zeus, NPC = Hermes)
    * `skipBoonSelectSymbol` (boolean) **(optional)** - If there is already a Boon Select Symbol (In upgrade screen), you can pass this to skip the creation of one.

    <details>
    <summary><strong>Optional Parameters</strong></summary>

	* `iconSpinPath` (string) - The animation of the physical boon drop.
	* `previewPath` (string) - The icon to display on doors.
  	* `colorA` (table) - The colours of the physical boon drop
	* `colorB` (table)
	* `colorC` (table)
	* `portraitData` (table) **(optional)** 
		* `skipNeutralPortrait` (boolean) **(optional)** - If there is already a neutral portrait for the character in the game.
        * `AnnoyedPortraitFilePath` (string)
        * `DialogueEntrance` (boolean) **(optional)** - If you wish to create animations during a portrait entrance.
            * `RedStart` (float) - The starting colour for the animations. eg. 1.0
    		* `StartGreen` (float)
    		* `StartBlue` (float)
    		* `EndRed` (float) - The starting colour for the animations. eg. 0.1
    		* `EndGreen` (float)
    		* `EndBlue` (float)
    </details>

#### For a full list of parameters, please refer to the [PARAMS.md](https://github.com/excellent-ae/zannc-GodsAPI/blob/main/PARAMS.md) file.

# Checking Implementation
If you need to check if the God you created is currently registered, or need to use an `if statement` to check if a god is enabled/disabled per config, you can use `gods.IsGodRegistered("GODNAME")` - returning **true or false**.<br>

# Examples
This will add a new God: `Artemis` with the **internal** name `ArtemisUpgrade`.
```lua
    gods.InitializeGod({
        godName = "Artemis",
        godType = "GOD",
        Gender = "F",
        LoadPackages = { "Artemis" },
        FlavorTextIds = { "ArtemisUpgrade_FlavorText01", "ArtemisUpgrade_FlavorText02", "ArtemisUpgrade_FlavorText03" },

        SpawnSound = "/SFX/ArtemisBoonArrow",
        PortraitEnterSound = "/SFX/ArtemisBoonArrow",

        WeaponUpgrades = game.EnemyData.NPC_Artemis_Field_01.WeaponUpgrades,
        Traits = game.EnemyData.NPC_Artemis_Field_01.Traits,

        Color = { 91, 255, 100, 255 },
        LightingColor = { 210, 255, 97, 190 },
        LootColor = { 110, 255, 0, 180 },
        SubtitleColor = Color.ArtemisVoice,
    })

    gods.CreateOlympianSJSONData({
        godName = "Artemis",
        godType = "god",
        skipBoonSelectSymbol = true,
        iconSpinPath = "Items\\Loot\\Boon\\ArtemisIconSpin\\ArtemisIconSpin",
        previewPath = "Items\\Loot\\Boon\\ArtemisIconSpin\\ArtemisPreview",
        colorA = { Red = 0.42, Green = 0.62, Blue = 0.21 },
        colorB = { Red = 0.35, Green = 0.51, Blue = 0.12 },
        colorC = { Red = 0.23, Green = 0.57, Blue = 0.31 },
        portraitData = {
            skipNeutralPortrait = true,
        },
    })
```

This will add a new NPC God: `Athena` with the **internal** name `AthenaUpgrade`, and function like Hermes does.

```lua
gods.InitializeGod({
	godName = "Athena",
	godType = "npcGOD",
	SpawnLikeHermes = true,

	Gender = "F",
	LoadPackages = { "Athena" },
	FlavorTextIds = { "AthenaUpgrade_FlavorText01", "AthenaUpgrade_FlavorText02", "AthenaUpgrade_FlavorText03" },

	Traits = game.EnemyData.NPC_Athena_01.Traits,

    SubtitleColor = Color.AthenaVoice,
	Color = { 91, 255, 100, 255 },
	LootColor = { 175, 157, 255, 255 },
	LightingColor = { 175, 157, 255, 255 },
})

gods.CreateOlympianSJSONData({
	godName = "Athena",
	godType = "npcGOD",
	skipBoonSelectSymbol = true,

	iconSpinPath = "Items\\Loot\\Boon\\AthenaIconSpin\\AthenaIconSpin",
	previewPath = "Items\\Loot\\Boon\\AthenaIconSpin\\AthenaPreview",
	colorA = { Red = 0.76, Green = 0.64, Blue = 0.16 },
	colorB = { Red = 0.68, Green = 0.57, Blue = 0.12 },
	colorC = { Red = 0.60, Green = 0.51, Blue = 0.19 },
	portraitData = {
		NeutralPortraitFilePath = "Portraits\\Portrait1",
		AnnoyedPortraitFilePath = "Portraits\\Portrait2",
    
        DialogueAnimations = {
            DialogueEntrance = {
                RedStart = 1.0,
                GreenStart =  0.7,
                BlueStart = 0.1,
                RedEnd = 0.3,
                GreenEnd = 0.4,
                BlueEnd = 1.0,
            }

            DialogueEntranceStreaks = {
                RedStart = 0.5,
                GreenStart =  0.8,
                BlueStart = 0.3,
                RedEnd = 0.2,
                GreenEnd = 0.1,
                BlueEnd = 0.1,
            }

            DialogueEntranceParticles = {
                RedStart = 0.5,
                GreenStart =  0.8,
                BlueStart = 0.3,
                RedEnd = 0.2,
                GreenEnd = 0.1,
                BlueEnd = 0.1,
            }

            DialogueEntranceParticleBurst = {
                RedStart = 0.5,
                GreenStart =  0.8,
                BlueStart = 0.3,
                RedEnd = 0.2,
                GreenEnd = 0.1,
                BlueEnd = 0.1,
            }
        }
	},
})
```