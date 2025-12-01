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
    * `RejectionTextLines` (table)
    * `RejectionVoiceLines` (table)
    * `MakeUpTextLines` (table)
    * `GiftTextLineSets` (table)
    * `GiftGivenVoiceLines` (table)
    * `FullSuperActivatedVoiceLines` (table)
    * `DeathTauntVoiceLines` (table)
    * `RarityUpgradeVoiceLines` (table)
    * `BlindBoxOpenedVoiceLines` (table)

    #### Codex Data
    * `skipCodex` (boolean) - Skip creating codex entries, only really useful if the codex entry already exists for character.
    * `extraCodexEntry` (table) - Additional codex entry text (like Cerberus has)
        * `UnlockGameStateRequirements` (table)
    * `codexData` (table)
        * `baseDescription` (string) - First codex description
        * `secondDescription` (string) - Second codex description
        * `imageData` (table) - Codex portrait image
            * `imagePath` (string)
            * `OffsetY` (integer)
            * `OffsetZ` (integer)
            * `Scale` (float)

    #### Other values
    * `Weight` (integer) - The chance of it spawning in the shop.
    * `CanReceiveGift` (boolean)
    * `AlwaysShowDefaultUseText` (boolean)
    * `LootRejectionAnimation` (string)
    * `ColorGrade` (string)
    * `Consumables` (table)
    * `EmoteOffsetX` (integer)
    * `EmoteOffsetY` (integer)
    </details>
</details>

## CreateOlympianSJSONData parameters
<details>
<summary><strong>Parameters</strong></summary><br>

* `params` (table) - A set of options to create the visual elements, colours, portraits, and codex entries.
    * `godName` (string) - The name of the God | eg "Ares", "Zeus" etc.
    * `godType` (string) - The type of God | eg "god" or "npcgod".
    * `boonSelectSymbolPath` (string) **( OPTIONAL requirement)** - Upgrade Menu Icon path, can be skipped by using: `skipBoonSelectSymbol`
    * `skipBoonSelectSymbol` (boolean) **(Optional)** - Skip creating the boon select symbol for upgrade menu.
    * `iconSpinPath` (string) - The series of images which create the little animation of the physical boon, must end in 0001, followed by 0010, 0100, 1000, and have a minimum of 2
    * `previewPath` (string) - Door Icons, Upgrade Icon path.<br><br>
    *Colours support `RGB 0-255` ({ 255, 0, 150, 255 }) or `RGB 0-1` ({ 1.0, 0, 0.3, 1.0 }), with an opacity field.*
    * `colorA` (table) - Inner Ring color - supports RGB 0-255 or 0-1.
    * `colorB` (table) - Outer Ring color.
    * `colorC` (table) - Flare Shootoffs color. <br><br> <img width="322" height="232" alt="Hades2_SNP4G6SaZi" src="https://github.com/user-attachments/assets/2df94b31-27f1-4fac-ac4a-45175a426499" />

    <details>
    <summary><strong>Optional Parameters</strong></summary><br>

    * `AmbientSound` (string) - The ambient sound of the boon drop.
    * `OffsetZBoonDrop` (integer) - Z offset for boon drop icon.
    * `BoonDropIconScale` (float) - Scale for boon drop icon (0.0-1.0).
    * `BoonDropIconHue` (float) - Hue adjustment for boon drop icon.
    * `OffsetZBoonPreview` (integer) - Z offset for physical boon preview.
    * `BoonPreviewScale` (float) - Scale for physical boon preview.<br>
    * `iconPathOverrides` (table) - Define which icons use base game paths (if reusing icons).
        * `previewPath` (boolean)
        * `iconSpinPath` (boolean)
        * `boonSelectSymbolPath` (boolean)<br>
    * `boonSelectSymbolOffsetY` (integer) - Y offset for boon select symbol
    * `boonDropIconCustomFrames` (table) - Custom animation frames for boon drop, useful if you don't want to create multiple frames.
        * `EndFrame` (integer)
        * `NumFrames` (integer)
        * `PlaySpeed` (integer)

    #### Portrait Data
    * `portraitData` (table) - Portrait configuration
        * `portraitPathOverrides` (table) - Define which portraits use base game paths
            * `NeutralPortraitPath` (boolean)
            * `AnnoyedPortraitPath` (boolean)
            * `SeriousPortraitPath` (boolean)
        * `NeutralPortraitPath` (string)
        * `AnnoyedPortraitPath` (string)
        * `SeriousPortraitPath` (string)
        * `OffsetX` (integer) - X offset for portraits
        * `OffsetY` (integer) - Y offset for portraits
        * `Scale` (float) - Scale for portraits
        * `NeutralAnimations` (table) - Animations for portraits, eg blinking etc, its done in frames.<br>
        * `DialogueAnimations` (table)
            * `DialogueEntrance` (table)
                * `RedStart` (float)
                * `StartGreen` (float)
                * `StartBlue` (float)
                * `EndRed` (float)
                * `EndGreen` (float)
                * `EndBlue` (float)
            * `DialogueEntranceStreaks` (table)
                * `RedStart` (float)
                * `StartGreen` (float)
                * `StartBlue` (float)
                * `EndRed` (float)
                * `EndGreen` (float)
                * `EndBlue` (float)
            * `DialogueEntranceParticles` (table)
                * `RedStart` (float)
                * `StartGreen` (float)
                * `StartBlue` (float)
                * `EndRed` (float)
                * `EndGreen` (float)
                * `EndBlue` (float)
            * `DialogueEntranceParticleBurst` (table)
                * `RedStart` (float)
                * `StartGreen` (float)
                * `StartBlue` (float)
                * `EndRed` (float)
                * `EndGreen` (float)
                * `EndBlue` (float)

    #### Text Content
    * `godDescriptionText` (string) - Subtitle under the GodName during dialogue
    * `godDescriptionTextFlavour01` (string) - Flavour Text, shown at the top of the screen when selecting boons
    * `godDescriptionTextFlavour02` (string)
    * `godDescriptionTextFlavour03` (string)
    </details>
</details>

<!-- ### CreateOlympianSJSONData Paramaters
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
    		* `EndBlue` (float) -->

## CreateKeepsake parameters
<details>
<summary><strong>Parameters</strong></summary><br>

* `params` (table) - A set of options to create a keepsake with rarity levels, icons, and text.
    * `characterName` (string) **(required)** - The name of the character giving the keepsake.
    * `internalKeepsakeName` (string) **(required)** - Internal name for the keepsake trait.
    * `RarityLevels` (table) **(required)** - Multipliers for each rarity level.
        * `Common` (number/table)
        * `Rare` (number/table)
        * `Epic` (number/table)
        * `Heroic` (number/table)

    <details>
    <summary><strong>Optional Parameters</strong></summary><br>

    * `DoesNotAutomaticallyExpire` (boolean)
    * `EquipSound` (string)
    * `EquipVoiceLines` (table)
    
    #### Gift Requirements (If you want custom, otherwise it tries to default to first/last gift set)
    * `maxRequirement` (table) - Requirements for maxed friendship.
    * `minRequirement` (table) - Requirements to initially unlock the keepsake.
    * `ExtraFields` (table) - Additional trait data fields, where most of the functionality will go.

    #### UI/Text Content
    * `Keepsake` (table)
        * `displayName` (string) - Display name
        * `description` (string) - Description
        * `trayDescription` (string) - Description when equipped
        * `trayExpired` (string) - Description when expired
        * `signoffMax` (string) - Max friendship signoff text

    #### Icons
    * `Icons` (table)
        * `iconPathOverrides` (table) - Define which icons use base game paths
            * `iconPath` (boolean)
            * `maxIcon` (boolean)
            * `maxCornerIcon` (boolean)<br>
        * `iconPath` (string) - Main keepsake icon
        * `maxIcon` (string) - Max friendship icon
        * `maxCornerIcon` (string) - Max friendship corner icon
    </details>
</details>

## CreateBoon parameters
<details>
<summary><strong>Parameters</strong></summary><br>

* `params` (table) - A set of options to create a boon with rarity levels, slots, and requirements.
    * `characterName` (string) **(required)** - The name of the character giving the boon
    * `internalBoonName` (string) **(required)** - Internal name for the boon trait

    <details>
    <summary><strong>Optional Parameters</strong></summary><br>

    * `addToExistingGod` (table/boolean) - Add to existing god's trait list
    * `RarityLevels` (table) - Multipliers for each rarity level
        * `Common` (number/table)
        * `Rare` (number/table)
        * `Epic` (number/table)
        * `Heroic` (number/table)
        * `Legendary` (number/table)
    
    * `Slot` (string) - Boon slot type: "Melee", "Secondary", "Ranged", "Rush", "Mana"
    * `BlockStacking` (boolean) - Prevent boon from stacking
    * `StatLines` (table) - Stat line definitions
    * `ExtractValues` (table) - Value extraction definitions
    * `displayName` (string) - Display name for the boon
    * `description` (string) - Description for the boon
    * `flavourText` (string) - Flavor text for the boon (eg if its legendary)
    
    #### Boon Type Inheritance
    * `InheritFrom` (table)
        ### All types of things you can inherit from, for more information what what they do, look in TraitData.lua
        - BaseTrait
        #### Elements
        - AirBoon
        - FireBoon
        - EarthBoon
        - WaterBoon
        - AetherBoon
        #### Others
        - InPersonOlympianTrait
        - SynergyTrait
        - LegacyTrait
        - UnityTrait
        - WeaponTrait
        - CostumeTrait
        - SpellTalentTrait
        - StorePendingDeliveryItem
        - ChaosCurseTrait
        - ChaosCurseRemainingEncounters
        - ChaosBlessingTrait
        - WeaponEnchantmentTrait
        - GodModeTrait
        - ManaOverTimeSource
        - FallbackGold
        - InfernalContractBoon
        - SurfacePenalty
        - ErisCurseTrait
        - UnusedWeaponBonusTrait
        - UnusedWeaponBonusTrait2
        - RoomRewardMaxManaTrait
        - RoomRewardMaxHealthTrait
        - RoomRewardEmptyMaxHealthTrait<br> 
    * `ExtraFields` (table)
    * `reuseBaseIcons` (boolean)
    * `boonIconPath` (string)
    
    #### Requirements
    * `requirements` (table) - Trait requirements
        * `OneOf` (table) - Require one of x traits
        * `TwoOf` (table) - Require two of x traits
        * `OneFromEachSet` (table) - Require one from each set
    
    #### Custom Stat Line
    * `customStatLine` (table)
        * `ID` (string) - Internal name - use it in `StatLines = {}`
        * `displayName` (string)
        * `description` (string)
    </details>
</details>