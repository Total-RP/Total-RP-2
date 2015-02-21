-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

TRP2_Libs = LibStub("AceAddon-3.0"):NewAddon("MyAddon", "AceSerializer-3.0")

-- Chargement de la librarie LibDGIcon-1.0 grâce à LibStub (gestionnaire de libraires)
local icon = LibStub("LibDBIcon-1.0")

-- Création d'un objet LDB, LibDataBroker, avec plusieurs attributs
local TRP2_MinimapButton = LibStub("LibDataBroker-1.1"):NewDataObject("TRP2_MinimapButton", {
	type = "data source",
	text = "Total RP 2",
	icon = "Interface\\AddOns\\totalRP2\\Images\\icon.tga",
	OnClick = function(clickedframe, button) if button == "LeftButton" then
					TRP2_OpenMainMenu(not TRP2MainFrame:IsVisible());
				elseif button == "RightButton" then
					if TRP2_RaccBar:IsVisible() then
						TRP2_RaccBar:Hide();
					else
						TRP2_RaccBar:Show();
					end
				end
			 end,
			OnLoad = function() self:RegisterForClicks("LeftButtonUp","RightButtonUp");end,
			OnTooltipShow = function(tooltip)
            TRP2_Libs:Tooltip_LDB(tooltip)
        end,
})

-- Populates the LDB tooltip
function TRP2_Libs:Tooltip_LDB(tooltip)
    tooltip:AddLine("Total RP 2");
    tooltip:AddLine(TRP2_LOC_CLIC.." : "..TRP2_LOC_OPENMENU);
    tooltip:AddLine(TRP2_LOC_CLICDROIT.." : "..TRP2_LOC_OPENRACC);
end

-- Fonction qui se lance au chargement de l'addon
function TRP2_Libs:OnInitialize()

	-- Enregistre une variable à partir de l'objet
	self.db = LibStub("AceDB-3.0"):New("totalRP2", {
		profile = {
			minimap = {
				hide = false,
			},
		},
	})
	icon:Register("TRP2_MinimapButton", TRP2_MinimapButton, self.db.profile.minimap)
end

function TRP2_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("CHAT_MSG_ADDON");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	self:RegisterEvent("CHAT_MSG_CHANNEL");
	self:RegisterEvent("PLAYER_REGEN_DISABLED");
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	self:RegisterEvent("WORLD_MAP_UPDATE");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	self:RegisterEvent("WORLD_MAP_UPDATE");
end

TRP2_UPDATERTAB = {};

function TRP2_OnEvent(self,event,...)
	local arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12 = ...;
	if(event=="ADDON_LOADED" and arg1=="totalRP2") then
		-- Chargement sécurisé
		local arg1,errorCall = TRP2_PCall(function() 
			TRP2_OnLoaded();
		end,nil,nil,nil,nil,nil,nil,nil,true);
		if errorCall then
			message("Total RP 2\nAn error occured during the loading of the addon. The addon won't work correctly !");
		end

	elseif event=="WORLD_MAP_UPDATE" then
		TRP2_debug("Should update map");
		local i = 1;
		while(getglobal("TRP2_WordMapPlayer"..i)) do
			getglobal("TRP2_WordMapPlayer"..i):Hide();
			i = i+1;
		end
		i = 0;
	elseif event=="CHAT_MSG_ADDON" then
		if arg1 == TRP2_COMM_PREFIX then
			if TRP2_EstIgnore(arg2) or arg2 == TRP2_Joueur or not TRP2_GetConfigValueFor("ActivateExchange",true) then
				return;
			end
			TRP2_receiveMessage(arg2,arg4);
		end
	elseif event=="CHAT_MSG_CHANNEL_NOTICE" then
		if arg1 == "YOU_JOINED" then
			TRP2_SePresenterSurLeChan();
		end
	elseif event=="PLAYER_ENTERING_WORLD" then
		RegisterAddonMessagePrefix(TRP2_COMM_PREFIX);
	elseif(event=="UPDATE_MOUSEOVER_UNIT") then
		local nom,royaume = UnitName("mouseover");
		if royaume then
			nom = nom.."-"..royaume;
		end
		if nom and nom ~= UNKNOWN and TRP2_EstDansLeReg(nom) and CheckInteractDistance("mouseover", 4)  and UnitIsPlayer("mouseover") and nom~=TRP2_Joueur and UnitFactionGroup("mouseover") == UnitFactionGroup("player") then
			if not TRP2_UPDATERTAB[nom] or time() - TRP2_UPDATERTAB[nom] > 1 then -- Optimisation (1 sec)
				TRP2_UPDATERTAB[nom] = time();
				TRP2_SecureSendAddonMessage("GTVN",TRP2_SendVernNum(),nom); -- Send VerNumTab avec request des VerNum adverses
				TRP2_MSP_Request(nom, royaume); -- MSP compatibility
			end
		end
		if TRP2_GetConfigValueFor("UseBroadcast",true) then
			if GetChannelName(string.lower(TRP2_GetConfigValueFor("ChannelToUse","xtensionxtooltip2"))) == 0 then
				JoinChannelByName(string.lower(TRP2_GetConfigValueFor("ChannelToUse","xtensionxtooltip2")));
			else -- Case of ReloadUI()
				TRP2_SePresenterSurLeChan();
			end
		end
		TRP2_MouseOverTooltip("mouseover");
		TRP2_UpdateRegistre();
	elseif(event=="PLAYER_TARGET_CHANGED") then
		local nom,royaume = UnitName("target");
		if royaume then
			nom = nom.."-"..royaume;
		end
		TRP2_TargetButton:Hide();
		TRP2_AuraTargetFrame:Hide();
		if nom and nom ~= UNKNOWN then -- Si on a une cible
			TRP2_PlacerIconeCible(nom);
			if not TRP2_EstDansLeReg(nom) and UnitIsPlayer("target") and nom~=TRP2_Joueur and UnitFactionGroup("target") == UnitFactionGroup("player") then
				TRP2_MSP_Request(nom); -- MSP compatibility
				TRP2_SecureSendAddonMessage("GTVN",TRP2_SendVernNum(),nom); -- Send VerNumTab avec request des VerNum adverses
			end
		end
		--TRP2_debug(UnitCreatureFamily("target"));
	elseif(event=="CHAT_MSG_CHANNEL") then
		--Spécifique au Module Registre
		if string.lower(arg9) == string.lower(TRP2_GetConfigValueFor("ChannelToUse","xtensionxtooltip2")) then
			desaoulage = string.gsub(arg1, "%.%.%.hips %!", "");
			TRP2_ReceiveMessageChannel(arg1,arg2);
		end
	elseif(event=="PLAYER_REGEN_DISABLED") then -- Marche uniquement quand aggro.
		if TRP2_GetConfigValueFor("CloseOnCombat",false) then
			TRP2MainFrame:Hide();
			TRP2_CreationFrame:Hide();
		end
	elseif(event=="COMBAT_LOG_EVENT") then -- Prise de dégats
		TRP2_GererDegats(...);
	elseif event=="WORLD_MAP_UPDATE" then
		if not TRP2_GetConfigValueFor("bDontUseCoord",false) and TRP2_GetWorldMap():IsVisible() and TRP2_GetWorldMap().TRP2_Zone ~= TRP2_GetCurrentMapZone() then
			wipe(TRP2_PlayersPosition);
		end
	end
end

function TRP2_GetWorldMap()
	if getglobal(TRP2_GetConfigValueFor("WorldMapToUse","WorldMapFrame")) then
		return getglobal(TRP2_GetConfigValueFor("WorldMapToUse","WorldMapFrame"));
	end
	return WorldMapFrame;
end

function TRP2_GossipFrame_OnEvent(self, event, ...)
	if ( event == "GOSSIP_SHOW" ) then
		if ( not GossipFrame:IsShown() ) then
			ShowUIPanel(self);
			if ( not self:IsShown() ) then
				CloseGossip();
				return;
			end
		end
		GossipFrameUpdate();
	elseif ( event == "GOSSIP_CLOSED" ) then
		HideUIPanel(self);
	end
end

function TRP2_test()
	TRP2_DebugScripterFrameScrollEditBox:SetText("");
	TRP2_DebugScripterFrameScrollEditBox:Insert("---- Continent 6 ----\n");
	for k,v in pairs({ GetMapZones(7)}) do
		TRP2_DebugScripterFrameScrollEditBox:Insert("[\""..v.."\"] = -- "..v.."\n");
	end
	
end

function TRP2_OnLoaded()
	-- Configuration load
	TRP2_Set_Module_Configuration();
	-- Locale detection
	if not TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] then
		if GetLocale() == "frFR" then
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 1;
		elseif GetLocale() == "esES" then
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 3;
		elseif GetLocale() == "deDE" then
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 4;
		elseif GetLocale() == "zhCN" then
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 5;
		else
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 2;
		end
	end

	-- Added by Ellypse, switch to Chinese font when language is Chinese
	if TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] == 5 then
		TRP2_font = 'ZYKai_T.TTF'
	end

	-- Saving variables load
	TRP2_Set_Module_PlayerInfos();
	TRP2_Set_Module_Registre();
	TRP2_Set_Module_Inventaire();
	TRP2_Set_Module_Quests();
	TRP2_Set_Module_Document();
	TRP2_Set_Module_Packages();
	-- Data base and guide
	TRP2_LoadDataBase();
	TRP2_LoadGuide();
	-- Localization
	TRP2_SetLocalisation();
	-- UI loading;
	TRP2_InitialisationUI();
	TRP2_Localisation_SetUI();
		        --Language Initialization
        TRP2_InitDialectList();
        TRP2_RefreshLangueListe();
	-- Welcoming message
	TRP2_Afficher(TRP2_LOC_ACCUEIL);
	-- Fichier export
	if not TRP2_Module_Interface["bHasWelcomed"] then
		TRP2_Module_Interface["bHasWelcomed"] = true;
		if TRP2_Guide_OpenPage then
			TRP2_Guide_OpenPage("Welcome");
		end
	end
	if TRP2_Module_Interface["bHasExport"] then
		TRP2_Module_Interface["bHasExport"] = nil;
		StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_EXPORTWIN);
		TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
	end
	if (select(4, GetBuildInfo())) < 60000 then
		StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE.."|cffff0000THIS VERSION REQUIRES PATCH 6.0.2 AND WON'T WORK CORRECTLY ON YOUR VERSION OF WORLD OF WARCRAFT|r");
		TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
	end
	-- MSP support
	TRP2_MSP_InitialLoad();
	-- Si tout s'est bien passé, on charge le onUpdate général
	TRP2_DebugSynchronizedFrame:Show();
	
	if TRP2_GetConfigValueFor("DebugMode",false) then
		UIParentLoadAddOn("Blizzard_DebugTools");
		TRP2_Afficher("TRP2 : Debug mode activated");
	end
end

function TRP2_LoadDataBase()
	local langue = TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"];
	--Auras
	if _G["TRP2_LoadDBAuras_"..langue] ~= nil then
		_G["TRP2_LoadDBAuras_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the states database. The addon won't work correctly.");
		return;
	end
	--Document
	if _G["TRP2_LoadDBDocuments_"..langue] ~= nil then
		_G["TRP2_LoadDBDocuments_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the documents database. The addon won't work correctly.");
		return;
	end
	--Items
	if _G["TRP2_LoadDBItems_"..langue] ~= nil then
		_G["TRP2_LoadDBItems_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the items database. The addon won't work correctly.");
		return;
	end
	--Quests
	if _G["TRP2_LoadDBQuests_"..langue] ~= nil then
		_G["TRP2_LoadDBQuests_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the quests database. The addon won't work correctly.");
		return;
	end
end

function TRP2_LoadGuide()
	local langue = TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"];
	if _G["TRP2_LoadGuide_"..langue] ~= nil then
		_G["TRP2_LoadGuide_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the guidebook. The addon won't work correctly.");
		return;
	end
end
