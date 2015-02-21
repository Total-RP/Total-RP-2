-------------------------------------------------------------------
-- Total RP 2
-- A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
-- Updated by Renaud Parize (Ellypse)
-- Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------


-------------------------------------------------------------------------------
-- [ Variables Systeme de l'add-on ] -- 
-------------------------------------------------------------------------------

TRP2_addonname = "Total RP 2";
BINDING_HEADER_TRP2 = TRP2_addonname;
TRP2_version = "1031"; --TODO UPDATE
TRP2_Joueur = UnitName("player");
TRP2_Royaume = GetRealmName();
TRP2_locRace, TRP2_enRace = UnitRace("player");
TRP2_locClass, TRP2_enClass = UnitClass("player");
TRP2_PlayerSex = UnitSex("player");
TRP2_bAlreadyTell = false;
TRP2_bAlreadyTellRSP = false;
TRP2_PrecisionPlanque = 250;
TRP2_UPDATEDOCUSENSI = 1.5;
TRP2_font = 'FRIZQT__.TTF';

TRP2_DesBarres = "-----------------------------------";

TRP2_ONGLETTEXTURE = {
	["Registre"] = "Interface\\ICONS\\INV_Misc_Book_02";
	["Journal"] = "Interface\\ICONS\\INV_Misc_Book_09";
	["Pets"] = "Interface\\ICONS\\INV_Box_PetCarrier_01";

	["Creation"] = "Interface\\ICONS\\INV_Misc_EngGizmos_swissArmy";
	["Options"] = "Interface\\ICONS\\INV_Misc_Wrench_02";

	["General"] = "Interface\\ICONS\\INV_Misc_GroupLooking";
	["Physique"] = "Interface\\ICONS\\Ability_Warrior_StrengthOfArms";
	["Psycho"] = "Interface\\ICONS\\Spell_Arcane_MindMastery";
	["Histoire"] = "Interface\\ICONS\\INV_Misc_Book_09";
	["Actu"] = "Interface\\ICONS\\INV_Misc_Note_03";
	["Caracteristiques"] = "Interface\\ICONS\\Spell_Holy_ImprovedResistanceAuras";

	["Quetes"] = "Interface\\ICONS\\Achievement_Quests_Completed_01";

	["Liste"] = "Interface\\ICONS\\INV_Misc_Note_05";
	["Consulte"] = "Interface\\ICONS\\Ability_Warrior_Revenge";
	["Edite"] = "Interface\\ICONS\\INV_Inscription_TradeSkill01";
};

TRP2_relation_texture = {
	"Interface\\ICONS\\Ability_DualWield",
	"Interface\\ICONS\\Achievement_Reputation_01",
	"Interface\\ICONS\\Achievement_Reputation_05",
	"Interface\\ICONS\\Achievement_Reputation_08",
	"Interface\\ICONS\\Achievement_Reputation_06",
	"Interface\\ICONS\\INV_ValentinesCandy",
	"Interface\\ICONS\\Achievement_Reputation_07"
};

TRP2_relation_color = { "|cffff0000", "|cffaaaaff", "|cff00ffff", "|cffffff00", "|cff00ff00", "|cffff7fff", "|cffff7f00" };
TRP2_relation_color_RGB = { { 0.3, 0.3, 0.3 }, { 1, 0, 0 }, { 0.5, 0.5, 1 }, { 1, 1, 1 }, { 0, 1, 0 }, { 1, 0.5, 1 }, { 1, 0.5, 0 } };

TRP2_ItemQuality = { "|cff9d9d9d", "|cffffffff", "|cff1eff00", "|cff0070dd", "|cffa335ee", "|cffff8000" };

TRP2_Auras_Color = { "{r}", "{w}", "{v}" };
TRP2_Auras_Color_RGB = { { 1, 0, 0 }, { 1, 1, 1 }, { 0, 1, 0 } };
TRP2_COLORREQUESTTAB = {};

TRP2_preTabDiscu = {
	["CHAT_MSG_SAY"] = "",
	["CHAT_MSG_YELL"] = "",
	["CHAT_MSG_PARTY"] = "|Hchannel:group|h[Groupe]|h",
	["CHAT_MSG_RAID"] = "|Hchannel:raid|h[Raid]|h",
	["CHAT_MSG_GUILD"] = "|Hchannel:guilde|h[Guilde]|h",
	["CHAT_MSG_OFFICER"] = "|Hchannel:officer|h[Officier]|h",
	["CHAT_MSG_RAID_LEADER"] = "|Hchannel:raid|h[Chef de Raid]|h",
	["CHAT_MSG_WHISPER"] = "",
	["CHAT_MSG_WHISPER_INFORM"] = "À ",
	["CHAT_MSG_TEXT_EMOTE"] = "",
	["CHAT_MSG_PARTY_LEADER"] = "|Hchannel:group|h[Chef de Groupe]|h",
}

TRP2_postTabDiscu = {
	["CHAT_MSG_SAY"] = "|r] dit : ",
	["CHAT_MSG_YELL"] = "|r] crie : ",
	["CHAT_MSG_PARTY"] = "|r] : ",
	["CHAT_MSG_RAID"] = "|r] : ",
	["CHAT_MSG_GUILD"] = "|r] : ",
	["CHAT_MSG_OFFICER"] = "|r] : ",
	["CHAT_MSG_RAID_LEADER"] = "|r] : ",
	["CHAT_MSG_WHISPER"] = "|r] chuchote : ",
	["CHAT_MSG_WHISPER_INFORM"] = "|r] : ",
	["CHAT_MSG_TEXT_EMOTE"] = "",
	["CHAT_MSG_PARTY_LEADER"] = "|r] : ",
}

TRP2_classes_color = {
	["HUNTER"] = "|cffabd473",
	["WARLOCK"] = "|cff9482c9",
	["PRIEST"] = "|cffffddff",
	["PALADIN"] = "|cfff58cba",
	["MAGE"] = "|cff69ccf0",
	["ROGUE"] = "|cfffff569 ",
	["DRUID"] = "|cffff7d0a",
	["SHAMAN"] = "|cff2459ff",
	["WARRIOR"] = "|cffc79c6e",
	["DEATHKNIGHT"] = "|cffc41f3b",
	["MONK"] = "|cff96ff00",
}

TRP2_textureRace = {
	Human = {
		Male = "Achievement_Character_Human_Male",
		Female = "Achievement_Character_Human_Female",
	},
	Gnome = {
		Male = "Achievement_Character_Gnome_Male",
		Female = "Achievement_Character_Gnome_Female",
	},
	Scourge = {
		Male = "Achievement_Character_Undead_Male",
		Female = "Achievement_Character_Undead_Female",
	},
	NightElf = {
		Male = "Achievement_Character_Nightelf_Male",
		Female = "Achievement_Character_Nightelf_Female",
	},
	Dwarf = {
		Male = "Achievement_Character_Dwarf_Male",
		Female = "Achievement_Character_Dwarf_Female",
	},
	Draenei = {
		Male = "Achievement_Character_Draenei_Male",
		Female = "Achievement_Character_Draenei_Female",
	},
	Orc = {
		Male = "Achievement_Character_Orc_Male",
		Female = "Achievement_Character_Orc_Female",
	},
	BloodElf = {
		Male = "Achievement_Character_Bloodelf_Male",
		Female = "Achievement_Character_Bloodelf_Female",
	},
	Troll = {
		Male = "Achievement_Character_Troll_Male",
		Female = "Achievement_Character_Troll_Female",
	},
	Tauren = {
		Male = "Achievement_Character_Tauren_Male",
		Female = "Achievement_Character_Tauren_Female",
	},
	Worgen = {
		Male = "Ability_Racial_TwoForms",
		Female = "Ability_Racial_Viciousness",
	},
	Goblin = {
		Male = "Ability_Racial_RocketJump",
		Female = "Ability_Racial_RocketJump",
	},
	Pandaren = {
		Male = "Achievement_Guild_ClassyPanda",
		Female = "Achievement_Character_Pandaren_Female",
	},
};

TRP2_textureSex = {
	"Neutre",
	"Male",
	"Female",
};

TRP2_QuestActionIconeTab = {
	"Ability_Warrior_Revenge",
	"Ability_Warrior_RallyingCry",
	"INV_Misc_Ear_Human_01",
	"INV_Gauntlets_41"
};

TRP2_QuestEtapeIconeTab = {
	"Achievement_BG_win_AB_X_Times",
	"Achievement_BG_killingblow_startingrock",
	"Achievement_BG_winWSG_3-0"
};

TRP2_ENTETE = "|TInterface\\AddOns\\totalRP2\\Images\\TRPlogo.tga:75:175|t\n \n";

TRP2_Saved_ChatFrame_OnEvent = nil;
TRP2_SavedFCF_OpenNewWindow = nil;
TRP2_SavedSendChatMessage = nil;

TRP2_DernierePhrase = nil;

-- TABLEAUX DE SYNCHRONISATION
TRP2_SynchronisedTab_InfoBase = {};
TRP2_SynchronisedTab_Actu = {};
TRP2_SynchronisedTab_Physique = {};
TRP2_SynchronisedTab_Psycho = {};
TRP2_SynchronisedTab_Histoire = {};
TRP2_SynchronisedTab_Caract = {};
TRP2_SynchronisedTab_InfoMinion = {};
TRP2_SynchronisedTab_InfoMount = {};
TRP2_SynchronisedTab_InfoPet = {};
-- TABLEAU DE SYNCHRONIZATION
TRP2_SynchronisedTab = {};
-- TABLEAUX DES CONNECTEs
TRP2_ConnectedUser = {};
-- TABLEAUX DE MAP
TRP2_PlayersPosition = {};
-- TABLEAUX DE LISTES 
TRP2_RegistreListeTab = {};
TRP2_JournalListeTab = {};
TRP2_GeneralListTab = {};
TRP2_SoundListTab = {};
TRP2_SoundFavListTab = {};
TRP2_PetsListeTab = {};
-- TABLEAUX LISTES CREATIONS 
TRP2_CreaListTabObjet = {};
TRP2_CreaListTabAura = {};
TRP2_CreaListTabLang = {};
TRP2_CreaListTabDocument = {};
TRP2_CreaListTabDocu = {};
TRP2_CreaListTabEvent = {};
-- TABLEAUX LISTES
TRP2_QuestsLogList = {};
TRP2_PlanqueList = {};
TRP2_PanneauList = {};

-- HOOKING
TRP2_Saved_ChatFrameEvent = nil;

TRP2_ReservedChar = '\1';
TRP2_ReservedCharBroadcast = '~';
TRP2_IDSIZE = 18;

TRP2_compagnonPrefixe = {
	"Serviteur d",
	"Familier d",
	"Compagnon d",
	"Gardien d",
	"Mascotte d",
	"'s Pet",
	"'s Guardian",
	"'s Minion",
	"'s Companion",
	"Compañero de",
	"Esbirro de",
	"Guardián de",
	"Begleiter von",
	"Gefährte von",
	"Diener von",
	"Wächter von"
};

TRP2_IconeFaction = {
	["Alliance"] = "|TInterface\\BattlefieldFrame\\Battleground-Alliance:35:35|t",
	["Horde"] = "|TInterface\\BattlefieldFrame\\Battleground-Horde:35:35|t",
}

TRP2_IconeXP = {
	["1"] = "|TInterface\\ICONS\\INV_Misc_Toy_01:",
	["2"] = "|TInterface\\ICONS\\INV_Misc_Map_01:",
	["3"] = "|TInterface\\ICONS\\Achievement_BG_tophealer_EOS:",
}

function TRP2_GetZoneIcon(zoneNum)
	if TRP2_ZoneIcons[tostring(zoneNum)] then
		return TRP2_ZoneIcons[tostring(zoneNum)];
	end
	return "Temp";
end

TRP2_ZoneIcons = {
	-- KALIMDOR
	["772"] = "Achievement_Zone_Silithus_01", -- Ahn'Qiraj: The Fallen Kingdom
	["894"] = "Achievement_Character_Draenei_Male", -- Ammen Vale
	["43"] = "Achievement_Zone_Ashenvale_01", -- Ashenvale
	["181"] = "Achievement_Zone_Azshara_01", -- Azshara
	["464"] = "Achievement_Zone_AzuremystIsle_01", -- Azuremyst Isle
	["476"] = "Achievement_Zone_BloodmystIsle_01", -- Bloodmyst Isle
	["890"] = "Achievement_Character_Tauren_Male", -- Camp Narache
	["42"] = "Achievement_Zone_Darkshore_01", -- Darkshore
	["381"] = "Achievement_Zone_Darnassus", -- Darnassus
	["101"] = "Achievement_Zone_Desolace", -- Desolace
	["4"] = "Achievement_Zone_Durotar", -- Durotar
	["141"] = "Achievement_Zone_DustwallowMarsh", -- Dustwallow Marsh
	["891"] = "Achievement_Character_Troll_Male", -- Echo Isles
	["182"] = "Achievement_Zone_Felwood", -- Felwood
	["121"] = "Achievement_Zone_Feralas", -- Feralas
	["13"] = "Achievement_Zone_Kalimdor_01", -- Kalimdor
	["795"] = "achievement_zone_firelands", -- Molten Front
	["241"] = "SPELL_ARCANE_TELEPORTMOONGLADE", -- Moonglade
	["606"] = "Achievement_Zone_Mount\ Hyjal", -- Mount Hyjal
	["9"] = "Achievement_Zone_Mulgore_01", -- Mulgore
	["11"] = "Achievement_Zone_Barrens_01", -- Northern Barrens
	["321"] = "PVPCurrency-Conquest-Horde", -- Orgrimmar
	["888"] = "Achievement_Character_Nightelf_Male", -- Shadowglen
	["261"] = "Achievement_Zone_Silithus_01", -- Silithus
	["607"] = "Achievement_Zone_Barrens_01", -- Southern Barrens
	["81"] = "Achievement_Zone_Stonetalon_01", -- Stonetalon Mountains
	["161"] = "Achievement_Zone_Tanaris_01", -- Tanaris
	["41"] = "Achievement_Zone_Darnassus", -- Teldrassil
	["471"] = "Spell_Arcane_TeleportExodar", -- The Exodar
	["61"] = "Achievement_Zone_ThousandNeedles_01", -- Thousand Needles
	["362"] = "Spell_Arcane_TeleportThunderBluff", -- Thunder Bluff
	["720"] = "Achievement_Zone_Uldum", -- Uldum
	["201"] = "Achievement_Zone_UnGoroCrater_01", -- Un'Goro Crater
	["889"] = "Achievement_Character_Orc_Male", -- Valley of Trials
	["281"] = "Achievement_Zone_Winterspring", -- Winterspring

	-- EASTERN KINGDOMS
	["614"] = "Achievement_Zone_Vashjir", -- Abyssal Depths
	["16"] = "Achievement_Zone_ArathiHighlands_01", -- Arathi Highlands
	["17"] = "Achievement_Zone_Badlands_01", -- Badlands
	["19"] = "Achievement_Zone_BlastedLands_01", -- Blasted Lands
	["29"] = "Achievement_Zone_BurningSteppes_01", -- Burning Steppes
	["866"] = "Achievement_Character_Dwarf_Male", -- Coldridge Valley
	["32"] = "Achievement_Zone_DeadwindPass", -- Deadwind Pass
	["892"] = "Achievement_Character_Undead_Male", -- Deathknell
	["27"] = "Achievement_Zone_DunMorogh", -- Dun Morogh
	["34"] = "Achievement_Zone_Duskwood", -- Duskwood
	["14"] = "Achievement_Zone_EasternKingdoms_01", -- Eastern Kingdoms
	["23"] = "Achievement_Zone_EasternPlaguelands", -- Eastern Plaguelands
	["30"] = "Achievement_Zone_ElwynnForest", -- Elwynn Forest
	["462"] = "Achievement_Zone_EversongWoods", -- Eversong Woods
	["463"] = "Achievement_Zone_Ghostlands", -- Ghostlands
	["545"] = "Achievement_Zone_Gilneas_02", -- Gilneas
	["611"] = "Achievement_Zone_Gilneas_02", -- Gilneas City
	["24"] = "Achievement_Zone_HillsbradFoothills", -- Hillsbrad Foothills
	["341"] = "Achievement_Zone_Ironforge", -- Ironforge
	["499"] = "Achievement_Zone_IsleOfQuelDanas", -- Isle of Quel'Danas
	["610"] = "Achievement_Zone_Vashjir", -- Kelp'thar Forest
	["35"] = "Achievement_Zone_LochModan", -- Loch Modan
	["895"] = "Achievement_Character_Gnome_Male", -- New Tinkertown
	["37"] = "Achievement_Zone_Stranglethorn_01", -- Northern Stranglethorn
	["864"] = "Achievement_Character_Human_Male", -- Northshire
	["36"] = "Achievement_Zone_RedridgeMountains", -- Redridge Mountains
	["684"] = "Achievement_Zone_Gilneas_02", -- Ruins of Gilneas
	["685"] = "Achievement_Zone_Gilneas_02", -- Ruins of Gilneas City
	["28"] = "Achievement_Zone_SearingGorge_01", -- Searing Gorge
	["615"] = "Achievement_Zone_Vashjir", -- Shimmering Expanse
	["480"] = "Inv_Misc_Tournaments_banner_Bloodelf", -- Silvermoon City
	["21"] = "Achievement_Zone_Silverpine_01", -- Silverpine Forest
	["301"] = "PVPCurrency-Conquest-Alliance", -- Stormwind City
	["689"] = "Achievement_Zone_Stranglethorn_01", -- Stranglethorn Vale
	["893"] = "Achievement_Character_Bloodelf_Male", -- Sunstrider Isle
	["38"] = "Achievement_Zone_SwampSorrows_01", -- Swamp of Sorrows
	["673"] = "Achievement_Zone_Stranglethorn_01", -- The Cape of Stranglethorn
	["26"] = "Achievement_Zone_Hinterlands_01", -- The Hinterlands
	["502"] = "INV_Misc_Token_ScarletCrusade", -- The Scarlet Enclave
	["20"] = "Achievement_Zone_TirisfalGlades_01", -- Tirisfal Glades
	["708"] = "Achievement_Zone_TolBarad", -- Tol Barad
	["709"] = "Achievement_Zone_TolBarad", -- Tol Barad Peninsula
	["700"] = "Achievement_Zone_TwilightHighlands", -- Twilight Highlands
	["382"] = "Spell_Arcane_TeleportUnderCity", -- Undercity
	["613"] = "Achievement_Zone_Vashjir", -- Vashj'ir
	["22"] = "Achievement_Zone_WesternPlaguelands_01", -- Western Plaguelands
	["39"] = "Achievement_Zone_WestFall_01", -- Westfall
	["40"] = "Achievement_Zone_Wetlands_01", -- Wetlands

	-- MAELSTROM
	["751"] = "INV_Misc_Ticket_Tarot_Maelstrom_01", -- The Maelstrom
	["640"] = "Achievement_Zone_DeepHolm", -- Deepholm
	["605"] = "INV_MISC_GOBLINCUP02", -- Kezan
	["544"] = "Ability_Rhyolith_Volcano", -- The Lost Isles
	["737"] = "INV_Misc_Ticket_Tarot_Maelstrom_01", -- The Maelstrom

	-- CLASSIC DUNGEONS
	["688"] = "achievement_boss_bazil_akumai", -- Blackfathom Deeps
	["704"] = "achievement_boss_emperordagranthaurissan", -- Blackrock Depths
	["721"] = "achievement_boss_overlord_wyrmthalak", -- Blackrock Spire
	["699"] = "ability_warrior_decisivestrike", -- Dire Maul
	["691"] = "achievement_boss_mekgineer_thermaplugg-", -- Gnomeregan
	["750"] = "achievement_boss_princesstheradras", -- Maraudon
	["680"] = "racial_orc_berserkerstrength", -- Ragefire Chasm
	["760"] = "achievement_boss_amnennar_the_coldbringer", -- Razorfen Downs
	["761"] = "achievement_boss_charlgarazorflank", -- Razorfen Kraul
	["764"] = "inv_helm_robe_dungeonrobe_c_04", -- Shadowfang Keep
	["765"] = "spell_deathknight_armyofthedead", -- Stratholme
	["756"] = "achievement_boss_edwinvancleef", -- The Deadmines
	["690"] = "inv_misc_head_gnoll_01", -- The Stockade
	["687"] = "achievement_boss_shadeoferanikus", -- The Temple of Atal'Hakkar
	["692"] = "achievement_boss_archaedas", -- Uldaman
	["749"] = "achievement_boss_mutanus_the_devourer", -- Wailing Caverns
	["686"] = "achievement_boss_chiefukorzsandscalp", -- Zul'Farrak

	-- CLASSIC RAIDS
	["755"] = "achievement_boss_nefarion", -- Blackwing Lair
	["696"] = "achievement_boss_ragnaros", -- Molten Core
	["717"] = "achievement_boss_ossiriantheunscarred", -- Ruins of Ahn'Qiraj
	["766"] = "achievement_boss_cthun", -- Temple of Ahn'Qiraj

	-- OUTLAND
	["466"] = "Achievement_Zone_Outland_01", -- Outland
	["475"] = "Achievement_Zone_BladesEdgeMtns_01", -- Blade's Edge Mountains
	["465"] = "Achievement_Zone_HellfirePeninsula_01", -- Hellfire Peninsula
	["477"] = "Achievement_Zone_Nagrand_01", -- Nagrand
	["479"] = "Achievement_Zone_Netherstorm_01", -- Netherstorm
	["473"] = "Achievement_Zone_Shadowmoon", -- Shadowmoon Valley
	["481"] = "Spell_Arcane_TeleportShattrath", -- Shattrath City
	["478"] = "Achievement_Zone_Terrokar", -- Terokkar Forest
	["467"] = "Achievement_Zone_Zangarmarsh", -- Zangarmarsh

	-- BURNING CRUSADE DUNGEONS
	["722"] = "achievement_boss_exarch_maladaar", -- Auchenai Crypts
	["797"] = "achievement_boss_omartheunscarred_01", -- Hellfire Ramparts
	["798"] = "achievement_boss_kael-thassunstrider_01", -- Magisters' Terrace
	["732"] = "achievement_boss_nexus_prince_shaffar", -- Mana-Tombs
	["734"] = "achievement_boss_epochhunter", -- Old Hillsbrad Foothills
	["723"] = "achievement_boss_talonkingikiss", -- Sethekk Halls
	["724"] = "achievement_boss_murmur", -- Shadow Labyrinth
	["731"] = "achievement_boss_harbinger_skyriss", -- The Arcatraz
	["733"] = "achievement_boss_aeonus_01", -- The Black Morass
	["725"] = "achievement_boss_kelidanthebreaker", -- The Blood Furnace
	["729"] = "achievement_boss_warpsplinter", -- The Botanica
	["730"] = "achievement_boss_pathaleonthecalculator", -- The Mechanar
	["710"] = "achievement_boss_kargathbladefist_01", -- The Shattered Halls
	["728"] = "achievement_boss_quagmirran", -- The Slave Pens
	["727"] = "achievement_boss_warlord_kalithresh", -- The Steamvault
	["726"] = "achievement_boss_theblackstalker", -- The Underbog

	-- BURNING CRUSADE RAIDS
	["796"] = "achievement_boss_illidan", -- Black Temple
	["776"] = "achievement_boss_gruulthedragonkiller", -- Gruul's Lair
	["775"] = "achievement_boss_archimonde-", -- Hyjal Summit
	["799"] = "achievement_boss_princemalchezaar_02", -- Karazhan
	["779"] = "achievement_boss_magtheridon", -- Magtheridon's Lair
	["780"] = "achievement_boss_ladyvashj", -- Serpentshrine Cavern
	["789"] = "achievement_boss_kiljaedan", -- Sunwell Plateau
	["782"] = "achievement_character_bloodelf_male", -- The Eye

	-- NORTHREND
	["485"] = "Achievement_Zone_BoreanTundra_01", -- Northrend
	["486"] = "Achievement_Zone_BoreanTundra_01", -- Borean Tundra
	["510"] = "Achievement_Zone_CrystalSong_01", -- Crystalsong Forest
	["504"] = "INV_Offhand_Dalaran_D_01", -- Dalaran
	["488"] = "Achievement_Zone_DragonBlight_02", -- Dragonblight
	["490"] = "Achievement_Zone_GrizzlyHills_01", -- Grizzly Hills
	["491"] = "Achievement_Zone_HowlingFjord_01", -- Howling Fjord
	["541"] = "INV_Misc_Head_Vrykul", -- Hrothgar's Landing
	["492"] = "Achievement_Zone_IceCrown_01", -- Icecrown
	["493"] = "Achievement_Zone_Sholazar_01", -- Sholazar Basin
	["495"] = "Achievement_Zone_StormPeaks_03", -- The Storm Peaks
	["501"] = "INV_EssenceOfWintergrasp", -- Wintergrasp
	["496"] = "Achievement_Zone_ZulDrak_01", -- Zul'Drak

	-- WOTLK DUNGEONS
	["522"] = "achievement_dungeon_azjollowercity_normal", -- Ahn'kahet: The Old Kingdom
	["533"] = "achievement_dungeon_azjoluppercity_normal", -- Azjol-Nerub
	["534"] = "achievement_dungeon_drak-tharon_normal", -- Drak'Tharon Keep
	["530"] = "achievement_dungeon_gundrak_heroic", -- Gundrak
	["525"] = "achievement_dungeon_ulduar80_normal", -- Halls of Lightning
	["603"] = "achievement_dungeon_icecrown_hallsofreflection", -- Halls of Reflection
	["526"] = "achievement_dungeon_ulduar77_normal", -- Halls of Stone
	["602"] = "achievement_dungeon_icecrown_pitofsaron", -- Pit of Saron
	["521"] = "achievement_dungeon_cotstratholme_normal", -- The Culling of Stratholme
	["601"] = "achievement_dungeon_icecrown_forgeofsouls", -- The Forge of Souls
	["520"] = "achievement_dungeon_nexus70_normal", -- The Nexus
	["528"] = "achievement_dungeon_nexus80_normal", -- The Oculus
	["536"] = "achievement_dungeon_theviolethold_normal", -- The Violet Hold
	["542"] = "inv_spear_05", -- Trial of the Champion
	["523"] = "inv_helmet_130", -- Utgarde Keep
	["524"] = "inv_mace_80", -- Utgarde Pinnacle

	-- WOTLK RAIDS
	["604"] = "achievement_boss_lichking", -- Icecrown Citadel
	["535"] = "Achievement_Dungeon_Naxxramas", -- Naxxramas
	["718"] = "Achievement_Boss_Onyxia", -- Onyxia's Lair
	["527"] = "achievement_dungeon_nexusraid", -- The Eye of Eternity
	["531"] = "achievement_dungeon_coablackdragonflight", -- The Obsidian Sanctum
	["609"] = "spell_shadow_twilight", -- The Ruby Sanctum
	["543"] = "achievement_reputation_argentchampion", -- Trial of the Crusader
	["529"] = "Achievement_Dungeon_Ulduar80_Normal", -- Ulduar
	["532"] = "spell_nature_elementalprecision_2", -- Vault of Archavon

	-- PANDARIA
	["862"] = "ExpansionIcon_MistsofPandaria", -- Pandaria
	["858"] = "Achievement_Zone_DreadWastes", -- Dread Wastes
	["929"] = "Achievement_Dungeon_UlduarRaid_IceGiant_01", -- Isle of Giants
	["928"] = "Achievement_Raid_Thunder_King", -- Isle of Thunder
	["857"] = "Achievement_Zone_KrasarangWilds", -- Krasarang Wilds
	["809"] = "Achievement_Zone_KunLaiSummit", -- Kun-Lai Summit
	["905"] = "ExpansionIcon_MistsofPandaria", -- Shrine of Seven Stars
	["903"] = "ExpansionIcon_MistsofPandaria", -- Shrine of Two Moons
	["806"] = "Achievement_Zone_JadeForest", -- The Jade Forest
	["873"] = "ExpansionIcon_MistsofPandaria", -- The Veiled Stair
	["808"] = "ExpansionIcon_MistsofPandaria", -- The Wandering Isle
	["951"] = "TimelessCoin", -- Timeless Isle
	["810"] = "Achievement_Zone_TownlongSteppes", -- Townlong Steppes
	["811"] = "Achievement_Zone_ValeofEternalBlossoms", -- Vale of Eternal Blossoms
	["807"] = "Achievement_Zone_ValleyofFourWinds", -- Valley of the Four Winds

	-- PANDARIA DUNGEONS
	["875"] = "Achievement_Raid_MantidRaid02", -- Gate of the Setting Sun
	["885"] = "achievement_dungeon_mogupalace", -- Mogu'Shan Palace
	["871"] = "inv_helmet_52", -- Scarlet Halls
	["874"] = "spell_holy_resurrection", -- Scarlet Monastery
	["898"] = "spell_holy_senseundead", -- Scholomance
	["877"] = "achievement_shadowpan_hideout_1", -- Shado-pan Monastery
	["887"] = "achievement_dungeon_siegeofniuzaotemple", -- Siege of Niuzao Temple
	["876"] = "achievement_brewery", -- Stormstout Brewery
	["867"] = "achievement_jadeserpent", -- Temple of the Jade Serpent

	-- PANDARIA RAIDS
	["897"] = "INV_Heart_of_the_Thunder King_Icon", -- Heart of Fear
	["896"] = "Achievement_Moguraid_02", -- Mogu'shan Vaults
	["953"] = "achievement_raid_soo_garrosh_compound_half2", -- Siege of Orgrimmar
	["886"] = "achievement_raid_terraceofendlessspring04", -- Terrace of Endless Spring
	["930"] = "Achievement_Raid_Thunder_King", -- Throne of Thunder

	-- DRAENOR
	["962"] = "Achievement_Zone_Draenor_01", -- Draenor
	["978"] = "Achievement_Zone_Ashran", -- Ashran
	["941"] = "Achievement_Zone_Frostfire", -- Frostfire Ridge
	["976"] = "Achievement_Garrison_Tier01_Horde", -- Frostwall (Horde garrison)
	["949"] = "Achievement_Zone_Gorgrond", -- Gorgrond
	["971"] = "Achievement_Garrison_Tier01_Alliance", -- Lunarfall (Alliance garrison)
	["950"] = "Achievement_Zone_Nagrand_02", -- Nagrand
	["947"] = "achievement_zone_newshadowmoonvalley", -- Shadowmoon Valley
	["948"] = "Achievement_Zone_SpiresofArak", -- Spires of Arak
	["1009"] = "INV_Banner_Stormshield", -- Stormshield
	["946"] = "Achievement_Zone_Talador", -- Talador
	["945"] = "Achievement_Zone_Tanaanjungle", -- Tanaan Jungle
	["970"] = "Achievement_Zone_Tanaanjungle", -- Tanaan Jungle - Assault on the Dark Portal
	["1011"] = "INV_Banner_Warspear", -- Warspear



	-- BATTLEGROUNDS
	["401"] = "Achievement_Zone_AlteracMountains_01", -- Alterac Valley
	["461"] = "Achievement_Zone_ArathiHighlands_01", -- Arathi Basin
	["935"] = "Achievement_BG_DG_Master_of_the_deepwind_gorge", -- Deepwind Gorge
	["482"] = "Spell_Nature_EyeOfTheStorm", -- Eye of the Storm
	["540"] = "achievement_bg_winwsg", -- Isle of Conquest
	["860"] = "Achievement_Battleground_SilvershardMines", -- Silvershard Mines
	["512"] = "Creatureportrait_portal_strandoftheancients", -- Strand of the Ancients
	["856"] = "Achievement_Battleground_TempleOfKotmogu", -- Temple of Kotmogu
	["736"] = "Achievement_Battleground_BattleForGilneas", -- The Battle for Gilneas
	["626"] = "Spell_Nature_EarthShock", -- Twin Peaks
	["443"] = "Spell_Misc_WarsongFocus", -- Warsong Gulch

	-- SCENARIOS
	["878"] = "pandarenracial_innerpeace", -- A Brewing Storm
	["912"] = "achievement_character_orc_male", -- A Little Patience
	["899"] = "achievement_arena_3v3_1", -- Arena of Annihilation
	["883"] = "achievement_raid_mantidraid03", -- Assault on Zan'vess
	["940"] = "ability_vehicle_siegeenginecannon", -- Battle on the High Seas
	["939"] = "achievement_zone_dunmorogh", -- Blood in the Snow
	["884"] = "inv_drink_05", -- Brewmoon Festival
	["955"] = "inv_celestialserpentmount", -- Celestial Tournament
	["900"] = "archaeology_5_0_keystone_mogu", -- Crypt of Forgotten Kings
	["914"] = "inv_knife_1h_cataclysm_c_03", -- Dagger in the Dark
	["937"] = "inv_heart_of_the_thunder-king_icon", -- Dark Heart of Pandaria
	["920"] = "pvpcurrency-honor-horde", -- Domination Point (H)
	["880"] = "inv_misc_gem_stone_01", -- Greenstone Village
	["911"] = "pvpcurrency-conquest-alliance", -- Lion's Landing (A)
	["938"] = "racial_orc_berserkerstrength", -- The Secrets of Ragefire
	["906"] = "spell_arcane_teleporttheramore", -- Theramore's Fall (A)
	["851"] = "spell_arcane_teleporttheramore", -- Theramore's Fall (H)
	["882"] = "inv_misc_hook_01", -- Unga Ingoo


	-- CATACLYSM DUNGEONS
	["753"] = "achievement_dungeon_blackrockcaverns", -- Blackrock Caverns
	["820"] = "achievement_boss_infinitecorruptor", -- End Time
	["757"] = "achievement_dungeon_grimbatol", -- Grim Batol
	["759"] = "achievement_dungeon_halls-of-origination", -- Halls of Origination
	["819"] = "achievment_raid_houroftwilight", -- Hour of Twilight
	["747"] = "achievement_dungeon_lostcity-of-tolvir", -- Lost City of the Tol'vir
	["768"] = "achievement_dungeon_deepholm", -- The Stonecore
	["769"] = "achievement_dungeon_skywall", -- The Vortex Pinnacle
	["767"] = "achievement_dungeon_throne-of-the-tides", -- Throne of the Tides
	["816"] = "achievment_boss_wellofeternity", -- Well of Eternity
	["781"] = "achievement_boss_zuljin", -- Zul'Aman
	["793"] = "achievement_boss_hakkar", -- Zul'Gurub

	-- CATACLYSM RAIDS
	["752"] = "achievement_zone_tolbarad", -- Baradin Hold
	["754"] = "achievement_dungeon_blackwingdescent_raid_nefarian", -- Blackwing Descent
	["824"] = "achievment_boss_madnessofdeathwing", -- Dragon Soul
	["800"] = "achievement_zone_firelands", -- Firelands
	["758"] = "Warlock_HourOfTwilight", -- The Bastion of Twilight
	["773"] = "achievement_boss_murmur", -- Throne of the Four Winds

	-- DRAENOR DUNGEONS
	["984"] = "Achievement_Dungeon_Auchindoun", -- Auchindoun
	["964"] = "achievement_dungeon_ogreslagmines", -- Bloodmaul Slag Mines
	["993"] = "achievement_dungeon_blackrockdepot", -- Grimrail Depot
	["987"] = "achievement_dungeon_blackrockdocks", -- Iron Docks
	["969"] = "achievement_dungeon_shadowmoonhideout", -- Shadowmoon Burial Grounds
	["989"] = "achievement_dungeon_arakkoaspires", -- Skyreach
	["1008"] = "inv_enchant_shaperessence", -- The Everbloom
	["995"] = "achievement_dungeon_upperblackrockspire", -- Upper Blackrock Spire

	-- DRAENOR RAIDS
	["994"] = "Achievement_Boss_HighMaul_King", -- Highmaul
	["988"] = "achievement_boss_blackhand", -- Blackrock Foundry
}

TRP2_PetFamilyTab = {
	["Ver"] = "Ability_Hunter_Pet_Worm",
	["Loup"] = "Ability_Hunter_Pet_Wolf",
	["Tortue"] = "Ability_Hunter_Pet_Turtle",
	["Rhinocéros"] = "Ability_Hunter_Pet_Rhino",
	["Diablotin"] = "Spell_Shadow_SummonImp",
	["Marcheur du Vide"] = "Spell_Shadow_SummonVoidWalker",
	["Scorpide"] = "Ability_Hunter_Pet_Scorpid",
	["Oiseau de proie"] = "Ability_Hunter_Pet_Owl",
	["Goule"] = "Spell_Shadow_RaiseDead",
	["Crabe"] = "Ability_Hunter_Pet_Crab",
	["Ours"] = "Ability_Hunter_Pet_Bear",
	["Sanglier"] = "Ability_Hunter_Pet_Boar",
	["Chasseur corrompu"] = "Spell_Shadow_SummonFelhunter",
	["Araignée"] = "Ability_Hunter_Pet_Spider",
	["Félin"] = "Ability_Hunter_Pet_Cat",
	["Gorille"] = "Ability_Hunter_Pet_Gorilla",
	["Gangregarde"] = "Spell_Shadow_SummonFelGuard",
	["Haut-trotteur"] = "Ability_Hunter_Pet_TallStrider",
	["Ravageur"] = "Ability_Hunter_Pet_Ravager",
	["Phalène"] = "Ability_Hunter_Pet_Moth",
	["Succube"] = "Spell_Shadow_SummonSuccubus",
	["Esprit de bête"] = "Spell_Nature_SpiritWolf",
	["Chien du Magma"] = "Ability_Hunter_Pet_CoreHound",
	["Guêpe"] = "Ability_Hunter_Pet_Wasp",
	["Garde funeste"] = "Spell_Fire_FelPyroblast",
	["Faucon-dragon"] = "Ability_Hunter_Pet_DragonHawk",
	["Serpent des vents"] = "Ability_Hunter_Pet_WindSerpent",
	["Diablosaure"] = "Ability_Hunter_Pet_Devilsaur",
	["Crocilisque"] = "Ability_Hunter_Pet_Crocolisk",
	["Hyène"] = "Ability_Hunter_Pet_Hyena",
	["Traqueur dim."] = "Ability_Hunter_Pet_WarpStalker",
	["Elémentaire d'eau"] = "Spell_Frost_SummonWaterElemental_2",
	["Silithide"] = "Ability_Hunter_Pet_Silithid",
	["Serpent"] = "Ability_Hunter_SerpentSwiftness",
	["Chauve-souris"] = "Ability_Hunter_Pet_Bat",
	["Chimère"] = "Ability_Hunter_Pet_Chimera",
	["Renard"] = "inv_misc_foxkit",
	["Chien"] = "Ability_Mount_BlackDireWolf",
	["Singe"] = "Ability_Hunter_AspectOfTheMonkey",
	["Worm"] = "Ability_Hunter_Pet_Ver",
	["Wolf"] = "Ability_Hunter_Pet_Wolf",
	["Turtle"] = "Ability_Hunter_Pet_Turtle",
	["Rhino"] = "Ability_Hunter_Pet_Rhino",
	["Imp"] = "Spell_Shadow_SummonImp",
	["Voidwalker"] = "Spell_Shadow_SummonVoidWalker",
	["Scorpid"] = "Ability_Hunter_Pet_Scorpid",
	["Bird of Prey"] = "Ability_Hunter_Pet_Owl",
	["Raptor"] = "Ability_Hunter_Pet_Raptor",
	["Ghoul"] = "Spell_Shadow_RaiseDead",
	["Crab"] = "Ability_Hunter_Pet_Crab",
	["Bear"] = "Ability_Hunter_Pet_Bear",
	["Boar"] = "Ability_Hunter_Pet_Boar",
	["Felhunter"] = "Spell_Shadow_SummonFelhunter",
	["Spider"] = "Ability_Hunter_Pet_Spider",
	["Cat"] = "Ability_Hunter_Pet_Cat",
	["Gorilla"] = "Ability_Hunter_Pet_Gorilla",
	["Felguard"] = "Spell_Shadow_SummonFelGuard",
	["Tallstrider"] = "Ability_Hunter_Pet_TallStrider",
	["Ravager"] = "Ability_Hunter_Pet_Ravager",
	["Moth"] = "Ability_Hunter_Pet_Moth",
	["Succubus"] = "Spell_Shadow_SummonSuccubus",
	["Spirit Beast"] = "Spell_Nature_SpiritWolf",
	["Core Hound"] = "Ability_Hunter_Pet_CoreHound",
	["Wasp"] = "Ability_Hunter_Pet_Wasp",
	["Doomguard"] = "Spell_Fire_FelPyroblast",
	["Dragonhawk"] = "Ability_Hunter_Pet_DragonHawk",
	["Wind Serpent"] = "Ability_Hunter_Pet_WindSerpent",
	["Devilsaur"] = "Ability_Hunter_Pet_Devilsaur",
	["Crocolisk"] = "Ability_Hunter_Pet_Crocolisk",
	["Hyena"] = "Ability_Hunter_Pet_Hyena",
	["Warp Stalker"] = "Ability_Hunter_Pet_WarpStalker",
	["Silithid"] = "Ability_Hunter_Pet_Silithid",
	["Serpent"] = "Ability_Hunter_SerpentSwiftness",
	["Bat"] = "Ability_Hunter_Pet_Bat",
	["Chimaera"] = "Ability_Hunter_Pet_Chimera",
	["Water Elemental"] = "Spell_Frost_SummonWaterElemental_2",
	["Fox"] = "inv_misc_foxkit",
	["Dog"] = "Ability_Mount_BlackDireWolf",
	["Monkey"] = "Ability_Hunter_AspectOfTheMonkey",
	["Carrion Bird"] = "Spell_Shadow_CarrionSwarm",
	["Remote Control"] = "INV_Gizmo_02",
	["Sporebat"] = "Ability_Hunter_Pet_Sporebat",
	["Nether Ray"] = "Ability_Hunter_Pet_NetherRay",
}

TRP2_FoodIconTable = {
	["Viande"] = "INV_Misc_Food_Meat_Raw_04";
	["Poisson"] = "INV_Misc_Fish_09";
	["Fruit"] = "INV_Misc_Food_57";
	["Champignon"] = "INV_Mushroom_12";
	["Pain"] = "INV_MISC_FOOD_11";
	["Fromage"] = "INV_Misc_Food_07";
	["Meat"] = "INV_Misc_Food_Meat_Raw_04";
	["Fish"] = "INV_Misc_Fish_09";
	["Fruit"] = "INV_Misc_Food_57";
	["Fungus"] = "INV_Mushroom_12";
	["Bread"] = "INV_MISC_FOOD_11";
	["Cheese"] = "INV_Misc_Food_07";
};

TRP2_EFFETCHATTAB = {
	"SAY", "EMOTE", "YELL", "GUILD", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "RAID_WARNING", "BATTLEGROUND", "BATTLEGROUND_LEADER"
}

TRP2_DIALBASETAB = {
	["Draenei"] = "Commun,Common,Lengua común,Gemeinsprache,Draeneï,Draenei";
	["Human"] = "Commun,Common,Lengua común,Gemeinsprache";
	["Gnome"] = "Commun,Common,Lengua común,Gemeinsprache,Gnome,Gnomish,Gnomótico,Gnomisch";
	["Dwarf"] = "Commun,Common,Lengua común,Gemeinsprache,Nain,Dwarvish,Enánico,Zwergisch";
	["NightElf"] = "Commun,Common,Lengua común,Gemeinsprache,Darnassien,Darnassian,Darnassiano,Darnassisch",
	["Worgen"] = "Commun,Common,Lengua común,Gemeinsprache",
	["Orc"] = "Orc,Orco,Orcish,Orcisch",
	["Scourge"] = "Orc,Orco,,Orcisch,Réprouvé,Orcish,Forsaken,Renegado,Gossensprache",
	["BloodElf"] = "Orc,Orco,Orcish,Orcisch,Thalassien,Thalassian,Thalassiano,Thalassisch",
	["Troll"] = "Orc,Orco,Orcish,Orcisch,Troll,Trol",
	["Tauren"] = "Orc,Orco,Orcish,Orcisch,Taurahe",
	["Goblin"] = "Orc,Orco,Orcish,Orcisch,Gobelin,Goblin",
	["Pandaren"] = "Commun,Common,Lengua común,Gemeinsprache,Orc,Orco,Orcish,Orcisch,Pandaren,Pandarisch";
};

TRP2_FACTION = {
	["Alliance"] = "Human, Dwarf, Gnome, NightElf, Worgen, Pandaren";
	["Horde"] = "Scourge, BloodElf, Troll, Tauren, Golbin, Pandaren";
}

TRP2_OriginelLang = {
	["Commun"] = true,
	--["Pandaren"] = true,
	--["Pandarisch"] = true,
	["Common"] = true,
	["Orc"] = true,
	["Orcish"] = true,
	["Lengua común"] = true,
	["Orco"] = true,
	["Gemeinsprache"] = true,
	["Orcisch"] = true,
}
