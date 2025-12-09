-- TODO, add info to run end
-- TODO, Damage Meter info PR

---@diagnostic disable: undefined-global
---@meta _

local mods = rom.mods
envy = mods["SGG_Modding-ENVY"].auto()
rom = rom
_PLUGIN = PLUGIN
game = rom.game
modutil = mods["SGG_Modding-ModUtil"]
sjson = mods["SGG_Modding-SJSON"]

import_as_fallback(rom.game)

local definitions = {}

--region SJSON defs
local GameplayFile = rom.path.combine(rom.paths.Content, "Game/Obstacles/Gameplay.sjson")
local MacroTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/MacroText.en.sjson")
local GUIScreensVFXFile = rom.path.combine(rom.paths.Content, "Game/Animations/GUI_Screens_VFX.sjson")
local ItemsGeneralVFX = rom.path.combine(rom.paths.Content, "Game/Animations/Items_General_VFX.sjson")
local ScreenText = rom.path.combine(rom.paths.Content, "Game/Text/en/ScreenText.en.sjson")
local TraitTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/TraitText.en.sjson")
local PortraitFile = rom.path.combine(rom.paths.Content, "Game/Animations/GUI_Portraits_VFX.sjson")
local GUIBoonsVFXFile = rom.path.combine(rom.paths.Content, "Game/Animations/GUI_Boons_VFX.sjson")
local HelpTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/HelpText.en.sjson")
local CodexTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/CodexText.en.sjson")

local Order = {
	"Id",
	"Name",
	"InheritFrom",
	"DisplayName",
	"Description",
	"DisplayInEditor",
	"Thing",
	"ChildAnimation",
	"CreateAnimation",
	"CreateAnimations",
	"Color",
	"FilePath",
	"OffsetX",
	"OffsetY",
	"OffsetZ",
	"Scale",
	"Hue",
	"StartFrame",
	"EndFrame",
	"NumFrames",
	"PlaySpeed",
	"ColorFromOwner",
	"AngleFromOwner",
	"Sound",
	"StartRed",
	"StartGreen",
	"StartBlue",
	"EndRed",
	"EndGreen",
	"EndBlue",
	"VisualFx",
	"Duration",
	"StartOffsetZ",
	"EndOffsetZ",
	"PingPongShiftOverDuration",
	"AmbientSound",
	"Graphic",
	"EditorOutlineDrawBounds",
}
--#endregion

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

local function cleanFilePath(pluginGUID, filePath, useBasePath)
	if useBasePath then
		return filePath
	end

	local parts = {}
	for part in filePath:gmatch("[^/\\]+") do
		table.insert(parts, part)
	end
	if parts[1] == pluginGUID then
		return filePath
	end

	return rom.path.combine(pluginGUID, filePath)
end

local function validateParams(params, requiredFields, context)
	if not params then
		rom.log.error(context .. ": Missing parameter 'params'")
		return false
	end

	for _, field in ipairs(requiredFields) do
		if params[field] == nil then
			rom.log.error(context .. ": Missing required parameter '" .. field .. "'")
			return false
		end
	end

	return true
end

local function codexReg(env, params, upgradeName, lowGodType)
	if params.skipCodex then
		return
	end
	local godName = env._PLUGIN.guid .. "-" .. params.godName

	game.CodexData.OlympianGods.Entries[upgradeName] = {
		Entries = {
			{
				UnlockGameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", godName .. "Gift01" },
					},
				},
				Text = "CodexData_" .. godName .. "_01",
			},
		},
		Image = "Codex_Portrait_" .. godName,
		BoonInfoAllowPinning = true,
		NoRequirements = lowGodType == "npcgod",
	}

	if params.extraCodexEntry then
		local entry = {
			UnlockGameStateRequirements = {
				params.extraCodexEntry.UnlockGameStateRequirements,
			},
			Text = "CodexData_" .. godName .. "_02",
		}
		table.insert(game.CodexData.OlympianGods.Entries[upgradeName].Entries, entry)
	end

	if params.codexData then
		local cData = {}

		if params.codexData.baseDescription then
			local codexText1 = sjson.to_object({
				Id = "CodexData_" .. godName .. "_01",
				InheritFrom = "BaseCodexEntry",
				DisplayName = params.codexData.baseDescription,
			}, Order)
			table.insert(cData, codexText1)
		end

		if params.codexData.secondDescription then
			local codexText2 = sjson.to_object({
				Id = "CodexData_" .. godName .. "_02",
				InheritFrom = "BaseCodexEntry",
				DisplayName = params.codexData.secondDescription,
			}, Order)
			table.insert(cData, codexText2)
		end

		if #cData > 0 then
			sjson.hook(CodexTextFile, function(data)
				for _, object in ipairs(cData) do
					table.insert(data.Texts, object)
				end
			end)
		end

		if params.codexData.imageData then
			local imageins = sjson.to_object({
				Name = "Codex_Portrait_" .. godName,
				InheritFrom = "Codex_Portrait_Base_01",
				FilePath = cleanFilePath(env._PLUGIN.guid, params.codexData.imageData.imagePath),
				OffsetY = params.codexData.imageData.OffsetY,
				OffsetZ = params.codexData.imageData.OffsetZ,
				Scale = params.codexData.imageData.Scale,
				EndFrame = 1,
				StartFrame = 1,
			}, Order)

			sjson.hook(GUIScreensVFXFile, function(data)
				table.insert(data.Animations, imageins)
			end)
		end
	end

	table.insert(game.CodexOrdering.OlympianGods, upgradeName)
end

-- Gods like Zeus/Ares/etc or NPC Gods like Hermes.
function definitions.InitializeGod(env, params)
	if not validateParams(params, { "godName", "godType" }, "InitializeGod") then
		return nil
	end

	local upgradeName = env._PLUGIN.guid .. "-" .. params.godName .. "Upgrade"
	local godName = env._PLUGIN.guid .. "-" .. params.godName
	local lowGodType = string.lower(params.godType)

	if game.LootData[upgradeName] then
		rom.log.warning(params.godName .. " is already registered, skipping creation.")
		return
	end

	game.LootData[upgradeName] = {
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		Name = upgradeName,
		Speaker = "NPC_" .. godName .. "_01",
		SpeakerName = godName,
		Gender = params.Gender or "X",
		GodLoot = true,
		TreatAsGodLootByShops = nil,
		GameStateRequirements = params.GameStateRequirements or {},

		BoonInfoIcon = "BoonInfoSymbol" .. godName .. "Icon",
		DoorIcon = "BoonDrop" .. godName .. "Preview",
		DoorUpgradedIcon = "BoonDrop" .. godName .. "UpgradedPreview",
		Icon = "BoonSymbol" .. godName,
		MenuTitle = "UpgradeChoiceMenu_Title_" .. upgradeName,
		BoonInfoTitleText = "UpgradeChoiceMenu_" .. godName,
		-- SurfaceShopIcon = "BoonInfoSymbol" .. godName .. "Icon",
		-- SurfaceShopText = upgradeName .. "_Store",

		--! Portraits
		Portrait = "Portrait_" .. godName .. "_Default_01", -- Default Portrait
		WrathPortrait = "Portrait_" .. godName .. "_Default_01_Wrath", -- Wrath Portrait
		OverlayAnim = godName .. "Overlay", -- Serious Portrait, but its defined later anyway?

		--! Likely to change
		Color = params.Color or { 250, 250, 215, 255 },
		NarrativeTextColor = params.NarrativeTextColor or { 32, 32, 30, 255 },
		NameplateSpeakerNameColor = params.NameplateSpeakerNameColor or game.Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = params.NameplateDescriptionColor or { 145, 45, 90, 255 },
		LightingColor = params.LightingColor or { 1, 0.91, 0.54, 1 },
		LootColor = params.LootColor or { 255, 128, 32, 255 },
		SubtitleColor = params.SubtitleColor or { 255, 255, 205, 255 },

		LoadPackages = params.LoadPackages or {}, -- Need it for the animations for in person, maybe, idk.
		FlavorTextIds = params.FlavourTextIds or {},
		SpawnSound = params.SFX_Portrait,
		PortraitEnterSound = params.SFX_Portrait,
		UpgradeSelectedSound = params.UpgradeSelectedSound, -- These are different.
		PriorityUpgrades = params.WeaponUpgrades or {}, -- Is the same as WeaponUpgrades
		WeaponUpgrades = params.WeaponUpgrades or {},
		Traits = params.Traits or {},
		-- TraitSortOrder = params.TraitSortOrder or {}, -- Gets populated later.
		TraitIndex = {}, -- Gets populated later

		FirstSpawnVoiceLines = params.FirstSpawnVoiceLines or {},
		OnSpawnVoiceLines = params.OnSpawnVoiceLines or {},
		UpgradeMenuOpenVoiceLines = params.UpgradeMenuOpenVoiceLines or { [1] = { GlobalVoiceLines = "HeraclesBoonReactionVoiceLines" } },
		DuoPickupTextLines = params.DuoPickupTextLines or {},
		InteractTextLineSets = params.InteractTextLineSets or {
			[godName .. "Chat01"] = {
				Name = godName .. "Chat01",
				UseableOffSource = true,
				{ Cue = "", UseEventEndSound = true, Text = "Dialogue has not been implemented, using default!" },
			},
		},
		BoughtTextLines = params.BoughtTextLines or {},
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
		Weight = params.Weight or 10,
		CanReceiveGift = params.CanReceiveGift or true,
		AlwaysShowDefaultUseText = params.AlwaysShowDefaultUseText or true,
		LootRejectionAnimation = params.LootRejectionAnimation or "BoonDissipateA_Zeus",
		ColorGrade = params.ColorGrade or "ZeusLightning",
		Consumables = params.Consumables or {},
		EmoteOffsetX = params.EmoteOffsetX or 30,
		EmoteOffsetY = params.EmoteOffsetY or -320,
		PlayInteract = true,
	}

	if params.ExtraFields then
		for k, v in pairs(params.ExtraFields) do
			game.LootData[upgradeName][k] = v
		end
	end

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
	end

	if params.SpawnLikeHermes then
		local spawnValue = 1
		if type(params.SpawnLikeHermes) == "table" and params.SpawnLikeHermes.maximumSpawns then
			spawnValue = params.SpawnLikeHermes.maximumSpawns or 1
		end

		game.NamedRequirementsData[upgradeName .. "-Requirements"] = {
			-- unlock requirements
			-- {
			-- 	Path = { "GameState", "TextLinesRecord" },
			-- 	HasAll = { godName .. "FirstPickUp" },
			-- }, // Not doing this in case someone doesnt have a first pickup text set.
			-- run requirements
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
				Value = spawnValue, -- 1 will be a max of 2 spawns, etc
			},
		}

		local insertRewards = {
			Name = upgradeName,
			GameStateRequirements = {
				NamedRequirements = { upgradeName .. "-Requirements" },
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
			UseFunctionName = "rom.mods." .. env._PLUGIN.guid .. "-Create" .. params.godName .. "Loot",
			SurfaceShopText = upgradeName .. "_Store",
			SurfaceShopIcon = "BoonDrop" .. godName .. "Preview",
			GameStateRequirements = {
				{
					Path = { "CurrentRun", "BiomeUseRecord" },
					HasNone = { upgradeName, "Shop" .. upgradeName },
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

		local envFunc = env._PLUGIN.guid .. "-Create" .. params.godName .. "Loot"
		envFunc = function(args)
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

				spawnedItem = envFunc({
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

	codexReg(env, params, upgradeName, lowGodType)

	if not params.SpawnLikeHermes then
		addGodtoRunData(game.RewardStoreData.RunProgress, upgradeName)
		addGodtoRunData(game.RewardStoreData.TartarusRewards, upgradeName)
	end
end

function definitions.CreateOlympianSJSONData(env, params)
	local requiredFields = { "godName", "godType", "iconSpinPath", "previewPath", "colorA", "colorB", "colorC" }
	if params and not params.skipBoonSelectSymbol then
		table.insert(requiredFields, "boonSelectSymbolPath")
	end

	if not validateParams(params, requiredFields, "CreateOlympianSJSONData") then
		return nil
	end

	local pluginGUID = env._PLUGIN.guid
	local godName = env._PLUGIN.guid .. "-" .. params.godName
	local upgradeName = env._PLUGIN.guid .. "-" .. params.godName .. "Upgrade"

	--* The actual boon drop
	local godUpgrade = sjson.to_object({
		Name = upgradeName,
		InheritFrom = "BaseBoon",
		DisplayInEditor = true,
		Thing = {
			EditorOutlineDrawBounds = false,
			Graphic = "BoonDrop" .. godName,
			AmbientSound = params.AmbientSound,
		},
	}, Order)

	sjson.hook(GameplayFile, function(data)
		table.insert(data.Obstacles, godUpgrade)
	end)

	local useBasePathPreview = params.iconPathOverrides and params.iconPathOverrides.previewPath or false
	local useBasePathSpin = params.iconPathOverrides and params.iconPathOverrides.iconSpinPath or false
	local useBasePathSelectSymbol = params.iconPathOverrides and params.iconPathOverrides.boonSelectSymbolPath or false

	--* The Boon Colours/Animations
	local boonDropConfigs = {
		["BoonDrop" .. godName] = {
			InheritFrom = "BoonDropGold",
			ChildAnimation = "BoonDropA-" .. godName,
		},
		["BoonDropA-" .. godName] = { -- This one is outer field, IDK why they did it this way, but I will assign colourB to it instead.
			InheritFrom = "BoonDropA",
			ChildAnimation = "BoonDropB-" .. godName,
			Color = params.colorB,
			CreateAnimations = { {
				Name = "BoonDropBackGlow",
			}, {
				Name = "BoonDropFrontFlare",
			} },
		},
		["BoonDropB-" .. godName] = {
			InheritFrom = "BoonDropB",
			ChildAnimation = "BoonDropC-" .. godName,
			Color = params.colorA,
			CreateAnimations = { {
				Name = "BoonDropBackGlow",
			}, {
				Name = "BoonDropFrontFlare",
			} },
		},
		["BoonDropC-" .. godName] = {
			InheritFrom = "BoonDropC",
			ChildAnimation = "BoonDrop" .. godName .. "Icon",
			Color = params.colorC,
			CreateAnimations = { {
				Name = "BoonDropBackGlow",
			}, {
				Name = "BoonDropFrontFlare",
			} },
		},
		["BoonDrop" .. godName .. "Preview"] = {
			InheritFrom = "BoonDropRoomRewardIconPreviewBase",
			FilePath = cleanFilePath(pluginGUID, params.previewPath, useBasePathPreview),
			OffsetZ = params.OffsetZBoonPreview or 0,
			Scale = params.BoonPreviewScale,
			ColorFromOwner = "Maintain",
			AngleFromOwner = "Ignore",
			Sound = params.AmbientSound,
		},
		["BoonDrop" .. godName .. "UpgradedPreview"] = {
			InheritFrom = "BoonDrop" .. godName .. "Preview",
			ChildAnimation = "BoonUpgradedPreviewSparkles",
		},
	}

	if not params.boonDropIconCustomFrames then
		boonDropConfigs["BoonDrop" .. godName .. "Icon"] = {
			InheritFrom = "BoonDropIcon",
			FilePath = cleanFilePath(pluginGUID, params.iconSpinPath, useBasePathSpin),
			OffsetZ = params.OffsetZBoonDrop,
			Scale = params.BoonDropIconScale,
			Hue = params.BoonDropIconHue,
		}
	else
		--can do math.max for the frames but meh
		boonDropConfigs["BoonDrop" .. godName .. "Icon"] = {
			InheritFrom = "BoonDropIcon", -- Still inherit from base BoonDropIcon, otherwise, stackoverflow magically.
			FilePath = cleanFilePath(pluginGUID, params.iconSpinPath, useBasePathSpin),
			OffsetZ = params.OffsetZBoonDrop,
			Scale = params.BoonDropIconScale,
			Hue = params.BoonDropIconHue,

			EndFrame = params.boonDropIconCustomFrames.EndFrame or 50,
			NumFrames = params.boonDropIconCustomFrames.NumFrames or 50,
			PlaySpeed = params.boonDropIconCustomFrames.PlaySpeed or 30,
		}
	end

	local dependencyOrder = {
		"BoonDrop" .. godName .. "Preview",
		"BoonDrop" .. godName .. "UpgradedPreview",
	}

	local boonVFXobj = {}
	for _, name in ipairs(dependencyOrder) do
		local config = boonDropConfigs[name]
		if config then
			local object = sjson.to_object({
				Name = name,
				InheritFrom = config.InheritFrom,
				ChildAnimation = config.ChildAnimation,
				FilePath = config.FilePath,
				OffsetZ = config.OffsetZ,
				Scale = config.Scale,
				ColorFromOwner = config.ColorFromOwner,
				AngleFromOwner = config.AngleFromOwner,
				Sound = config.Sound,
			}, Order)
			table.insert(boonVFXobj, object)
			boonDropConfigs[name] = nil
		end
	end

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
		}, Order)
		table.insert(boonVFXobj, object)
	end

	sjson.hook(ItemsGeneralVFX, function(data)
		for _, object in ipairs(boonVFXobj) do
			table.insert(data.Animations, object)
		end
	end)

	-- Name = "ZeusOverlay"
	-- InheritFrom = "HadesOverlay"
	-- FilePath = "PortraitsZeusPortraits_Zeus_01"
	-- OffsetX = 450
	-- OffsetY = 0
	-- if params.overlayAnimData then
	-- 	local overlayVFXobj = {}
	-- 	local overlayAnim = sjson.to_object({
	-- 		Name = godName .. "Overlay",
	-- 		InheritFrom = "BoonOverlay",
	-- 		FilePath = cleanFilePath(pluginGUID, params.overlayAnimData.FilePath or "", params.overlayAnimData.UseBasePath or false),
	-- 		OffsetX = params.overlayAnimData.OffsetX or 0,
	-- 		OffsetY = params.overlayAnimData.OffsetY or 0,
	-- 		Scale = params.overlayAnimData.Scale or 1,
	-- 	}, Order)
	-- 	table.insert(overlayVFXobj, overlayAnim)

	-- 	sjson.hook(GUIBoonsVFXFile, function(data)
	-- 		for _, object in ipairs(overlayVFXobj) do
	-- 			table.insert(data.Animations, object)
	-- 		end
	-- 	end)
	-- end

	--* Visuals on doors/boon select
	local boonInfoConfigs = {}
	boonInfoConfigs["BoonInfoSymbol" .. godName .. "Icon"] = {
		InheritFrom = "BoonInfoSymbolBase",
		FilePath = cleanFilePath(pluginGUID, params.previewPath, useBasePathPreview),
	}

	if not params.skipBoonSelectSymbol then
		boonInfoConfigs["BoonSymbol" .. godName] = {
			InheritFrom = "BoonSymbolBase",
			FilePath = cleanFilePath(pluginGUID, params.boonSelectSymbolPath, useBasePathSelectSymbol),
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
		}, Order)
		table.insert(boonInfoObjects, object)
	end

	sjson.hook(GUIScreensVFXFile, function(data)
		for _, object in ipairs(boonInfoObjects) do
			table.insert(data.Animations, object)
		end
	end)

	--* Macro texts
	local macrosText = {
		["Player_GodDispleased_" .. upgradeName] = {
			DisplayName = params.godName .. " Grew Displeased!",
		},
		["SuperSacrifice_CombatText_" .. upgradeName] = {
			DisplayName = "{#CombatTextHighlightFormat}Boons of " .. params.godName .. " {#Prev}{#UpgradeFormat}+{$TempTextData.Amount}{#Prev}{!Icons.PomLevel}!",
		},
		["EchoLastRewardBoon_" .. upgradeName] = {
			InheritFrom = "BaseBoon",
			DisplayName = "Manifest a copy of your most recently claimed {#ItalicFormat}Reward: {#Prev}{#BoldFormat}{$Keywords.GodBoon} of " .. params.godName,
		},
		["UpgradeChoiceMenu_Title_" .. upgradeName] = {
			DisplayName = "Boons of " .. params.godName,
		},
	}

	local macrosTextobj = {}
	for id, config in pairs(macrosText) do
		local object = sjson.to_object({
			Id = id,
			DisplayName = config.DisplayName,
			InheritFrom = config.InheritFrom,
		}, Order)
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
		[upgradeName] = {
			DisplayName = params.godName,
			Description = params.godDescriptionText,
		},
		[upgradeName .. "_FlavorText01"] = {
			DisplayName = params.godDescriptionTextFlavour01,
		},
		[upgradeName .. "FlavorText02"] = {
			DisplayName = params.godDescriptionTextFlavour02,
		},
		[upgradeName .. "_FlavorText03"] = {
			DisplayName = params.godDescriptionTextFlavour03,
		},
	}

	local screenTextsobj = {}
	for id, config in pairs(screenTexts) do
		local object = sjson.to_object({
			Id = id,
			DisplayName = config.DisplayName,
			Description = config.Description,
		}, Order)
		table.insert(screenTextsobj, object)
	end

	sjson.hook(ScreenText, function(data)
		for _, object in ipairs(screenTextsobj) do
			table.insert(data.Texts, object)
		end
	end)

	local testing = sjson.to_object({
		Id = "NPC_" .. godName .. "_01",
		DisplayName = params.godName,
		Description = params.godDescriptionText,
	}, Order)

	sjson.hook(HelpTextFile, function(data)
		table.insert(data.Texts, testing)
	end)

	if params.godDescriptionTextFlavour01 then
		if game.LootData[upgradeName] then
			table.insert(game.LootData[upgradeName].FlavorTextIds, upgradeName .. "_FlavorText01")
		end
	elseif params.godDescriptionTextFlavour02 then
		if game.LootData[upgradeName] then
			table.insert(game.LootData[upgradeName].FlavorTextIds, upgradeName .. "_FlavorText02")
		end
	elseif params.godDescriptionTextFlavour03 then
		if game.LootData[upgradeName] then
			table.insert(game.LootData[upgradeName].FlavorTextIds, upgradeName .. "_FlavorText03")
		end
	end

	if string.lower(params.godType) == "npcgod" then
		local vfxObjects = {}

		local upgradePrev = sjson.to_object({
			Name = godName .. "UpgradePreview",
			InheritFrom = "BoonSymbolBaseIsometric",
			FilePath = cleanFilePath(pluginGUID, params.previewPath, useBasePathPreview),
		}, Order)
		table.insert(vfxObjects, upgradePrev)

		local upgradeShop = sjson.to_object({
			InheritFrom = godName .. "UpgradePreview",
			Name = godName .. "UpgradeShop",

			Duration = 0,
			StartOffsetZ = 0,
			EndOffsetZ = 0,
			PingPongShiftOverDuration = false,
			Sound = null,
		}, Order)
		table.insert(vfxObjects, upgradeShop)

		sjson.hook(ItemsGeneralVFX, function(data)
			for _, object in ipairs(vfxObjects) do
				table.insert(data.Animations, object)
			end
		end)

		local upgradeStore = sjson.to_object({
			Id = godName .. "Upgrade_Store",
			DisplayName = "Boon of " .. params.godName,
			Description = "Receive your choice of {#BoldFormat}1 {#Prev}out of {$ScreenData.UpgradeChoice.MaxChoices} {$Keywords.GodBoonPlural} from {#BoldFormat}" .. params.godName .. "{#Prev}.",
		}, Order)

		sjson.hook(TraitTextFile, function(data)
			table.insert(data.Texts, upgradeStore)
		end)
	end

	--! Portraits
	if params.portraitData then
		local useBaseNeutral = params.portraitPathOverrides and params.portraitPathOverrides.NeutralPortraitPath or false
		local useBaseAnnoyed = params.portraitPathOverrides and params.portraitPathOverrides.AnnoyedPortraitPath or false
		local useBaseSerious = params.portraitPathOverrides and params.portraitPathOverrides.SeriousPortraitPath or false
		--! I have no idea what some of these do lmao.
		local portraitObj = {}

		local defaultPortrait = sjson.to_object({
			Name = "Portrait_" .. godName .. "_Default_01",
			InheritFrom = "Portrait_God_01",
			FilePath = cleanFilePath(pluginGUID, params.portraitData.NeutralPortraitPath or "", useBaseNeutral),
			ChildAnimation = "PortraitGodRayEmitter_Athena",
			EndFrame = 1,
			StartFrame = 1,
			OffsetX = params.portraitData.OffsetX,
			OffsetY = params.portraitData.OffsetY,
			Scale = params.portraitData.Scale,
			CreateAnimation = "OlympianDialogueEntrance_" .. godName,
			CreateAnimations = params.portraitData.NeutralAnimations or {}, -- This is... blinking, and stuff - which you see in a gods Package.
			-- SortMode = "Id", --! check what this do
		}, Order)
		table.insert(portraitObj, defaultPortrait)

		local defaultExitPortrait = sjson.to_object({
			Name = "Portrait_" .. godName .. "_Default_01_Exit",
			InheritFrom = "Portrait_God_01_Exit",
			FilePath = cleanFilePath(pluginGUID, params.portraitData.NeutralPortraitPath or "", useBaseNeutral),
			EndFrame = 1,
			StartFrame = 1,
			Sound = "/Leftovers/World Sounds/MapZoomInShortHigh",
		}, Order)
		table.insert(portraitObj, defaultExitPortrait)

		local wrathPortrait = sjson.to_object({
			Name = "Portrait_" .. godName .. "_Default_01_Wrath",
			InheritFrom = "Portrait_God_01_Wrath",
			FilePath = cleanFilePath(pluginGUID, params.portraitData.NeutralPortraitPath or "", useBaseNeutral),
			EndFrame = 1,
			StartFrame = 1,
		}, Order)
		table.insert(portraitObj, wrathPortrait)

		local displeasedPortrait = sjson.to_object({
			Name = "Portrait_" .. godName .. "_Displeased_01",
			InheritFrom = "Portrait_" .. godName .. "_Default_01",
			FilePath = cleanFilePath(pluginGUID, params.portraitData.AnnoyedPortraitPath or "", useBaseAnnoyed),
		}, Order)
		table.insert(portraitObj, displeasedPortrait)

		local seriousPortrait = sjson.to_object({
			Name = "Portrait_" .. godName .. "_Serious_01",
			InheritFrom = "Portrait_" .. godName .. "_Default_01",
			FilePath = cleanFilePath(pluginGUID, params.portraitData.SeriousPortraitPath or "", useBaseSerious),
		}, Order)
		table.insert(portraitObj, seriousPortrait)

		local seriousExitPortrait = sjson.to_object({
			Name = "Portrait_" .. godName .. "_Serious_01_Exit",
			InheritFrom = "Portrait_" .. godName .. "_Default_01_Exit",
			FilePath = cleanFilePath(pluginGUID, params.portraitData.SeriousPortraitPath or "", useBaseSerious),
		}, Order)
		table.insert(portraitObj, seriousExitPortrait)

		if params.portraitData.DialogueAnimations then
			local dialogueEntrance = sjson.to_object({
				Name = "OlympianDialogueEntrance_" .. godName,
				InheritFrom = "OlympianDialogueEntrance_Base",
				StartRed = params.portraitData.DialogueAnimations.DialogueEntrance.RedStart,
				StartGreen = params.portraitData.DialogueAnimations.DialogueEntrance.GreenStart,
				StartBlue = params.portraitData.DialogueAnimations.DialogueEntrance.BlueStart,
				EndRed = params.portraitData.DialogueAnimations.DialogueEntrance.RedEnd,
				EndGreen = params.portraitData.DialogueAnimations.DialogueEntrance.GreenEnd,
				EndBlue = params.portraitData.DialogueAnimations.DialogueEntrance.BlueEnd,
				CreateAnimations = {},
			}, Order)

			if params.portraitData.DialogueAnimations.DialogueEntranceStreaks then
				local dialogueStreaks = sjson.to_object({
					Name = "OlympianDialogueEntranceStreaks_" .. godName,
					InheritFrom = "OlympianDialogueEntranceStreaks_Base",
					StartRed = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.RedStart,
					StartGreen = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.GreenStart,
					StartBlue = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.BlueStart,
					EndRed = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.RedEnd,
					EndGreen = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.GreenEnd,
					EndBlue = params.portraitData.DialogueAnimations.DialogueEntranceStreaks.BlueEnd,
					VisualFx = "OlympianDialogueEntranceParticle_" .. godName,
				}, Order)
				table.insert(portraitObj, dialogueStreaks)
				table.insert(dialogueEntrance.CreateAnimations, { Name = "OlympianDialogueEntranceStreaks_" .. godName })
			elseif params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst then
				local particleBurst = sjson.to_object({
					Name = "OlympianDialogueEntranceParticleBurst_" .. godName,
					InheritFrom = "OlympianDialogueEntranceParticleBurst_Base",
					StartRed = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedStart,
					StartGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenStart,
					StartBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueStart,
					EndRed = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedEnd,
					EndGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenEnd,
					EndBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueEnd,
				}, Order)
				table.insert(portraitObj, particleBurst)

				local particleBurstFlip = sjson.to_object({
					Name = "OlympianDialogueEntranceParticleBurst_" .. godName .. "_Flip",
					InheritFrom = "OlympianDialogueEntranceParticleBurst_Base_Flip",
					StartRed = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedStart,
					StartGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenStart,
					StartBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueStart,
					EndRed = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedEnd,
					EndGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenEnd,
					EndBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueEnd,
				}, Order)
				table.insert(portraitObj, particleBurstFlip)

				table.insert(dialogueEntrance.CreateAnimations, { Name = "OlympianDialogueEntranceParticleBurst_" .. godName })
				table.insert(dialogueEntrance.CreateAnimations, { Name = "OlympianDialogueEntranceParticleBurst_" .. godName .. "_Flip" })
			end

			table.insert(portraitObj, dialogueEntrance)

			local dialogueParticle = sjson.to_object({
				Name = "OlympianDialogueEntranceParticle_" .. godName,
				InheritFrom = "OlympianDialogueEntranceParticles_Base",
				StartRed = params.portraitData.DialogueAnimations.DialogueEntranceParticles.RedStart,
				StartGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticles.GreenStart,
				StartBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticles.BlueStart,
				EndRed = params.portraitData.DialogueAnimations.DialogueEntranceParticles.RedEnd,
				EndGreen = params.portraitData.DialogueAnimations.DialogueEntranceParticles.GreenEnd,
				EndBlue = params.portraitData.DialogueAnimations.DialogueEntranceParticles.BlueEnd,
			}, Order)
			table.insert(portraitObj, dialogueParticle)
		end

		sjson.hook(PortraitFile, function(data)
			local existingPortraits = {}
			for _, animation in ipairs(data.Animations) do
				existingPortraits[animation.Name] = true
			end

			for _, object in ipairs(portraitObj) do
				if not existingPortraits[object.Name] then
					table.insert(data.Animations, object)
				end
			end
		end)
	end
end

--[[
basically, get a god name for gift data, else, pluginGUID.name = whatever
then do the entire keepsake, see like wtf is up with all the gaw damn trait texts and stuff, and make sure i can pass in custom stuff
then sjson
--]]
function definitions.CreateKeepsake(env, params)
	if not validateParams(params, { "characterName", "internalKeepsakeName", "RarityLevels" }, "CreateKeepsake") then
		return nil
	end

	if not params.RarityLevels.Common or not params.RarityLevels.Rare or not params.RarityLevels.Epic or not params.RarityLevels.Heroic then
		rom.log.warning("No Common/Rare/Epic/Heroic rarity multiplier passed in, falling back to default.")
	end

	local pluginGUID = env._PLUGIN.guid
	local internalKeepsakeName = pluginGUID .. "-" .. params.internalBoonName -- used when passing into traits
	local characterName = pluginGUID .. "-" .. params.characterName -- used when passing into traits

	game.TraitData[internalKeepsakeName] = {
		InheritFrom = { "GiftTrait" }, -- don't need "BaseBoonUpgradeKeepsake", handled by DoesNotAutomaticallyExpire
		Icon = internalKeepsakeName, --! req
		Name = internalKeepsakeName,
		Ordered = true,
		PriorityDisplay = true,
		TraitOrderingValueCache = -1,
		DoesNotAutomaticallyExpire = params.DoesNotAutomaticallyExpire,

		EquipSound = params.EquipSound, --? Opt
		EquipVoiceLines = params.EquipVoiceLines, -- table --? Opt

		CustomTrayText = internalKeepsakeName .. "_Tray", -- When you equip it
		ZeroBonusTrayText = internalKeepsakeName .. "_Expired",
	}

	--? I wrote this code and then forgot what it does
	--really ugly code, but if god exists, do gift text lines for max gift, otherwise, user args for what is max and min req.
	if game.LootData[characterName .. "Upgrade"] then
		local giftTextLines = game.LootData[characterName .. "Upgrade"].GiftTextLineSets
		local lastGiftLineKey = nil

		for key, value in pairs(giftTextLines) do
			lastGiftLineKey = key
		end
		game.GiftData[characterName .. "Upgrade"] = {
			InheritFrom = { "DefaultGiftData" },
			MaxedRequirement = {
				{
					PathTrue = { "GameState", "TextLinesRecord", game.LootData[characterName .. "Upgrade"][lastGiftLineKey] },
				},
			},
			MaxedIcon = "Keepsake_" .. characterName .. "_Corner",
			MaxedSticker = "Keepsake_" .. characterName,
			[1] = {
				GameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", game.LootData[characterName .. "Upgrade"][1] },
					},
				},
				Gift = internalKeepsakeName,
			},
		}
		game.TraitData[internalKeepsakeName].SignOffData = {
			{
				GameStateRequirements = {
					{
						PathTrue = { "GameState", "TextLinesRecord", game.LootData[characterName .. "Upgrade"][lastGiftLineKey] },
					},
				},
				Text = "Signoff" .. characterName .. "_Max",
			},
			{
				Text = "Signoff" .. characterName,
			},
		}
	else
		game.GiftData[characterName .. "Upgrade"] = {
			InheritFrom = { "DefaultGiftData" },
			MaxedRequirement = params.maxRequirement,
			MaxedIcon = "Keepsake_" .. characterName .. "_Corner",
			MaxedSticker = "Keepsake_" .. characterName,
			[1] = {
				GameStateRequirements = params.minRequirement,
				Gift = internalKeepsakeName,
			},
		}
		game.TraitData[internalKeepsakeName].SignOffData = {
			{
				GameStateRequirements = params.maxRequirement,
				Text = "Signoff" .. characterName .. "_Max",
			},
			{
				Text = "Signoff" .. characterName,
			},
		}
	end

	if params.ExtraFields then
		for k, v in pairs(params.ExtraFields) do
			game.TraitData[internalKeepsakeName][k] = v
		end
	end

	if params.RarityLevels then
		game.TraitData[internalKeepsakeName].RarityLevels = {}
		local rarity = game.TraitData[internalKeepsakeName].RarityLevels

		for rarityName, value in pairs(params.RarityLevels) do
			if type(value) == "number" then
				rarity[rarityName] = { Multiplier = value }
			elseif type(value) == "table" then
				if value.Multiplier then
					rarity[rarityName] = value.Multiplier
				elseif value.MinMultiplier and value.MaxMultiplier then
					rarity[rarityName] = {
						MinMultiplier = value.MinMultiplier,
						MaxMultiplier = value.MaxMultiplier,
					}
				else
					rom.log.error("Unknown rarity format for: " .. rarityName)
					rarity[rarityName] = value
				end
			end
		end
	end
	table.insert(game.ScreenData.KeepsakeRack.ItemOrder, internalKeepsakeName)

	-- SJSON stuff now
	local textsins = {}
	local vfxins = {}

	if params.Keepsake then
		textsins[internalKeepsakeName] = {
			InheritFrom = "BaseBoonMultiline",
			DisplayName = params.Keepsake.displayName or "Lorem Ipsum Display Name",
			Description = params.Keepsake.description or "Lorem Ipsum Description",
		}

		if params.Keepsake.trayDescription then
			textsins[internalKeepsakeName .. "_Tray"] = {
				InheritFrom = internalKeepsakeName,
				Description = params.Keepsake.trayDescription,
			}
		else
			textsins[internalKeepsakeName .. "_Tray"] = {
				InheritFrom = internalKeepsakeName,
				Description = params.Keepsake.description or "Lorem Ipsum Tray Description", -- fall to default
			}
		end

		if params.Keepsake.trayExpired then
			textsins[internalKeepsakeName .. "_Expired"] = {
				InheritFrom = internalKeepsakeName,
				Description = params.Keepsake.trayExpired,
			}
		end
	end

	textsins["Signoff" .. characterName] = {
		DisplayName = "From " .. params.characterName,
	}

	textsins["Signoff" .. characterName .. "_Max"] = {
		DisplayName = params.Keepsake.signoffMax or ("Max Friendship Signoff not implemented for " .. params.characterName),
	}

	if params.Icons then
		local useBaseIcon = params.iconPathOverrides and params.iconPathOverrides.iconPath or false
		local useBaseMaxIcon = params.iconPathOverrides and params.iconPathOverrides.maxIcon or false
		local useBaseMaxCornerIcon = params.iconPathOverrides and params.iconPathOverrides.maxCornerIcon or false

		vfxins[internalKeepsakeName] = {
			InheritFrom = "KeepsakeIcon",
			FilePath = cleanFilePath(pluginGUID, params.Icons.iconPath, useBaseIcon),
		}
		if not params.Icons.iconPath then -- def icon
			game.TraitData[internalKeepsakeName].Icon = "Keepsake_34"
		end

		if params.Icons.maxIcon then
			vfxins["Keepsake_" .. characterName] = {
				InheritFrom = "KeepsakeMax",
				FilePath = cleanFilePath(pluginGUID, params.Icons.maxIcon, useBaseMaxIcon),
			}
		end

		if params.Icons.maxCornerIcon then
			vfxins["Keepsake_" .. characterName .. "_Corner"] = {
				InheritFrom = "KeepsakeMax_Corner",
				FilePath = cleanFilePath(pluginGUID, params.Icons.maxCornerIcon, useBaseMaxCornerIcon),
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
		}, Order)
		table.insert(textObjects, object)
	end

	local vfxObjects = {}
	for name, config in pairs(vfxins) do
		local object = sjson.to_object({
			Name = name,
			InheritFrom = config.InheritFrom,
			FilePath = config.FilePath,
		}, Order)
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

--[[
Required:   "characterName", "internalBoonName"
Optional:   "RarityLevels", "Slot", "BlockStacking", "StatLines", "ExtractValues", "displayName"
            "ExtraFields", "boonIconPath", "requirements", "flavourText", "addToExistingGod", "reuseBaseIcons"
]]
function definitions.CreateBoon(env, params)
	if not validateParams(params, { "characterName", "internalBoonName" }, "CreateBoon") then
		return nil
	end

	if not params.RarityLevels then
		rom.log.warning("No rarity multiplier passed in, falling back to default.")
	end

	local pluginGUID = env._PLUGIN.guid
	local intboonName = pluginGUID .. "-" .. params.internalBoonName -- used when passing into traits

	local characterCoreTraits = pluginGUID .. "-" .. params.characterName .. "CoreTraits"
	local characterUpgrade = pluginGUID .. "-" .. params.characterName .. "Upgrade"

	-- Creating the boon functions itself
	game.TraitData[intboonName] = {
		InheritFrom = params.InheritFrom or {}, -- this is where the type of boon really happens
		Name = intboonName, -- eg TycheWeaponBoon
		BoonInfoTitle = intboonName,
		Icon = intboonName,
		Slot = params.Slot,
		BlockStacking = params.BlockStacking, -- specfic override

		StatLines = params.StatLines or {},
		ExtractValues = params.ExtractValues or {},
	}

	if params.Elements then
		rom.log.warning("Usage of `Elements` is no longer needed, pass an element into `InheritFrom` e.g: 'AirBoon'.")

		if params.Elements == "Air" then
			table.insert(game.TraitData[intboonName].InheritFrom, "AirBoon")
		elseif params.Elements == "Fire" then
			table.insert(game.TraitData[intboonName].InheritFrom, "FireBoon")
		elseif params.Elements == "Earth" then
			table.insert(game.TraitData[intboonName].InheritFrom, "EarthBoon")
		elseif params.Elements == "Water" then
			table.insert(game.TraitData[intboonName].InheritFrom, "WaterBoon")
		elseif params.Elements == "Aether" then
			table.insert(game.TraitData[intboonName].InheritFrom, "AetherBoon")
		end
	end
	if params.isLegendary then
		rom.log.warning('Usage of `isLegendary` is no longer needed, pass "LegendaryTrait" into `InheritFrom`.')
		table.insert(game.TraitData[intboonName].InheritFrom, "LegendaryTrait")
	end

	if params.ExtraFields then
		for k, v in pairs(params.ExtraFields) do
			game.TraitData[intboonName][k] = v
		end
	end

	if params.RarityLevels then
		game.TraitData[intboonName].RarityLevels = {}
		local rarity = game.TraitData[intboonName].RarityLevels

		for rarityName, value in pairs(params.RarityLevels) do
			if type(value) == "number" then
				rarity[rarityName] = { Multiplier = value }
			elseif type(value) == "table" then
				if value.Multiplier then
					rarity[rarityName] = value
				elseif value.MinMultiplier and value.MaxMultiplier then
					rarity[rarityName] = {
						MinMultiplier = value.MinMultiplier,
						MaxMultiplier = value.MaxMultiplier,
					}
				else
					rom.log.warning("Unknown multiplier in " .. intboonName .. ", " .. rarityName .. " falling back to default.")
					rarity[rarityName] = { Multiplier = 1 }
				end
			end
		end
	end

	-- just do a check incase nothing is in inheritfrom, fall back to basetrait
	if game.TraitData[intboonName].InheritFrom == {} then
		game.TraitData[intboonName].InheritFrom = { "BaseTrait", "FireBoon" }
	end

	local traitIcon
	local useBasePath = params.reuseBaseIcons or false
	if params.Slot == "Melee" or params.Slot == "Secondary" or params.Slot == "Ranged" or params.Slot == "Rush" or params.Slot == "Mana" then
		traitIcon = sjson.to_object({
			Name = intboonName,
			InheritFrom = "BoonTrayIcon",
			FilePath = cleanFilePath(pluginGUID, params.boonIconPath or nil, useBasePath),
		}, Order)
	else
		traitIcon = sjson.to_object({
			Name = intboonName,
			InheritFrom = "BoonIcon",
			FilePath = cleanFilePath(pluginGUID, params.boonIconPath or nil, useBasePath),
		}, Order)
	end

	sjson.hook(GUIBoonsVFXFile, function(data)
		table.insert(data.Animations, traitIcon)
	end)
	if not params.boonIconPath then -- def icon
		game.TraitData[intboonName].Icon = "Boon_Hera_40"
	end

	local flavourText
	if params.flavourText then
		game.TraitData[intboonName].FlavorText = intboonName .. "_FlavourText"
		flavourText = sjson.to_object({
			Id = intboonName .. "_FlavourText",
			DisplayName = params.flavourText,
		}, Order)
	end

	local traitDisplay = sjson.to_object({
		Id = intboonName,
		InheritFrom = "BaseBoonMultiline",
		DisplayName = params.displayName or "Lorem Ipsum DisplayName",
		Description = params.description or "Lorem Ipsum Description",
	}, Order)
	sjson.hook(TraitTextFile, function(data)
		table.insert(data.Texts, traitDisplay)
		if params.flavourText then
			table.insert(data.Texts, flavourText)
		end
	end)

	if params.customStatLine then
		local statline = sjson.to_object({
			Id = params.customStatLine.ID,
			InheritFrom = "BaseStatLine",
			DisplayName = params.customStatLine.displayName or "Lorem Ipsum DisplayName",
			Description = params.customStatLine.description or "Lorem Ipsum Description",
		}, Order)

		sjson.hook(TraitTextFile, function(data)
			table.insert(data.Texts, statline)
		end)
	end

	game.TraitData[intboonName].TraitOrderingValueCache = GetTraitOrderingValue(game.TraitData[intboonName])

	if params.addToExistingGod then
		local customGUIDLoot = nil
		if type(params.addToExistingGod) == "table" and params.addToExistingGod.customGUID then
			customGUIDLoot = params.addToExistingGod.customGUID .. "-" .. params.characterName .. "Upgrade"
		end

		local characterData = nil
		if game.LootData[params.characterName .. "Upgrade"] then
			characterData = game.LootData[params.characterName .. "Upgrade"]
		elseif game.LootData[characterUpgrade] then
			characterData = game.LootData[characterUpgrade]
		elseif customGUIDLoot and game.LootData[customGUIDLoot] then
			characterData = game.LootData[customGUIDLoot]
		else
			local warningMsg = "addToExistingGod: LootData: " .. params.characterName .. "Upgrade / or / " .. characterUpgrade .. " do not exist"
			if customGUIDLoot then
				warningMsg = warningMsg .. "/ or / " .. customGUIDLoot .. " does not exist."
			else
				warningMsg = warningMsg .. ", attempt to pass in a customGUID."
			end
			rom.log.warning(warningMsg)
		end

		if characterData then
			if params.Slot == "Melee" or params.Slot == "Secondary" or params.Slot == "Ranged" or params.Slot == "Rush" or params.Slot == "Mana" then
				if characterData.WeaponUpgrades == nil then -- we wanna create the weapon tables if it doesnt exist, just in case its not defined
					characterData.WeaponUpgrades = {}
				end
				if characterData.PriorityUpgrades == nil then -- same
					characterData.PriorityUpgrades = {}
				end

				local alreadyExists = false
				for _, existingBoon in ipairs(characterData.WeaponUpgrades) do
					if existingBoon == intboonName then
						alreadyExists = true
						break
					end
				end

				if not alreadyExists then
					if type(params.addToExistingGod) == "table" and params.addToExistingGod.boonPosition then
						table.insert(characterData.WeaponUpgrades, params.addToExistingGod.boonPosition, intboonName)
						table.insert(characterData.PriorityUpgrades, params.addToExistingGod.boonPosition, intboonName)
					else
						table.insert(characterData.WeaponUpgrades, intboonName)
						table.insert(characterData.PriorityUpgrades, intboonName)
					end
				end
			else
				if characterData.Traits == nil then -- same here
					characterData.Traits = {}
				end

				local alreadyExists = false
				for _, existingTrait in ipairs(characterData.Traits) do
					if existingTrait == intboonName then
						alreadyExists = true
						break
					end
				end

				if not alreadyExists then
					table.insert(characterData.Traits, intboonName)
				end
			end
		end
	end
	if params.Slot == "Melee" or params.Slot == "Secondary" or params.Slot == "Ranged" or params.Slot == "Rush" or params.Slot == "Mana" then
		-- if we want to do linkedtraitdata, but we dont really need to, since its only used to create requirements
		-- i wrote this comment and had to immediately change my mind!
		if params.Slot == "Melee" then
			table.insert(game.LinkedTraitData.WeaponTraits, intboonName)
		elseif params.Slot == "Secondary" then
			table.insert(game.LinkedTraitData.SpecialTraits, intboonName)
		elseif params.Slot == "Ranged" then
			table.insert(game.LinkedTraitData.CastTraits, intboonName)
		end

		-- realistically dont *need* this, but will do it anyway
		if game.LinkedTraitData[characterCoreTraits] then
			table.insert(game.LinkedTraitData[characterCoreTraits], intboonName)
		else
			game.LinkedTraitData[characterCoreTraits] = {}
			table.insert(game.LinkedTraitData[characterCoreTraits], intboonName)
		end

		-- table.insert(game.LinkedTraitData.WeaponTraits, "ArtemisWeaponBoon")
		-- table.insert(game.LinkedTraitData.ArtemisCoreTraits, "ArtemisWeaponBoon")
	end

	--? requirements
	if params.requirements then
		local function checkList(requirementList)
			local processedList = {}

			for _, req in ipairs(requirementList) do
				if game.TraitData[req] then
					table.insert(processedList, req)
				else
					local attemptGUID = pluginGUID .. "-" .. req
					if game.TraitData[attemptGUID] then
						table.insert(processedList, attemptGUID)
					else
						rom.log.warning("Cannot find trait for requirement: " .. req .. ", or for: " .. attemptGUID .. ". This will cause errors!")
					end
				end
			end

			return processedList
		end

		game.TraitRequirements[intboonName] = {}

		if params.requirements.OneOf then
			game.TraitRequirements[intboonName].OneOf = checkList(params.requirements.OneOf)
		end
		if params.requirements.TwoOf then
			game.TraitRequirements[intboonName].TwoOf = checkList(params.requirements.TwoOf)
		end
		if params.requirements.OneFromEachSet then
			for i, set in ipairs(params.requirements.OneFromEachSet) do
				params.requirements.OneFromEachSet[i] = checkList(set)
			end
			game.TraitRequirements[intboonName].OneFromEachSet = params.requirements.OneFromEachSet
		end
	end
end

--#region Extra func for testing or function checsk
function definitions.IsGodRegistered(env, godName, debug)
	if debug then
		local isRegistered = game.LootData[env._PLUGIN.guid .. "-" .. godName .. "Upgrade"] ~= nil
		rom.log.warning("IsGodRegistered: " .. godName .. " = " .. tostring(isRegistered))
		return isRegistered
	end

	return game.LootData[env._PLUGIN.guid .. "-" .. godName .. "Upgrade"] ~= nil
end

function definitions.GetInternalGodName(env, godName)
	if not godName or type(godName) ~= "string" then
		return nil
	end
	return env._PLUGIN.guid .. "-" .. godName .. "Upgrade"
end

function definitions.GetGodData(env, godName)
	if not godName or type(godName) ~= "string" then
		return nil
	end
	local fullGodName = env._PLUGIN.guid .. "-" .. godName
	return game.LootData[fullGodName]
end

function definitions.IsKeepsakeRegistered(env, internalKeepsakeName, debug)
	if debug then
		local isRegistered = game.TraitData[env._PLUGIN.guid .. "-" .. internalKeepsakeName] ~= nil
		rom.log.warning("IsKeepsakeRegistered: " .. internalKeepsakeName .. " = " .. tostring(isRegistered))
		return isRegistered
	end

	return game.TraitData[env._PLUGIN.guid .. "-" .. internalKeepsakeName]
end

function definitions.GetInternalKeepsakeName(env, internalKeepsakeName)
	if not internalKeepsakeName or type(internalKeepsakeName) ~= "string" then
		return nil
	end
	return env._PLUGIN.guid .. "-" .. internalKeepsakeName
end

function definitions.GetKeepsakeData(env, internalKeepsakeName)
	if not internalKeepsakeName or type(internalKeepsakeName) ~= "string" then
		return nil
	end
	local fullKeepsakeName = env._PLUGIN.guid .. "-" .. internalKeepsakeName
	return game.TraitData[fullKeepsakeName]
end

function definitions.IsBoonRegistered(env, internalBoonName, debug)
	if debug then
		local isRegistered = game.TraitData[env._PLUGIN.guid .. "-" .. internalBoonName] ~= nil
		rom.log.warning("IsBoonRegistered: " .. internalBoonName .. " = " .. tostring(isRegistered))
		return isRegistered
	end

	return game.TraitData[env._PLUGIN.guid .. "-" .. internalBoonName] ~= nil
end

function definitions.GetInternalBoonName(env, internalBoonName)
	if not internalBoonName or type(internalBoonName) ~= "string" then
		return nil
	end
	return env._PLUGIN.guid .. "-" .. internalBoonName
end

function definitions.GetBoonData(env, internalBoonName)
	if not internalBoonName or type(internalBoonName) ~= "string" then
		return nil
	end
	local fullBoonName = env._PLUGIN.guid .. "-" .. internalBoonName
	return game.TraitData[fullBoonName]
end
--#endregion

function public.setup(env)
	local binds = {}
	for k, v in pairs(definitions) do
		binds[k] = function(...)
			return v(env, ...)
		end
	end
	return binds
end

function public.auto()
	return public.setup(envy.getfenv(2))
end

modutil.once_loaded.game(function()
	mod = modutil.mod.Mod.Register(_PLUGIN.guid)
end)

mods.on_all_mods_loaded(function()
	modutil.once_loaded.game(function()
		for enemyName, enemyData in pairs(EnemyData) do
			ProcessDataInheritance(enemyData, EnemyData)
			if enemyData.PropertyChanges ~= nil then
				for k, propertyChange in pairs(enemyData.PropertyChanges) do
					AddFormattedPercentageChangeValues(propertyChange)
				end
			end

			if enemyData.TreatAsGodLootByShops and not IsEmpty(enemyData.Traits) then
				local fieldLootEntry = {
					Name = enemyName,
					TraitIndex = ToLookup(enemyData.Traits),
					TreatAsGodLootByShops = enemyData.TreatAsGodLootByShops,
					IgnoreRestrictBoonChoices = enemyData.IgnoreRestrictBoonChoices,
					ExcludeFromLastRunBoon = enemyData.ExcludeFromLastRunBoon,
					GodLoot = enemyData.GodLoot,
				}

				if not IsEmpty(enemyData.WeaponUpgrades) then
					fieldLootEntry.TraitIndex = fieldLootEntry.TraitIndex and ToLookup(enemyData.WeaponUpgrades)
				end

				FieldLootData[enemyName] = fieldLootEntry
			end

			local traitDictionary = {}
			ScreenData.BoonInfo.TraitDictionary[enemyName] = {}
			ScreenData.BoonInfo.TraitSortOrder[enemyName] = {}

			if enemyData.TraitSortOrder then
				ScreenData.BoonInfo.TraitSortOrder[enemyName] = ShallowCopyTable(enemyData.TraitSortOrder)
			else
				if enemyData.WeaponUpgrades then
					ScreenData.BoonInfo.TraitSortOrder[enemyName] = ConcatTableValuesIPairs(ScreenData.BoonInfo.TraitSortOrder[enemyName], enemyData.WeaponUpgrades)
				end
				if enemyData.Traits then
					ScreenData.BoonInfo.TraitSortOrder[enemyName] = ConcatTableValuesIPairs(ScreenData.BoonInfo.TraitSortOrder[enemyName], enemyData.Traits)
				end
			end

			if enemyData.WeaponUpgrades ~= nil then
				for i, traitName in pairs(enemyData.WeaponUpgrades) do
					traitDictionary[traitName] = true
					ScreenData.BoonInfo.TraitDictionary[enemyName][traitName] = true
				end
				if IsEmpty(enemyData.PriorityUpgrades) then
					enemyData.PriorityUpgrades = enemyData.WeaponUpgrades
				end
			end
			if enemyData.Traits ~= nil then
				for i, traitName in pairs(enemyData.Traits) do
					traitDictionary[traitName] = true
					ScreenData.BoonInfo.TraitDictionary[enemyName][traitName] = true
				end
			end
			if enemyData.PermanentTraits ~= nil then
				for i, traitName in pairs(enemyData.PermanentTraits) do
					traitDictionary[traitName] = true
					ScreenData.BoonInfo.TraitDictionary[enemyName][traitName] = true
				end
			end
			if enemyData.TemporaryTraits ~= nil then
				for i, traitName in pairs(enemyData.TemporaryTraits) do
					traitDictionary[traitName] = true
					ScreenData.BoonInfo.TraitDictionary[enemyName][traitName] = true
				end
			end
			if enemyData.Consumables ~= nil then
				for i, consumableName in pairs(enemyData.Consumables) do
					ScreenData.BoonInfo.TraitDictionary[enemyName][consumableName] = true
				end
			end
			enemyData.TraitIndex = traitDictionary
			ProcessTextLines(enemyData, enemyData.InteractTextLineSets, "InteractTextLinePriorities", { DefaultStatusAnimation = StatusAnimations.WantsToTalk })
			ProcessTextLines(enemyData, enemyData.RejectionTextLines, nil, args)
			ProcessTextLines(enemyData, enemyData.MakeUpTextLines, nil, args)
			ProcessTextLines(enemyData, enemyData.BoughtTextLines, nil, args)
			ProcessTextLines(enemyData, enemyData.DuoPickupTextLines, nil, args)
			ProcessTextLines(enemyData, enemyData.GiftTextLineSets, "GiftTextLinePriorities", args)

			ProcessTextLines(enemyData, enemyData.BossIntroTextLineSets, "BossIntroTextLinePriorities", args)
			ProcessTextLines(enemyData, enemyData.BossPhaseChangeTextLineSets, "BossPhaseChangeTextLinePriorities", args)
			ProcessTextLines(enemyData, enemyData.BossOutroTextLineSets, "BossOutroTextLinePriorities", args)
			ProcessTextLines(enemyData, enemyData.DeathPresentationTextLineSets, nil, args)
		end

		for traitName, traitData in pairs(TraitData) do
			traitData.Name = traitName
			ProcessDataInheritance(traitData, TraitData)
			local autoExpandProperties = {
				WeaponProperties = "WeaponProperty",
				ProjectileProperties = "ProjectileProperty",
				EffectProperties = "EffectProperty",
			}

			if traitData.PropertyChanges ~= nil and not traitData.ExpandedProperties then
				local addlPropertyChanges = {}
				for k, propertyChange in pairs(traitData.PropertyChanges) do
					for expandFromName, expandToName in pairs(autoExpandProperties) do
						if propertyChange[expandFromName] then
							for property, changeValue in pairs(propertyChange[expandFromName]) do
								if property ~= "ReportValues" then
									local newPropertyChange = ShallowCopyTable(propertyChange)
									for autoExpandPropertyName in pairs(autoExpandProperties) do
										newPropertyChange[autoExpandPropertyName] = nil
									end
									newPropertyChange[expandToName] = property
									newPropertyChange.ChangeValue = changeValue
									newPropertyChange.ChangeType = "Absolute"
									if propertyChange[expandFromName].ReportValues then
										for reportKey, reportSourceName in pairs(propertyChange[expandFromName].ReportValues) do
											if reportSourceName == property then
												newPropertyChange.ReportValues = {}
												newPropertyChange.ReportValues[reportKey] = "ChangeValue"
											end
										end
									end
									table.insert(addlPropertyChanges, newPropertyChange)
								end
							end
						end
					end
					if propertyChange.SpeedPropertyChanges then
						local weaponNames = ShallowCopyTable(propertyChange.WeaponNames)
						if weaponNames == nil then
							weaponNames = { propertyChange.WeaponName }
						end
						for q, weaponName in pairs(weaponNames) do
							local newPropertyChanges = DeepCopyTable(WeaponData.DefaultWeaponValues.DefaultSpeedPropertyChanges)
							if WeaponData[weaponName] and WeaponData[weaponName].SpeedPropertyChanges then
								newPropertyChanges = DeepCopyTable(WeaponData[weaponName].SpeedPropertyChanges)
							end
							for s, newPropertyChange in pairs(newPropertyChanges) do
								newPropertyChange = MergeTables(newPropertyChange, propertyChange)
								newPropertyChange.WeaponNames = nil
								newPropertyChange.WeaponName = weaponName
								newPropertyChange.ChangeType = "Multiply"
								if newPropertyChange.InvertSource then
									if newPropertyChange.ChangeValue then
										newPropertyChange.ChangeValue = 1 / newPropertyChange.ChangeValue
									end
									if newPropertyChange.BaseValue then
										newPropertyChange.BaseValue = 1 / newPropertyChange.BaseValue
									end
								end
								newPropertyChange.SpeedPropertyChanges = nil
								table.insert(addlPropertyChanges, newPropertyChange)
							end
						end
					end
				end
				if not IsEmpty(addlPropertyChanges) then
					ConcatTableValues(traitData.PropertyChanges, addlPropertyChanges)
					traitData.ExpandedProperties = true
				end
			end
			if not traitData.ExcludeLinked then
				if traitData.DamageOnFireWeapons and not traitData.DamageOnFireWeapons.ExcludeLinked then
					traitData.DamageOnFireWeapons.WeaponNames = AddLinkedWeapons(traitData.DamageOnFireWeapons.WeaponNames)
				end
				if traitData.AddOutgoingLifestealModifiers then
					if traitData.AddOutgoingLifestealModifiers.ValidWeapons then
						if not traitData.AddOutgoingLifestealModifiers.ExcludeLinked then
							traitData.AddOutgoingLifestealModifiers.ValidWeapons = AddLinkedWeapons(traitData.AddOutgoingLifestealModifiers.ValidWeapons)
						end
						traitData.AddOutgoingLifestealModifiers.ValidWeaponsLookup = ToLookup(traitData.AddOutgoingLifestealModifiers.ValidWeapons)
					end
				end
				if traitData.DamageClamps and traitData.DamageClamps.ValidProjectiles then
					traitData.DamageClamps.ValidProjectilesLookup = ToLookup(traitData.DamageClamps.ValidProjectiles)
				end
				if traitData.AddOutgoingDamageModifiers then
					if traitData.AddOutgoingDamageModifiers.ValidWeapons then
						if not traitData.AddOutgoingDamageModifiers.ExcludeLinked then
							traitData.AddOutgoingDamageModifiers.ValidWeapons = AddLinkedWeapons(traitData.AddOutgoingDamageModifiers.ValidWeapons)
						end
						traitData.AddOutgoingDamageModifiers.ValidWeaponsLookup = ToLookup(traitData.AddOutgoingDamageModifiers.ValidWeapons)
					end
					if traitData.AddOutgoingDamageModifiers.ValidProjectiles then
						traitData.AddOutgoingDamageModifiers.ValidProjectilesLookup = ToLookup(traitData.AddOutgoingDamageModifiers.ValidProjectiles)
					end
					if traitData.AddOutgoingDamageModifiers.ValidEnchantments and not traitData.AddOutgoingDamageModifiers.ExcludeLinked then
						for key, weaponNames in pairs(traitData.AddOutgoingDamageModifiers.ValidEnchantments.TraitDependentWeapons) do
							traitData.AddOutgoingDamageModifiers.ValidEnchantments.TraitDependentWeapons[key] = AddLinkedWeapons(weaponNames)
						end

						if traitData.AddOutgoingDamageModifiers.ValidEnchantments.ValidWeapons then
							traitData.AddOutgoingDamageModifiers.ValidEnchantments.ValidWeapons = AddLinkedWeapons(traitData.AddOutgoingDamageModifiers.ValidEnchantments.ValidWeapons)
						end
					end
					if traitData.AddOutgoingDamageModifiers.EmptySlotValidData then
						for key, weaponNames in pairs(traitData.AddOutgoingDamageModifiers.EmptySlotValidData) do
							traitData.AddOutgoingDamageModifiers.EmptySlotValidData[key] = AddLinkedWeapons(weaponNames)
						end
					end
				end

				if traitData.AddOutgoingDamageModifiersArray then
					for i, data in pairs(traitData.AddOutgoingDamageModifiersArray) do
						if data.ValidWeapons then
							if not data.ExcludeLinked then
								data.ValidWeapons = AddLinkedWeapons(data.ValidWeapons)
							end
							data.ValidWeaponsLookup = ToLookup(data.ValidWeapons)
						end
						if data.ValidProjectiles then
							data.ValidProjectilesLookup = ToLookup(data.ValidProjectiles)
						end
						if data.ValidEnchantments and not data.ExcludeLinked then
							for key, weaponNames in pairs(data.ValidEnchantments.TraitDependentWeapons) do
								data.ValidEnchantments.TraitDependentWeapons[key] = AddLinkedWeapons(weaponNames)
							end

							if data.ValidEnchantments.ValidWeapons then
								data.ValidEnchantments.ValidWeapons = AddLinkedWeapons(data.ValidEnchantments.ValidWeapons)
							end
						end
						if data.EmptySlotValidData then
							for key, weaponNames in pairs(data.EmptySlotValidData) do
								data.EmptySlotValidData[key] = AddLinkedWeapons(weaponNames)
							end
						end
					end
				end

				if traitData.AddOutgoingCritModifiers then
					if traitData.AddOutgoingCritModifiers.ValidWeapons then
						if not traitData.AddOutgoingCritModifiers.ExcludeLinked then
							traitData.AddOutgoingCritModifiers.ValidWeapons = AddLinkedWeapons(traitData.AddOutgoingCritModifiers.ValidWeapons)
						end
						traitData.AddOutgoingCritModifiers.ValidWeaponsLookup = ToLookup(traitData.AddOutgoingCritModifiers.ValidWeapons)
					end
					if traitData.AddOutgoingCritModifiers.ValidProjectiles then
						traitData.AddOutgoingCritModifiers.ValidProjectilesLookup = ToLookup(traitData.AddOutgoingCritModifiers.ValidProjectiles)
					end
				end
				if traitData.AddOutgoingDoubleDamageModifiers then
					if traitData.AddOutgoingDoubleDamageModifiers.ValidWeapons then
						if not traitData.AddOutgoingDoubleDamageModifiers.ExcludeLinked then
							traitData.AddOutgoingDoubleDamageModifiers.ValidWeapons = AddLinkedWeapons(traitData.AddOutgoingDoubleDamageModifiers.ValidWeapons)
						end
						traitData.AddOutgoingDoubleDamageModifiers.ValidWeaponsLookup = ToLookup(traitData.AddOutgoingDoubleDamageModifiers.ValidWeapons)
					end
				end

				if traitData.ChargeStageModifiers then
					if traitData.ChargeStageModifiers.ValidWeapons then
						if not traitData.ChargeStageModifiers.ExcludeLinked then
							traitData.ChargeStageModifiers.ValidWeapons = AddLinkedWeapons(traitData.ChargeStageModifiers.ValidWeapons)
						end
						traitData.ChargeStageModifiers.ValidWeaponsLookup = ToLookup(traitData.ChargeStageModifiers.ValidWeapons)
					end
				end

				if traitData.ChargeStageModifiersArray then
					for i, data in pairs(traitData.ChargeStageModifiersArray) do
						if data.ValidWeapons then
							if not data.ExcludeLinked then
								data.ValidWeapons = AddLinkedWeapons(data.ValidWeapons)
							end
							data.ValidWeaponsLookup = ToLookup(data.ValidWeapons)
						end
					end
				end

				if traitData.OnWeaponChargeFunctions then
					if traitData.OnWeaponChargeFunctions.ValidWeapons then
						if not traitData.OnWeaponChargeFunctions.ExcludeLinked then
							traitData.OnWeaponChargeFunctions.ValidWeapons = AddLinkedWeapons(traitData.OnWeaponChargeFunctions.ValidWeapons)
						end
					end
				end
				if traitData.OnWeaponFiredFunctions then
					if traitData.OnWeaponFiredFunctions.ValidWeapons then
						if not traitData.OnWeaponFiredFunctions.ExcludeLinked then
							traitData.OnWeaponFiredFunctions.ValidWeapons = AddLinkedWeapons(traitData.OnWeaponFiredFunctions.ValidWeapons)
						end
						traitData.OnWeaponFiredFunctions.ValidWeaponsLookup = ToLookup(traitData.OnWeaponFiredFunctions.ValidWeapons)
					end
				end
				if traitData.OnWeaponChargeCanceledFunctions then
					if traitData.OnWeaponChargeCanceledFunctions.ValidWeapons then
						if not traitData.OnWeaponChargeCanceledFunctions.ExcludeLinked then
							traitData.OnWeaponChargeCanceledFunctions.ValidWeapons = AddLinkedWeapons(traitData.OnWeaponChargeCanceledFunctions.ValidWeapons)
						end
					end
				end
				if traitData.OnProjectileDeathFunction then
					if traitData.OnProjectileDeathFunction.ValidWeapons then
						if not traitData.OnProjectileDeathFunction.ExcludeLinked then
							traitData.OnProjectileDeathFunction.ValidWeapons = AddLinkedWeapons(traitData.OnProjectileDeathFunction.ValidWeapons)
						end
						traitData.OnProjectileDeathFunction.ValidWeaponsLookup = ToLookup(traitData.OnProjectileDeathFunction.ValidWeapons)
					end
					if traitData.OnProjectileDeathFunction.ValidProjectiles then
						traitData.OnProjectileDeathFunction.ValidProjectilesLookup = ToLookup(traitData.OnProjectileDeathFunction.ValidProjectiles)
					end
				end
				if traitData.OnProjectileCreationFunction then
					if traitData.OnProjectileCreationFunction.ValidProjectiles then
						traitData.OnProjectileCreationFunction.ValidProjectilesLookup = ToLookup(traitData.OnProjectileCreationFunction.ValidProjectiles)
					end
				end
				if traitData.OnEnemyDamagedAction then
					if traitData.OnEnemyDamagedAction.ValidWeapons then
						if not traitData.OnEnemyDamagedAction.ExcludeLinked then
							traitData.OnEnemyDamagedAction.ValidWeapons = AddLinkedWeapons(traitData.OnEnemyDamagedAction.ValidWeapons)
						end
						traitData.OnEnemyDamagedAction.ValidWeaponsLookup = ToLookup(traitData.OnEnemyDamagedAction.ValidWeapons)
					end
					if traitData.OnEnemyDamagedAction.ValidProjectiles then
						traitData.OnEnemyDamagedAction.ValidProjectilesLookup = ToLookup(traitData.OnEnemyDamagedAction.ValidProjectiles)
					end
					if traitData.OnEnemyDamagedAction.ExcludeProjectiles then
						traitData.OnEnemyDamagedAction.ExcludeProjectilesLookup = ToLookup(traitData.OnEnemyDamagedAction.ExcludeProjectiles)
					end
					if traitData.OnEnemyDamagedAction.Args then
						if traitData.OnEnemyDamagedAction.Args.TraitWeaponMappings then
							for traitName, weaponList in pairs(traitData.OnEnemyDamagedAction.Args.TraitWeaponMappings) do
								traitData.OnEnemyDamagedAction.Args.TraitWeaponMappings[traitName] = AddLinkedWeapons(weaponList)
							end
							traitData.OnEnemyDamagedAction.Args.TraitWeaponMappingsLookup = {}
							for traitName, weaponList in pairs(traitData.OnEnemyDamagedAction.Args.TraitWeaponMappings) do
								for i, weaponName in pairs(weaponList) do
									traitData.OnEnemyDamagedAction.Args.TraitWeaponMappingsLookup[weaponName] = traitName
								end
							end
						end
						if traitData.OnEnemyDamagedAction.Args.MultihitWeaponWhitelist then
							if not traitData.OnEnemyDamagedAction.Args.ExcludeLinked then
								traitData.OnEnemyDamagedAction.Args.MultihitWeaponWhitelist = AddLinkedWeapons(traitData.OnEnemyDamagedAction.Args.MultihitWeaponWhitelist)
							end
							traitData.OnEnemyDamagedAction.Args.MultihitWeaponWhitelistLookup = ToLookup(traitData.OnEnemyDamagedAction.Args.MultihitWeaponWhitelist)
						end
						if traitData.OnEnemyDamagedAction.Args.MultihitProjectileWhitelist then
							traitData.OnEnemyDamagedAction.Args.MultihitProjectileWhitelistLookup = ToLookup(traitData.OnEnemyDamagedAction.Args.MultihitProjectileWhitelist)
						end
						if traitData.OnEnemyDamagedAction.Args.ValidProjectiles then
							traitData.OnEnemyDamagedAction.Args.ValidProjectilesLookup = ToLookup(traitData.OnEnemyDamagedAction.Args.ValidProjectiles)
						end
						if traitData.OnEnemyDamagedAction.Args.ValidEffectNames then
							traitData.OnEnemyDamagedAction.Args.ValidEffectNamesLookup = ToLookup(traitData.OnEnemyDamagedAction.Args.ValidEffectNames)
						end
					end
				end
			end
			if traitData.AddWeaponsToTraits and traitData.AddWeaponsToTraits.WeaponNames then
				if not traitData.AddWeaponsToTraits.ExcludeLinked then
					traitData.AddWeaponsToTraits.WeaponNames = AddLinkedWeapons(traitData.AddWeaponsToTraits.WeaponNames)
				end

				traitData.AddWeaponsToTraits.WeaponNamesLookup = ToLookup(traitData.AddWeaponsToTraits.WeaponNames)
			end
			if traitData.ManaCostModifiers and traitData.ManaCostModifiers.WeaponNames then
				if not traitData.ManaCostModifiers.ExcludeLinked then
					traitData.ManaCostModifiers.WeaponNames = AddLinkedWeapons(traitData.ManaCostModifiers.WeaponNames)
				end

				traitData.ManaCostModifiers.WeaponNamesLookup = ToLookup(traitData.ManaCostModifiers.WeaponNames)
			end
			if traitData.WeaponSpeedMultiplier and traitData.WeaponSpeedMultiplier.WeaponNames then
				if not traitData.WeaponSpeedMultiplier.ExcludeLinked then
					traitData.WeaponSpeedMultiplier.WeaponNames = AddLinkedWeapons(traitData.WeaponSpeedMultiplier.WeaponNames)
				end

				traitData.WeaponSpeedMultiplier.WeaponNamesLookup = ToLookup(traitData.WeaponSpeedMultiplier.WeaponNames)
			end
			if traitData.OnResourceMaxHealth then
				traitData.OnResourceMaxHealth.ResourceNamesLookup = ToLookup(traitData.OnResourceMaxHealth.ResourceNames)
			end
			if traitData.OnResourceMaxMana then
				traitData.OnResourceMaxMana.ResourceNamesLookup = ToLookup(traitData.OnResourceMaxMana.ResourceNames)
			end
			if traitData.WeaponDataOverride then
				for weaponName, weaponData in pairs(traitData.WeaponDataOverride) do
					if weaponData.Sounds ~= nil then
						for _, key in pairs({ "ChargeSounds", "ChargeStageSounds" }) do
							if weaponData.Sounds[key] then
								for k, soundElement in pairs(weaponData.Sounds[key]) do
									if soundElement.StoppedBy ~= nil then
										soundElement.StoppedByLookup = soundElement.StoppedByLookup or {}
										for k, eventName in pairs(soundElement.StoppedBy) do
											soundElement.StoppedByLookup[eventName] = true
										end
									end
								end
							end
						end
					end
				end
			end
			local roomExitTraitKeys = {
				DoorHeal = "CheckDoorHealTrait",
				DoorHealFixed = "CheckDoorHealTrait",
				DoorHealIgnorePenaltyFixed = "CheckDoorHealTrait",
				DoorFullHealThreshold = "CheckDoorHealTrait",
				DoorHealThreshold = "CheckDoorHealTrait",
				DoorHealReserve = "CheckDoorHealTrait",
				DoorArmor = "CheckDoorArmorTrait",
				DoorCash = "CheckDoorGoldTrait",
			}

			for key, functionName in pairs(roomExitTraitKeys) do
				if traitData[key] then
					traitData.LeaveRoomFunctionName = functionName
				end
			end

			traitData.TraitOrderingValueCache = GetTraitOrderingValue(traitData)
		end

		for lootName, lootData in pairs(LootData) do
			ProcessDataInheritance(lootData, LootData)
			if lootData.PropertyChanges ~= nil then
				for k, propertyChange in pairs(lootData.PropertyChanges) do
					AddFormattedPercentageChangeValues(propertyChange)
				end
			end

			local traitDictionary = {}
			ScreenData.BoonInfo.TraitDictionary[lootName] = {}
			ScreenData.BoonInfo.TraitSortOrder[lootName] = {}

			if lootData.TraitSortOrder then
				ScreenData.BoonInfo.TraitSortOrder[lootName] = ShallowCopyTable(lootData.TraitSortOrder)
			else
				if lootData.WeaponUpgrades then
					ScreenData.BoonInfo.TraitSortOrder[lootName] = ConcatTableValuesIPairs(ScreenData.BoonInfo.TraitSortOrder[lootName], lootData.WeaponUpgrades)
				end
				if lootData.Traits then
					ScreenData.BoonInfo.TraitSortOrder[lootName] = ConcatTableValuesIPairs(ScreenData.BoonInfo.TraitSortOrder[lootName], lootData.Traits)
				end
			end

			if lootData.WeaponUpgrades ~= nil then
				for i, traitName in pairs(lootData.WeaponUpgrades) do
					traitDictionary[traitName] = true
					ScreenData.BoonInfo.TraitDictionary[lootName][traitName] = true
				end
				if IsEmpty(lootData.PriorityUpgrades) then -- custom
					lootData.PriorityUpgrades = lootData.WeaponUpgrades
				end
			end
			if lootData.Traits ~= nil then
				for i, traitName in pairs(lootData.Traits) do
					traitDictionary[traitName] = true
					ScreenData.BoonInfo.TraitDictionary[lootName][traitName] = true
				end
			end
			if lootData.PermanentTraits ~= nil then
				for i, traitName in pairs(lootData.PermanentTraits) do
					traitDictionary[traitName] = true
					ScreenData.BoonInfo.TraitDictionary[lootName][traitName] = true
				end
			end
			if lootData.TemporaryTraits ~= nil then
				for i, traitName in pairs(lootData.TemporaryTraits) do
					traitDictionary[traitName] = true
					ScreenData.BoonInfo.TraitDictionary[lootName][traitName] = true
				end
			end
			if lootData.Consumables ~= nil then
				for i, consumableName in pairs(lootData.Consumables) do
					ScreenData.BoonInfo.TraitDictionary[lootName][consumableName] = true
				end
			end
			lootData.TraitIndex = traitDictionary
			ProcessTextLines(lootData, lootData.InteractTextLineSets, "InteractTextLinePriorities", args)
			ProcessTextLines(lootData, lootData.RejectionTextLines, nil, args)
			ProcessTextLines(lootData, lootData.MakeUpTextLines, nil, args)
			ProcessTextLines(lootData, lootData.BoughtTextLines, nil, args)
			ProcessTextLines(lootData, lootData.DuoPickupTextLines, nil, args)
			ProcessTextLines(lootData, lootData.GiftTextLineSets, "GiftTextLinePriorities", args)
		end

		for traitName, linkedData in pairs(TraitRequirements) do
			-- Process type of link
			ScreenData.BoonInfo.TraitRequirementsDictionary[traitName] = DeepCopyTable(linkedData)
			if linkedData.OneOf then
				ScreenData.BoonInfo.TraitRequirementsDictionary[traitName].Type = "OneOf"
			elseif linkedData.TwoOf then
				ScreenData.BoonInfo.TraitRequirementsDictionary[traitName].Type = "TwoOf"
			elseif linkedData.OneFromEachSet then
				ScreenData.BoonInfo.TraitRequirementsDictionary[traitName].Type = "OneFromEachSet"
				if TableLength(linkedData.OneFromEachSet) == 3 and #linkedData.OneFromEachSet[1] == #linkedData.OneFromEachSet[2] and #linkedData.OneFromEachSet[2] == #linkedData.OneFromEachSet[3] then
					ScreenData.BoonInfo.TraitRequirementsDictionary[traitName].Type = "TwoOf"
				end
			end
		end
	end)
end)
