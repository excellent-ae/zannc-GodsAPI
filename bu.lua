
--* property changes - yoinked from aphrodite, files are melinoe_staff_vfx etc
--[[ Primary

PropertyChanges =
{
    -- Staff
    {
        WeaponName = "WeaponStaffSwing",
        WeaponProperty = "FireFx",
        ChangeValue = "StaffProjectileFireFx1_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponStaffSwing",
        ProjectileName = "ProjectileStaffSwing1",
        ProjectileProperty = "Graphic",
        ChangeValue = "StaffComboAttack1_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffSwing",
        ProjectileName = "ProjectileStaffSwing1",
        ProjectileProperty = "DissipateFx",
        ChangeValue = "StaffComboAttack1Dissipate_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffSwing",
        ProjectileName = "ProjectileStaffSwing1",
        ProjectileProperty = "DeathFx",
        ChangeValue = "StaffComboAttack1Dissipate_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffSwing2",
        ProjectileName = "ProjectileStaffSwing2",
        ProjectileProperty = "Graphic",
        ChangeValue = "StaffComboAttack2_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffSwing2",
        ProjectileName = "ProjectileStaffSwing2",
        ProjectileProperty = "DissipateFx",
        ChangeValue = "StaffComboAttack2Dissipate_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffSwing2",
        ProjectileName = "ProjectileStaffSwing2",
        ProjectileProperty = "DeathFx",
        ChangeValue = "StaffComboAttack2Dissipate_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffSwing3",
        ProjectileName = "ProjectileStaffSwing3",
        ProjectileProperty = "Graphic",
        ChangeValue = "StaffComboAttack3_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffSwing3",
        ProjectileName = "ProjectileStaffSwing3",
        ProjectileProperty = "GroupName",
        ChangeValue = "FX_Standing_Add",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffSwing3",
        ProjectileName = "ProjectileStaffSwing3",
        ProjectileProperty = "DissipateFx",
        ChangeValue = "StaffComboAttack3Dissipate_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffSwing3",
        ProjectileName = "ProjectileStaffSwing3",
        ProjectileProperty = "DeathFx",
        ChangeValue = "StaffComboAttack3Dissipate_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffDash",
        ProjectileName = "ProjectileStaffDash",
        ProjectileProperty = "Graphic",
        ChangeValue = "StaffComboAttack1Dash_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffSwing5",
        ProjectileProperty = "Graphic",
        ChangeValue = "StaffChargedAttackFxEmitter_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponStaffSwing5",
        TraitName = "StaffRaiseDeadAspect",
        ProjectileName = "ProjectileStaffWall",
        ProjectileProperty = "Graphic",
        ChangeValue = "StaffWallIn_Aphrodite",
        ChangeType = "Absolute",
    },			
    {
        WeaponName = "WeaponStaffSwing5",
        TraitName = "StaffRaiseDeadAspect",
        ProjectileName = "ProjectileStaffWall",
        ProjectileProperty = "ImpactFx",
        ChangeValue = "AnubisWallImpactFx_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponStaffSwing",
        TraitName = "StaffRaiseDeadAspect",
        ProjectileName = "ProjectileStaffSingle",
        ProjectileProperty = "Graphic",
        ChangeValue = "AnubisRingFx_Aphrodite",
        ChangeType = "Absolute",
    },			
    {
        WeaponName = "WeaponStaffSwing",
        TraitName = "StaffRaiseDeadAspect",
        WeaponProperty = "FireFx",
        ChangeValue = "StaffProjectileFireFx3_Aphrodite",
        ChangeType = "Absolute",
    },
    
    -- Dagger
    {
        WeaponName = "WeaponDagger",
        FalseTraitName = "DaggerTripleAspect",
        WeaponProperty = "FireFx",
        ChangeValue = "DaggerSwipeFast_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponDagger2",
        WeaponProperty = "FireFx",
        ChangeValue = "DaggerSwipeFastFlip_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponDaggerDash",
        FalseTraitName = "DaggerTripleAspect",
        ProjectileName = "ProjectileDaggerDash",
        WeaponProperty = "FireFx",
        ChangeValue = "DaggerSwipeFastFlipDash_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponDaggerMultiStab",
        ProjectileName = "ProjectileDagger",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "DaggerJab_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponDaggerDouble",
        ProjectileName = "ProjectileDaggerSliceDouble",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "DaggerSwipeDouble_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponDaggerDouble",
        WeaponProperty = "FireFx",
        ChangeValue = "null",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponDagger5",
        WeaponProperty = "FireFx",
        ChangeValue = "null",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponDagger5",
        WeaponProperty = "ChargeStartFx",
        ChangeValue = "DaggerCharge_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponDagger5",
        ProjectileName = "ProjectileDaggerBackstab",
        ProjectileProperty = "StartFx",
        ChangeValue = "DaggerSwipe_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponDagger",
        TraitName = "DaggerTripleAspect",
        ProjectileName = "ProjectileDaggerSpinMorrigan",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "DaggerMorriganSpin_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponDaggerDash",
        TraitName = "DaggerTripleAspect",
        ProjectileName = "ProjectileDaggerSpinMorrigan",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "DaggerMorriganSpin_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponDagger5",
        TraitName = "DaggerTripleAspect",
        ProjectileName = "ProjectileDaggerExecuteMorrigan",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "DaggerSwipeDouble_Morrigan_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },

    -- Axe
    {
        WeaponName = "WeaponAxe",
        FalseTraitName = "AxeRallyAspect",
        WeaponProperty = "FireFx",
        ChangeValue = "AxeSwipe1_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponAxe2",
        FalseTraitName = "AxeRallyAspect",
        WeaponProperty = "FireFx",
        ChangeValue = "AxeSwipe2_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponAxe3",
        FalseTraitName = "AxeRallyAspect",
        ProjectileName = "ProjectileAxeOverhead",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "AxeNova_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponAxeDash",
        FalseTraitName = "AxeRallyAspect",
        WeaponProperty = "FireFx",
        ChangeValue = "AxeSwipeUpper_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponAxeSpin",
        ProjectileName = "ProjectileAxeSpin",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "AxeSwipe2Spin_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponAxe",
        TraitName = "AxeRallyAspect",
        ProjectileName = "ProjectileAxeNergalSlow",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "AxeNovaNergal_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponAxe2",
        TraitName = "AxeRallyAspect",
        ProjectileName = "ProjectileAxeNergalFast",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "AxeNovaNergal_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponAxe3",
        TraitName = "AxeRallyAspect",
        ProjectileName = "ProjectileAxeNergalFast",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "AxeNovaNergal_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponAxe4",
        TraitName = "AxeRallyAspect",
        ProjectileName = "ProjectileAxeNergalFast",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "AxeNovaNergal_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponAxe5",
        TraitName = "AxeRallyAspect",
        ProjectileName = "ProjectileAxeNergalFast",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "AxeNovaNergal_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponAxeDash",
        TraitName = "AxeRallyAspect",
        ProjectileName = "ProjectileAxeNergalFastDash",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "AxeNovaNergal_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },

    -- Lob
    {
        FalseTraitName = "LobCloseAttackAspect",
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLob",
        ProjectileProperty = "Graphic",
        ChangeValue = "LobProjectile_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLob",
        ProjectileProperty = "BounceFx",
        ChangeValue = "LobProjectileBounceFx_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "LobGunAspect",
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLobBullet",
        ProjectileProperty = "Graphic",
        ChangeValue = "LobProjectileBullet_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "LobGunAspect",
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLobBullet",
        ProjectileProperty = "DeathFx",
        ChangeValue = "LobProjectileBulletFade_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLobOverheat",
        ProjectileProperty = "Graphic",
        ChangeValue = "LobSpecialFx_Hel_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        FalseTraitName = "LobCloseAttackAspect",
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLob",
        ProjectileProperty = "StartFx",
        ChangeValue = "StaffProjectileFireFx2Close_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "LobCloseAttackAspect",
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLob",
        ProjectileProperty = "StartFx",
        ChangeValue = "MedeaLoadFx_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "LobCloseAttackAspect",
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLob",
        ProjectileProperty = "Graphic",
        ChangeValue = "MedeaFuseFx_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLob",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "LobExplosion_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLobCharged",
        ProjectileProperty = "Graphic",
        ChangeValue = "LobProjectileCharged_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLobCharged",
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "LobProjectileChargedSecondaryEmitter_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLobCharged",
        ProjectileProperty = "DescentStartFx",
        ChangeValue = "LobEXDescentStart_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLobCharged",
        ProjectileProperty = "StartFx",
        ChangeValue = "LobEXFireFx_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponLob",
        ProjectileName = "ProjectileLobCharged",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "LobExplosionCharged_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },

    -- Torch
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchBall",
        ProjectileProperty = "Graphic",
        ChangeValue = "TorchBallIn_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchBall",
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "TorchBallGroundGlow_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchBall",
        ProjectileProperty = "DissipateFx",
        ChangeValue = "TorchBallDissipate_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchWave",
        ProjectileProperty = "Graphic",
        ChangeValue = "ProjectileTorchWave_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchWave",
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "TorchBallGroundGlowWave_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "TorchEnhancedAttackTrait",
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchWave",
        ProjectileProperty = "Graphic",
        ChangeValue = "ProjectileTorchWaveReturn_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },	
    {
        TraitName = "TorchEnhancedAttackTrait",
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchSupayBallEx",
        ProjectileProperty = "Graphic",
        ChangeValue = "ProjectileTorchWaveReturn_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },	
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchBall",
        ProjectileProperty = "ImpactFx",
        ChangeValue = "TorchImpactFx_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchGhost",
        ProjectileProperty = "Graphic",
        ChangeValue = "TorchProjectileGhostIn_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        FalseTraitName = "TorchSprintRecallAspect",
        ProjectileName = "ProjectileTorchGhostLarge",
        ProjectileProperty = "Graphic",
        ChangeValue = "TorchProjectileGhostLargeIn_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchGhost",
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "TorchProjectileShadow_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        FalseTraitName = "TorchSprintRecallAspect",
        ProjectileName = "ProjectileTorchGhostLarge",
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "TorchProjectileShadowLarge_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchGhost",
        ProjectileProperty = "DissipateFx",
        ChangeValue = "TorchProjectileDissipate_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchGhostLarge",
        ProjectileProperty = "DissipateFx",
        ChangeValue = "TorchProjectileDissipate_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchRepeatStrike",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "RadialNovaPentagramCharged_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponTorch",
        TraitName = "TorchSprintRecallAspect",
        ProjectileName = "ProjectileTorchBallEos",
        ProjectileProperty = "Graphic",
        ChangeValue = "EosProjectile_Aphrodite_In",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponTorch",
        TraitName = "TorchSprintRecallAspect",
        ProjectileName = "ProjectileTorchBallEos",
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "EosProjectileShadow",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchGhostExplosion",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "ProjectileTorchGhostExplosion_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },	
    {
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchGhostLargeExplosion",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "ProjectileTorchGhostExplosion_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        FalseTraitName = "TorchEnhancedAttackTrait",
        TraitName = "TorchAutofireAspect",
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchSupayBallEx",
        ProjectileProperty = "Graphic",
        ChangeValue = "ProjectileTorchWave_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "TorchAutofireAspect",
        WeaponName = "WeaponTorch",
        ProjectileName = "ProjectileTorchSupayBallEx",
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "TorchBallGroundGlowWave_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },

    -- Suit
    {
        WeaponName = "WeaponSuit",
        ProjectileName = "ProjectileSuit",
        ProjectileProperty = "StartFx",
        ChangeValue = "SuitPunch_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponSuit",
        ProjectileName = "ProjectileSuit2",
        ProjectileProperty = "StartFx",
        ChangeValue = "SuitPunch_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        TraitName = "SuitComboAspect",
        WeaponName = "WeaponSuitDouble",
        ProjectileName = "ProjectileSuitDouble",
        ProjectileProperty = "StartFx",
        ChangeValue = "SuitPunch_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        TraitName = "SuitComboAspect",
        WeaponName = "WeaponSuitDouble",
        WeaponProperty = "FireFx",
        ChangeValue = "SuitPunchFlare_R_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "SuitComboAspect",
        WeaponName = "WeaponSuitDouble",
        WeaponProperty = "FireFx2",
        ChangeValue = "SuitPunchFlare_L_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        WeaponName = "WeaponSuitCharged",
        ProjectileProperty = "StartFx",
        ChangeValue = "SuitPunchLarge_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponSuitDash",
        ProjectileName = "ProjectileSuitDash",
        ProjectileProperty = "StartFx",
        ChangeValue = "SuitNovaBurn_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        TraitName = "SuitDashAttackTrait",
        WeaponName = "WeaponSuitDash",
        ProjectileName = "ProjectileSuitDash",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "SuitNovaBurnRapid_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponSuitDash",
        WeaponProperty = "FireFx",
        ChangeValue = "SuitExhaustDashTrail_R_Spawner_Aphrodite",
        ChangeType = "Absolute",
    },
},
]]

--[[ Special
PropertyChanges =
{
    -- Staff
    {
        WeaponName = "WeaponStaffBall",
        WeaponProperty = "FireFx",
        ChangeValue = "StaffProjectileFireFxRing_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponStaffBall",
        ProjectileName = "ProjectileStaffBall",
        ProjectileProperty = "StartFx",
        ChangeValue = "StaffProjectileFireFx2_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponStaffBall",
        ProjectileName = "ProjectileStaffBall",
        ProjectileProperty = "Graphic",
        ChangeValue = "StaffBallProjectileIn_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponStaffBall",
        ProjectileName = "ProjectileStaffBall",
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "AphroditeStaffProjectileShadow",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponStaffBall",
        ProjectileName = "ProjectileStaffBall",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "RadialNovaPentagram_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponStaffBall",
        ProjectileName = "ProjectileStaffBallCharged",
        ProjectileProperty = "Graphic",
        ChangeValue = "StaffBallProjectileCharged_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponStaffBall",
        ProjectileName = "ProjectileStaffBallCharged",
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "StaffBallProjectileCharged_Aphrodite_Shadow",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponStaffBall",
        ProjectileName = "ProjectileStaffBallCharged",
        ProjectileProperty = "StartFx",
        ChangeValue = "StaffProjectileFireFx3_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponStaffBall",
        ProjectileName = "ProjectileStaffBallCharged",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "RadialNovaPentagramCharged_Aphrodite",
        ChangeType = "Absolute",
    },

    -- Dagger
    {
        FalseTraitName = "DaggerTripleAspect",
        WeaponName = "WeaponDaggerThrow",
        ProjectileName = "ProjectileDaggerThrow",
        ProjectileProperty = "Graphic",
        ChangeValue = "DaggerProjectileCurved_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        TraitName = "DaggerTripleAspect",
        WeaponName = "WeaponDaggerThrow",
        ProjectileName = "ProjectileDaggerThrow",
        ProjectileProperty = "Graphic",
        ChangeValue = "DaggerThrowMorrigan_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        FalseTraitName = "DaggerTripleAspect",
        WeaponName = "WeaponDaggerThrow",
        ProjectileName = "ProjectileDaggerThrowCharged",
        ProjectileProperty = "Graphic",
        ChangeValue = "DaggerProjectileFx_Aphrodite", 
        ChangeType = "Absolute",
    },
    {
        TraitName = "DaggerTripleAspect",
        WeaponName = "WeaponDaggerThrow",
        ProjectileName = "ProjectileDaggerThrowCharged",
        ProjectileProperty = "Graphic",
        ChangeValue = "DaggerThrowMorrigan_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        TraitName = "DaggerHomingThrowAspect",
        WeaponName = "WeaponDaggerThrow",
        ProjectileName = "ProjectileDaggerThrowCharged",
        ProjectileProperty = "Graphic",
        ChangeValue = "DaggerProjectileFx_Pan_Aphrodite",
    },
    {
        WeaponName = "WeaponDaggerThrow",
        ProjectileName = "ProjectileDaggerThrow",
        ProjectileProperty = "DeathFx",
        ChangeValue = "DaggerProjectileFxFade_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponDaggerThrow",
        WeaponProperty = "FireSound",
        ChangeValue = "/SFX/Player Sounds/AphroditeLoveDaggerThrow",
        ChangeType = "Absolute",
    },

    -- Axe
    {
        WeaponName = "WeaponAxeBlock2",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "AxeDeflect_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        FalseTraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect", },
        WeaponName = "WeaponAxeSpecial",
        WeaponProperty = "FireFx",
        ChangeValue = "AxeSpinDouble_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true
    },
    {
        TraitName = "AxeRallyAspect",
        FalseTraitName = "AxeBlockEmpowerTrait",
        WeaponName = "WeaponAxeSpecial",
        ProjectileProperty = "StartFx",
        ChangeValue = "null",
        ChangeType = "Absolute",
        ExcludeLinked = true
    },
    {
        TraitName = "AxeRallyAspect",
        FalseTraitName = "AxeBlockEmpowerTrait",
        WeaponName = "WeaponAxeSpecial",
        WeaponProperty = "FireFx",
        ChangeValue = "AxeSwipeUpper_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true
    },
    {
        TraitName = "AxeBlockEmpowerTrait",
        FalseTraitName = "AxeRallyAspect",
        WeaponName = "WeaponAxeSpecial",
        WeaponProperty = "FireFx",
        ChangeValue = "null",
        ChangeType = "Absolute",
        ExcludeLinked = true
    },
    {
        TraitName = "AxeBlockEmpowerTrait",
        FalseTraitName = "AxeRallyAspect",
        WeaponName = "WeaponAxeSpecial",
        ProjectileProperty = "StartFx",
        ChangeValue = "AxeSpinDouble_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true
    },
    {
        TraitNames = { "AxeBlockEmpowerTrait", "AxeRallyAspect" },
        WeaponName = "WeaponAxeSpecial",
        ProjectileProperty = "StartFx",
        ChangeValue = "AxeSwipeUpper_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true
    },
    {
        WeaponName = "WeaponAxeSpecialSwing",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "AxeNovaEX_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },

    -- Lob
    {
        FalseTraitName = "LobGunAspect",
        WeaponName = "WeaponLobSpecial",
        ProjectileName = "ProjectileThrowCharged",
        ProjectileProperty = "Graphic",
        ChangeValue = "LobSpecialFx_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        TraitName = "LobGunAspect",
        WeaponName = "WeaponLobSpecial",
        ProjectileName = "ProjectileThrowCharged",
        ProjectileProperty = "Graphic",
        ChangeValue = "LobSpecialFx_Hel_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponLobSpecial",
        ProjectileName = "ProjectileThrowBlink",
        ProjectileProperty = "Graphic",
        ChangeValue = "DashLobTrailEmitter_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        TraitName = "LobGunAspect",
        WeaponName = "WeaponLobSpecial",
        ProjectileName = "ProjectileLobGunRift",
        ProjectileProperty = "Graphic",
        ChangeValue = "LobProjectileHel_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        TraitName = "LobGunAspect",
        WeaponName = "WeaponLobSpecial",
        ProjectileName = "ProjectileLobSpecialBounce",
        ProjectileProperty = "Graphic",
        ChangeValue = "LobProjectileHel_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponSkullImpulse",
        ProjectileName = "ProjectileSkullImpulse",
        ProjectileProperty = "Graphic",
        ChangeValue = "DashLobTrailEmitter_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponLobSpecial",
        WeaponProperty = "ChargeStartFx",
        ChangeValue = "LobCharge_Aphrodite",
        ChangeType = "Absolute",
    },

    -- Torch
    {
        WeaponName = "WeaponTorchSpecial",
        ProjectileName = "ProjectileTorchOrbit",
        ProjectileProperty = "Graphic",
        ChangeValue = "TorchOrbitIn_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponTorchSpecial",
        ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
        ProjectileProperty = "DissipateFx",
        ChangeValue = "TorchOrbitOut_Aphrodite",
        ChangeType = "Absolute",
    },			
    {
        WeaponName = "WeaponTorchSpecial",
        ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "TorchOrbitShadow_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponTorchSpecial",
        ProjectileName = "ProjectileTorchOrbitEx",
        ProjectileProperty = "Graphic",
        ChangeValue = "TorchOrbitInEX_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponTorchSpecial",
        WeaponProperty = "FireFx",
        ChangeValue = "TorchOrbitStartSwirl_Single_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponTorchSpecial",
        TraitName = "TorchDetonateAspect",
        ProjectileName = "ProjectileTorchOrbit",
        ProjectileProperty = "Graphic",
        ChangeValue = "TorchSpecialProjectileIn_Moros_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponTorchSpecial",
        TraitName = "TorchDetonateAspect",
        ProjectileName = "ProjectileTorchOrbit",
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponTorchSpecial",
        TraitName = "TorchDetonateAspect",
        ProjectileName = "ProjectileTorchOrbit",
        ProjectileProperty = "DissipateFx",
        ChangeValue = "TorchSpecialProjectileDissipate_Moros_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponTorchSpecial",
        TraitName = "TorchDetonateAspect",
        ProjectileName = "ProjectileTorchOrbitEx",
        ProjectileProperty = "Graphic",
        ChangeValue = "TorchSpecialProjectileIn_Moros_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponTorchSpecial",
        TraitName = "TorchDetonateAspect",
        ProjectileName = "ProjectileTorchOrbitEx",
        ProjectileProperty = "AttachedAnim",
        ChangeValue = "TorchSpecialProjectileGroundGlow_Moros_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponTorchSpecial",
        TraitName = "TorchDetonateAspect",
        ProjectileName = "ProjectileTorchOrbitEx",
        ProjectileProperty = "DissipateFx",
        ChangeValue = "TorchSpecialProjectileDissipate_Moros_Aphrodite",
        ChangeType = "Absolute",
    },

    -- Suit
    {
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitRangedChargedUnguided",
        ProjectileProperty = "Graphic",
        ChangeValue = "SuitRocketTravel_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitRangedCharged",
        ProjectileProperty = "Graphic",
        ChangeValue = "SuitRocket_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitRangedUnguided",
        ProjectileProperty = "Graphic",
        ChangeValue = "SuitRocketUnguided_Aphrodite",
        ChangeType = "Absolute",
    },			
    {
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitRangedGuided",
        ProjectileProperty = "Graphic",
        ChangeValue = "SuitRocketTravelUnguided_Aphrodite",
        ChangeType = "Absolute",
    },			
    {
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitRangedGuided",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "SuitRocketExplosion_Aphrodite",
        ChangeType = "Absolute",
    },			
    {
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitRangedCharged",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "SuitRocketExplosion_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        TraitName = "SuitComboAspect",
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitGrenade",
        ProjectileProperty = "Graphic",
        ChangeValue = "ShivaGrenade_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "SuitComboAspect",
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitGrenade",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "GrenadeExplosion_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "SuitComboAspect",
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitBomb",
        ProjectileProperty = "Graphic",
        ChangeValue = "ShivaGrenadeBig_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "SuitComboAspect",
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitBomb",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "GrenadeExplosion_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "SuitComboAspect",
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitGrenadeStraight",
        ProjectileProperty = "Graphic",
        ChangeValue = "ShivaGrenade_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "SuitComboAspect",
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitGrenadeStraight",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "GrenadeExplosion_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "SuitComboAspect",
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitBombStraight",
        ProjectileProperty = "Graphic",
        ChangeValue = "ShivaGrenadeBig_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "SuitComboAspect",
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitBombStraight",
        ProjectileProperty = "DetonateFx",
        ChangeValue = "GrenadeExplosion_Aphrodite",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    },
    {
        TraitName = "SuitSpecialJumpTrait",
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitRangedGuided",
        ProjectileProperty = "BounceFx",
        ChangeValue = "SuitRocketExplosion_Aphrodite",
        ChangeType = "Absolute",
    },
    {
        TraitName = "SuitSpecialJumpTrait",
        WeaponName = "WeaponSuitRanged",
        ProjectileName = "ProjectileSuitRangedCharged",
        ProjectileProperty = "BounceFx",
        ChangeValue = "SuitRocketExplosion_Aphrodite",
    },
},
]]

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
