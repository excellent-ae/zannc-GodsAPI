---@meta zannc-GodsAPI
local gods = {}

---@alias GodType "god" | "npcgod"

--- [DEFUNCT]
function gods.Initialize() end

--! not done
--[[
    Creates the main LootData for a god, contains trais, dialogue, game spawn requirements, colours. <br>
    Refer to the docs for all available fields: "https://github.com/excellent-ae/zannc-GodsAPI/blob/main/PARAMS.md"

    Basic Usage:
        gods.InitializeGod({

        })
--]]
---@class GodParams
---@field godName string
---@field godType GodType
function gods.InitializeGod(params) end

--! not done
--[[
    Creates SJSON data for a God. <br>
    Refer to the docs for all available fields: "https://github.com/excellent-ae/zannc-GodsAPI/blob/main/PARAMS.md"

    Basic Usage:
        gods.CreateOlympianSJSONData({
            godName = "Artemis",
            godType = "god",
        })
--]]
---@class SJSONData
---@field pluginGUID string
---@field godName string
---@field godType GodType
---@field skipBoonSelectSymbol boolean?
---@field iconSpinPath string
---@field previewPath string
---@field boonSelectSymbolPath string?
---@field colorA table
---@field colorB table
---@field colorC table
function gods.CreateOlympianSJSONData(params) end

--[[
    Creates a Keepsake for a character, doesn't have to be related to a specific God/Character in the game already. <br>
    Refer to the docs for all available fields: "https://github.com/excellent-ae/zannc-GodsAPI/blob/main/PARAMS.md"

    Usage:
        gods.CreateKeepsake({
            pluginGUID = _PLUGIN.guid,
            characterName = "Hephaestus",
            internalKeepsakeName = "ForceHephaestusBoonKeepsake",
            RarityLevels = {Common = 1.0, Rare = 1.5, Epic = 2.0, Heroic = 2.5},
            ExtraFields = { -- This is where you do all the functionality of the keepsake.
                AddOutgoingDamageMultiplier = { ... }
            }
        })
--]]
---@class KeepsakeParams
---@field pluginGUID string
---@field characterName string
---@field internalKeepsakeName string
---@field RarityLevels table
---@field Keepsake table?
---@field Icons table?
---@field ExtraFields table?
function gods.CreateKeepsake(params) end

--! not done
--[[
    Creates a Boon for a God/Character. <br>
    Refer to the docs for all available fields: "https://github.com/excellent-ae/zannc-GodsAPI/blob/main/PARAMS.md"

    Basic Usage:
        gods.CreateBoon({
            pluginGUID = _PLUGIN.guid,
            internalBoonName = "Hephaestus",
            Slot = "Melee",
            BlockStacking = false,
            isLegendary = false,
            RarityLevels = {Common = 1.0, Rare = 1.5, Epic = 2.0, Heroic = 2.5},
            ExtraFields = { -- This is where you do all the functionality of the Boon.
                AddOutgoingDamageMultiplier = { ... }
            }
        })
--]]
---@class TraitParams
---@field pluginGUID string
---@field characterName string
---@field internalKeepsakeName string
---@field RarityLevels table
---@field Keepsake table?
---@field Icons table?
---@field ExtraFields table?
function gods.CreateBoon(TraitParams) end

--[[
    Checks if a God is in LootData, usually for debugging but can be used to do game checks.

    Usage:
        gods.IsGodRegistered("Ares", true)
--]]
---@param godName string (required) The name of the God to check.
---@param debug boolean? (optional) Enable debug prints, just returns if true or false as a warning.
---@return boolean # True if the God is in LootData
function gods.IsGodRegistered(godName, debug) end

--[[
    Checks if a Keepsake is created in TraitData, usually for debugging but can be used to do game checks.

    Usage:
        gods.IsKeepsakeRegistered("ForceHephaestusBoonKeepsake")
--]]
---@param internalKeepsakeName string (required) The internal name of the Keepsake to check.
---@param debug boolean? (optional) Enable debug prints, just returns if true or false as a warning.
---@return boolean # True if the Keepsake is in TraitData
function gods.IsKeepsakeRegistered(internalKeepsakeName, debug) end

--[[
    Checks if a Boon is created in TraitData, usually for debugging but can be used to do game checks.

    Usage:
        gods.IsBoonRegistered("ApolloWeaponBoon")
--]]
---@param internalBoonName string (required) The internal name of the Boon to check.
---@param debug boolean? (optional) Enable debug prints, just returns if true or false as a warning.
---@return boolean # True if the Boon is in TraitData
function gods.IsBoonRegistered(internalBoonName, debug) end

return gods
