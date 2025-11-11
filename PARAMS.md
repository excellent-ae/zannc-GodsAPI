# InitializeGod parameters:

### **Likely to change**
- `godName` string **(required)** - The name of the God | eg "Ares", "Zeus" etc.
- `godType` string **(required)** - The type of God | eg "god" or "npcgod" (God = Zeus, NPC = Hermes)
- `SpawnLikeHermes` boolean **(optional)** - Commonly used with a NPCGod, which creates requirements for the god to spawn, just like Hermes. <br><br>
- `GameStateRequirements` table
- `Gender` string - eg "F"
#### Colours support `RGB 0-255` ({ 255, 0, 150, 255 }) or `RGB 0-1` { 1.0, 0 ,0.3, 1.0 }.**
- `NarrativeTextColor` table - default of `{ 32, 32, 30, 255 }`
- `NameplateSpeakerNameColor` table - default of `{24, 24, 24, 255}`
- `NameplateDescriptionColor` table - default of `{ 145, 45, 90, 255 }`
- `SubtitleColor` table - default of `{ 255, 255, 205, 255 }`<br><br>
- `Color` table - IDK - default of `{ 250, 250, 215, 255 }`
- `LightingColor` table - In the Upgrade Choice menu, its the colour behind hte boon icon - default of `{ 1, 0.91, 0.54, 1 }`
- `LootColor` table - The glow that the Physical Drop gives off - default of `{ 255, 128, 32, 255 }` <br><br> <img width="300" height="245" alt="Hades2_2krkFu7Mj6" src="https://github.com/user-attachments/assets/f53178a0-7dd8-422c-b2d4-cb933fae0123" /><br><br>
- `LoadPackages` table - eg `{"Apollo"}`
- `SFX_Portrait` string - eg `"SFX/Sound"`
- `UpgradeSelectedSound` string - eg `"SFX/Sound"` <br><br>
- `FlavorTextIds` table - eg `{"FlavourText1", "FlavourTex2" "FlavourTex3"}` <br><br>
- `WeaponUpgrades` table - eg `{"ApolloWeaponBoon", "ApolloCastBoon"}`
- `Traits` table - eg `{"PerfectDamageBonusBoon", "BlindChanceBoon"}`
#### For Voice Lines/Dialogue, refer to any LootData file
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

#### Unlikely to change, and have default values
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
- `EmoteOffsetY` integer <br>

# CreateOlympianSJSONData parameters:
- `pluginGUID` string **(required)** 
- `godName` string **(required)** 
- `godType` string **(required)** 
- `skipBoonSelectSymbol` boolean
- `AmbientSound` string - The ambient sound of the boon drop <br><br>
- The colours of the physical boon drop - with the inside colour always being white.
- Supports `RGB 0-255` ({ Red = 255, Green = 0, Blue = 150 }) or `RGB 0-1` { Red = 1.0, Green = 0, Blue = 0.3 }, as well as an Opacity field. **(required)** 
    - `colorA` table - Inner Ring eg. { Red = 255, Green = 0, Blue = 150, Opacity = 0.7 }
    - `colorB` table - Outer Ring
    - `colorC` table - Flare Shootoffs <br><br> <img width="322" height="232" alt="Hades2_SNP4G6SaZi" src="https://github.com/user-attachments/assets/2df94b31-27f1-4fac-ac4a-45175a426499" />
- `OffsetZBoonDrop` integer - Negative or Positive offset.
- `BoonDropIconScale` float - 0.0 through to 1.0
- `BoonDropIconHue` float - Negative or Positive. <br><br>
- `OffsetZBoonPreview` integer - physical boon drop icon offset
- `BoonPreviewScale` float - physical boon drop icon scale <br><br>
- `iconSpinPath` string **(required)**  - The series of images which create the little animation of the physical boon, must end in 0001, followed by 0010, 0100, 1000, and have a minimum of 2
- `previewPath` string **(required)**  - Door Icons, Upgrade Icon
- `boonSelectSymbolPath` string - Upgrade Menu Icon
- `boonSelectSymbolOffsetY` integer <br><br>
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
