Just moving stuff around for now, will update with more information later.

#### For a full list of parameters, please refer to the [PARAMS.md](https://github.com/excellent-ae/zannc-GodsAPI/blob/main/PARAMS.md) file.

## Parameters
While this is not a definitive list, these are the most common that will need to be changed.

<details>
<summary><strong>Parameters</strong></summary>

### InitializeGod Paramaters
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

### CreateOlympianSJSONData Paramaters
If you wish to add SJSON content, such as the boon drop icons, door preview icons or portraits, you must call `gods.CreateOlympianSJSONData(sjsonData)`

>[!IMPORTANT]
> When passing in your Icon Paths, you do not need to provide your `_PLUGIN.guid`. <br>
> `Example:` deppth2 provides: `zannc-GodsAPI\\Icons\\Boons\\img.png`, however you only need to provide `Icons\\Boons\\img.png`.
> Passing in your `_PLUGIN.guid` will not break anything, but it is not necessary.

* `sjsonData` (table) - A set of options to create the name, colour, text, gender, spawn sound etc.
    * `pluginGUID` (string) **(required)** - Your plugins GUID, commonly passed with `_PLUGIN.guid`
    * `godName` (string) **(required)** - The name of the God | eg "Ares", "Zeus" etc.
    * `godType` (string) **(required)** - The type of God | eg "god" or "npcgod" (God = Zeus, NPC = Hermes)
    * `skipBoonSelectSymbol` (boolean) **(optional)** - If there is already a Boon Select Symbol (In upgrade screen), you can pass this to skip the creation of one.
	* `iconSpinPath` (string) - The animation of the physical boon drop.
	* `previewPath` (string) - The icon to display on doors.
  	* `colorA` (table) - The colours of the physical boon drop
	* `colorB` (table)
	* `colorC` (table)<br><br>
	* `godDescriptionText` (string) **(optional)** - The subtitle when picking up a boon eg... `Artemis, Goddess of the Hunt`
	* `godDescriptionTextFlavour01` (string) **(optional)** The subtitle at the top, when the boons are selected eg... `Boons of Artemis, she moves through the woods like...`
	* `godDescriptionTextFlavour02` (string) **(optional)** 
	* `godDescriptionTextFlavour03` (string) **(optional)** 

    <details>
    <summary><strong>Optional Parameters</strong></summary>

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
</details>

#### For a full list of parameters, please refer to the [PARAMS.md](https://github.com/excellent-ae/zannc-GodsAPI/blob/main/PARAMS.md) file.

# Checking Implementation
If you need to check if the God you created is currently registered, or need to use an `if statement` to check if a god is enabled/disabled per config, you can use `gods.IsGodRegistered("GODNAME", debug)` - returning **true or false**. If you pass in debug (true), it will return a warning print for confirmation of creation.<br>

# Examples
This will add a new God: `Artemis` with the **internal** name `ArtemisUpgrade`.
```lua
gods.InitializeGod({
    godName = "Artemis",
    godType = "GOD",
    Gender = "F",
    LoadPackages = { "Artemis" },
    FlavorTextIds = { "ArtemisUpgrade_FlavorText01", "ArtemisUpgrade_FlavorText02", "ArtemisUpgrade_FlavorText03" },

    SFX_Portrait = "/SFX/ArtemisBoonArrow",

    WeaponUpgrades = game.EnemyData.NPC_Artemis_Field_01.WeaponUpgrades,
    Traits = game.EnemyData.NPC_Artemis_Field_01.Traits,

    Color = { 91, 255, 100, 255 },
    LightingColor = { 210, 255, 97, 190 },
    LootColor = { 110, 255, 0, 180 },
    SubtitleColor = Color.ArtemisVoice,
})

gods.CreateOlympianSJSONData({
    pluginGUID = _PLUGIN.guid
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

This will add a new NPC God: `Athena` with the **internal** name `AthenaUpgrade`, and function/spawn like Hermes does.

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
    pluginGUID = _PLUGIN.guid
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


# Example Keepsake

```lua

gods.CreateKeepsake({
	pluginGUID = _PLUGIN.guid,
	characterName = "Spike",
	internalKeepsakeName = "CarryingWeightKeepsake",

	RarityLevels = {
		Common = 1,
		Rare = 2,
		Epic = 3,
		Heroic = 4,
	},

	-- The Actual Display stuff, so name/description/icons start here
	Keepsake = {
		displayName = "Weight Carrier",
		description = "For all the weight carried by Melinoe, gain {!Icons.Health}25 health.", -- refer to multiple descriptions in the game.
		signoffMax = "From {#AwardMaxFormat}Persephone{#Prev}; you share a {#AwardMaxFormat}Bond{#Prev}.{!Icons.ObjectiveSeparatorDark} Bang.",
		--? Optional Descriptions
		trayDescription = "For all the weight carried by Melinoe, gain {!Icons.Health}25 health.", -- this could be different to basic desc, if the keepsake increments/decreases etc
		trayExpired = "For all the weight carried by Melinoe, gain {!Icons.Health}25 health.",
	},

	Icons = {
		iconPath = "Keepsakes\\Icons\\Spiegel",
		--? Optional
		maxIcon = "Keepsakes\\Icons\\Spiegel_Max",
		maxCornerIcon = "Keepsakes\\Icons\\Spiegel_Corner",
	},

	ExtraFields = { -- This is basically where you do all your funky stuff that you want the keepsake to do
		AddOutgoingDamageModifiers = {
			VengeanceMultiplier = {
				BaseValue = 1.20,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "VengeanceMultiplier" },
		},
	},
})

```