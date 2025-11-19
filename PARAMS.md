>[!IMPORTANT]
> This is still a work in progress, and hasn't been fully written up with information on each field. <br>
> I will update this note when it is fully up to date.

## InitializeGod parameters
<details>
<summary><strong>Parameters</strong></summary><br>

* `params` (table) - A set of options to create the name, colour, text, gender, spawn sound etc.
    * `godName` (string) **(required)** - The name of the God | eg "Ares", "Zeus" etc.
    * `godType` (string) **(required)** - The type of God | eg "god" or "npcgod" (God = Zeus, NPC = Hermes)<br>
    >[!IMPORTANT]
    `SpawnLikeHermes` is commonly used with a NPCGod, which creates requirements for the god to spawn, just like Hermes, otherwise, they will spawn like normal, but not apply to the `MaxGods` table.<br>
    NPCGod main use is to not apply to the MetGods table.
    * `SpawnLikeHermes` (boolean) **(optional)** - `default is = nil `

    <details>
    <summary><strong>Optional Parameters</strong></summary><br>

    * `Gender` (string) - eg "Male", "Female", "X" -- used mainly for dialogue - default of `nil`
    * `GameStateRequirements` (table) - If xyz thing needs to happen before this god can spawn, eg DemeterUpgrade for first time - default of `{}`
    * `LoadPackages` (table) - This is a set of images which create the glint affect/blinking/whatever of the portrait - eg `{"Apollo"}` - default of `{}`
    * `FlavorTextIds` (table) - eg `{"FlavourText1", "FlavourTex2" "FlavourTex3"}` - default of `{}`
    * `SFX_Portrait` (string) - Spawn sound for the portrait and the boon drop - eg `"SFX/Sound"` - default of `nil`
    * `UpgradeSelectedSound` (string) - eg `"SFX/Sound"` - default of `nil`
    * `WeaponUpgrades` (table) - Core boons, eg `{"ApolloWeaponBoon", "ApolloCastBoon"}` - default of `{}`
    * `Traits` (table) - Other Boons for the god, so not slotted anywhere - eg `{"PerfectDamageBonusBoon", "BlindChanceBoon"}` - default of `{}`
    * `TraitSortOrder` (table) - Order to show traits in codex - default of `{}`

    #### Colours
    *Colours support `RGB 0-255` ({ 255, 0, 150, 255 }) or `RGB 0-1` ({ 1.0, 0, 0.3, 1.0 }), with an opacity field.*
    * `NarrativeTextColor` (table) - default of `{ 32, 32, 30, 255 }`
    * `NameplateSpeakerNameColor` (table) - default of `{24, 24, 24, 255}`
    * `NameplateDescriptionColor` (table) - default of `{ 145, 45, 90, 255 }`
    * `SubtitleColor` (table) - default of `{ 255, 255, 205, 255 }`<br><br>
    * `Color` (table) - default of `{ 250, 250, 215, 255 }`
    * `LootColor` (table) - In the Upgrade Choice menu, its the colour behind the boon icon - default of `{ 1, 0.91, 0.54, 1 }`
    * `LightingColor` (table) The glow that the Physical Drop gives off - default of `{ 255, 128, 32, 255 }` <br><br> <img width="300" height="245" alt="Hades2_2krkFu7Mj6" src="https://github.com/user-attachments/assets/f53178a0-7dd8-422c-b2d4-cb933fae0123" /><br><br>

    #### Dialogue/Text
    *For Voice Lines/Dialogue, refer to any LootData file*
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

    #### Other values which are possible to change, but not needed to be except in rare specific cases.
    * `BackgroundAnimation` (string)
    * `GoldifyValue` (integer)
    * `GoldConversionEligible` (boolean)
    * `ReplaceSpecialForGoldify` (boolean)
    * `Weight` (integer) - The chance of it spawning in the shop.
    * `NarrativeContextArtFlippable` (boolean)
    * `CanReceiveGift` (boolean)
    * `TextLinesIgnoreQuests` (boolean)
    * `UsePromptOffsetX` (integer)
    * `AlwaysShowDefaultUseText` (boolean)
    * `DestroyOnPickup` (boolean)
    * `SelectionSound` (string)
    * `ConfirmSound` (string)
    * `OnUsedFunctionArgs` table
    * `BanUnpickedBoonsEligible` (boolean)
    * `LastRewardEligible` (boolean)
    * `AnimOffsetZ` (integer)
    * `LootRejectionAnimation` (string)
    * `NarrativeContextArt` (string)
    * `BoxAnimation` (string)
    * `BoxExitAnimation` (string)
    * `RequireUseToGift` (boolean)
    * `ManualRecordUse` (boolean)
    * `UsePromptOffsetY` (integer)
    * `ColorGrade` (string)
    * `UseText` (string)
    * `OnUsedFunctionName` (string)
    * `UseTextTalkAndGift` (string)
    * `UseTextTalkAndSpecial` (string)
    * `BlockedLootInteractionText` (string)
    * `UseTextTalkGiftAndSpecial` (string)
    * `Consumables` (table)
    * `EmoteOffsetX` (integer)
    * `EmoteOffsetY` (integer) <br>
    </details>
</details>

# CreateOlympianSJSONData parameters:
- `pluginGUID` string **(required)** 
- `godName` string **(required)** 
- `godType` string **(required)** 
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
- `iconPathOverrides` table - Let's you define which icons you want to be using base game icons.
- `skipBoonSelectSymbol` boolean
- `iconSpinPath` string **(required)**  - The series of images which create the little animation of the physical boon, must end in 0001, followed by 0010, 0100, 1000, and have a minimum of 2
- `previewPath` string **(required)**  - Door Icons, Upgrade Icon
- `boonSelectSymbolPath` string - Upgrade Menu Icon
- `boonSelectSymbolOffsetY` integer <br><br>
- `portraitData` table
    - `portraitPathOverrides` table - Let's you define which portraits you want to be using base game portraits.
    - `skipNeutralPortrait` boolean
    - `NeutralPortraitPath` string
    - `AnnoyedPortraitPath` string
    - `SeriousPortraitPath` string
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
<!-- 
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
</details> -->
