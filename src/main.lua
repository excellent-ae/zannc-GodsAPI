---@diagnostic disable: undefined-global
---@meta _

local mods = rom.mods
mods["LuaENVY-ENVY"].auto()
rom = rom
---@diagnostic disable-next-line: undefined-global
_PLUGIN = PLUGIN
game = rom.game
modutil = mods["SGG_Modding-ModUtil"]
sjson = mods["SGG_Modding-SJSON"]

import_as_fallback(rom.game)

local GameplayFile = rom.path.combine(rom.paths.Content, "Game/Obstacles/Gameplay.sjson")
local MacroTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/MacroText.en.sjson")
local GUIScreensVFXFile = rom.path.combine(rom.paths.Content, "Game/Animations/GUI_Screens_VFX.sjson")
local ItemsGeneralVFX = rom.path.combine(rom.paths.Content, "Game/Animations/Items_General_VFX.sjson")
local ScreenText = rom.path.combine(rom.paths.Content, "Game/Text/en/ScreenText.en.sjson")
local TraitTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/TraitText.en.sjson")
local PortraitFile = rom.path.combine(rom.paths.Content, "Game/Animations/GUI_Portraits_VFX.sjson")
local GUIBoonsVFXFile = rom.path.combine(rom.paths.Content, "Game/Animations/GUI_Boons_VFX.sjson")
local HelpTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/HelpText.en.sjson")

local TextOrder = { "Id", "InheritFrom", "DisplayName", "Description" }
local IconOrder = { "Name", "InheritFrom", "FilePath", "OffsetY", "OffsetZ", "Scale", "Hue" }
local GameplayOrder = { "Name", "InheritFrom", "DisplayInEditor", "Thing" }
local VFXMainOrder = {
	"Name",
	"InheritFrom",
	"ChildAnimation",
	"CreateAnimations",
	"Color",
	"FilePath",
	"OffsetZ",
	"Scale",
	"Hue",
	"EndFrame",
	"NumFrames",
	"PlaySpeed",
	"ColorFromOwner",
	"AngleFromOwner",
	"Sound",
}
local PortraitOrder = {
	"Name",
	"InheritFrom",
	"ChildAnimation",
	"CreateAnimation",
	"CreateAnimations",
	"EndFrame",
	"StartFrame",
	"FilePath",
	"Sound",
	"StartRed",
	"StartGreen",
	"StartBlue",
	"EndRed",
	"EndGreen",
	"EndBlue",
	"VisualFx",
}

local function addGodtoRunData(runData, upgrade)
	local requirementNames = { MaxHealthDrop = true, MaxManaDrop = true, RoomMoneyDrop = true, StackUpgrade = true, Devotion = true }
	for _, entry in ipairs(runData) do
		if not requirementNames[entry.Name] then
			return
		end

		if not entry.GameStateRequirements then
			return
		end

		for _, requirement in ipairs(entry.GameStateRequirements) do
			if requirement.CountOf then
				table.insert(requirement.CountOf, upgrade)
			end
		end
	end
end

local function registerEntityData(entityName, entityType, entityData)
	local upgradeName = entityName .. "Upgrade"

	game.CodexData.OlympianGods.Entries[upgradeName] = {
		Entries = {
			{
				UnlockGameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", entityName .. "Gift01" },
					},
				},
				Text = "CodexData_" .. entityName .. "_01",
			},
		},
		Image = "Codex_Portrait_" .. entityName,
		BoonInfoAllowPinning = true,
	}
	if entityType == "npcgod" then
		game.CodexData.OlympianGods.Entries[upgradeName].NoRequirements = true
	end

	if entityType == "god" then
		addGodtoRunData(game.RewardStoreData.RunProgress, upgradeName)
		addGodtoRunData(game.RewardStoreData.TartarusRewards, upgradeName)
	end

	local traitDictionary = {}
	game.ScreenData.BoonInfo.TraitDictionary[entityName] = {}
	game.ScreenData.BoonInfo.TraitSortOrder[entityName] = {}

	--* LinkedTraitData is just WeaponUpgrades.
	if entityData.WeaponUpgrades then
		game.ScreenData.BoonInfo.TraitSortOrder[entityName] = game.ConcatTableValuesIPairs(game.ScreenData.BoonInfo.TraitSortOrder[entityName], entityData.WeaponUpgrades)
		game.LinkedTraitData[entityName .. "WeaponTraits"] = game.ConcatTableValuesIPairs(game.ScreenData.BoonInfo.TraitSortOrder[entityName], entityData.WeaponUpgrades)
		game.LinkedTraitData[entityName .. "CoreTraits"] = game.ConcatTableValuesIPairs(game.ScreenData.BoonInfo.TraitSortOrder[entityName], entityData.WeaponUpgrades)
	end
	if entityData.Traits then
		game.ScreenData.BoonInfo.TraitSortOrder[entityName] = game.ConcatTableValuesIPairs(game.ScreenData.BoonInfo.TraitSortOrder[entityName], entityData.Traits)
	end

	if entityData.WeaponUpgrades ~= nil then
		for i, traitName in pairs(entityData.WeaponUpgrades) do
			traitDictionary[traitName] = true
			game.ScreenData.BoonInfo.TraitDictionary[entityName][traitName] = true
		end
	end
	if entityData.Traits ~= nil then
		for i, traitName in pairs(entityData.Traits) do
			traitDictionary[traitName] = true
			game.ScreenData.BoonInfo.TraitDictionary[entityName][traitName] = true
		end
	end
	if entityData.PermanentTraits ~= nil then
		for i, traitName in pairs(entityData.PermanentTraits) do
			traitDictionary[traitName] = true
			game.ScreenData.BoonInfo.TraitDictionary[entityName][traitName] = true
		end
	end
	if entityData.TemporaryTraits ~= nil then
		for i, traitName in pairs(entityData.TemporaryTraits) do
			traitDictionary[traitName] = true
			game.ScreenData.BoonInfo.TraitDictionary[entityName][traitName] = true
		end
	end
	if entityData.Consumables ~= nil then
		for i, consumableName in pairs(entityData.Consumables) do
			game.ScreenData.BoonInfo.TraitDictionary[entityName][consumableName] = true
		end
	end

	entityData.TraitIndex = traitDictionary
end

local function cleanFilePath(pluginGUID, filePath)
	local parts = {}
	for part in filePath:gmatch("[^/\\]+") do
		table.insert(parts, part)
	end

	if parts[1] == pluginGUID then
		table.remove(parts, 1)
		local result = table.concat(parts, "\\")
		return result
	end

	return filePath
end

local function validateParams(params, requiredFields, context)
	if not params then
		rom.log.error(context .. ": Missing parameter 'params'")
		return false
	end

	for _, field in ipairs(requiredFields) do
		if not params[field] then
			rom.log.error(context .. ": Missing required parameter '" .. field .. "'")
			return false
		end
	end

	return true
end

function public.Initialize()
	rom.log.warning("Initialize is now a `DEFUNCT` function, it no longer does anything, you now pass in your _PLUGIN.guid into any function that requires it.")
end

-- Gods like Zeus/Ares/etc or NPC Gods like Hermes.
function public.InitializeGod(params)
	if not validateParams(params, { "godName", "godType" }, "InitializeGod") then
		return nil
	end

	local upgradeName = params.godName .. "Upgrade"
	local lowGodType = string.lower(params.godType)

	if game.LootData[upgradeName] then
		rom.log.warning(params.godName .. " is already registered, skipping creation.")
		return
	end

	game.LootData[upgradeName] = {
		Name = upgradeName,
		Speaker = "NPC_" .. params.godName .. "_01",
		SpeakerName = params.godName,
		Gender = params.Gender,

		GodLoot = true,
		TreatAsGodLootByShops = nil,
		GameStateRequirements = params.GameStateRequirements or {},

		BoonInfoIcon = "BoonInfoSymbol" .. params.godName .. "Icon",
		DoorIcon = "BoonDrop" .. params.godName .. "Preview",
		DoorUpgradedIcon = "BoonDrop" .. params.godName .. "UpgradedPreview",
		Icon = "BoonSymbol" .. params.godName,
		MenuTitle = "UpgradeChoiceMenu_Title_" .. params.godName .. "Upgrade",

		--! Portraits
		Portrait = "Portrait_" .. params.godName .. "_Default_01", -- Default Portrait
		WrathPortrait = "Portrait_" .. params.godName .. "_Default_01_Wrath", -- Wrath Portrait
		OverlayAnim = params.godName .. "Overlay", -- Serious Portrait, but its defined later anyway?

		--! Likely to change
		Color = params.Color or { 250, 250, 215, 255 },
		NarrativeTextColor = params.NarrativeTextColor or { 32, 32, 30, 255 },
		NameplateSpeakerNameColor = params.NameplateSpeakerNameColor or game.Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = params.NameplateDescriptionColor or { 145, 45, 90, 255 },
		LightingColor = params.LightingColor or { 1, 0.91, 0.54, 1 },
		LootColor = params.LootColor or { 255, 128, 32, 255 },
		SubtitleColor = params.SubtitleColor or { 255, 255, 205, 255 },

		LoadPackages = params.LoadPackages or {}, -- Need it for the animations for in person, maybe, idk.
		SpawnSound = params.SFX_Portrait,
		PortraitEnterSound = params.SFX_Portrait,
		UpgradeSelectedSound = params.UpgradeSelectedSound, -- These are different.

		FlavorTextIds = params.FlavorTextIds or {},

		PriorityUpgrades = params.WeaponUpgrades or {}, -- Is the same as WeaponUpgrades
		WeaponUpgrades = params.WeaponUpgrades or {},
		Traits = params.Traits or {},
		TraitIndex = {}, -- Gets populated later

		FirstSpawnVoiceLines = params.FirstSpawnVoiceLines or {},
		OnSpawnVoiceLines = params.OnSpawnVoiceLines or {},
		UpgradeMenuOpenVoiceLines = params.UpgradeMenuOpenVoiceLines or { [1] = { GlobalVoiceLines = "HeraclesBoonReactionVoiceLines" } },
		DuoPickupTextLines = params.DuoPickupTextLines or {},
		InteractTextLineSets = params.InteractTextLineSets or {
			[params.godName .. "Chat01"] = {
				Name = params.godName .. "Chat01",
				UseableOffSource = true,
				{ Cue = "", UseEventEndSound = true, Text = "Dialogue has not been implemented, using default!" },
			},
		},
		BoughtTextLines = params.BoughtTextLines or {},
		BoughtTextLinesRequirements = params.BoughtTextLinesRequirements or {},
		RejectionTextLines = params.RejectionTextLines or {},
		RejectionVoiceLines = params.RejectionVoiceLines or { [1] = { GlobalVoiceLines = "GodRejectedVoiceLines" } },
		SwapUpgradePickedVoiceLines = {
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.05,
			SuccessiveChanceToPlay = 0.33,
			UsePlayerSource = true,
			GameStateRequirements = {
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "ReplacedTraitSource" },
				},
			},
		},
		MakeUpTextLines = params.MakeUpTextLines or {},
		GiftTextLineSets = params.GiftTextLineSets or {},
		GiftGivenVoiceLines = params.GiftGivenVoiceLines or {},
		FullSuperActivatedVoiceLines = params.FullSuperActivatedVoiceLines or {},
		DeathTauntVoiceLines = params.DeathTauntVoiceLines or {},
		RarityUpgradeVoiceLines = params.RarityUpgradeVoiceLines or {},
		BlindBoxOpenedVoiceLines = params.BlindBoxOpenedVoiceLines or {},

		--! Unlikely to change, and have default values
		LootRejectedText = "Player_GodDispleased_" .. upgradeName,
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_" .. upgradeName,
		EchoLastRewardId = "EchoLastRewardBoon_" .. upgradeName,
		BackgroundAnimation = params.BackgroundAnimation or "DialogueBackground_Olympus_BoonScreen",
		GoldifyValue = params.GoldifyValue or 400,
		GoldConversionEligible = params.GoldConversionEligible or true,
		ReplaceSpecialForGoldify = params.ReplaceSpecialForGoldify or true,
		Weight = params.Weight or 10,
		NarrativeContextArtFlippable = params.NarrativeContextArtFlippable or false,
		CanReceiveGift = params.CanReceiveGift or true,
		TextLinesIgnoreQuests = params.TextLinesIgnoreQuests or true,
		UsePromptOffsetX = params.UsePromptOffsetX or 80,
		AlwaysShowDefaultUseText = params.AlwaysShowDefaultUseText or true,
		DestroyOnPickup = params.DestroyOnPickup or true,
		SelectionSound = params.SelectionSound or "/SFX/Menu Sounds/GeneralWhooshMENU",
		ConfirmSound = params.ConfirmSound or "/SFX/Menu Sounds/GodBoonChoiceConfirm",
		OnUsedFunctionArgs = params.OnUsedFunctionArgs or { PreserveContextArt = true },
		BanUnpickedBoonsEligible = params.BanUnpickedBoonsEligible or true,
		LastRewardEligible = params.LastRewardEligible or true,
		AnimOffsetZ = params.AnimOffsetZ or 80,
		LootRejectionAnimation = params.LootRejectionAnimation or "BoonDissipateA_Zeus",
		NarrativeContextArt = params.NarrativeContextArt or "DialogueBackground_Olympus",
		BoxAnimation = params.BoxAnimation or "DialogueSpeechBubbleLight",
		BoxExitAnimation = params.BoxExitAnimation or "DialogueSpeechBubbleLightOut",
		RequireUseToGift = params.RequireUseToGift or true,
		ManualRecordUse = params.ManualRecordUse or true,
		UsePromptOffsetY = params.UsePromptOffsetY or 48,
		ColorGrade = params.ColorGrade or "ZeusLightning",
		UseText = params.UseText or "UseLoot",
		OnUsedFunctionName = params.OnUsedFunctionName or "UseLoot",
		UseTextTalkAndGift = params.UseTextTalkAndGift or "UseLootAndGift",
		UseTextTalkAndSpecial = params.UseTextTalkAndSpecial or "UseLootAndSpecial",
		BlockedLootInteractionText = params.BlockedLootInteractionText or "UseLootLocked",
		UseTextTalkGiftAndSpecial = params.UseTextTalkGiftAndSpecial or "UseLootGiftAndSpecial",
		Consumables = params.Consumables or {},
		EmoteOffsetX = params.EmoteOffsetX or 30,
		EmoteOffsetY = params.EmoteOffsetY or -320,
	}

	if lowGodType == "npcgod" then
		--! Stuff for NPC Gods like Hermes
		game.LootData[upgradeName].SpecialInteractFunctionName = "SpecialInteractSalute"
		game.LootData[upgradeName].SpecialInteractGameStateRequirements = {
			{
				PathTrue = { "GameState", "UseRecord", upgradeName },
			},
		}
		game.LootData[upgradeName].SpecialInteractCooldown = 60
		game.LootData[upgradeName].GodLoot = false
		game.LootData[upgradeName].TreatAsGodLootByShops = true
		game.LootData[upgradeName].BoonInfoTitleText = "UpgradeChoiceMenu_" .. params.godName
		game.LootData[upgradeName].SurfaceShopIcon = "BoonInfoSymbol" .. params.godName .. "Icon"
		game.LootData[upgradeName].SurfaceShopText = upgradeName .. "_Store"

		if params.SpawnLikeHermes then
			game.NamedRequirementsData[upgradeName .. "Requirements"] = {
				-- unlock requirements
				{
					Path = { "GameState", "TextLinesRecord" },
					HasAll = { params.godName .. "FirstPickUp" },
				},
				{
					FunctionName = "RequiredNotInStore",
					FunctionArgs = { Name = "Shop" .. upgradeName },
				},
				{
					Path = { "CurrentRun", "BiomeUseRecord" },
					HasNone = { upgradeName, "Shop" .. upgradeName },
				},
				{
					Path = { "CurrentRun", "LootTypeHistory", upgradeName },
					Comparison = "<=",
					Value = 1,
				},
			}

			local insertRewards = {
				Name = upgradeName,
				GameStateRequirements = {
					NamedRequirements = { upgradeName .. "Requirements" },
				},
			}

			table.insert(game.RewardStoreData.HubRewards, insertRewards)
			table.insert(game.RewardStoreData.RunProgress, insertRewards)

			game.ConsumableData["Shop" .. upgradeName] = {
				UsePromptOffsetX = 65,
				UsePromptOffsetY = 0,
				DebugOnly = false,
				CanDuplicate = true,
				ResourceCosts = {
					Money = 150,
				},
				UseText = "UsePurchaseLoot",
				UseFunctionName = "rom.mods." .. _PLUGIN.guid .. ".Create" .. params.godName .. "Loot",
				SurfaceShopText = upgradeName .. "_Store",
				SurfaceShopIcon = upgradeName .. "Shop",
				GameStateRequirements = {
					{
						Path = { "CurrentRun", "BiomeUseRecord" },
						HasNone = { upgradeName, upgradeName .. "Shop" },
					},
					{
						Path = { "CurrentRun", "LootTypeHistory", upgradeName },
						Comparison = "<=",
						Value = 1,
					},
				},
			}

			table.insert(game.StoreData.SurfaceShop.GroupsOf[2].OptionsData, { Name = "Shop" .. upgradeName })
			table.insert(game.StoreData.WorldShop.GroupsOf[1].OptionsData, { Name = "Shop" .. upgradeName })
			table.insert(game.StoreData.I_WorldShop.GroupsOf[4].OptionsData, { Name = "Shop" .. upgradeName, Cost = 500, UpgradeChance = 1.0, UpgradedCost = 500, ReplaceRequirements = nil })
			table.insert(game.StoreData.Q_WorldShop.GroupsOf[3].OptionsData, { Name = "Shop" .. upgradeName, Cost = 500, UpgradeChance = 1.0, UpgradedCost = 500, ReplaceRequirements = nil })

			mod["Create" .. params.godName .. "Loot"] = function(args)
				args = args or {}
				return CreateLoot(MergeTables(args, { Name = upgradeName, AutoLoadPackages = true }))
			end

			modutil.mod.Path.Wrap("SpawnStoreItemInWorld", function(base, itemData, kitId)
				if not itemData then
					return
				end
				local spawnedItem = nil
				if itemData.Name == "Shop" .. upgradeName then
					local boonRarities = itemData.BoonRaritiesOverride
					if not boonRarities and itemData.Args then
						boonRarities = itemData.Args.BoonRaritiesOverride
					end
					spawnedItem = mod["Create" .. params.godName .. "Loot"]({
						SpawnPoint = kitId,
						ResourceCosts = itemData.ResourceCosts or GetProcessedValue(ConsumableData[itemData.Name].ResourceCosts),
						DoesNotBlockExit = true,
						SuppressSpawnSounds = true,
						BoughtFromShop = true,
						AddBoostedAnimation = itemData.AddBoostedAnimation,
						BoonRaritiesOverride = itemData.BoonRaritiesOverride,
					})
					spawnedItem.CanReceiveGift = false
					SetThingProperty({ Property = "SortBoundsScale", Value = 1.0, DestinationId = kitId })
				end
				if spawnedItem ~= nil then
					MapState.RewardPointsUsed[kitId] = spawnedItem.ObjectId
					spawnedItem.SpawnPointId = kitId
					if not itemData.PendingShopItem and not itemData.ZagContractItem then
						SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = spawnedItem.ObjectId })
						spawnedItem.UseText = spawnedItem.PurchaseText or "Shop_UseText"
						spawnedItem.IconPath = spawnedItem.TextIconPath or spawnedItem.IconPath
						table.insert(CurrentRun.CurrentRoom.Store.SpawnedStoreItems, { KitId = kitId, ObjectId = spawnedItem.ObjectId, OriginalResourceCosts = spawnedItem.BaseResourceCosts, ResourceCosts = spawnedItem.ResourceCosts })
					else
						MapState.SurfaceShopItems = MapState.SurfaceShopItems or {}
						table.insert(MapState.SurfaceShopItems, spawnedItem.Name)
					end
					return spawnedItem
				end
				return base(itemData, kitId)
			end)
		end
	end

	registerEntityData(params.godName, lowGodType, game.LootData[upgradeName])
end

function public.CreateOlympianSJSONData(params)
	local requiredFields = { "pluginGUID", "godName", "godType", "iconSpinPath", "previewPath", "colorA", "colorB", "colorC" }
	if params and not params.skipBoonSelectSymbol then
		table.insert(requiredFields, "boonSelectSymbolPath")
	end -- doesnt really matter if i do it like this

	if not validateParams(params, requiredFields, "CreateOlympianSJSONData") then
		return nil
	end
	local pluginGUID = params.pluginGUID

	--* The actual boon drop
	local godUpgrade = sjson.to_object({
		Name = params.godName .. "Upgrade",
		InheritFrom = "BaseBoon",
		DisplayInEditor = true,
		Thing = {
			EditorOutlineDrawBounds = false,
			Graphic = "BoonDrop" .. params.godName,
			AmbientSound = params.AmbientSound,
		},
	}, GameplayOrder)

	sjson.hook(GameplayFile, function(data)
		table.insert(data.Obstacles, godUpgrade)
	end)

	--* The Boon Colours/Animations
	local boonDropConfigs = {
		["BoonDrop" .. params.godName] = {
			InheritFrom = "BoonDropGold",
			ChildAnimation = "BoonDropA-" .. params.godName,
		},
		["BoonDropA-" .. params.godName] = { -- This one is outer field, IDK why they did it this way, but I will assign colourB to it instead.
			InheritFrom = "BoonDropA",
			ChildAnimation = "BoonDropB-" .. params.godName,
			Color = params.colorB,
			CreateAnimations = { {
				Name = "BoonDropBackGlow",
			}, {
				Name = "BoonDropFrontFlare",
			} },
		},
		["BoonDropB-" .. params.godName] = {
			InheritFrom = "BoonDropB",
			ChildAnimation = "BoonDropC-" .. params.godName,
			Color = params.colorA,
			CreateAnimations = { {
				Name = "BoonDropBackGlow",
			}, {
				Name = "BoonDropFrontFlare",
			} },
		},
		["BoonDropC-" .. params.godName] = {
			InheritFrom = "BoonDropC",
			ChildAnimation = "BoonDrop" .. params.godName .. "Icon",
			Color = params.colorC,
			CreateAnimations = { {
				Name = "BoonDropBackGlow",
			}, {
				Name = "BoonDropFrontFlare",
			} },
		},
		["BoonDrop" .. params.godName .. "Preview"] = {
			InheritFrom = "BoonDropRoomRewardIconPreviewBase",
			FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.previewPath)),
			OffsetZ = params.OffsetZBoonPreview or 0,
			Scale = params.BoonPreviewScale,
			ColorFromOwner = "Maintain",
			AngleFromOwner = "Ignore",
			Sound = params.AmbientSound,
		},
		["BoonDrop" .. params.godName .. "UpgradedPreview"] = {
			InheritFrom = "BoonDrop" .. params.godName .. "Preview",
			ChildAnimation = "BoonUpgradedPreviewSparkles",
		},
	}

	if not params.boonDropIconCustomFrames then
		boonDropConfigs["BoonDrop" .. params.godName .. "Icon"] = {
			InheritFrom = "BoonDropIcon",
			FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.iconSpinPath)),
			OffsetZ = params.OffsetZBoonDrop,
			Scale = params.BoonDropIconScale,
			Hue = params.BoonDropIconHue,
		}
	else
		--can do math.max for the frames but meh
		boonDropConfigs["BoonDrop" .. params.godName .. "Icon"] = {
			InheritFrom = "BoonDropIcon", -- Still inherit from base BoonDropIcon, otherwise, stackoverflow magically.
			FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.iconSpinPath)),
			OffsetZ = params.OffsetZBoonDrop,
			Scale = params.BoonDropIconScale,
			Hue = params.BoonDropIconHue,

			EndFrame = params.boonDropIconCustomFrames.EndFrame or 50,
			NumFrames = params.boonDropIconCustomFrames.NumFrames or 50,
			PlaySpeed = params.boonDropIconCustomFrames.PlaySpeed or 30,
		}
	end

	local boonVFXobj = {}
	for name, config in pairs(boonDropConfigs) do
		local object = sjson.to_object({
			Name = name,
			InheritFrom = config.InheritFrom,
			ChildAnimation = config.ChildAnimation,
			CreateAnimations = config.CreateAnimations,
			Color = config.Color,
			FilePath = config.FilePath,
			OffsetZ = config.OffsetZ,
			Scale = config.Scale,
			Hue = config.Hue,
			EndFrame = config.EndFrame,
			NumFrames = config.NumFrames,
			PlaySpeed = config.PlaySpeed,
			ColorFromOwner = config.ColorFromOwner,
			AngleFromOwner = config.AngleFromOwner,
			Sound = config.Sound,
		}, VFXMainOrder)
		table.insert(boonVFXobj, object)
	end

	sjson.hook(ItemsGeneralVFX, function(data)
		for _, object in ipairs(boonVFXobj) do
			table.insert(data.Animations, object)
		end
	end)

	--* Visuals on doors/boon select
	local boonInfoConfigs = {}
	boonInfoConfigs["BoonInfoSymbol" .. params.godName .. "Icon"] = {
		InheritFrom = "BoonInfoSymbolBase",
		FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.previewPath)),
	}

	if not params.skipBoonSelectSymbol then
		boonInfoConfigs["BoonSymbol" .. params.godName] = {
			InheritFrom = "BoonSymbolBase",
			FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.boonSelectSymbolPath)),
			Scale = 1,
			OffsetY = params.boonSelectSymbolOffsetY or 0,
		}
	end

	local boonInfoObjects = {}
	for name, config in pairs(boonInfoConfigs) do
		local object = sjson.to_object({
			Name = name,
			InheritFrom = config.InheritFrom,
			FilePath = config.FilePath,
			Scale = config.Scale,
			OffsetY = config.OffsetY,
		}, IconOrder)
		table.insert(boonInfoObjects, object)
	end

	sjson.hook(GUIScreensVFXFile, function(data)
		for _, object in ipairs(boonInfoObjects) do
			table.insert(data.Animations, object)
		end
	end)

	--* Macro texts
	local macrosText = {
		["Player_GodDispleased_" .. params.godName .. "Upgrade"] = {
			DisplayName = params.godName .. " Grew Displeased!",
		},
		["SuperSacrifice_CombatText_" .. params.godName .. "Upgrade"] = {
			DisplayName = "{#CombatTextHighlightFormat}Boons of " .. params.godName .. " {#Prev}{#UpgradeFormat}+{$TempTextData.Amount}{#Prev}{!Icons.PomLevel}!",
		},
		["EchoLastRewardBoon_" .. params.godName .. "Upgrade"] = {
			InheritFrom = "BaseBoon",
			DisplayName = "Manifest a copy of your most recently claimed {#ItalicFormat}Reward: {#Prev}{#BoldFormat}{$Keywords.GodBoon} of " .. params.godName,
		},
		["UpgradeChoiceMenu_Title_" .. params.godName .. "Upgrade"] = {
			DisplayName = "Boons of " .. params.godName,
		},
	}

	local macrosTextobj = {}
	for id, config in pairs(macrosText) do
		local object = sjson.to_object({
			Id = id,
			DisplayName = config.DisplayName,
			InheritFrom = config.InheritFrom,
		}, TextOrder)
		table.insert(macrosTextobj, object)
	end

	sjson.hook(MacroTextFile, function(data)
		for _, object in ipairs(macrosTextobj) do
			table.insert(data.Texts, object)
		end
	end)

	local screenTexts = {
		["UpgradeChoiceMenu_" .. params.godName] = {
			DisplayName = "Boons of " .. params.godName,
		},
		[params.godName .. "Upgrade"] = {
			DisplayName = params.godName,
			Description = params.godDescriptionText,
		},
		[params.godName .. "Upgrade_FlavorText01"] = {
			DisplayName = params.godDescriptionTextFlavour01,
		},
		[params.godName .. "Upgrade_FlavorText02"] = {
			DisplayName = params.godDescriptionTextFlavour02,
		},
		[params.godName .. "Upgrade_FlavorText03"] = {
			DisplayName = params.godDescriptionTextFlavour03,
		},
	}

	local screenTextsobj = {}
	for id, config in pairs(screenTexts) do
		local object = sjson.to_object({
			Id = id,
			DisplayName = config.DisplayName,
			Description = config.Description,
		}, TextOrder)
		table.insert(screenTextsobj, object)
	end

	sjson.hook(ScreenText, function(data)
		for _, object in ipairs(screenTextsobj) do
			table.insert(data.Texts, object)
		end
	end)

	local testing = sjson.to_object({
		Id = "NPC_" .. params.godName .. "_01",
		DisplayName = params.godName,
		Description = params.godDescriptionText,
	}, TextOrder)

	sjson.hook(HelpTextFile, function(data)
		table.insert(data.Texts, testing)
	end)

	if string.lower(params.godType) == "npcgod" then
		local configs = {
			[params.godName .. "UpgradePreview"] = {
				InheritFrom = "BoonSymbolBaseIsometric",
				FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.previewPath)),
			},
			[params.godName .. "UpgradeShop"] = {
				InheritFrom = params.godName .. "UpgradePreview",
				Duration = 0,
				StartOffsetZ = 0,
				EndOffsetZ = 0,
				PingPongShiftOverDuration = false,
				Sound = null,
			},
		}

		local vfxObjects = {}
		for name, config in pairs(configs) do
			local object = sjson.to_object({
				Name = name,
				InheritFrom = config.InheritFrom,
				FilePath = config.FilePath,
				Duration = config.Duration,
				StartOffsetZ = config.StartOffsetZ,
				EndOffsetZ = config.EndOffsetZ,
				PingPongShiftOverDuration = config.PingPongShiftOverDuration,
				Sound = config.Sound,
			}, VFXMainOrder)
			table.insert(vfxObjects, object)
		end

		sjson.hook(ItemsGeneralVFX, function(data)
			for _, object in ipairs(vfxObjects) do
				table.insert(data.Animations, object)
			end
		end)

		local upgradeStore = sjson.to_object({
			Id = params.godName .. "Upgrade_Store",
			DisplayName = "Boon of " .. params.godName,
			Description = "Receive your choice of {#BoldFormat}1 {#Prev}out of {$ScreenData.UpgradeChoice.MaxChoices} {$Keywords.GodBoonPlural} from {#BoldFormat}" .. params.godName .. "{#Prev}.",
		}, TextOrder)

		sjson.hook(TraitTextFile, function(data)
			table.insert(data.Texts, upgradeStore)
		end)
	end

	--! Portraits
	if params.portraitData then
		--! I have no idea what some of these do lmao.
		local portraitConfigs = {}
		if not params.portraitData.skipNeutralPortrait then
			portraitConfigs["Portrait_" .. params.godName .. "_Default_01"] = {
				InheritFrom = "Portrait_God_01",
				FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.portraitData.NeutralPortraitFilePath or "")),
				ChildAnimation = "PortraitGodRayEmitter_Athena",
				EndFrame = 1,
				StartFrame = 1,
				OffsetX = params.portraitData.OffsetX,
				OffsetY = params.portraitData.OffsetY,
				Scale = params.portraitData.Scale,
				CreateAnimation = "OlympianDialogueEntrance_" .. params.godName,
				CreateAnimations = params.portraitData.NeutralAnimations or {}, -- This is... blinking, and stuff - which you see in a gods Package.
			}
		end

		portraitConfigs["Portrait_" .. params.godName .. "_Default_01_Exit"] = {
			InheritFrom = "Portrait_God_01_Exit",
			FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.portraitData.NeutralPortraitFilePath or "")),
			EndFrame = 1,
			StartFrame = 1,
			Sound = "/Leftovers/World Sounds/MapZoomInShortHigh",
		}

		portraitConfigs["Portrait_" .. params.godName .. "_Default_01_Wrath"] = {
			InheritFrom = "Portrait_God_01_Wrath",
			FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.portraitData.NeutralPortraitFilePath or "")),
			EndFrame = 1,
			StartFrame = 1,
		}

		portraitConfigs["Portrait_" .. params.godName .. "_Displeased_01"] = {
			InheritFrom = "Portrait_" .. params.godName .. "_Default_01",
			FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.portraitData.AnnoyedPortraitFilePath or "")),
		}

		portraitConfigs["Portrait_" .. params.godName .. "_Serious_01"] = {
			InheritFrom = "Portrait_" .. params.godName .. "_Default_01",
			FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.portraitData.SeriousPortraitFilePath or "")),
		}

		portraitConfigs["Portrait_" .. params.godName .. "_Serious_01_Exit"] = {
			InheritFrom = "Portrait_" .. params.godName .. "_Default_01_Exit",
			FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.portraitData.SeriousPortraitFilePath or "")),
		}

		if params.portraitData.DialogueAnimations then
			portraitConfigs["OlympianDialogueEntrance_" .. params.godName] = {
				InheritFrom = "OlympianDialogueEntrance_Base",
				StartRed = params.portraitData.DialogueAnimations.DialogueEntrance.RedStart,
				StartGreen = params.portraitData.DialogueAnimations.DialogueEntrance.GreenStart,
				StartBlue = params.portraitData.DialogueAnimations.DialogueEntrance.BlueStart,
				EndRed = params.portraitData.DialogueAnimations.DialogueEntrance.RedEnd,
				EndGreen = params.portraitData.DialogueAnimations.DialogueEntrance.GreenEnd,
				EndBlue = params.portraitData.DialogueAnimations.DialogueEntrance.BlueEnd,
				CreateAnimations = {},
			}

			portraitConfigs["OlympianDialogueEntranceStreaks_" .. params.godName] = {
				InheritFrom = "OlympianDialogueEntranceStreaks_Base",
				StartRed = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.RedStart,
				StartGreen = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.GreenStart,
				StartBlue = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.BlueStart,
				EndRed = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.RedEnd,
				EndGreen = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.GreenEnd,
				EndBlue = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.BlueEnd,
				VisualFx = "OlympianDialogueEntranceParticle_" .. params.godName,
			}

			portraitConfigs["OlympianDialogueEntranceParticle_" .. params.godName] = {
				InheritFrom = "OlympianDialogueEntranceParticles_Base",
				StartRed = params.portraitData.DialogueAnimations.DialogueEntranceParticles.RedStart,
				StartGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticles.GreenStart,
				StartBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticles.BlueStart,
				EndRed = params.portraitData.DialogueAnimations.DialogueEntranceParticles.RedEnd,
				EndGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticles.GreenEnd,
				EndBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticles.BlueEnd,
			}

			portraitConfigs["OlympianDialogueEntranceParticleBurst_" .. params.godName] = {
				InheritFrom = "OlympianDialogueEntranceParticleBurst_Base",
				StartRed = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedStart,
				StartGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenStart,
				StartBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueStart,
				EndRed = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedEnd,
				EndGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenEnd,
				EndBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueEnd,
			}

			portraitConfigs["OlympianDialogueEntranceParticleBurst_" .. params.godName .. "_Flip"] = {
				InheritFrom = "OlympianDialogueEntranceParticleBurst_Base_Flip",
				StartRed = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedStart,
				StartGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenStart,
				StartBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueStart,
				EndRed = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedEnd,
				EndGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenEnd,
				EndBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueEnd,
			}

			if params.portraitData.DialogueAnimations.DialogueEntranceStreaks then
				table.insert(portraitConfigs["OlympianDialogueEntrance_" .. params.godName].CreateAnimations, { Name = "OlympianDialogueEntranceStreaks_" .. params.godName })
			elseif params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst then
				table.insert(portraitConfigs["OlympianDialogueEntrance_" .. params.godName].CreateAnimations, { Name = "OlympianDialogueEntranceParticleBurst_" .. params.godName })
				table.insert(portraitConfigs["OlympianDialogueEntrance_" .. params.godName].CreateAnimations, { Name = "OlympianDialogueEntranceParticleBurst_" .. params.godName .. "_Flip" })
			end
		end

		local portraitObj = {}
		for name, config in pairs(portraitConfigs) do
			local object = sjson.to_object({
				Name = name,
				InheritFrom = config.InheritFrom,
				FilePath = config.FilePath,
				ChildAnimation = config.ChildAnimation,
				EndFrame = config.EndFrame,
				StartFrame = config.StartFrame,
				OffsetX = config.OffsetX,
				OffsetY = config.OffsetY,
				Scale = config.Scale,
				CreateAnimation = config.CreateAnimation,
				CreateAnimations = config.CreateAnimations,
				Sound = config.Sound,
				StartRed = config.StartRed,
				StartGreen = config.StartGreen,
				StartBlue = config.StartBlue,
				EndRed = config.EndRed,
				EndGreen = config.EndGreen,
				EndBlue = config.EndBlue,
				VisualFx = config.VisualFx,
			}, PortraitOrder)
			table.insert(portraitObj, object)
		end

		sjson.hook(PortraitFile, function(data)
			for _, object in ipairs(portraitObj) do
				table.insert(data.Animations, object)
			end
		end)
	end
end

--[[
basically, get a god name for gift data, else, pluginGUID.name = whatever
then do the entire keepsake, see like wtf is up with all the gaw damn trait texts and stuff, and make sure i can pass in custom stuff
then sjson
--]]
function public.CreateKeepsake(params)
	if not validateParams(params, { "pluginGUID", "characterName", "internalKeepsakeName", "RarityLevels", "Keepsake" }, "CreateKeepsake") then
		return nil
	end

	local pluginGUID = params.pluginGUID

	game.TraitData[params.internalKeepsakeName] = {
		Icon = params.internalKeepsakeName, --! req
		Name = params.internalKeepsakeName,

		ShowInHUD = true,
		Ordered = true,
		HUDScale = params.HUDScale or 0.435, --? Opt
		PriorityDisplay = true,
		ChamberThresholds = { 25, 50 },
		HideInRunHistory = true,
		Slot = "Keepsake",
		InfoBackingAnimation = "KeepsakeSlotBase",
		RecordCacheOnEquip = true,
		TraitOrderingValueCache = -1,
		ActiveSlotOffsetIndex = 0,

		TrayTextBackingAnimation = "TraitTray_LevelBacking_Alt",
		TrayTextBackingOffsetY = 9,
		TrayTextOffsetY = -10,
		NewTraitHighlightAnimation = "NewTraitHighlightKeepsake",
		PinAnimationIn = "TraitPinIn_Keepsake",
		PinAnimationOut = "TraitPinOut_Keepsake",
		TrayHighlightAnimScale = 1.2,
		PreCreateActiveOverlay = true,

		FrameRarities = {
			Common = "Frame_Keepsake_Rank1",
			Rare = "Frame_Keepsake_Rank2",
			Epic = "Frame_Keepsake_Rank3",
			Heroic = "Frame_Keepsake_Rank4",
		},

		CustomRarityLevels = {
			"TraitLevel_Keepsake1",
			"TraitLevel_Keepsake2",
			"TraitLevel_Keepsake3",
			"TraitLevel_Keepsake4",
		},

		--* Then whatever they wanna add
		RarityLevels = { -- !req
			Common = { Multiplier = params.RarityLevels.Common },
			Rare = { Multiplier = params.RarityLevels.Rare },
			Epic = { Multiplier = params.RarityLevels.Epic },
			Heroic = { Multiplier = params.RarityLevels.Heroic },
		},

		EquipSound = params.EquipSound, --? Opt
		EquipVoiceLines = params.EquipVoiceLines, -- table --? Opt

		--* like, just say they can pass wahtever, or else ill be here foreve
		-- SpeakerNames = params.SpeakerNames, -- table --? Opt
		-- BlockedByEnding = params.BlockedByEnding, -- this is like... if the god would be fighting typhon? or what.  --? Opt

		-- find out
		CustomTrayText = "SisyphusVanillaKeepsake_Tray", -- When you equip it
		ZeroBonusTrayText = params.internalKeepsakeName .. "_Expired",
		--???
		-- InRackTitle = params.internalKeepsakeName .. "_Rack", -- Literally! Unused! Why!
		-- UnequippedKeepsakeTitle = params.internalKeepsakeName .. "_Rack", -- ? Also no reason.
		-- CustomTrayNameWhileDead = params.internalKeepsakeName, --? There is literally no reason to do this though.
	}

	--? IDK!!!!
	-- * document the if GodLoot, else do params (basically, if god exists, dev do nothing, otherwise, smile.)
	-- if params.createGiftData then
	--     if params.characterName then

	--[[
    really ugly code, but if god exists, do gift text lines for max gift, otherwise, user args for what is max and min req.
    ]]
	if game.LootData[params.characterName .. "Upgrade"] then
		local lootGiftPath = game.LootData[params.characterName .. "Upgrade"].GiftTextLineSets
		game.GiftData[params.characterName .. "Upgrade"] = {
			InheritFrom = { "DefaultGiftData" },
			MaxedRequirement = {
				{
					PathTrue = { "GameState", "TextLinesRecord", lootGiftPath[#lootGiftPath] },
				},
			},
			MaxedIcon = "Keepsake_" .. params.characterName .. "_Corner",
			MaxedSticker = "Keepsake_" .. params.characterName,
			[1] = {
				GameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", game.LootData[params.characterName .. "Upgrade"][1] },
					},
				},
				Gift = params.internalKeepsakeName,
			},
		}
		game.TraitData[params.internalKeepsakeName].SignOffData = {
			{
				GameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", lootGiftPath[#lootGiftPath] },
					},
				},
				Text = "Signoff" .. params.characterName .. "_Max",
			},
			{
				Text = "Signoff" .. params.characterName,
			},
		}
	else
		game.GiftData[params.characterName .. "Upgrade"] = {
			InheritFrom = { "DefaultGiftData" },
			MaxedRequirement = params.maxRequirement,
			MaxedIcon = "Keepsake_" .. params.characterName .. "_Corner",
			MaxedSticker = "Keepsake_" .. params.characterName,
			[1] = {
				GameStateRequirements = params.minRequirement,
				Gift = params.internalKeepsakeName,
			},
		}
		game.TraitData[params.internalKeepsakeName].SignOffData = {
			{
				GameStateRequirements = params.maxRequirement,
				Text = "Signoff" .. params.characterName .. "_Max",
			},
			{
				Text = "Signoff" .. params.characterName,
			},
		}
	end

	if params.ExtraFields then
		for k, v in pairs(params.ExtraFields) do
			game.TraitData[params.internalKeepsakeName][k] = v
		end
	end

	table.insert(game.ScreenData.KeepsakeRack.ItemOrder, params.internalKeepsakeName)

	-- SJSON stuff now
	local textsins = {}
	local vfxins = {}

	if params.Keepsake then
		textsins[params.internalKeepsakeName] = {
			InheritFrom = "BaseBoonMultiline",
			DisplayName = params.Keepsake.displayName,
			Description = params.Keepsake.description,
		}

		if params.Keepsake.trayDescription then
			textsins[params.internalKeepsakeName .. "_Tray"] = {
				InheritFrom = params.internalKeepsakeName,
				Description = params.Keepsake.trayDescription,
			}
		end

		if params.Keepsake.trayExpired then
			textsins[params.internalKeepsakeName .. "_Expired"] = {
				InheritFrom = params.internalKeepsakeName,
				Description = params.Keepsake.trayExpired,
			}
		end
	end

	textsins["Signoff" .. params.characterName] = {
		DisplayName = "From " .. params.characterName,
	}

	textsins["Signoff" .. params.characterName .. "_Max"] = {
		DisplayName = params.Keepsake.signoffMax or ("Max Friendship Signoff not implemented for " .. params.characterName),
	}

	if params.Icons then
		vfxins[params.internalKeepsakeName] = {
			InheritFrom = "KeepsakeIcon",
			FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.Icons.iconPath)),
		}

		if params.Icons.maxIcon then
			vfxins["Keepsake_" .. params.characterName] = {
				InheritFrom = "KeepsakeMax",
				FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.Icons.maxIcon)),
			}
		end

		if params.Icons.maxCornerIcon then
			vfxins["Keepsake_" .. params.characterName .. "_Corner"] = {
				InheritFrom = "KeepsakeMax_Corner",
				FilePath = rom.path.combine(pluginGUID, cleanFilePath(pluginGUID, params.Icons.maxCornerIcon)),
			}
		end
	end

	local textObjects = {}
	for id, config in pairs(textsins) do
		local object = sjson.to_object({
			Id = id,
			InheritFrom = config.InheritFrom,
			DisplayName = config.DisplayName,
			Description = config.Description,
		}, TextOrder)
		table.insert(textObjects, object)
	end

	local vfxObjects = {}
	for name, config in pairs(vfxins) do
		local object = sjson.to_object({
			Name = name,
			InheritFrom = config.InheritFrom,
			FilePath = config.FilePath,
		}, IconOrder)
		table.insert(vfxObjects, object)
	end

	if #textObjects > 0 then
		sjson.hook(TraitTextFile, function(data)
			for _, object in ipairs(textObjects) do
				table.insert(data.Texts, object)
			end
		end)
	end

	if #vfxObjects > 0 then
		sjson.hook(GUIBoonsVFXFile, function(data)
			for _, object in ipairs(vfxObjects) do
				table.insert(data.Animations, object)
			end
		end)
	end
end

-- Extra func for testing or function checsk
function public.IsGodRegistered(godName, debug)
	if debug then
		local isRegistered = game.LootData[godName .. "Upgrade"] ~= nil
		rom.log.warning("IsGodRegistered: " .. godName .. " = " .. tostring(isRegistered))
		return isRegistered
	end

	return game.LootData[godName .. "Upgrade"] ~= nil
end

function public.IsKeepsakeRegistered(internalKeepsakeName, debug)
	if debug then
		local isRegistered = game.TraitData[internalKeepsakeName] ~= nil
		rom.log.warning("IsKeepsakeRegistered: " .. internalKeepsakeName .. " = " .. tostring(isRegistered))
		return isRegistered
	end

	return game.TraitData[internalKeepsakeName] ~= nil
end

modutil.once_loaded.game(function()
	mod = modutil.mod.Mod.Register(_PLUGIN.guid)
end)

--! bons in core still go invis idk why
--TODO More ReadME stuff
--TODO look at defs
--TODO Traits
