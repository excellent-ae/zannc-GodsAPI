---@meta zannc-GodsAPI-auto
local public = {}

---@alias GodType "god" | "npcgod"

--Creates the main LootData for a god, contains traits, dialogue, game spawn requirements, colours.
---@class GodParams
---@field godName string
---@field godType GodType
---@field Gender? string
---@field GameStateRequirements? table
---@field Color? table
---@field NarrativeTextColor? table
---@field NameplateSpeakerNameColor? table
---@field NameplateDescriptionColor? table
---@field LightingColor? table
---@field LootColor? table
---@field SubtitleColor? table
---@field LoadPackages? table
---@field FlavorTextIds? table
---@field SFX_Portrait? string
---@field UpgradeSelectedSound? string
---@field WeaponUpgrades? table
---@field Traits? table
---@field FirstSpawnVoiceLines? table
---@field OnSpawnVoiceLines? table
---@field UpgradeMenuOpenVoiceLines? table
---@field DuoPickupTextLines? table
---@field InteractTextLineSets? table
---@field BoughtTextLines? table
---@field RejectionTextLines? table
---@field RejectionVoiceLines? table
---@field MakeUpTextLines? table
---@field GiftTextLineSets? table
---@field GiftGivenVoiceLines? table
---@field FullSuperActivatedVoiceLines? table
---@field DeathTauntVoiceLines? table
---@field RarityUpgradeVoiceLines? table
---@field BlindBoxOpenedVoiceLines? table
---@field Weight? number
---@field CanReceiveGift? boolean
---@field AlwaysShowDefaultUseText? boolean
---@field LootRejectionAnimation? string
---@field ColorGrade? string
---@field Consumables? table
---@field EmoteOffsetX? number
---@field EmoteOffsetY? number
---@field SpawnLikeHermes? boolean|table
---@field skipCodex? boolean
---@field extraCodexEntry? table
---@field codexData? table
---@field ExtraFields? table

---@param params GodParams
function public.InitializeGod(params) end

--Creates SJSON data for a God including boon drops, icons, portraits, and text entries.
---@class SJSONData
---@field godName string
---@field godType GodType
---@field skipBoonSelectSymbol? boolean
---@field iconSpinPath string
---@field previewPath string
---@field boonSelectSymbolPath? string
---@field colorA table
---@field colorB table
---@field colorC table
---@field AmbientSound? string
---@field iconPathOverrides? table
---@field OffsetZBoonPreview? number
---@field BoonPreviewScale? number
---@field OffsetZBoonDrop? number
---@field BoonDropIconScale? number
---@field BoonDropIconHue? number
---@field boonDropIconCustomFrames? table
---@field boonSelectSymbolOffsetY? number
---@field godDescriptionText? string
---@field godDescriptionTextFlavour01? string
---@field godDescriptionTextFlavour02? string
---@field godDescriptionTextFlavour03? string
---@field portraitData? table
---@field portraitPathOverrides? table

---@param params SJSONData
function public.CreateOlympianSJSONData(params) end

--Creates a Keepsake for a character, doesn't have to be related to a specific God/Character in the game already.
---@class KeepsakeParams
---@field characterName string
---@field internalKeepsakeName string
---@field RarityLevels table
---@field DoesNotAutomaticallyExpire? boolean
---@field ExtractValues? table
---@field EquipSound? string
---@field EquipVoiceLines? table
---@field customGiftData? table
---@field ExtraFields? table
---@field Keepsake? table
---@field Icons? table
---@field iconPathOverrides? table

---@param params KeepsakeParams
function public.CreateKeepsake(params) end

--Creates a Boon for a God/Character.
---@class TraitParams
---@field characterName string
---@field internalBoonName string
---@field InheritFrom? string|table
---@field RarityLevels? table
---@field Slot? string
---@field BlockStacking? boolean
---@field StatLines? table
---@field ExtractValues? table
---@field ExtraFields? table
---@field boonIconPath? string
---@field reuseBaseIcons? boolean
---@field requirements? table
---@field flavourText? string
---@field displayName? string
---@field description? string
---@field addToExistingGod? boolean|table
---@field customStatLine? table

---@param params TraitParams
function public.CreateBoon(params) end

--Checks if a God is in LootData, usually for debugging.
---@param godName string
---@param debug? boolean
---@return boolean
function public.IsGodRegistered(godName, debug) end

--Gets the internal god upgrade name with plugin GUID prefix.
---@param godName string
---@return string|nil
function public.GetInternalGodName(godName) end

--Gets the full god data from LootData.

---@param godName string
---@return table|nil
function public.GetGodData(godName) end

--Checks if a Keepsake is created in TraitData, usually for debugging.
---@param internalKeepsakeName string
---@param debug? boolean
---@return boolean
function public.IsKeepsakeRegistered(internalKeepsakeName, debug) end

--Gets the internal keepsake name with plugin GUID prefix.
---@param internalKeepsakeName string
---@return string|nil
function public.GetInternalKeepsakeName(internalKeepsakeName) end

--Gets the full keepsake data from TraitData.
---@param internalKeepsakeName string
---@return table|nil
function public.GetKeepsakeData(internalKeepsakeName) end

--Checks if a Boon is created in TraitData, usually for debugging.
---@param internalBoonName string
---@param debug? boolean
---@return boolean
function public.IsBoonRegistered(internalBoonName, debug) end

--Gets the internal boon name with plugin GUID prefix.
---@param internalBoonName string
---@return string|nil
function public.GetInternalBoonName(internalBoonName) end

--Gets the full boon data from TraitData.
---@param internalBoonName string
---@return table|nil
function public.GetBoonData(internalBoonName) end

return public
