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
local MacroTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/MacroText.sjson")
local GUIScreensVFXFile = rom.path.combine(rom.paths.Content, "Game/Animations/GUI_Screens_VFX.sjson")
local ItemsGeneralVFX = rom.path.combine(rom.paths.Content, "Game/Animations/Items_General_VFX.sjson")
local ScreenText = rom.path.combine(rom.paths.Content, "Game/Text/en/ScreenText.en.sjson")
local TraitTextFile = rom.path.combine(rom.paths.Content, "Game/Text/en/TraitText.en.sjson")
local PortraitFile = rom.path.combine(rom.paths.Content, "Game/Animations/GUI_Portraits_VFX.sjson")

local TextOrder = { "Id", "DisplayName", "Description" }
local IconOrder = { "Name", "InheritFrom", "FilePath", "OffsetY", "OffsetZ", "Scale", "Hue" }
local GameplayOrder = { "Name", "InheritFrom", "DisplayInEditor", "Thing" }
local VFXMainOrder = { "Name", "InheritFrom", "ChildAnimation", "CreateAnimations", "Color", "NumFrames", "FilePath", "OffsetZ", "Scale", "ColorFromOwner", "AngleFromOwner", "Sound" }
local PortraitOrder = { "Name", "InheritFrom", "ChildAnimation", "CreateAnimation", " CreateAnimations", "EndFrame", "StartFrame", "FilePath", "Sound", "StartRed", "StartGreen", "StartBlue", "EndRed", "EndGreen", "EndBlue", "VisualFx" }

local requirementNames = { MaxHealthDrop = true, MaxManaDrop = true, RoomMoneyDrop = true, StackUpgrade = true, Devotion = true }

function public.Initialize()
	rom.log.warning("Initialize is now a `DEFUNCT` function, it no longer does anything, you now pass in your _PLUGIN.guid into any function that requires it.")
end

-- Gods like Zeus/Ares/etc or NPC Gods like Hermes.
--TODO Document that you need to add spawn requirements if NPC God
function public.InitializeGod(params)
	if not params then
		rom.log.error("InitializeGod: Missing parameter 'params''")
		return nil
	end

	local requiredList = { "godName", "godType" }
	for _, field in ipairs(requiredList) do
		if not params[field] then
			rom.log.error("InitializeGod: Missing required parameter '" .. field .. "'")
		end
	end

	local upgradeName = params.godName .. "Upgrade"

	local baseGod = {
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
		MenuTitle = "UpgradeChoiceMenu_" .. params.godName,

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

		LoadPackages = params.LoadPackages or {}, -- Need it for the animations for in person
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
		InteractTextLineSets = params.InteractTextLineSets or {},
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

	local lowGodType = string.lower(params.godType)

	if lowGodType == "npcgod" then
		local addToBase = {
			--! Stuff for NPC Gods like Hermes
			SpecialInteractFunctionName = "SpecialInteractSalute",
			SpecialInteractGameStateRequirements = {
				{
					PathTrue = { "GameState", "UseRecord", upgradeName },
				},
			},
			SpecialInteractCooldown = 60,

			GodLoot = false,
			TreatAsGodLootByShops = true,
			BoonInfoTitleText = "UpgradeChoiceMenu_" .. params.godName,
			SurfaceShopIcon = "BoonInfoSymbol" .. params.godName .. "Icon",
			SurfaceShopText = upgradeName .. "_Store",
		}

		for k, v in pairs(addToBase) do
			baseGod[k] = v
		end

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

	for k, v in pairs(params) do
		baseGod[k] = v
	end

	registerEntityData(params.godName, lowGodType, baseGod)
end

--#region npc
-- function public.InitializeNPC(npcName, godType, params)
-- 	if not modstate.initialized then
-- 		rom.log.error("You must first Initialize your plugin guid, please use `GodsAPI.Initialize`")
-- 	end

-- 	if not npcName then
-- 		rom.log.error("InitializeGod: Missing required parameters `npcName`")
-- 	end

-- 	local baseGod = {
-- 		Name = "NPC_" .. npcName .. "_01",
-- 		Groups = { "NPCs" },
-- 		DamageType = "Neutral",

-- 		LoadPackages = params.LoadPackages or {}, -- Need it for the animations for in person

-- 		RepulseOnMeleeInvulnerableHit = params.RepulseOnMeleeInvulnerableHit or 150,
-- 		RarityUpgradeVoiceLines = params.RarityUpgradeVoiceLines or { [1] = { GlobalVoiceLines = "ZagreusRarifyVoiceLines" } },

-- 		NarrativeTextColor = params.NarrativeTextColor or { 32, 32, 30, 255 },
-- 		NameplateSpeakerNameColor = params.NameplateSpeakerNameColor or game.Color.DialogueSpeakerNameOlympian,
-- 		NameplateDescriptionColor = params.NameplateDescriptionColor or { 145, 45, 90, 255 },
-- 		LightingColor = params.LightingColor or { 1, 0.91, 0.54, 1 },
-- 		LootColor = params.LootColor or { 255, 128, 32, 255 },
-- 		SubtitleColor = params.SubtitleColor or { 255, 255, 205, 255 },

-- 		UpgradeScreenOpenFunctionName = params.UpgradeScreenOpenFunctionName,
-- 		RequiredRoomInteraction = params.RequiredRoomInteraction or true,
-- 		Traits = params.Traits or {},

-- 		--
-- 		EmoteOffsetY = -320,
-- 		UpgradeScreenOpenSound = "/SFX/DionysusBoonWineLaugh",
-- 		BoxAnimation = "DialogueSpeechBubbleLight",
-- 		MenuTitle = "UpgradeChoiceMenu_Dionysus",
-- 		TreatAsGodLootByShops = true,
-- 		UpgradeSelectedSound = "/SFX/DionysusBoonChoice",
-- 		InteractTextLineSets = {},
-- 		Using = {
-- 			Animation = "DionysusLobProjectileSmoke",
-- 		},
-- 		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
-- 		AnimOffsetZ = 50,
-- 		FlavorTextIds = {
-- 			"DionysusUpgrade_FlavorText01",
-- 			"DionysusUpgrade_FlavorText02",
-- 			"DionysusUpgrade_FlavorText03",
-- 		},
-- 		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
-- 		Portrait = "Portrait_Dionysus_Default_01",
-- 		SpeakerName = "Dionysus",
-- 		UpgradeMenuOpenVoiceLines = {},
-- 		OnUsedFunctionName = "UseLoot",
-- 		BoxExitAnimation = "DialogueSpeechBubbleLightOut",
-- 		SimulationSlowOnHit = false,
-- 		EmoteOffsetX = -30,
-- 		UseShrineUpgrades = false,
-- 		RequireUseToGift = true,
-- 		PreEventFunctionName = "AngleNPCToHero",
-- 		Icon = "BoonSymbolDionysus",
-- 		SpecialInteractCooldown = 60,
-- 		ActivateRequirements = {},
-- 		CanBeFrozen = false,
-- 		AlwaysShowDefaultUseText = true,
-- 		InvincibubbleScale = 1.5,
-- 		BlockPolymorph = true,
-- 		UsePromptOffsetY = -80,
-- 		TriggersOnDamageEffects = false,
-- 		BlocksLootInteraction = false,
-- 		SpecialInteractGameStateRequirements = {
-- 			{
-- 				PathTrue = { "GameState", "UseRecord", "NPC_Dionysus_01" },
-- 			},
-- 		},
-- 		SpecialInteractFunctionName = "SpecialInteractSalute",
-- 		TriggersOnHitEffects = true,
-- 		DropItemsOnDeath = false,
-- 		BlockLifeSteal = true,
-- 		GiftTextLineSets = {},
-- 		CanReceiveGift = true,
-- 		UsePromptOffsetX = 50,
-- 		PostTextLineEvents = {
-- 			{
-- 				FunctionName = "PartnersChattingPresentation",
-- 				Threaded = true,
-- 			},
-- 		},
-- 		ManualRecordUse = true,
-- 		IgnoreAutoLock = true,
-- 		UpgradeAcquiredAnimation = "MelinoeSalute",
-- 		MaxHitShields = 5,
-- 		BlockWrathGain = true,
-- 		TurnInPlaceAnimation = "Dionysus_Turn",
-- 		HideLevelDisplay = true,
-- 		UpgradeAcquiredAnimationDelay = 1.2,
-- 		RecheckConversationOnLootPickup = true,
-- 		SkipModifiers = true,
-- 		SkipDamagePresentation = true,
-- 		SkipDamageText = true,
-- 		AggroMinimumDistance = 500,
-- 		OnHitVoiceLines = {},
-- 		GiftGivenVoiceLines = {
-- 			{
-- 				Cue = "/VO/MelinoeField_2396",
-- 				Text = "I'm most grateful... and wish I could stay for the festivities.",
-- 				PlayFromTarget = true,
-- 				BreakIfPlayed = true,
-- 				PreLineWait = 1,
-- 			},
-- 		},
-- 		InteractVoiceLines = {},
-- 		NarrativeContextArtFlippable = false,
-- 		AttachedAnimationName = "MedeaGlow",
-- 	}
-- 	if params.OnUsedFunctionArgs then
-- 		local addToBase = {
-- 			OnUsedFunctionArgs = {
-- 				PreserveContextArt = true,
-- 				SkipInteractAnim = true,
-- 				SkipSound = true,
-- 				PackageName = "NPC_" .. npcName .. "_01",
-- 				ResetUseText = true,
-- 			},
-- 		}

-- 		for k, v in pairs(addToBase) do
-- 			baseGod[k] = v
-- 		end
-- 	end

-- 	local lowGodType = string.lower(godType)

-- 	for k, v in pairs(params) do
-- 		baseGod[k] = v
-- 	end

-- 	registerEntityData(npcName, lowGodType, baseGod)
-- end
--#endregion

--#region selene
-- Selene type shi
--* Too many functions run on the fact that there is only one "SpellDrop" - even if I add a spell lib there are a lot of functions that need to be reworked.
-- function public.InitializeSpellGod(spellName, params)
-- 	if not modstate.initialized then
-- 		rom.log.error("You must first Initialize your plugin guid, please use `GodsAPI.Initialize`")
-- 	end

-- 	local baseSpellDrop = {
-- 		-- GameStateRequirements handled in RunProgress table
-- 		Name = "SpellDrop",
-- 		TraitIndex = nil,
-- 		InheritFrom = nil,

-- 		OnUsedFunctionName = "OpenSpellScreen",
-- 		SpawnSound = "/SFX/SeleneMoonDrop",
-- 		ConsumeSound = "/SFX/SeleneMoonPickup",

-- 		DoorIcon = "SpellDropPreview",
-- 		UseText = "UseSpellDrop",
-- 		UseTextTalkAndGift = "UseLootAndGift",
-- 		UseTextTalkAndSpecial = "UseLootAndSpecial",
-- 		UseTextTalkGiftAndSpecial = "UseLootGiftAndSpecial",
-- 		BlockedLootInteractionText = "UseLootLocked",
-- 		ManualRecordUse = true,
-- 		CanReceiveGift = true,
-- 		RequireUseToGift = true,
-- 		AlwaysShowDefaultUseText = true,
-- 		BlockExitText = "ExitBlockedByMoney",
-- 		PlayInteract = true,
-- 		HideWorldText = true,
-- 		ExitUnlockDelay = 1.1,
-- 		TextLinesIgnoreQuests = true,
-- 		BoonInfoTitleText = "Codex_BoonInfo_Selene",
-- 		SubtitleColor = Color.SeleneVoice,
-- 		SurfaceShopText = "SpellDrop_Store",
-- 		SurfaceShopIcon = "SpellDropPreview",
-- 		AnimOffsetZ = 100,
-- 		ReplaceSpecialForGoldify = true,
-- 		GoldifyValue = 500,
-- 		GoldConversionEligible = true,
-- 		ResourceCosts = {
-- 			Money = 100,
-- 		},
-- 		SetupEvents = {
-- 			{
-- 				FunctionName = "PregenerateSpells",
-- 			},
-- 		},
-- 		ConfirmSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
-- 		Color = { 100, 25, 255, 255 },
-- 		LightingColor = { 100, 25, 255, 255 },
-- 		LootColor = { 100, 25, 255, 255 },
-- 		PortraitEnterSound = "/SFX/Menu Sounds/LegendaryBoonShimmer",
-- 		SpeakerName = "Selene",
-- 		Speaker = "NPC_Selene_01",
-- 		LoadPackages = { "Selene" },
-- 		Portrait = "Portrait_Selene_Default_01",
-- 		NarrativeContextArt = "DialogueBackground_Moon",
-- 		SuperSacrificeCombatText = "SuperSacrifice_CombatText_SeleneUpgrade",
-- 		Gender = "F",
-- 		FlavorTextIds = {
-- 			"SpellDrop_FlavorText01",
-- 			"SpellDrop_FlavorText02",
-- 			"SpellDrop_FlavorText03",
-- 		},
-- 		SpecialInteractFunctionName = "SpecialInteractSalute",
-- 		SpecialInteractGameStateRequirements = {
-- 			{
-- 				PathTrue = { "GameState", "UseRecord", "SpellDrop" },
-- 			},
-- 		},
-- 		SpecialInteractCooldown = 60,
-- 		InteractVoiceLines = {
-- 			{ GlobalVoiceLines = "SeleneSaluteLines" },
-- 		},
-- 		PickupFunctionName = "SpellDropInteractPresentation",
-- 		PickupVoiceLines = {},
-- 		FirstSpawnVoiceLines = {},
-- 		OnSpawnVoiceLines = {},
-- 		UpgradeMenuOpenVoiceLines = {},
-- 		InteractTextLineSets = {},
-- 		GiftTextLineSets = {},
-- 		GiftGivenVoiceLines = {},
-- 		UsingInPortraitPackage = { "DialogueBackground_Moon_In" },
-- 	}

-- 	for k, v in pairs(params or {}) do
-- 		baseSpellDrop[k] = v
-- 	end

-- 	table.insert(queueToAdd, {
-- 		entityName = spellName,
-- 		entityType = "spell",
-- 		entityData = baseSpellDrop,
-- 	})
-- end
--#endregion

-- SJSON Data Creation, Portraits, Text and such
function public.CreateOlympianSJSONData(sjsonData)
	if not sjsonData then
		rom.log.error("CreateOlympianSJSONData: Missing parameter 'sjsonData'")
		return nil
	end

	local requiredFields = { "pluginGUID", "godName", "godType", "iconSpinPath", "previewPath", "colorA", "colorB", "colorC" }
	if not sjsonData.skipBoonSelectSymbol then
		table.insert(requiredFields, 3, "boonSelectSymbolPath")
	end
	for _, field in ipairs(requiredFields) do
		if not sjsonData[field] then
			rom.log.error("CreateOlympianSJSONData: Missing required field '" .. field .. "' for god " .. sjsonData.godName)
		end
	end

	--! The actual boon drop
	local godUpgrade = sjson.to_object({
		Name = sjsonData.godName .. "Upgrade",
		InheritFrom = "BaseBoon",
		DisplayInEditor = true,
		Thing = {
			EditorOutlineDrawBounds = false,
			Graphic = "BoonDrop" .. sjsonData.godName,
			AmbientSound = sjsonData.AmbientSound,
		},
	}, GameplayOrder)

	sjson.hook(GameplayFile, function(data)
		table.insert(data.Obstacles, godUpgrade)
	end)

	--! The Boon Colours/Animations
	local boonDropConfigs = {
		["BoonDrop" .. sjsonData.godName] = {
			InheritFrom = "BoonDropGold",
			ChildAnimation = "BoonDropA-" .. sjsonData.godName,
		},
		["BoonDropA-" .. sjsonData.godName] = { -- This one is outer field, IDK why they did it this way, but I will assign colourB to it instead.
			InheritFrom = "BoonDropA",
			ChildAnimation = "BoonDropB-" .. sjsonData.godName,
			Color = sjsonData.colorB,
			CreateAnimations = { {
				Name = "BoonDropBackGlow",
			}, {
				Name = "BoonDropFrontFlare",
			} },
		},
		["BoonDropB-" .. sjsonData.godName] = {
			InheritFrom = "BoonDropB",
			ChildAnimation = "BoonDropC-" .. sjsonData.godName,
			Color = sjsonData.colorA,
			CreateAnimations = { {
				Name = "BoonDropBackGlow",
			}, {
				Name = "BoonDropFrontFlare",
			} },
		},
		["BoonDropC-" .. sjsonData.godName] = {
			InheritFrom = "BoonDropC",
			ChildAnimation = "BoonDrop" .. sjsonData.godName .. "Icon",
			Color = sjsonData.colorC,
			CreateAnimations = { {
				Name = "BoonDropBackGlow",
			}, {
				Name = "BoonDropFrontFlare",
			} },
		},
		["BoonDrop" .. sjsonData.godName .. "Icon"] = {
			InheritFrom = "BoonDropIcon",
			FilePath = rom.path.combine(sjsonData.pluginGUID, sjsonData.iconSpinPath),
			OffsetZ = sjsonData.OffsetZBoonDrop,
			Scale = sjsonData.BoonDropIconScale,
			Hue = sjsonData.BoonDropIconHue,
		},
		["BoonDrop" .. sjsonData.godName .. "Preview"] = {
			InheritFrom = "BoonDropRoomRewardIconPreviewBase",
			FilePath = rom.path.combine(sjsonData.pluginGUID, sjsonData.previewPath),
			OffsetZ = sjsonData.OffsetZBoonPreview or 0,
			Scale = sjsonData.BoonPreviewScale,
			ColorFromOwner = "Maintain",
			AngleFromOwner = "Ignore",
			Sound = sjsonData.AmbientSound,
		},
		["BoonDrop" .. sjsonData.godName .. "UpgradedPreview"] = {
			InheritFrom = "BoonDrop" .. sjsonData.godName .. "Preview",
			ChildAnimation = "BoonUpgradedPreviewSparkles",
		},
	}

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
		}, VFXMainOrder)

		sjson.hook(ItemsGeneralVFX, function(data)
			table.insert(data.Animations, object)
		end)
	end

	--! Visuals on doors/boon select
	local boonInfoIcon = sjson.to_object({
		Name = "BoonInfoSymbol" .. sjsonData.godName .. "Icon",
		InheritFrom = "BoonInfoSymbolBase",
		FilePath = rom.path.combine(sjsonData.pluginGUID, sjsonData.previewPath),
	}, IconOrder)

	if not sjsonData.skipBoonSelectSymbol then
		local boonSymbol = sjson.to_object({
			Name = "BoonSymbol" .. sjsonData.godName,
			InheritFrom = "BoonSymbolBase",
			FilePath = rom.path.combine(sjsonData.pluginGUID, sjsonData.boonSelectSymbolPath),
			Scale = 1,
			OffsetY = sjsonData.boonSelectSymbolOffsetY or 0,
		}, IconOrder)

		sjson.hook(GUIScreensVFXFile, function(data)
			table.insert(data.Animations, boonSymbol)
		end)
	end

	sjson.hook(GUIScreensVFXFile, function(data)
		table.insert(data.Animations, boonInfoIcon)
	end)

	--? Macro texts
	local godDispleased = sjson.to_object({
		Id = "Player_GodDispleased_" .. sjsonData.godName .. "Upgrade",
		DisplayName = sjsonData.godName .. " Grew Displeased!",
	}, TextOrder)

	local sacrificeCombatText = sjson.to_object({
		Id = "SuperSacrifice_CombatText_" .. sjsonData.godName .. "Upgrade",
		DisplayName = "{#CombatTextHighlightFormat}Boons of " .. sjsonData.godName .. " {#Prev}{#UpgradeFormat}+{$TempTextData.Amount}{#Prev}{!Icons.PomLevel}!",
	}, TextOrder)

	local echoLastRewardBoon = sjson.to_object({
		Id = "EchoLastRewardBoon_" .. sjsonData.godName .. "Upgrade",
		InheritFrom = "BaseBoon",
		DisplayName = "Manifest a copy of your most recently claimed {#ItalicFormat}Reward: {#Prev}{#BoldFormat}{$Keywords.GodBoon} of " .. sjsonData.godName,
	}, TextOrder)

	local upgradeChoiceMenu = sjson.to_object({
		Id = "UpgradeChoiceMenu_" .. sjsonData.godName,
		DisplayName = "Boons of " .. sjsonData.godName,
		Description = nil,
	}, TextOrder)

	sjson.hook(MacroTextFile, function(data)
		table.insert(data.Texts, godDispleased)
		table.insert(data.Texts, sacrificeCombatText)
		table.insert(data.Texts, echoLastRewardBoon)
		table.insert(data.Texts, upgradeChoiceMenu)
	end)

	mod["UpgradeChoiceMenu_" .. sjsonData.godName] = sjson.to_object({
		Id = "UpgradeChoiceMenu_" .. sjsonData.godName,
		DisplayName = "Boons of " .. sjsonData.godName,
		Description = nil,
	}, TextOrder)

	sjson.hook(ScreenText, function(data)
		table.insert(data.Texts, mod["UpgradeChoiceMenu_" .. sjsonData.godName])
	end)

	if string.lower(sjsonData.godType) == "npcgod" then
		mod[sjsonData.godName .. "UpgradePreview"] = sjson.to_object({
			InheritFrom = "BoonSymbolBaseIsometric",
			FilePath = rom.path.combine(sjsonData.pluginGUID, sjsonData.previewPath),
		}, VFXMainOrder)

		mod[sjsonData.godName .. "UpgradeShop"] = sjson.to_object({
			InheritFrom = sjsonData.godName .. "UpgradePreview",
			Duration = 0,
			StartOffsetZ = 0,
			EndOffsetZ = 0,
			PingPongShiftOverDuration = false,
			Sound = nil,
		}, VFXMainOrder)

		mod[sjsonData.godName .. "Upgrade_Store"] = sjson.to_object({
			Id = sjsonData.godName .. "Upgrade_Store",
			DisplayName = "Boon of " .. sjsonData.godName,
			Description = "Receive your choice of {#BoldFormat}1 {#Prev}out of {$ScreenData.UpgradeChoice.MaxChoices} {$Keywords.GodBoonPlural} from {#BoldFormat}" .. sjsonData.godName .. "{#Prev}.",
		}, TextOrder)

		sjson.hook(TraitTextFile, function(data)
			table.insert(data.Texts, mod[sjsonData.godName .. "Upgrade_Store"])
		end)

		sjson.hook(ItemsGeneralVFX, function(data)
			table.insert(data.Animations, mod[sjsonData.godName .. "UpgradePreview"])
			table.insert(data.Animations, mod[sjsonData.godName .. "UpgradeShop"])
		end)
	end

	--! Portraits
	if sjsonData.portraitData then
		local portraitConfigs = {}
		--! I have no idea what some of these do lmao.
		if not sjsonData.portraitData.skipNeutralPortrait then
			portraitConfigs["Portrait_" .. sjsonData.godName .. "_Default_01"] = {
				InheritFrom = "Portrait_God_01",
				FilePath = rom.path.combine(sjsonData.pluginGUID, sjsonData.portraitData.NeutralPortraitFilePath or ""),
				ChildAnimation = "PortraitGodRayEmitter_Athena",
				EndFrame = 1,
				StartFrame = 1,
				CreateAnimation = "OlympianDialogueEntrance_" .. sjsonData.godName,
				CreateAnimations = sjsonData.portraitData.NeutralAnimations or {},
			}
		end

		portraitConfigs["Portrait_" .. sjsonData.godName .. "_Default_01_Exit"] = {
			InheritFrom = "Portrait_God_01_Exit",
			FilePath = rom.path.combine(sjsonData.pluginGUID, sjsonData.portraitData.NeutralPortraitFilePath or ""),
			EndFrame = 1,
			StartFrame = 1,
			Sound = "/Leftovers/World Sounds/MapZoomInShortHigh",
		}

		portraitConfigs["Portrait_" .. sjsonData.godName .. "_Default_01_Wrath"] = {
			InheritFrom = "Portrait_God_01_Wrath",
			FilePath = rom.path.combine(sjsonData.pluginGUID, sjsonData.portraitData.NeutralPortraitFilePath or ""),
			EndFrame = 1,
			StartFrame = 1,
		}

		portraitConfigs["Portrait_" .. sjsonData.godName .. "_Displeased_01"] = {
			InheritFrom = "Portrait_" .. sjsonData.godName .. "_Default_01",
			FilePath = rom.path.combine(sjsonData.pluginGUID, sjsonData.portraitData.AnnoyedPortraitFilePath or ""),
		}

		portraitConfigs["Portrait_" .. sjsonData.godName .. "_Serious_01"] = {
			InheritFrom = "Portrait_" .. sjsonData.godName .. "_Default_01",
			FilePath = rom.path.combine(sjsonData.pluginGUID, sjsonData.portraitData.SeriousPortraitFilePath or ""),
		}

		portraitConfigs["Portrait_" .. sjsonData.godName .. "_Serious_01_Exit"] = {
			InheritFrom = "Portrait_" .. sjsonData.godName .. "_Default_01_Exit",
			FilePath = rom.path.combine(sjsonData.pluginGUID, sjsonData.portraitData.SeriousPortraitFilePath or ""),
		}

		--* Dialogue Entrance Anim, like the bling bling
		if sjsonData.portraitData.DialogueAnimations then
			portraitConfigs["OlympianDialogueEntrance_" .. sjsonData.godName] = {
				InheritFrom = "OlympianDialogueEntrance_Base",
				StartRed = sjsonData.portraitData.DialogueAnimations.DialogueEntrance.RedStart,
				StartGreen = sjsonData.portraitData.DialogueAnimations.DialogueEntrance.GreenStart,
				StartBlue = sjsonData.portraitData.DialogueAnimations.DialogueEntrance.BlueStart,
				EndRed = sjsonData.portraitData.DialogueAnimations.DialogueEntrance.RedEnd,
				EndGreen = sjsonData.portraitData.DialogueAnimations.DialogueEntrance.GreenEnd,
				EndBlue = sjsonData.portraitData.DialogueAnimations.DialogueEntrance.BlueEnd,
				CreateAnimations = {},
			}

			portraitConfigs["OlympianDialogueEntranceStreaks_" .. sjsonData.godName] = {
				InheritFrom = "OlympianDialogueEntranceStreaks_Base",
				StartRed = sjsonData.portraitData.DialogueAnimations.DialogueEntranceStreaks.RedStart,
				StartGreen = sjsonData.portraitData.DialogueAnimations.DialogueEntranceStreaks.GreenStart,
				StartBlue = sjsonData.portraitData.DialogueAnimations.DialogueEntranceStreaks.BlueStart,
				EndRed = sjsonData.portraitData.DialogueAnimations.DialogueEntranceStreaks.RedEnd,
				EndGreen = sjsonData.portraitData.DialogueAnimations.DialogueEntranceStreaks.GreenEnd,
				EndBlue = sjsonData.portraitData.DialogueAnimations.DialogueEntranceStreaks.BlueEnd,
				VisualFx = "OlympianDialogueEntranceParticle_" .. sjsonData.godName,
			}

			portraitConfigs["OlympianDialogueEntranceParticle_" .. sjsonData.godName] = {
				InheritFrom = "OlympianDialogueEntranceParticles_Base",
				StartRed = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticles.RedStart,
				StartGreen = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticles.GreenStart,
				StartBlue = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticles.BlueStart,
				EndRed = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticles.RedEnd,
				EndGreen = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticles.GreenEnd,
				EndBlue = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticles.BlueEnd,
			}

			portraitConfigs["OlympianDialogueEntranceParticleBurst_" .. sjsonData.godName] = {
				InheritFrom = "OlympianDialogueEntranceParticleBurst_Base",
				StartRed = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedStart,
				StartGreen = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenStart,
				StartBlue = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueStart,
				EndRed = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedEnd,
				EndGreen = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenEnd,
				EndBlue = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueEnd,
			}

			portraitConfigs["OlympianDialogueEntranceParticleBurst_" .. sjsonData.godName .. "_Flip"] = {
				InheritFrom = "OlympianDialogueEntranceParticleBurst_Base_Flip",
				StartRed = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedStart,
				StartGreen = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenStart,
				StartBlue = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueStart,
				EndRed = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.RedEnd,
				EndGreen = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.GreenEnd,
				EndBlue = sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst.BlueEnd,
			}

			if sjsonData.portraitData.DialogueAnimations.DialogueEntranceStreaks then
				table.insert(portraitConfigs["OlympianDialogueEntrance_" .. sjsonData.godName].CreateAnimations, { Name = "OlympianDialogueEntranceStreaks_" .. sjsonData.godName })
			elseif sjsonData.portraitData.DialogueAnimations.DialogueEntranceParticleBurst then
				table.insert(portraitConfigs["OlympianDialogueEntrance_" .. sjsonData.godName].CreateAnimations, { Name = "OlympianDialogueEntranceParticleBurst_" .. sjsonData.godName })
				table.insert(portraitConfigs["OlympianDialogueEntrance_" .. sjsonData.godName].CreateAnimations, { Name = "OlympianDialogueEntranceParticleBurst_" .. sjsonData.godName .. "_Flip" })
			end
		end

		for name, config in pairs(portraitConfigs) do
			local object = sjson.to_object({
				Name = name,
				InheritFrom = config.InheritFrom,
				FilePath = config.FilePath,
				ChildAnimation = config.ChildAnimation,
				EndFrame = config.EndFrame,
				StartFrame = config.StartFrame,
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

			sjson.hook(PortraitFile, function(data)
				table.insert(data.Animations, object)
			end)
		end
	end

	--#region portrait in person?
	-- {
	-- 	Name = "Portrait_Apollo_InPerson_01"
	-- 	InheritFrom = "Portrait_Base_01"
	--     FilePath = "Portraits\Apollo\Portraits_Apollo_01"
	--  OffsetX = 0
	-- 	EndFrame = 1
	-- 	StartFrame = 1
	-- 	CreateAnimations = [
	-- 		{ Name = "Portrait_Apollo_OlympianGlow_In" }
	-- 		{ Name = "Portrait_Apollo_Wiggle1_In" }
	-- 		{ Name = "Portrait_Apollo_Wiggle2_In" }
	-- 		{ Name = "Portrait_Apollo_StringsGlow"}
	-- 		{ Name = "Portrait_Apollo_MainGlow"}
	-- 		{ Name = "Portrait_Apollo_GlowArrow"}
	-- 		{ Name = "Portrait_Apollo_Glint" }
	-- 		{ Name = "Portrait_Apollo_Blink" }
	-- 	]
	-- }
	-- {
	-- 	Name = "Portrait_Apollo_InPerson_01_Exit"
	-- 	InheritFrom = "Portrait_Base_01_Exit"
	-- 	FilePath = "Portraits\Apollo\Portraits_Apollo_01"
	-- 	EndFrame = 1
	-- 	StartFrame = 1
	-- }
	-- {
	-- 	Name = "Portrait_Apollo_InPerson_Serious_01"
	-- 	InheritFrom = "Portrait_Apollo_InPerson_01"
	-- 	FilePath = "Portraits\Apollo\Portraits_Apollo_Serious_01"
	-- }
	-- {
	-- 	Name = "Portrait_Apollo_InPerson_Serious_01_Exit"
	-- 	InheritFrom = "Portrait_Apollo_InPerson_01_Exit"
	-- 	FilePath = "Portraits\Apollo\Portraits_Apollo_Serious_01"
	-- }

	--     	{
	-- 	Name = "ApolloOverlay"
	-- 	InheritFrom = "HadesOverlay"
	-- 	FilePath = "Portraits\Apollo\Portraits_Apollo_Serious_01"
	-- 	OffsetX = 150
	-- 	OffsetY = 240
	-- }

	--#endregion
end

local function addGodtoRunData(runData, upgrade)
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

function registerEntityData(entityName, entityType, entityData)
	local upgradeName = entityName .. "Upgrade"

	if game.LootData[upgradeName] then
		rom.log.warning(entityName .. " is already registered, skipping creation.")
		return
	end

	game.LootData[upgradeName] = entityData

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

-- Extra func for testing or function checsk
function public.IsGodRegistered(godName, debug)
	if debug then
		local isRegistered = game.LootData[godName .. "Upgrade"] ~= nil
		rom.log.warning("IsGodRegistered: " .. godName .. " = " .. tostring(isRegistered))
		return isRegistered
	end

	return game.LootData[godName .. "Upgrade"] ~= nil
end

modutil.once_loaded.game(function()
	mod = modutil.mod.Mod.Register(_PLUGIN.guid)
end)

---[[[
---
--- basically, get a god name for gift data, else, pluginGUID.name = whatever
--- then do the entire keepsake, see like wtf is up with all the gaw damn trait texts and stuff, and make sure i can pass in custom stuff
--- then sjson
---
---]]]

-- function public.CreateKeepsake(params)
-- 	--? IDK!!!!
-- 	if params.characterName then
-- 		game.GiftData[params.characterName .. "Upgrade"] = {
-- 			InheritFrom = { "DefaultGiftData" },
-- 			MaxedRequirement = {
-- 				{
-- 					PathTrue = { "GameState", "TextLinesRecord", game.LootData[params.characterName .. "Upgrade"][-1] },
-- 				},
-- 			},
-- 			MaxedIcon = "Keepsake_Demeter_Corner",
-- 			MaxedSticker = "Keepsake_Demeter",
-- 			[1] = {
-- 				GameStateRequirements = {
-- 					{
-- 						PathTrue = { "GameState", "TextLinesRecord", "DemeterGift01" },
-- 					},
-- 				},
-- 				Gift = "ForceDemeterBoonKeepsake",
-- 			},
-- 		}
-- 	end

-- 	game.TraitData[params.KeepsakeName] = {
-- 		Icon = params.Icons.IconName,
-- 		Name = params.KeepsakeName, -- req

-- 		-- find out
-- 		InRackTitle = "SpellTalentKeepsake_Rack",
-- 		ZeroBonusTrayText = "SpellTalentKeepsake_Expired",
-- 		PartialActiveTrayText = "SpellTalentKeepsake_Inactive",
-- 		BlockedByEnding = true,
-- 		--???
-- 		UnequippedKeepsakeTitle = "BonusMoneyKeepsake_Rack",
-- 		CustomTrayNameWhileDead = "BonusMoneyKeepsake",

-- 		ShowInHUD = true,
-- 		Ordered = true,
-- 		HUDScale = params.HUDScale,
-- 		PriorityDisplay = true,
-- 		ChamberThresholds = { 25, 50 },
-- 		HideInRunHistory = true,
-- 		Slot = "Keepsake",
-- 		InfoBackingAnimation = "KeepsakeSlotBase",
-- 		RecordCacheOnEquip = true,
-- 		TraitOrderingValueCache = -1,
-- 		ActiveSlotOffsetIndex = 0,

-- 		TrayTextBackingAnimation = "TraitTray_LevelBacking_Alt",
-- 		TrayTextBackingOffsetY = 9,
-- 		TrayTextOffsetY = -10,
-- 		NewTraitHighlightAnimation = "NewTraitHighlightKeepsake",
-- 		PinAnimationIn = "TraitPinIn_Keepsake",
-- 		PinAnimationOut = "TraitPinOut_Keepsake",
-- 		TrayHighlightAnimScale = 1.2,
-- 		PreCreateActiveOverlay = true,

-- 		EquipSound = params.EquipSound,
-- 		EquipVoiceLines = params.EquipVoiceLines, -- table
-- 		SpeakerNames = params.SpeakerNames, -- table

-- 		FrameRarities = {
-- 			Common = "Frame_Keepsake_Rank1",
-- 			Rare = "Frame_Keepsake_Rank2",
-- 			Epic = "Frame_Keepsake_Rank3",
-- 			Heroic = "Frame_Keepsake_Rank4",
-- 		},

-- 		CustomRarityLevels = {
-- 			"TraitLevel_Keepsake1",
-- 			"TraitLevel_Keepsake2",
-- 			"TraitLevel_Keepsake3",
-- 			"TraitLevel_Keepsake4",
-- 		},

-- 		--! Same issue as gift data, IDK!
-- 		SignOffData = {
-- 			{
-- 				GameStateRequirements = {
-- 					{
-- 						PathTrue = { "GameState", "TextLinesRecord", "EurydiceGift08" },
-- 					},
-- 				},
-- 				Text = "SignoffEurydice_Max",
-- 			},
-- 			{
-- 				Text = "SignoffEurydice",
-- 			},
-- 		},

-- 		--* Then whatever they wanna add
-- 		RarityLevels = {
-- 			Common = { Multiplier = config.Eurydice.a_KeepsakeCommon },
-- 			Rare = { Multiplier = config.Eurydice.b_KeepsakeRare },
-- 			Epic = { Multiplier = config.Eurydice.c_KeepsakeEpic },
-- 			Heroic = { Multiplier = config.Eurydice.d_KeepsakeHeroic },
-- 		},
-- 	}

-- 	table.insert(game.ScreenData.KeepsakeRack.ItemOrder, params.KeepsakeName)

-- 	-- SJSON stuff now
-- 	if params.Keepsake then
-- 		local keepsakerack_char = sjson.to_object({
-- 			Id = params.KeepsakeName,
-- 			InheritFrom = "BaseBoonMultiline",
-- 			DisplayName = params.Keepsake.DisplayName,
-- 			Description = params.Keepsake.Description,
-- 		}, Order)
-- 	end

-- 	if params.trayDescription then
-- 		local keepsake_char = sjson.to_object({
-- 			Id = params.KeepsakeName .. "_Tray",
-- 			InheritFrom = params.KeepsakeName,
-- 			Description = params.trayDescription.Description,
-- 		}, Order)
-- 	end

-- 	if params.signOff then
-- 		local signoff_char = sjson.to_object({
-- 			Id = "Signoff" .. params.characterName,
-- 			DisplayName = "From " .. params.characterName,
-- 		}, Order)
-- 	end

-- 	if params.signOffMax then
-- 		local signoff_charmax = sjson.to_object({
-- 			Id = "Signoff" .. params.characterName .. "_Max",
-- 			DisplayName = params.signOffMax.Description,
-- 		}, Order)
-- 	end

-- 	if params.Icons then
-- 		local keepsakeicon_char = sjson.to_object({
-- 			Name = params.IconName,
-- 			InheritFrom = "KeepsakeIcon",
-- 			FilePath = rom.path.combine(params.pluginGUID, params.Icons.iconPath),
-- 		}, IconOrder)

-- 		if params.Icons.maxCornerIcon then
-- 			local keepsakemaxCorner_char = sjson.to_object({
-- 				Name = "Keepsake_" .. params.characterName .. "_Corner",
-- 				InheritFrom = "KeepsakeMax_Corner",
-- 				FilePath = rom.path.combine(params.pluginGUID, params.Icons.iconPath),
-- 			}, IconOrder)
-- 		end

-- 		if params.Icons.maxIcon then
-- 			local keepsakemax_char = sjson.to_object({
-- 				Name = "Keepsake_" .. params.characterName,
-- 				InheritFrom = "KeepsakeMax",
-- 				FilePath = rom.path.combine(params.pluginGUID, params.Icons.maxIcon),
-- 			}, IconOrder)
-- 		end
-- 	end

-- 	sjson.hook(TraitTextFile, function(data)
-- 		table.insert(data.Texts, keepsake_eurydice)
-- 		table.insert(data.Texts, keepsakerack_eurydice)
-- 		table.insert(data.Texts, signoff_eurydice)
-- 		table.insert(data.Texts, signoff_eurydicemax)
-- 	end)

-- 	sjson.hook(GUIBoonsVFXFile, function(data)
-- 		table.insert(data.Animations, keepsakeicon_eurydice)
-- 		table.insert(data.Animations, keepsakemaxCorner_eurydice)
-- 		table.insert(data.Animations, keepsakemax_eurydice)
-- 	end)
-- end
