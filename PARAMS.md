# InitializeGod parameters:

### Likely to change
- `godName` string **(required)** - The name of the God | eg "Ares", "Zeus" etc.
- `godType` string **(required)** - The type of God | eg "god" or "npcgod" (God = Zeus, NPC = Hermes)
- `SpawnLikeHermes` boolean **(optional)** - Commonly used with a NPCGod, which creates requirements for the god to spawn, just like Hermes.
-
- `GameStateRequirements` table
- `Gender` string eg "F"
- For all colours below, eg { 91, 255, 100, 255 } 
- `Color` table 
- `NarrativeTextColor` table
- `NameplateSpeakerNameColor` table
- `NameplateDescriptionColor` table
- `LightingColor` table
- `LootColor` table
- `SubtitleColor` table
- 
- `LoadPackages` table eg {"Apollo"}
- `SFX_Portrait` string eg "SFX/Sound"
- `UpgradeSelectedSound` string eg "SFX/Sound"
- 
- `FlavorTextIds` table eg {"FlavourText1", "FlavourTex2"}
- 
- `WeaponUpgrades` table eg {"ApolloWeaponBoon", "ApolloCastBoon"}
- `Traits` table eg  {"PerfectDamageBonusBoon", "BlindChanceBoon"}
- For Voice Lines/Dialogue, refer to any LootData file
- `FirstSpawnVoiceLines` table
- `OnSpawnVoiceLines` table
- `UpgradeMenuOpenVoiceLines` table
- `DuoPickupTextLines` table
- `InteractTextLineSets` table
- `BoughtTextLines` table
- `BoughtTextLinesRequirements` table
- `RejectionTextLines` table
- `RejectionVoiceLines` table
- `MakeUpTextLines` table
- `GiftTextLineSets` table
- `GiftGivenVoiceLines` table
- `FullSuperActivatedVoiceLines` table
- `DeathTauntVoiceLines` table
- `RarityUpgradeVoiceLines` table
- `BlindBoxOpenedVoiceLines` table

### Unlikely to change, and have default values
- `BackgroundAnimation` string
- `GoldifyValue` integer
- `GoldConversionEligible` boolean
- `ReplaceSpecialForGoldify` boolean
- `Weight` integer - The chance of it spawning in the shop
- `NarrativeContextArtFlippable` boolean
- `CanReceiveGift` boolean
- `TextLinesIgnoreQuests` boolean
- `UsePromptOffsetX` integer
- `AlwaysShowDefaultUseText` boolean
- `DestroyOnPickup` boolean
- `SelectionSound` string
- `ConfirmSound` string
- `OnUsedFunctionArgs` table
- `BanUnpickedBoonsEligible` boolean
- `LastRewardEligible` boolean
- `AnimOffsetZ` integer
- `LootRejectionAnimation` string
- `NarrativeContextArt` string
- `BoxAnimation` string
- `BoxExitAnimation` string
- `RequireUseToGift` boolean
- `ManualRecordUse` boolean
- `UsePromptOffsetY` integer
- `ColorGrade` string
- `UseText` string
- `OnUsedFunctionName` string
- `UseTextTalkAndGift` string
- `UseTextTalkAndSpecial` string
- `BlockedLootInteractionText` string
- `UseTextTalkGiftAndSpecial` string
- `Consumables` table
- `EmoteOffsetX` integer
- `EmoteOffsetY` integer

# CreateOlympianSJSONData parameters:
- `godName` string
- `godType` string
- `skipBoonSelectSymbol` boolean
- `AmbientSound` string - The ambient sound of the boon drop
- 
- The colours of the physical boon drop
- `colorA` table
- `colorB` table
- `colorC` table
-  
- `OffsetZBoonDrop` integer
- `BoonDropIconScale` float
- `BoonDropIconHue` float
-
- `OffsetZBoonPreview` integer - physical boon drop icon offset
- `BoonPreviewScale` float - physical boon drop icon scale
- 
- `iconSpinPath` string - The series of images which create the little animation of the physical boon
- `previewPath` string - Door Icons
- `boonSelectSymbolPath` string - Upgrade Menu Icon
- `boonSelectSymbolOffsetY` integer
-
- `portraitData` table
    - `skipNeutralPortrait` boolean
    - `NeutralPortraitFilePath` string
    - `AnnoyedPortraitFilePath` string
    - `SeriousPortraitFilePath` string
    - `DialogueAnimations` table
        - `DialogueEntrance` table
            * `RedStart` float - The starting colour for the animations. eg. 1.0
    		* `StartGreen` float
    		* `StartBlue` float
    		* `EndRed` float - The starting colour for the animations. eg. 0.1
    		* `EndGreen` float
    		* `EndBlue` float
        - `DialogueEntranceStreaks` table
            * `RedStart` float
    		* `StartGreen` float
    		* `StartBlue` float
    		* `EndRed` float
    		* `EndGreen` float
    		* `EndBlue` float
        - `DialogueEntranceParticles` table
            * `RedStart` float
    		* `StartGreen` float
    		* `StartBlue` float
    		* `EndRed` float
    		* `EndGreen` float
    		* `EndBlue` float
        - `DialogueEntranceParticleBurst` table
          * `RedStart` float
    		* `StartGreen` float
    		* `StartBlue` float
    		* `EndRed` float
    		* `EndGreen` float
    		* `EndBlue` float