### For a full list of parameters, please refer to the [PARAMS.md](https://github.com/excellent-ae/zannc-GodsAPI/blob/main/PARAMS.md) file.

>[!NOTE]
A lot of values have default values to remove errors if not manually filled, there are paramaters to manually fill multiple fields, however, unless directly specified are **NOT** required for the basic creation to work.

<br>

>[!IMPORTANT]
> This is still a work in progress, and needs to be cleaned up/ written with better examples for SJSON/Keepsake & Traits.

### InitializeGod Examples
```lua
--[[
This will add a new God: `Artemis` with the **internal** name `ArtemisUpgrade`.
]]
gods.InitializeGod({
    godName = "Artemis",
    godType = "GOD",
    Gender = "F",
    LoadPackages = { "Artemis" },
    FlavorTextIds = { "ArtemisUpgrade_FlavorText01", "ArtemisUpgrade_FlavorText02", "ArtemisUpgrade_FlavorText03" }, -- Defined later in SJSON

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
It is possible to also limit the spawning of the God to function like hermes, but still apply to the MetGods table (by using godType = GOD).
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

<br>

```lua
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

### Example Keepsake
#### WIP
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

### Example Boon
#### WIP
Although this function exists, a lot of the dirty work will have to be done through external custom functions and or reusing existing functions/wrapping them.
```lua
--[[ 
uid, internal, charactername ,legendary, rarity, slot, blockstacking,  statlines, extractval, elements, displayName
extrafields, boonIconPath, requirements, flavourtext
]]
gods.CreateBoon({
	pluginGUID = _PLUGIN.guid,
	internalBoonName = "AwesomeWeaponBoon",  -- eg TycheWeaponBoon
	isLegendary = false,
    Elements = {"Air"},
    characterName = "Tyche",
    --? Optional
    Slot = "Special",
    BlockStacking = false,
    StatLines = { "NearbyDamageStatDisplay1" },
    ExtractValues = {
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
	requirements = { OneOf = { "ApolloWeaponBoon" } },
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
```

# Checking Implementation
If you need to check if the God you created is currently registered, or need to use an `if statement` to check if a god is enabled/disabled per config, you can use `gods.IsGodRegistered("GODNAME", debug)` - returning **true or false**. If you pass in debug (true), it will return a warning print for confirmation of creation.<br>
