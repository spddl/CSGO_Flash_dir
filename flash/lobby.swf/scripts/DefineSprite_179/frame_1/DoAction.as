function Init()
{
   idx = 0;
   while(idx < NumPlayerButtons)
   {
      var _loc3_ = this["PlayerButton0" + idx];
      _loc3_ = _loc3_.Pbutton;
      if(_loc3_ != undefined)
      {
         _loc3_._visible = false;
         _loc3_.Selected._visible = false;
         _loc3_.dialog = this;
         _loc3_.onRollOver = function()
         {
            m_objRightClick = this;
         };
         _loc3_.onRollOut = function()
         {
            m_objRightClick = null;
         };
         _loc3_.Action = function()
         {
            this.dialog.OpenContextMenu(this);
         };
      }
      idx++;
   }
   PublicOption = kPublic;
   SetTextDisplayButton();
   UpdatePrimeStatusUi();
   ButtonPermissions.SetText("#SFUI_Change_Permissions");
   ButtonPermissions.dialog = this;
   ButtonPermissions.Action = function()
   {
      this.dialog.ChangePermissions();
   };
   _global.LobbyMovie.SetButtonLayout(this.ButtonPermissions,"unlocked");
   PrimeStatus.SetText("#SFUI_Lobby_PrimeStatus");
   PrimeStatus.dialog = this;
   PrimeStatus.Action = function()
   {
      this.dialog.UpdatePrimeSettings();
   };
   _global.LobbyMovie.SetButtonLayout(this.PrimeStatus,"verified");
   PrimeTooltip.Text.htmlText = "#SFUI_Elevated_Status_Not_Enrolled_Tooltip";
   PrimeTooltip.Text.autoSize = "left";
   PrimeTooltip.Bg._height = PrimeTooltip.Text._height + 20;
   PrimeTooltip.Bg._width = PrimeTooltip.Text._width + 20;
   PrimeTooltip.LeftArrow._y = PrimeTooltip.Bg._height - 5;
   PrimeTooltip._visible = false;
   PrimeTooltip._y = PrimeStatus._y - PrimeTooltip._height;
   ShowInventory.SetText("#SFUI_PauseMenu_OpenLoadout");
   ShowInventory.dialog = this;
   ShowInventory.Action = function()
   {
      this.dialog._global.LobbyMovie.ShowInventory();
   };
   _global.LobbyMovie.SetButtonLayout(this.ShowInventory,"inventory");
   MouseOverPanel.onRollOver = MouseOverPanel.onDragOver = function()
   {
      _global.LobbyMovie.onRolloverChange(_global.LobbyMovie.Panel_Lobby);
   };
   if(_global.IsPS3())
   {
      DisplayButtonText._visible = false;
      DisplayButtonTextStatus._visible = false;
   }
   _global.LobbyMovie.LobbyPanel.Panels.ClientPanel.Bg.onRollOver = function()
   {
   };
   _global.LobbyMovie.LobbyPanel.Panels.LobbyBg.onMouseDown = function()
   {
      onClickOutside(this);
   };
}
function SetTournament()
{
   var _loc3_ = _global.CScaleformComponent_MyPersona.GetMyOfficialTeamName();
   var strTournament = _global.CScaleformComponent_MyPersona.GetMyOfficialTournamentName();
   if(_loc3_ != "" && strTournament != "" && IsLobbyHost)
   {
      if(m_TournamentOpponentSelected == "")
      {
         TournamentSelect.PickOpponent.SetText("#SFUI_Tournament_Pick_Opponent");
         TournamentSelect.SetCtWarning._visible = true;
      }
      if(m_TournamentStage == "")
      {
         TournamentSelect.PickStage.SetText("#SFUI_Tournament_Stage");
         TournamentSelect.SetStageWarning._visible = true;
      }
      TournamentSelect.PickOpponent.Action = function()
      {
         SetupTeamSelectorPanel(this,strTournament);
      };
      TournamentSelect.PickOpponent._Type = "opponent";
      TournamentSelect.PickStage.Action = function()
      {
         SetupTeamSelectorPanel(this,strTournament);
      };
      TournamentSelect.PickStage._Type = "stage";
      TournamentSelect._visible = true;
      TournamentSelect.TeamSelecterPanel._visible = false;
      TournamentSelect.TeamSelecterPanel.ButtonNext.actionSound = "PageScroll";
      TournamentSelect.TeamSelecterPanel.ButtonNext.Action = function()
      {
         onScrollForward(TeamListerInfo,RefreshTeamSelectorLister);
      };
      TournamentSelect.TeamSelecterPanel.ButtonPrev.actionSound = "PageScroll";
      TournamentSelect.TeamSelecterPanel.ButtonPrev.Action = function()
      {
         onScrollBackward(TeamListerInfo,RefreshTeamSelectorLister);
      };
      GameSettingsText._visible = false;
   }
   else
   {
      TournamentSelect._visible = false;
   }
   UpdatePrimeStatusUi();
}
function SetupTeamSelectorPanel(objType, strTournament)
{
   TeamListerInfo._ListType = objType._Type;
   TeamListerInfo._TournamentName = strTournament;
   TournamentSelect.TeamSelecterPanel.Close.dialog = this;
   TournamentSelect.TeamSelecterPanel.Close.Action = function()
   {
      this.dialog.CloseTeamSelectorPanel();
   };
   TournamentSelect.TeamSelecterPanel.Bg.onRollOver = function()
   {
      trace("");
   };
   TournamentSelect.TeamSelecterPanel._visible = true;
   ScrollReset(TeamListerInfo);
   UpdatePageCount(TeamListerInfo);
   RefreshTeamSelectorLister();
}
function RefreshTeamSelectorLister()
{
   if(TeamListerInfo._ListType == "opponent")
   {
      TeamListerInfo._m_numItems = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamCount(TeamListerInfo._TournamentName);
      TournamentSelect.TeamSelecterPanel.Title.htmlText = "#SFUI_Tournament_Pick_Opponent";
   }
   else if(TeamListerInfo._ListType == "stage")
   {
      TeamListerInfo._m_numItems = _global.CScaleformComponent_CompetitiveMatch.GetTournamentStageCount(TeamListerInfo._TournamentName);
      TournamentSelect.TeamSelecterPanel.Title.htmlText = "#SFUI_Tournament_Stage";
   }
   var _loc2_ = 0;
   while(_loc2_ < TeamListerInfo._TotalTiles)
   {
      SetUpTeamButton(_loc2_,TeamListerInfo._m_numTopItemTile + _loc2_,TeamListerInfo._ListType);
      _loc2_ = _loc2_ + 1;
   }
   EnableDisableScrollButtons(TeamListerInfo);
   UpdatePageCount(TeamListerInfo);
}
function SetUpTeamButton(numTile, numItemIndex, strListType)
{
   var _loc3_ = TournamentSelect.TeamSelecterPanel.Lister["Team" + numTile];
   if(numItemIndex < 0 || numItemIndex > TeamListerInfo._m_numItems - 1)
   {
      _loc3_._visible = false;
      return undefined;
   }
   if(TeamListerInfo._ListType == "stage")
   {
      var _loc5_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentStageNameByIndex(TeamListerInfo._TournamentName,numItemIndex);
      var _loc7_ = _loc5_;
      if(_loc5_ == m_TournamentStage)
      {
         _loc3_.Selected._visible = true;
         m_TournamentSelection = _loc3_;
      }
      else
      {
         _loc3_.Selected._visible = false;
      }
      _loc3_.Logo._visible = false;
      _loc3_.ButtonText.Text._x = -19;
   }
   else if(TeamListerInfo._ListType == "opponent")
   {
      _loc5_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamNameByIndex(TeamListerInfo._TournamentName,numItemIndex);
      var _loc9_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamTagByIndex(TeamListerInfo._TournamentName,numItemIndex);
      _loc7_ = _loc5_;
      var _loc10_ = "econ/tournaments/teams/" + _loc9_ + ".png";
      var _loc8_ = new Object();
      _loc8_.onLoadInit = function(target_mc)
      {
         target_mc._width = 25;
         target_mc._height = 25;
      };
      var _loc6_ = new MovieClipLoader();
      _loc6_.addListener(_loc8_);
      _loc6_.loadClip(_loc10_,_loc3_.Logo.Image);
      if(_loc5_ == m_TournamentOpponentSelected)
      {
         _loc3_.Selected._visible = true;
         m_TournamentSelection = _loc3_;
      }
      else
      {
         _loc3_.Selected._visible = false;
      }
      _loc3_.Logo._visible = true;
      _loc3_.ButtonText.Text._x = 3.3;
   }
   _loc3_.dialog = this;
   _loc3_._visible = true;
   _loc3_._strDisplayName = _loc7_;
   _loc3_._strName = _loc5_;
   _loc3_.SetText(_loc7_);
   _loc3_.Action = function()
   {
      this.dialog.SelectItemFromLister(this,strListType);
   };
   _loc3_.ButtonText.Text.autoSize = "left";
}
function SelectItemFromLister(objItemTile, strListType)
{
   m_TournamentSelection.Selected._visible = false;
   m_TournamentSelection = objItemTile;
   m_TournamentSelection.Selected._visible = true;
   if(strListType == "opponent")
   {
      m_TournamentOpponentSelected = objItemTile._strName;
      TournamentSelect.PickOpponent.SetText(objItemTile._strDisplayName);
      TournamentSelect.SetCtWarning._visible = false;
   }
   if(strListType == "stage")
   {
      m_TournamentStage = objItemTile._strName;
      TournamentSelect.PickStage.SetText(objItemTile._strName);
      TournamentSelect.SetStageWarning._visible = false;
   }
}
function CloseTeamSelectorPanel()
{
   TournamentSelect.TeamSelecterPanel._visible = false;
}
function SetTextDisplayButton()
{
   AssignValueOfbisQueuedMatch();
   var _loc3_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("system/access");
   if(_loc3_ == "public")
   {
      _global.LobbyMovie.SetButtonLayout(this.ButtonPermissions,"unlocked");
   }
   else
   {
      _global.LobbyMovie.SetButtonLayout(this.ButtonPermissions,"lock");
   }
   _loc3_ = _global.GameInterface.Translate("#SFUI_Lobby_" + _loc3_);
   PermissionsText.Text.htmlText = _loc3_;
}
function GetActiveFriendXuid()
{
   return SelectedXuid;
}
function UpdateHostMatchSettings(bQuickmatch, CustomMode, CustomMapname, leaderXuid)
{
   var _loc12_ = _global.LobbyMovie.LobbyPanel.Panels.SearchInfoPanel;
   var _loc5_ = false;
   var _loc15_ = "";
   var _loc3_ = "";
   var _loc2_ = "";
   WarningIcon._visible = false;
   trace("bQuickmatch: " + bQuickmatch);
   trace("CustomMapname1: " + CustomMapname);
   if(bQuickmatch)
   {
      GameSettingsText.GameSettingsText.text = "#SFUI_Lobby_GameSettingsQuickmatch";
   }
   else
   {
      var _loc6_ = CustomMapname.indexOf("@");
      if(_loc6_ > 0)
      {
         _loc5_ = true;
         CustomMapname = CustomMapname.substr(_loc6_ + 1);
         var _loc8_ = _global.CScaleformComponent_UGC.GetMapNiceName(CustomMapname);
         _loc2_ = _loc8_;
         _loc3_ = CustomMode;
      }
      else if(CustomMapname == "reconnect")
      {
         _loc3_ = _global.GameInterface.Translate("#SFUI_Lobby_GameSettingsReconnectTitle");
         _loc2_ = "";
      }
      else
      {
         _loc5_ = false;
         var _loc7_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/mode");
         var _loc9_ = _global.CScaleformComponent_GameTypes.GetGameModeType(_loc7_);
         _loc3_ = _global.CScaleformComponent_GameTypes.GetGameModeAttribute(_loc9_,_loc7_,"nameID");
         _loc3_ = _global.GameInterface.Translate(_loc3_);
         _loc3_ = "<b>GameMode: </b>" + _loc3_;
         var _loc10_ = _global.LobbyMovie.GetValueOfAnyMode();
         if(_loc10_ == 1)
         {
            CustomMode = _global.GameInterface.Translate("#SFUI_GameModeAny");
         }
         _loc2_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/mapgroupname");
         _loc2_ = MakeSelectedMapsString(_loc2_);
         _loc2_ = "<b>Maps: </b>" + _loc2_;
      }
      trace("-------------------UpdateHostMatchSettings-----------------------" + _loc2_);
      GameSettingsText.GameSettingsTextMode.htmlText = _loc3_;
      GameSettingsText.GameSettingsTextMaps.htmlText = _loc2_;
      SetSearchPanelMapInfo(_loc3_,_loc2_);
   }
   var _loc11_ = _global.CScaleformComponent_MyPersona.GetXuid();
   if(_loc11_ == _global.CScaleformComponent_PartyList.GetPartySystemSetting("xuidHost"))
   {
      IsLobbyHost = true;
   }
   else
   {
      IsLobbyHost = false;
      OpenMap._visible = false;
   }
   if("cooperative" == _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/type"))
   {
      SettingsForCoop();
   }
   else
   {
      OpenMap._visible = false;
      CoopMissionPanel._visible = false;
   }
   SetTextDisplayButton();
   UpdatePrimeStatusUi();
   SetStartButtonText(_loc5_);
}
function SetSearchPanelMapInfo(strGameModeNiceName, strMapGroups)
{
   if(!_global.LobbyMovie.LobbyPanel.Panels.SearchInfoPanel._visible)
   {
      return undefined;
   }
   var _loc2_ = _global.LobbyMovie.LobbyPanel.Panels.SearchInfoPanel.GameSettingsText;
   var _loc7_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/mapgroupname");
   var _loc6_ = _loc7_.split(",");
   var _loc4_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(_loc6_[0],"imagename");
   var _loc3_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/questid");
   var _loc8_ = _global.CScaleformComponent_MyPersona.GetXuid();
   trace("----------------------SetSearchPanelMapInfo-----strFirstMapInSelection-------------------------" + _loc7_);
   trace("----------------------SetSearchPanelMapInfo-----aTemp-------------------------" + _loc6_[0]);
   trace("----------------------SetSearchPanelMapInfo-----mapNameIcon-------------------------" + _loc4_);
   trace("----------------------SetSearchPanelMapInfo-----strServerQuestId-------------------------" + _loc3_);
   if(_loc3_ != 0 && _loc3_ != null && _loc3_ != undefined && _loc3_ != "")
   {
      var _loc9_ = _global.CScaleformComponent_Inventory.GetCampaignFromQuestID(Number(_loc3_));
      var _loc11_ = _global.CScaleformComponent_Inventory.GetCampaignNodeFromQuestID(Number(_loc3_));
      var _loc5_ = _global.CScaleformComponent_Inventory.GetAQuestItemIDGivenCampaignNodeID(_loc11_,_loc9_);
      var _loc10_ = _global.CScaleformComponent_Inventory.GetItemDescription(_loc8_,_loc5_,"default,-detailedinfo");
      var _loc12_ = _global.CScaleformComponent_Inventory.GetItemDescription(_loc8_,_loc5_,"detailedinfo");
      _loc2_.GameSettingsTextMaps.htmlText = _loc10_;
   }
   else
   {
      _loc2_.GameSettingsTextMaps.htmlText = strMapGroups;
   }
   _loc2_.GameSettingsTextMode.htmlText = strGameModeNiceName;
   _loc2_.MapThumbnail.Icon.unloadMovie();
   _loc2_.MapThumbnail.DefaultIcon._visible = false;
   _loc2_.MapThumbnail.attachMovie(_loc4_,"Icon",_loc2_.MapThumbnail.getNextHighestDepth());
}
function SettingsForCoop()
{
   var PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc3_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/questid");
   var _loc6_ = DoesPlayerOwnOperation();
   if(_loc3_ != 0 && _loc3_ != null && _loc3_ != undefined && _loc3_ != "")
   {
      var _loc4_ = _global.CScaleformComponent_Inventory.GetCampaignFromQuestID(Number(_loc3_));
      var _loc7_ = _global.CScaleformComponent_Inventory.GetCampaignNodeFromQuestID(Number(_loc3_));
      var _loc5_ = _global.CScaleformComponent_Inventory.GetAQuestItemIDGivenCampaignNodeID(_loc7_,_loc4_);
      var _loc9_ = _global.CScaleformComponent_Inventory.GetItemDescription(PlayerXuid,_loc5_,"default");
      var _loc8_ = _global.CScaleformComponent_Inventory.GetQuestGameMode(PlayerXuid,_loc5_);
      var _loc10_ = _global.CScaleformComponent_Inventory.GetCampaignNodeState(_loc7_,_loc4_);
      trace("-------------------------strServerQuestId--------------------" + _loc3_);
      ButtonPermissions.setDisabled(true);
      SetMissionState(_loc10_,_loc9_,_loc6_,_loc8_);
   }
   if(IsLobbyHost && _loc6_)
   {
      var ItemId = _global.CScaleformComponent_Inventory.GetActiveSeasonCoinItemId(PlayerXuid);
      OpenMap.SetText("#SFUI_InvContextMenu_Campaign_Map");
      OpenMap.dialog = this;
      OpenMap.Action = function()
      {
         this.dialog.OpenJournal(ItemId,2,true,PlayerXuid);
      };
      _global.LobbyMovie.SetButtonLayout(this.OpenMap,"journal");
      OpenMap._visible = true;
   }
}
function SetMissionState(strStatus, MissionDesc, bDoesOwnOperation, GameMode)
{
   var _loc4_ = "";
   CoopMissionPanel.Text.cooperative._visible = false;
   CoopMissionPanel.Text.coopmission._visible = false;
   CoopMissionPanel.Text._y = 0;
   CoopMissionPanel.btnMissionChange._visible = false;
   CoopMissionPanel.Spinner._visible = false;
   CoopMissionPanel._visible = true;
   if(bDoesOwnOperation)
   {
      if(strStatus == "complete")
      {
         CoopMissionPanel.Text._y = 10;
      }
      else if(strStatus == "accessible")
      {
         var _loc5_ = _global.CScaleformComponent_Inventory.GetMissionBacklog();
         if(_loc5_ <= 0 && GetActiveMission() == 0)
         {
            strStatus = "out_of_missions";
            CoopMissionPanel.Text._y = 10;
         }
         else
         {
            CoopMissionPanel.btnMissionChange.SetText("#SFUI_Activate_Server_Mission");
            CoopMissionPanel.btnMissionChange.dialog = this;
            CoopMissionPanel.btnMissionChange.Action = function()
            {
               this.dialog.RequestMission();
            };
            _global.LobbyMovie.SetButtonLayout(this.CoopMissionPanel.btnMissionChange,"refresh");
            CoopMissionPanel.btnMissionChange.setDisabled(false);
            CoopMissionPanel.btnMissionChange._visible = true;
         }
      }
      else if(strStatus == "locked")
      {
         CoopMissionPanel.Text._y = 10;
      }
      else if(strStatus == "active")
      {
         CoopMissionPanel.Text._y = 20;
      }
   }
   else
   {
      strStatus = "does_not_own";
      CoopMissionPanel.Text._y = 10;
   }
   if(strStatus == "active")
   {
      _loc4_ = "";
   }
   else
   {
      _loc4_ = _global.GameInterface.Translate("#SFUI_Lobby_Mission_" + strStatus);
   }
   CoopMissionPanel.Text.Desc.htmlText = MissionDesc;
   CoopMissionPanel.Text.Hint.htmlText = _loc4_;
   _global.AutosizeTextDown(CoopMissionPanel.Text.Desc,8);
   _global.AutosizeTextDown(CoopMissionPanel.Text.Hint,7);
   CoopMissionPanel.Text[GameMode]._visible = true;
}
function GetActiveMission()
{
   var _loc3_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc4_ = _global.CScaleformComponent_Inventory.GetActiveSeasonCoinItemId(_loc3_);
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(_loc3_,_loc4_,"quest id");
   if(_loc2_ != 0 && _loc2_ != undefined && _loc2_ != null)
   {
      return _loc2_;
   }
   return 0;
}
function RequestMission(CampaignID, NodeID)
{
   var numCount = 0;
   var _loc3_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/questid");
   NodeID = _global.CScaleformComponent_Inventory.GetCampaignFromQuestID(Number(_loc3_));
   CampaignID = _global.CScaleformComponent_Inventory.GetCampaignNodeFromQuestID(Number(_loc3_));
   _global.CScaleformComponent_Inventory.RequestNewMission(CampaignID,NodeID);
   CoopMissionPanel.btnMissionChange.setDisabled(true);
   CoopMissionPanel.Spinner._visible = true;
   CoopMissionPanel.Spinner.Loading.htmlText = "#CSGO_Journal_Get_Mission_Lobby";
   CoopMissionPanel.onEnterFrame = function()
   {
      numCount++;
      if(numCount == 60 || numCount == 90 || numCount == 120)
      {
         var _loc2_ = GetActiveMission();
         var _loc4_ = _global.CScaleformComponent_Inventory.GetCampaignFromQuestID(_loc2_);
         var _loc3_ = _global.CScaleformComponent_Inventory.GetCampaignNodeFromQuestID(_loc2_);
         if(_global.CScaleformComponent_Inventory.DoesUserOwnQuest(_loc3_,_loc4_))
         {
            SettingsForCoop();
            delete CoopMissionPanel.onEnterFrame;
         }
      }
      if(numCount == 121)
      {
         CoopMissionPanel.Spinner.Loading.htmlText = "#CSGO_Journal_Get_Mission_Failed";
      }
      if(numCount == 210)
      {
         SettingsForCoop();
         delete CoopMissionPanel.onEnterFrame;
      }
   };
}
function DoesPlayerOwnOperation()
{
   var _loc2_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
   if(_loc2_ == -1)
   {
      return false;
   }
   var _loc3_ = _global.CScaleformComponent_MyPersona.GetMyMedalRankByType(_loc2_ + 1 + "Operation$OperationCoin");
   if(_loc3_ >= 2)
   {
      return true;
   }
   return false;
}
function OpenJournal(ItemID, Page, bOpenToPage, PlayerXuid)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(PlayerXuid,ItemID,"season access");
   _global.MainMenuMovie.Panel.JournalPanel._visible = true;
   _global.MainMenuMovie.Panel.JournalPanel.Journal.ShowPanel(Page,ItemID,_loc2_,bOpenToPage);
}
function MakeSelectedMapsString(strMapGroups)
{
   var _loc4_ = strMapGroups.split(",");
   var _loc2_ = 0;
   while(_loc2_ < _loc4_.length)
   {
      var _loc3_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(_loc4_[_loc2_],"nameID");
      _loc3_ = _global.GameInterface.Translate(_loc3_);
      _loc4_.splice(_loc2_,1,_loc3_);
      _loc2_ = _loc2_ + 1;
   }
   strMapGroups = _loc4_.join(", ");
   return strMapGroups;
}
function GetWorkshopMapNiceName(MapName)
{
   var _loc6_ = _global.LobbyMovie.LobbyPanel.Panels.ClientPanel;
   var _loc4_ = "";
   MapName = MapName.substr(index + 1);
   _loc4_ = _global.CScaleformComponent_UGC.GetMapNiceName(MapName);
   if(_loc4_ == "")
   {
      var _loc5_ = MapName.indexOf("/");
      var _loc2_ = MapName.substr(_loc5_ + 1);
      _loc5_ = _loc2_.indexOf("/");
      _loc2_ = _loc2_.substr(_loc5_ + 1);
      return _loc2_;
   }
   return _loc4_;
}
function GetCurrentPremissionsSettingNiceString(strMapMode)
{
   var _loc3_ = _global.CScaleformComponent_GameTypes.GetGameModeType(strMapMode);
   var _loc2_ = _global.CScaleformComponent_GameTypes.GetGameModeAttribute(_loc3_,strMapMode,"nameID");
   return _global.GameInterface.Translate(_loc2_);
}
function UpdateClientMatchSettings(strMode, strMapgroupname, AnyMode)
{
   var _loc2_ = _global.LobbyMovie.LobbyPanel.Panels.ClientPanel;
   UpdateHostMatchSettings(false,strMode,strMapgroupname);
   trace("-------------------AnyMode-------------------------------" + AnyMode);
   var _loc4_ = strMapgroupname.indexOf("@");
   if(_loc4_ > 0)
   {
      trace("-------------------strMode-------------------------------" + strMode);
      bIsWorkshopMap = true;
      _loc2_.MapName.text = GetWorkshopMapNiceName(strMapgroupname);
      _loc2_.MapThumbnail.Icon.unloadMovie();
      _loc2_.MapThumbnail.DefaultIcon._visible = true;
   }
   else
   {
      trace("-------------------UpdateClientMatchSettings-----------------------" + strMapgroupname);
      bIsWorkshopMap = false;
      var _loc7_ = strMapgroupname.split(",");
      var _loc6_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(_loc7_[0],"imagename");
      strMapgroupname = MakeSelectedMapsString(strMapgroupname);
      _loc2_.MapName.text = strMapgroupname;
      trace("-------------------UpdateClientMatchSettings-----------------------" + strMapgroupname);
      _loc2_.MapThumbnail.Icon.unloadMovie();
      _loc2_.MapThumbnail.DefaultIcon._visible = false;
      _loc2_.MapThumbnail.attachMovie(_loc6_,"Icon",_loc2_.MapThumbnail.getNextHighestDepth());
   }
   var _loc8_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/mode");
   if(AnyMode == 0)
   {
      _loc2_.GameModeName.text = GetCurrentPremissionsSettingNiceString(_loc8_);
   }
   else if(AnyMode == 1)
   {
      HostMode = _global.GameInterface.Translate("#SFUI_GameModeAny");
   }
}
function SetWorkshopMapImage(ImagePath)
{
   var _loc1_ = new Object();
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("---------->Error loading image: " + errorCode + " [" + status + "]");
   };
   _loc1_.onLoadStart = function(target_mc)
   {
   };
   _loc1_.onLoadProgress = function(target_mc, numBytesLoaded, numBytesTotal)
   {
      var _loc1_ = numBytesLoaded / numBytesTotal * 100;
   };
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = 196;
      target_mc._height = 109;
   };
   var _loc3_ = "../../" + ImagePath;
   if(ClientPanel.MapThumbnail != undefined)
   {
      ClientPanel.MapThumbnail.unloadMovie();
   }
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc3_,ClientPanel.MapThumbnail);
   MapButton.MapWorkshopImage._visible = true;
}
function SetStartButtonText(bIsWorkshopMap)
{
   if(bIsWorkshopMap && PublicOption == 0)
   {
      StartMatchButton.SetText("#SFUI_Start_ListenServer_Workshop_Map");
   }
   else if(bIsWorkshopMap && PublicOption == 3)
   {
      StartMatchButton.SetText("#SFUI_Start_ListenServer_Workshop_Map");
   }
   else
   {
      StartMatchButton.SetText("#SFUI_Lobby_StartMatchButton");
   }
}
function UpdateClientText(strHostMode)
{
   var _loc3_ = _global.LobbyMovie.LobbyPanel.Panels.ClientPanel;
   var _loc2_ = CScaleformComponent_PartyList.GetPartySessionSetting("system/access");
   _loc2_ = _global.GameInterface.Translate("#SFUI_Lobby_" + _loc2_);
   _loc3_.VisibilitySetting.htmlText = _loc2_;
}
function UpdateLobbyHost(leaderName, leaderXuid)
{
   LobbyLeaderName = leaderName;
   LobbyLeaderXuid = leaderXuid;
   var _loc2_ = _global.GameInterface.Translate("#SFUI_LOBBYLEADER");
   _loc2_ = _global.ConstructString(_loc2_,leaderName);
   LobbyLeaderText.LobbyLeaderText.text = _loc2_;
}
function InitLobby(leaderName, leaderXuid, isHost)
{
   UpdateActivePlayers(1);
   LobbyLeaderXuid = leaderXuid;
   IsLobbyHost = isHost;
   PublicOptionToggle._visible = isHost;
   PublicOptionShortcut._visible = isHost;
   InviteLIVEPartyShortcut._visible = bIsXbox;
   var _loc3_ = _global.LobbyMovie.LobbyPanel.Panels.LobbySideText.LobbyText;
   if(isHost)
   {
      _loc3_.text = _global.GameInterface.Translate("#SFUI_BYT_TITLE");
   }
   else
   {
      _loc3_.text = _global.GameInterface.Translate("#SFUI_BYT_TITLECLIENT");
   }
}
function ChangePermissions()
{
   if(PublicOption == kPublic)
   {
      PublicOption = PublicOption + 3;
   }
   else
   {
      PublicOption = PublicOption - 3;
   }
   SetTextDisplayButton();
   UpdateLobbyPrefs();
}
function UpdatePrimeStatusUi()
{
   ShowHidePrimeStatus();
   if(!m_bisQueued || TournamentSelect._visible)
   {
      return undefined;
   }
   var _loc3_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/prime");
   var _loc2_ = AreLobbyPlayersPrime();
   if(!_loc2_)
   {
      PrimeText.Text.htmlText = "#SFUI_Lobby_Has_NonPrime_Player";
   }
   else if(_loc3_ == 1)
   {
      PrimeText.Text.htmlText = "#SFUI_Lobby_Prime_Active";
   }
   else
   {
      PrimeText.Text.htmlText = "#SFUI_Lobby_Prime_InActive";
   }
   EnableDisablePrimeStatusButton(_loc2_);
}
function ShowHidePrimeStatus()
{
   PrimeText._visible = m_bisQueued && !TournamentSelect._visible;
   PrimeStatus._visible = m_bisQueued && !TournamentSelect._visible;
}
function EnableDisablePrimeStatusButton(bAreLobbyPlayersPrime)
{
   if(!IsLobbyHost || !bAreLobbyPlayersPrime || _global.LobbyMovie.bshowQueuedStatus)
   {
      PrimeStatus.setDisabled(true);
      if(!bAreLobbyPlayersPrime)
      {
         var _loc2_ = _global.CScaleformComponent_PartyList.GetFriendPrimeEligible(_global.CScaleformComponent_MyPersona.GetXuid());
         if(!_loc2_)
         {
            PrimeStatus.onRollOver = function()
            {
               ShowHidePrimeTooltip(true);
            };
            PrimeStatus.onRollOut = function()
            {
               ShowHidePrimeTooltip(false);
            };
         }
         else
         {
            PrimeStatus.onRollOver = function()
            {
            };
            PrimeStatus.onRollOut = function()
            {
            };
         }
      }
   }
   else
   {
      PrimeStatus.setDisabled(false);
   }
}
function ShowHidePrimeTooltip(bShow)
{
   PrimeTooltip._visible = bShow;
}
function AreLobbyPlayersPrime()
{
   var _loc7_ = _global.CScaleformComponent_PartyList.GetCount();
   var _loc3_ = 0;
   while(_loc3_ < _loc7_)
   {
      var _loc6_ = this["PlayerButton0" + _loc3_];
      var _loc5_ = _global.CScaleformComponent_PartyList.GetXuidByIndex(_loc3_);
      var _loc4_ = _global.CScaleformComponent_PartyList.GetFriendPrimeEligible(_loc5_);
      if(_loc4_ == false)
      {
         return false;
      }
      _loc3_ = _loc3_ + 1;
   }
   return true;
}
function UpdatePrimeSettings()
{
   var _loc2_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/prime") != 0?0:1;
   _global.CScaleformComponent_PartyList.UpdateSessionSettings("update { Game { prime " + _loc2_ + " }  }");
}
function FriendsListUp()
{
   UnselectPlayer();
   var _loc2_ = ActiveButton;
   do
   {
      if(ActiveButton > 0)
      {
         ActiveButton--;
      }
      else
      {
         ActiveButton = NumButtons - 1;
      }
   }
   while((!ButtonList[ActiveButton]._visible || ButtonList[ActiveButton]._xuid == "0") && ActiveButton != _loc2_);
   
   if(ButtonList[ActiveButton]._visible)
   {
      _global.navManager.SetHighlightedObject(ButtonList[ActiveButton]);
   }
   SelectedButton = ButtonList[ActiveButton];
   SelectedXuid = SelectedButton._xuid;
   onSelectedPlayer(ButtonList[ActiveButton]);
}
function FriendsListDown()
{
   UnselectPlayer();
   var _loc2_ = ActiveButton;
   do
   {
      if(ActiveButton < NumButtons - 1)
      {
         ActiveButton++;
      }
      else
      {
         ActiveButton = 0;
      }
   }
   while((!ButtonList[ActiveButton]._visible || ButtonList[ActiveButton]._xuid == "0") && ActiveButton != _loc2_);
   
   if(ButtonList[ActiveButton]._visible)
   {
      _global.navManager.SetHighlightedObject(ButtonList[ActiveButton]);
   }
   SelectedButton = ButtonList[ActiveButton];
   SelectedXuid = SelectedButton._xuid;
   onSelectedPlayer(ButtonList[ActiveButton]);
}
function StartMatch()
{
}
function UpdateLobbyPrefs()
{
   _global.LobbyAPI.UpdateLobbyModeAndPrefs(LobbyType,PublicOption);
}
function UpdateActivePlayers(NumPlayers)
{
   NumActivePlayers = NumPlayers;
}
function UnselectPlayer()
{
   if(SelectedButton != undefined)
   {
      hightlight = SelectedButton._parent;
      hightlight.Pbutton.Selected._visible = false;
      SelectedButton.Selected._visible = false;
      SelectedButton = undefined;
      SelectedXuid = undefined;
   }
}
function onSelectedPlayer(button)
{
   if(button._xuid == "0")
   {
      return undefined;
   }
   UnselectPlayer();
   SelectedButton = button;
   SelectedXuid = button._xuid;
   if(_global.CScaleformComponent_MyPersona.GetXuid() != button._xuid)
   {
      OpenContextMenu(button);
   }
}
function OpenContextMenu(objTargetTile)
{
   var _loc7_ = _global.MainMenuMovie.Panel.TooltipContextMenu;
   var _loc11_ = {x:objTargetTile._x + objTargetTile._width,y:objTargetTile._y};
   var _loc8_ = _global.CScaleformComponent_FriendsList.IsFriendPlayingCSGO(objTargetTile._xuid);
   var _loc4_ = [];
   var _loc5_ = [];
   if(objTargetTile != null && objTargetTile != undefined)
   {
      var _loc6_ = false;
      if(objTargetTile._xuid == _global.CScaleformComponent_MyPersona.GetXuid())
      {
         _loc6_ = true;
      }
      if(_loc6_)
      {
         _loc5_.push("#SFUI_BuyMenu_Inventory");
         _loc4_.push("Inventory");
         if(m_bisQueued)
         {
            _loc5_.push("#SFUI_Lobby_ChangeTeammateColor");
            _loc4_.push("ChangeColor");
         }
      }
      if(_loc8_ && !_loc6_)
      {
         _loc5_.push("#SFUI_Lobby_ShowCSGOProfile");
         _loc4_.push("ShowCSGOProfile");
      }
      else if(!_loc6_)
      {
         _loc5_.push("#SFUI_Lobby_ShowGamercard");
         _loc4_.push("ShowGamercard");
      }
      if(!_loc6_)
      {
         _loc5_.push("#SFUI_Steam_Message");
         _loc4_.push("SteamMessage");
      }
      if(IsLobbyHost)
      {
         if(objTargetTile._xuid != undefined && objTargetTile._xuid != "0" && objTargetTile._xuid != LobbyLeaderXuid)
         {
            _loc5_.push("#SFUI_LobbyKick_Title");
            _loc4_.push("Kick");
         }
      }
   }
   _loc7_.TooltipShowHide(objTargetTile);
   _loc7_.TooltipLayout(_loc4_,_loc5_,objTargetTile,this.AssignContextMenuAction);
}
function AssignContextMenuAction(strMenuItem, objTargetTile)
{
   switch(strMenuItem)
   {
      case "Inventory":
         _global.LobbyMovie.ShowInventory();
         break;
      case "ShowGamercard":
         onShowGamercard(objTargetTile._xuid);
         break;
      case "ChangeColor":
         onChangeTeammateColor(objTargetTile);
         break;
      case "ShowCSGOProfile":
         onShowCSGOProfile(objTargetTile._xuid);
         break;
      case "SteamMessage":
         onSteamChat(objTargetTile._xuid);
         break;
      case "Kick":
         onKick(objTargetTile._xuid);
   }
}
function onShowGamercard(Xuid)
{
   _global.CScaleformComponent_FriendsList.ShowUserProfilePage(Xuid);
}
function onShowCSGOProfile(Xuid)
{
   _global.CScaleformComponent_FriendsList.ActionShowCSGOProfile(Xuid);
}
function onSteamChat(Xuid)
{
   _global.CScaleformComponent_SteamOverlay.StartChatWithUser(Xuid);
}
function onKick(Xuid)
{
   if(Xuid == undefined || Xuid == "0" || Xuid == LobbyLeaderXuid)
   {
      return undefined;
   }
   if(_global.LobbyAPI.ConfirmKick(Xuid))
   {
      _global.LobbyMovie.bModalPrompt = true;
   }
}
function onChangeTeammateColor(button)
{
   _global.LobbyAPI.ChangeTeammateColor();
   RefreshAvatarImage(button);
}
function HideLobbyListAt(index)
{
   idx = index;
   while(idx < NumPlayerButtons)
   {
      var _loc3_ = this["PlayerButton0" + idx];
      _loc3_ = _loc3_.Pbutton;
      if(SelectedButton == _loc3_ || ActiveButton == index)
      {
         UnselectPlayer();
         ActiveButton = Math.max(0,index - 1);
         if(ButtonList[ActiveButton]._visible)
         {
            _global.navManager.SetHighlightedObject(ButtonList[ActiveButton]);
         }
      }
      if(_loc3_ != undefined)
      {
         playerButtonParent = _loc3_._parent;
         _loc3_._visible = false;
         if(_loc3_._xuid != undefined)
         {
            _loc3_._xuid = undefined;
         }
      }
      idx++;
   }
}
function UpdateTeamName(bShowTeamName, strTeamName)
{
   SteamGroupTitle._visible = bShowTeamName;
   Title._visible = !bShowTeamName;
}
function UpdateLobbyPlayer(index, xuid, playerName, bSpeaking, bVacBanned, numRank, numWins, iTeamColor)
{
   numRank = _global.CScaleformComponent_PartyList.GetFriendCompetitiveRank(xuid);
   var _loc7_ = _global.CScaleformComponent_PartyList.GetFriendPrimeEligible(xuid);
   if(xuid != "0")
   {
      UpdateActivePlayers(index + 1);
   }
   var _loc3_ = this["PlayerButton0" + index];
   _loc3_ = _loc3_.Pbutton;
   if(_loc3_ == SelectedButton && xuid != SelectedXuid)
   {
      UnselectPlayer();
   }
   _loc3_.iTeamColor = -1;
   if(xuid == "0")
   {
      _loc3_.SoundIcon._visible = false;
      _loc3_.eloBracket._visible = false;
      _loc3_._xuid = "0";
      if(NumActivePlayers > 4)
      {
         _loc3_._visible = false;
      }
      else
      {
         _loc3_._visible = true;
      }
      _loc3_.setDisabled(true);
      SetPlayerData(_loc3_);
   }
   else
   {
      _loc3_._visible = true;
      _loc3_.setDisabled(false);
      _loc3_._xuid = xuid;
      _loc3_._bIsPrime = _loc7_;
      if(m_bisQueued)
      {
         _loc3_.iTeamColor = iTeamColor;
      }
      if(numRank == 0)
      {
         _loc3_.eloBracket._visible = false;
      }
      else
      {
         _loc3_.eloBracket._visible = true;
         var _loc5_ = _loc3_.eloBracket;
         _loc5_._visible = true;
         _loc3_.eloBracket;
         if(_loc5_ && _loc5_.Image != undefined)
         {
            delete register5.Image;
         }
         var _loc10_ = "econ/status_icons/skillgroup" + numRank + ".png";
         var _loc8_ = new Object();
         _loc8_.onLoadInit = function(target_mc)
         {
            target_mc._width = 60;
            target_mc._height = 24;
            target_mc.forceSmoothing = true;
         };
         var _loc6_ = new MovieClipLoader();
         _loc6_.addListener(_loc8_);
         _loc6_.loadClip(_loc10_,_loc5_);
      }
      if(!_loc7_ || !m_bisQueued)
      {
         _loc5_ = _loc3_.PrimeIcon;
         _loc5_._visible = false;
      }
      else
      {
         _loc5_ = _loc3_.PrimeIcon;
         _loc5_._visible = true;
         _loc5_._alpha = 20;
         _loc10_ = "images/ui_icons/verified.png";
         _loc8_ = new Object();
         _loc8_.onLoadInit = function(target_mc)
         {
            target_mc._width = 71;
            target_mc._height = 71;
            target_mc.forceSmoothing = true;
         };
         _loc6_ = new MovieClipLoader();
         _loc6_.addListener(_loc8_);
         _loc6_.loadClip(_loc10_,_loc5_);
      }
      SetPlayerData(_loc3_);
      if(bSpeaking)
      {
         _loc3_.SoundIcon._visible = true;
         _loc3_.SoundIcon.gotoAndPlay("StartShow1");
      }
      else
      {
         _loc3_.SoundIcon._visible = false;
         _loc3_.SoundIcon.gotoAndStop("Off");
      }
   }
   AssignValueOfbisQueuedMatch();
   _global.LobbyMovie.LobbyPanel.Panels.FocusMovie.focus_tenplayer._visible = !bisQueued;
   _global.LobbyMovie.LobbyPanel.Panels.FocusMovie.focus_fiveplayer._visible = bisQueued;
}
function ScaleformComponent_PartyList_RebuildPartyList()
{
   UpdatePrimeStatusUi();
}
function SetPlayerData(playerButton)
{
   var _loc6_ = playerButton.PlayerText;
   var _loc4_ = playerButton._xuid;
   var _loc2_ = _global.CScaleformComponent_FriendsList.GetFriendName(_loc4_);
   var _loc3_ = _global.CScaleformComponent_FriendsList.GetFriendClanTag(_loc4_);
   if(_loc3_ != "" && _loc3_ != undefined)
   {
      _loc2_ = "<font color=\'#84AAC2\'>" + _loc3_ + "</font>" + " " + _loc2_;
   }
   _loc6_.SetText(_loc2_);
   RefreshAvatarImage(playerButton);
}
function RefreshAvatarImage(playerButton)
{
   var _loc4_ = playerButton._xuid;
   _global.LobbyAPI.EnsureAvatarCached(_loc4_);
   var _loc3_ = false;
   if(playerButton.iTeamColor >= 0 && m_bisQueued)
   {
      _loc3_ = true;
   }
   playerButton.LobbyAvatar.SetShouldShowPlayerColor(_loc3_,playerButton.iTeamColor);
   playerButton.LobbyAvatar._visible = true;
   playerButton.LobbyAvatar.ShowAvatar(3,_loc4_,true,false);
}
function AssignValueOfbisQueuedMatch()
{
   var _loc2_ = _global.LobbyMovie;
   m_bisQueued = _loc2_.GetValueOfbisQueuedMatch();
}
function Activated()
{
   _global.LobbyMovie.LobbyPanel.Panels.FocusMovie.focus_fiveplayer._visible = false;
   _global.LobbyMovie.LobbyPanel.Panels.FocusMovie.focus_tenplayer._visible = false;
   _global.LobbyMovie.LobbyPanel.Panels.FocusMovie.LeftFade._visible = bConsoleVersion;
   _global.LobbyMovie.LobbyPanel.Panels.FocusMovie.LeftFadePC._visible = !bConsoleVersion;
   _global.LobbyMovie.LobbyPanel.Panels.FocusMovie.gotoAndPlay("FocusLeftFade");
   lobbyNav.SetInitialHighlight(ButtonList[ActiveButton]);
   SelectedButton = ButtonList[ActiveButton];
   SelectedXuid = SelectedButton._xuid;
   bPanelActive = true;
}
function Deactivated()
{
   AssignValueOfbisQueuedMatch();
   _global.LobbyMovie.LobbyPanel.Panels.FocusMovie.focus_tenplayer._visible = !bisQueued;
   _global.LobbyMovie.LobbyPanel.Panels.FocusMovie.focus_fiveplayer._visible = bisQueued;
   _global.LobbyMovie.LobbyPanel.Panels.FocusMovie.gotoAndPlay("FocusRightFade");
   UnselectPlayer();
   MouseOverPanel._visible = true;
   bPanelActive = false;
}
function StartMatchOptionActive(bisQueuedMatch)
{
   if(IsLobbyHost)
   {
      if(m_bisQueued)
      {
         if(NumActivePlayers <= 5)
         {
            return true;
         }
      }
   }
   return true;
}
function onLoadInit(movieClip)
{
   movieClip._x = avatarX;
   movieClip._y = avatarY;
   movieClip._width = avatarWidth;
   movieClip._height = avatarHeight;
}
function onScrollForward(objPanelInfo, RefreshTiles)
{
   if(objPanelInfo._m_numTopItemTile + objPanelInfo._SelectableTiles < objPanelInfo._m_numItems)
   {
      ScrollNext(objPanelInfo,RefreshTiles);
      objPanelInfo._NextButton.setDisabled(true);
   }
}
function onScrollBackward(objPanelInfo, RefreshTiles)
{
   if(objPanelInfo._m_numTopItemTile != 0)
   {
      ScrollPrev(objPanelInfo,RefreshTiles);
      objPanelInfo._PrevButton.setDisabled(true);
   }
}
function ScrollNext(objPanelInfo, RefreshTiles)
{
   var LoopCount = 0;
   var mcMovie = objPanelInfo._AnimObject;
   var SpeedOut = 0.6;
   var _loc1_ = 1;
   mcMovie.onEnterFrame = function()
   {
      if(LoopCount < 1)
      {
         mcMovie._x = mcMovie._x + (objPanelInfo._EndPos - 1 - mcMovie._x) * SpeedOut;
      }
      if(mcMovie._x < objPanelInfo._EndPos)
      {
         LoopCount++;
         mcMovie._x = objPanelInfo._StartPos;
         objPanelInfo._m_numTopItemTile = objPanelInfo._m_numTopItemTile + objPanelInfo._SelectableTiles;
         RefreshTiles();
         EnableDisableScrollButtons(objPanelInfo);
         UpdatePageCount(objPanelInfo);
         delete mcMovie.onEnterFrame;
      }
   };
}
function ScrollPrev(objPanelInfo, RefreshTiles)
{
   var LoopCount = 0;
   var mcMovie = objPanelInfo._AnimObject;
   var SpeedOut = 0.6;
   var _loc1_ = 1;
   mcMovie._x = objPanelInfo._EndPos;
   objPanelInfo._m_numTopItemTile = objPanelInfo._m_numTopItemTile - objPanelInfo._SelectableTiles;
   RefreshTiles();
   mcMovie.onEnterFrame = function()
   {
      if(LoopCount < 1)
      {
         mcMovie._x = mcMovie._x + (objPanelInfo._StartPos + 1 - mcMovie._x) * SpeedOut;
      }
      if(mcMovie._x > objPanelInfo._StartPos)
      {
         LoopCount++;
         mcMovie._x = objPanelInfo._StartPos;
         EnableDisableScrollButtons(objPanelInfo);
         UpdatePageCount(objPanelInfo);
         delete mcMovie.onEnterFrame;
      }
   };
}
function ScrollReset(objPanelInfo)
{
   if(GetCurrentPageNumber(objPanelInfo._m_numTopItemTile,objPanelInfo._SelectableTiles) > 1)
   {
      objPanelInfo._m_numTopItemTile = objPanelInfo._SelectableTiles;
      ScrollPrev(objPanelInfo);
   }
}
function EnableDisableScrollButtons(objPanelInfo)
{
   if(objPanelInfo._m_numTopItemTile != 0)
   {
      objPanelInfo._PrevButton.setDisabled(false);
   }
   else
   {
      objPanelInfo._PrevButton.setDisabled(true);
   }
   if(objPanelInfo._m_numTopItemTile + objPanelInfo._SelectableTiles < objPanelInfo._m_numItems)
   {
      objPanelInfo._NextButton.setDisabled(false);
   }
   else
   {
      objPanelInfo._NextButton.setDisabled(true);
   }
}
function UpdatePageCount(objPanelInfo)
{
   var _loc2_ = GetPageCount(objPanelInfo._m_numItems,objPanelInfo._SelectableTiles);
   var _loc3_ = GetCurrentPageNumber(objPanelInfo._m_numTopItemTile,objPanelInfo._SelectableTiles);
   if(_loc2_ > 1)
   {
      objPanelInfo._PageCountObject.htmlText = "Page " + _loc3_ + "/" + _loc2_;
   }
   else
   {
      objPanelInfo._PageCountObject.htmlText = "";
   }
}
function GetPageCount(numItems, NumTotalTiles)
{
   var _loc1_ = Math.ceil(numItems / NumTotalTiles);
   return _loc1_;
}
function GetCurrentPageNumber(numTopItemTile, NumTotalTiles)
{
   var _loc1_ = Math.ceil(numTopItemTile / NumTotalTiles);
   _loc1_ = _loc1_ + 1;
   return _loc1_;
}
var bConsoleVersion = _global.IsXbox() || _global.IsPS3();
var bIsXbox = _global.IsXbox();
var NumPlayerButtons = 10;
var avatarX = 2;
var avatarY = 2;
var avatarWidth = 28;
var avatarHeight = 28;
var NumActivePlayers = 0;
var LobbyLeaderXuid = "";
var LobbyLeaderName = "";
var IsLobbyHost = false;
var kPublic = 0;
var kPrivate = 3;
var PublicOption = kPublic;
var PublicOptionLabels = ["#SFUI_Lobby_PublicMatch","#SFUI_Lobby_ClanPreferredMatch","#SFUI_Lobby_ClanOnlyMatch","#SFUI_Lobby_PrivateMatch"];
var PublicOptionLabelsQueue = ["#SFUI_Lobby_QueuePublicMatch","#SFUI_Lobby_ClanPreferredMatchButton","#SFUI_Lobby_ClanOnlyMatchButton","#SFUI_Lobby_QueuePrivateMatch"];
var kLobby_FivePlayer = 0;
var kLobby_TenPlayer = 1;
var LobbyType = kLobby_TenPlayer;
var GameModeData = undefined;
var SelectedXuid = undefined;
var SelectedButton = undefined;
var m_objRightClick = null;
var bPanelActive = false;
var bisQueued = false;
var arrCheckedMapNames = new Array();
var arrShortMapNames = new Array();
var m_TournamentOpponentSelected = "";
var m_TournamentStage = "";
var m_TournamentSelection = null;
var m_bisQueued = false;
TournamentSelect.TeamSelecterPanel.Lister._x = 128;
var TeamListerInfo = new Object();
TeamListerInfo._TotalTiles = 60;
TeamListerInfo._SelectableTiles = 30;
TeamListerInfo._StartPos = TournamentSelect.TeamSelecterPanel.Lister._x;
TeamListerInfo._EndPos = TournamentSelect.TeamSelecterPanel.Lister._x - TournamentSelect.TeamSelecterPanel.Lister._width / 2 - 22;
TeamListerInfo._PrevButton = TournamentSelect.TeamSelecterPanel.ButtonPrev;
TeamListerInfo._NextButton = TournamentSelect.TeamSelecterPanel.ButtonNext;
TeamListerInfo._AnimObject = TournamentSelect.TeamSelecterPanel.Lister;
TeamListerInfo._PageCountObject = PageCount;
TeamListerInfo._m_numItems = 0;
TeamListerInfo._m_numTopItemTile = 0;
TeamListerInfo._ListType = "";
TeamListerInfo._TournamentName = "";
var NumButtons = ButtonList.length;
var ActiveButton = 0;
stop();
