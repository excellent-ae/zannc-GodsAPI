### For a full list of parameters, please refer to the [PARAMS.md](https://github.com/excellent-ae/zannc-GodsAPI/blob/main/PARAMS.md) file.

>[!NOTE]
A lot of values have default values to remove errors if not manually filled, there are paramaters to manually fill multiple fields, however, unless directly specified are **NOT** required for the basic creation to work.

<br>

>[!IMPORTANT]
> This is still a work in progress, if you have any questions, please join the [Hades Modding Discord](https://discord.gg/AHk3D48WYD), [post an issue](https://github.com/excellent-ae/zannc-GodsAPI/issues/new) or message me on discord: **dwbl.**

### Checking Implementation
There are a series of functions you can use to retrieve internal names for Gods/Boons/Keepsakes, retrieve their data or to simply check if they are registered.

**Gods**<br>
`gods.IsGodRegistered("godName", debug)`<br>
`gods.GetInternalGodName("godName")`<br>
`gods.GetGodData("godName")`

**Keepsakes**<br>
`gods.IsKeepsakeRegistered("internalKeepsakeName", debug)`<br>
`gods.GetInternalKeepsakeName("internalKeepsakeName")`<br>
`gods.GetKeepsakeData("internalKeepsakeName")`

**Boons**<br>
`gods.IsBoonRegistered("internalBoonName", debug)`<br>
`gods.GetInternalBoonName("internalBoonName")`<br>
`gods.GetBoonData("internalBoonName")`

If you pass in debug (`true`), it will return a warning print for confirmation of creation and that it is in the correct table (`LootData` or `TraitData`)

### InitializeGod Examples
```lua
--[[
This will add a new God: `Artemis` with the **internal** name `<_PLUGIN.guid>-ArtemisUpgrade`.
]]
gods.InitializeGod({
    godName = "Artemis",
    godType = "GOD",
    Gender = "F",
    LoadPackages = { "Artemis" },

    SFX_Portrait = "/SFX/ArtemisBoonArrow",
    UpgradeSelectedSound = "/SFX/ArtemisBoonArrow",

    WeaponUpgrades = game.EnemyData.NPC_Artemis_Field_01.WeaponUpgrades,
    Traits = game.EnemyData.NPC_Artemis_Field_01.Traits,

    Color = { 91, 255, 100, 255 },
    LightingColor = { 210, 255, 97, 190 },
    LootColor = { 110, 255, 0, 180 },
    SubtitleColor = Color.ArtemisVoice,

    OnSpawnVoiceLines = {
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.85,
		SuccessiveChanceToPlay = 0.25,
		GameStateRequirements = {
			NamedRequirements = { "OlympianOnSpawnVoiceLinesAllowed" },
		},

		{
			Cue = "/VO/Melinoe_1472",
			Text = "It's her.",
		},
		{
			Cue = "/VO/Melinoe_1477",
			Text = "She's back.",
		},
		{
			Cue = "/VO/ArtemisKeepsake_0214",
			Text = "Hey Sister.",
		},
	},
})
```

<br>

```lua
--[[
This will add a new npc type God: `Tyche` with the **internal** name `TycheUpgrade`.
]]

--[[
Pretending as if there is a config for users to change how the god will spawn.
If this is set to false, the god will spawn like other gods, however it will not add to the MetGod pool.
]]
local spawnrequirements = false
if config.Tyche.requirements then
	spawnrequirements = true
end

gods.InitializeGod({
    godName = "Tyche",
    godType = "npcGOD",
    SpawnLikeHermes = spawnrequirements
    Traits = {
        "TycheMoneyBoon",
        "OutWithABangBoon",
    },
})

--[[
If we want to get around the MetGod pool not being applied, you can modify the code above to something like this.
]]
local spawnrequirements = false
local typeofGod = "GOD"
if config.Tyche.requirements then
	spawnrequirements = true
	typeofGod = "NPCGOD"
end

gods.InitializeGod({
    godName = "Tyche",
    godType = typeofGod,
    SpawnLikeHermes = spawnrequirements
    Traits = {
        "TycheMoneyBoon",
        "OutWithABangBoon",
    },
})

--[[
It is possible to also limit the spawning of the God to function like Hermes, but still be GodLoot (by using godType = GOD).
Doing so however would severly limit the users' to see an additional god.
]]
```

### CreateOlympianSJSONData Examples
#### WIP, following InitializeGod creation

```lua
gods.CreateOlympianSJSONData({
    pluginGUID = _PLUGIN.guid
    godName = "Artemis",
    godType = "god",
    skipBoonSelectSymbol = true,
    previewPath = "Items\\Loot\\Boon\\ArtemisIconSpin\\ArtemisPreview",
    iconSpinPath = "Items\\Loot\\Boon\\ArtemisIconSpin\\ArtemisIconSpin",
    colorA = { Red = 0.42, Green = 0.62, Blue = 0.21 },
    colorB = { Red = 0.35, Green = 0.51, Blue = 0.12 },
    colorC = { Red = 0.23, Green = 0.57, Blue = 0.31 },
    portraitData = {
        skipNeutralPortrait = true,
    },
})
```

<br>

```lua
gods.CreateOlympianSJSONData({
    pluginGUID = _PLUGIN.guid
	godName = "Athena",
	godType = "npcGOD",

    iconPathOverrides = { -- Optional, allows you to reuse icons in base game, you still need to pass in paths
        previewPath = true,
        iconSpinPath = true,
        boonSelectSymbolPath = true,
    }
	skipBoonSelectSymbol = true,
	previewPath = "Items\\Loot\\Boon\\AthenaIconSpin\\AthenaPreview",
	iconSpinPath = "Items\\Loot\\Boon\\AthenaIconSpin\\AthenaIconSpin",
	colorA = { Red = 0.76, Green = 0.64, Blue = 0.16 },
	colorB = { Red = 0.68, Green = 0.57, Blue = 0.12 },
	colorC = { Red = 0.60, Green = 0.51, Blue = 0.19 },
	portraitData = {
        portraitPathOverrides = { -- Optional, allows you to reuse portraits in base game, you still need to pass in paths
            NeutralPortraitPath = true,
            AnnoyedPortraitPath = true,
            SeriousPortraitPath = true,
        }
		NeutralPortraitPath = "Portraits\\Portrait1",
		AnnoyedPortraitPath = "Portraits\\Portrait2",

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

### Example Keepsake
#### WIP

```lua
gods.CreateKeepsake({

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
        iconPathOverrides = { -- Optional, allows you to reuse icons in base game
            iconPath = true,
            maxIcon = true,
            maxCornerIcon = true,
        },
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

### Example Boon
#### WIP
Although this function exists, a lot of the dirty work will have to be done through external custom functions and or reusing existing functions/wrapping them.
```lua
--[[
Required:   "characterName", "internalBoonName"
Optional:   "RarityLevels", "Slot", "BlockStacking", "StatLines", "ExtractValues", "displayName"
            "ExtraFields", "boonIconPath", "requirements", "flavourText", "addToExistingGod", "reuseBaseIcons"
]]
gods.CreateBoon({
	internalBoonName = "AwesomeWeaponBoon",  -- eg TycheWeaponBoon
	isLegendary = false,
    Elements = {"Air"},
    characterName = "Tyche",
	addToExistingGod = { boonPosition = 2 }, -- OR true // Allows you to insert traits into Olympains (Zeus etc) and Daedalus Hammers (characterName = Weapon) --- Chaos and Selene NOT supported ATM.
    --? Everything below is an Optional field

    -- "Melee" or "Secondary" or "Ranged" or "Rush" or "Mana", doesn't need to be passed if not a core boon.
    Slot = "Special",
    BlockStacking = false, -- Can't be upgraded with poms
    StatLines = { "NearbyDamageStatDisplay1" }, -- The display for damage bonus etc etc.
    ExtractValues = { -- Values to get from ExtraFields eg any damage bonus, which is ued in description and in the stat display.
        {
            Key = "ReportedWeaponMultiplier",
            ExtractAs = "TooltipBonus",
            Format = "PercentDelta",
            SkipAutoExtract = true,
		},
    }, -- refer to traits, or make your own from extra fields
    displayName = "Awesome!",
    description = "Awesome Description!",
    flavourText = "Legendary Flavour Text!",
	requirements = { OneOf = { "ApolloWeaponBoon" } }, -- If this boon needs xyz before it spawns
    reusingBaseIcons = false, -- Optional, allows you to reuse icons in base game, you still need to pass in paths
    boonIconPath = "path\\to\\boonIcon",
    RarityLevels = {
        Common = { Multiplier = 1.0 },
        Rare = { Multiplier = 1.5 },
        Epic = { Multiplier = 2.0 },
        Heroic = { Multiplier = 2.5 },
    },

    --[[
    This is basically where you do all your funky stuff that you want the boon to do, there are a -
        lot of fields you can look at by using existing traits, or even make your own new ones.
    ]]
    ExtraFields = {
		AddOutgoingDamageModifiers = {
			VengeanceMultiplier = {
				BaseValue = 1.20,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "VengeanceMultiplier" },
		},
	},
})

--[[ Elements you can use:
	AirBoon =
	{
		Elements = { "Air" },
		DebugOnly = true,
	},
	FireBoon =
	{
		Elements = {"Fire"},
		DebugOnly = true,
	},
	EarthBoon =
	{
		Elements = {"Earth"},
		DebugOnly = true,
	},
	WaterBoon =
	{
		Elements = {"Water"},
		DebugOnly = true,
	},
	AetherBoon =
	{
		Elements = {"Aether"},
		DebugOnly = true,
	},
    	SynergyTrait =
	{
		InheritFrom = { "AetherBoon", },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "ChosenRewardType", },
				IsNone = { "Devotion", },
			},
		},
		IsDuoBoon = true,
		Frame = "Duo",
		BlockStacking = true,
		DebugOnly = true,
		RarityLevels =
		{
			Duo =
			{
				MinMultiplier = 1,
				MaxMultiplier = 1,
			},
		},
	},

	LegacyTrait =
	{
		IsLegacyTrait = true,
		DebugOnly = true,
	},

	UnityTrait =
	{
		IsElementalTrait = true,
		BlockStacking = true,
		BlockInRunRarify = true,
		BlockMenuRarify = true,
		ExcludeFromRarityCount = true,
		CustomRarityName = "Boon_Infusion",
		CustomRarityColor = Color.BoonPatchElemental,
		InfoBackingAnimation = "BoonSlotUnity",
		UpgradeChoiceBackingAnimation = "BoonSlotUnity",
		Frame = "Unity",
		DebugOnly = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1,
			},
		}
	},
]]
```