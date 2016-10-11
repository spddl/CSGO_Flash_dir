function AddChatKeyHandlers(navLayout)
{
   if(!_global.IsXbox() && !_global.IsPS3())
   {
      navLayout.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.executeChat();
      }},"KEY_ENTER");
      navLayout.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.PageUp();
      }},"KEY_PAGEUP");
      navLayout.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.PageDown();
      }},"KEY_PAGEDOWN");
      navLayout.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.HomeButtonPressed();
      }},"KEY_HOME");
      navLayout.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.EndButtonPressed();
      }},"KEY_END");
      navLayout.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.ShiftPressed();
         return true;
      },onUp:function(button, control, keycode)
      {
         _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.ShiftReleased();
         return true;
      }},"KEY_LSHIFT","KEY_RSHIFT");
      navLayout.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.chatStringTyped(String.fromCharCode(_global.LobbyMovie.LobbyPanel.Panels.ChatPanel.keyDelete));
      }},"KEY_DELETE");
      navLayout.onCharTyped = function(typed)
      {
         var _loc2_ = typed.charCodeAt(0);
         if(_loc2_ == _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.keyBackquote)
         {
            return false;
         }
         if(_loc2_ == _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.keyEscape)
         {
            return false;
         }
         if(_global.GameInterface.GetConvarNumber("console_window_open") == 0)
         {
            _global.navManager.SetHighlightedObject(_global.LobbyMovie.LobbyPanel.Panels.ChatPanel);
            _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.chatStringTyped(typed);
            return true;
         }
         return false;
      };
      return true;
   }
   return false;
}
function ConfirmExit()
{
   var _loc2_ = _global.MainMenuMovie.Panel.TooltipItemPreview;
   _loc2_.ShowHidePreview(false);
   if(bshowQueuedStatus && bIsHost)
   {
      _global.LobbyAPI.StopQueuedMatchmakingSearch();
      return undefined;
   }
   if(_global.GameInterface.GetConvarNumber("console_window_open") == 0)
   {
      bModalPrompt = true;
      _global.LobbyAPI.ConfirmExit();
   }
   clearInterval(GameTimeInterval);
}
function MatchReady()
{
   if(m_bPressedButton)
   {
      return undefined;
   }
   m_bPressedButton = true;
   var _loc3_ = "dot";
   var _loc2_ = LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel;
   if("cooperative" == _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/type"))
   {
      LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.TextPlayers._visible = false;
      i = 1;
      while(i <= 10)
      {
         var _loc4_ = _loc3_ + i;
         _loc2_[_loc4_]._visible = false;
         i++;
      }
      _loc3_ = "dotCoop";
      i = 9;
      while(i <= 10)
      {
         _loc4_ = _loc3_ + i;
         _loc2_[_loc4_]._visible = true;
         i++;
      }
   }
   else
   {
      _loc2_.dotCoop9._visible = false;
      _loc2_.dotCoop10._visible = false;
      i = 0;
      while(i < 10)
      {
         _loc4_ = _loc3_ + i;
         _loc2_[_loc4_]._visible = true;
         i++;
      }
      LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.TextPlayers._visible = true;
   }
   _global.LobbyAPI.IsReady();
   LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.ReadyButton.gotoAndPlay("startAnim");
   LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.ReadyButton.ReadyButton.setDisabled(true);
   trace("MatchReady: ReadyButton._visible = " + LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.ReadyButton._visible + ", ReadyButton.gotoAndPlay(\'startAnim\');");
   trace("Player Is Ready");
}
function ShowInventory()
{
   LobbyPanel.Panels.InventoryPanel.InitInventoryPanelMaster();
   LobbyPanel.Panels.InventoryClose._visible = true;
   LobbyPanel.Panels.LobbyBg._visible = false;
   LobbyPanel.Panels.LobbyMainPanel._visible = false;
   LobbyPanel.Panels.ChatPanel._visible = false;
   LobbyPanel.Panels.NavigationMaster._visible = false;
}
function ShowLobby()
{
   LobbyPanel.Panels.LobbyBg._visible = true;
   LobbyPanel.Panels.LobbyMainPanel._visible = true;
   LobbyPanel.Panels.ChatPanel._visible = true;
   LobbyPanel.Panels.NavigationMaster._visible = true;
}
function modalDialogClosed()
{
   bModalPrompt = false;
}
function CyclePanelLeft()
{
   if(!bHidden && !bModalPrompt && !bChatRaised && ActivePanelIdx > Panel_First)
   {
      if(SubPanels[ActivePanelIdx] != undefined)
      {
         SubPanels[ActivePanelIdx].Deactivated();
      }
      _global.navManager.PlayNavSound("ButtonAction");
      ActivePanelIdx--;
      if(SubPanels[ActivePanelIdx] != undefined)
      {
         SubPanels[ActivePanelIdx].Activated();
      }
      ApplyActivePanels();
   }
}
function CyclePanelRight()
{
   if(!bHidden && !bModalPrompt && !bChatRaised && ActivePanelIdx < Panel_Last)
   {
      if(SubPanels[ActivePanelIdx] != undefined)
      {
         SubPanels[ActivePanelIdx].Deactivated();
      }
      _global.navManager.PlayNavSound("ButtonAction");
      ActivePanelIdx++;
      if(SubPanels[ActivePanelIdx] != undefined)
      {
         SubPanels[ActivePanelIdx].Activated();
      }
      ApplyActivePanels();
   }
}
function onRolloverChange(newPanel)
{
   if(bHidden || bModalPrompt || bChatRaised)
   {
      return undefined;
   }
   if(newPanel != ActivePanelIdx)
   {
      _global.navManager.PlayNavSound("ButtonAction");
      var _loc2_ = ActivePanelIdx;
      if(SubPanels[ActivePanelIdx] != undefined)
      {
         SubPanels[ActivePanelIdx].Deactivated();
      }
      ActivePanelIdx = newPanel;
      if(SubPanels[ActivePanelIdx] != undefined)
      {
         SubPanels[ActivePanelIdx].Activated();
      }
      ApplyActivePanels();
   }
}
function ApplyActivePanels()
{
   switch(ActivePanelIdx)
   {
      case Panel_Friends:
         SubPanels[Panel_Friends]._visible = true;
         if(!bConsoleVersion)
         {
            if(SubPanels[Panel_Clan]._visible)
            {
               SubPanels[Panel_Clan].onClanList();
            }
            SubPanels[Panel_Clan]._visible = false;
         }
         break;
      case Panel_Clan:
         if(!bConsoleVersion)
         {
            SubPanels[Panel_Friends]._visible = false;
            SubPanels[Panel_Clan]._visible = true;
         }
   }
}
function ForcePanel(newPanel)
{
   if(SubPanels[ActivePanelIdx] != undefined)
   {
      SubPanels[ActivePanelIdx].Deactivated();
   }
   ActivePanelIdx = newPanel;
   if(SubPanels[ActivePanelIdx] != undefined)
   {
      SubPanels[ActivePanelIdx].Activated();
   }
}
function onResize(rm)
{
   rm.ResetPositionByPixel(LobbyPanel,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_NONE);
   rm.DisableAdditionalScaling = true;
}
function showPanel()
{
   if(bHidden && SubPanels[ActivePanelIdx] != undefined)
   {
      LobbyPanel._visible = true;
      SubPanels[ActivePanelIdx].Activated();
   }
   if(!bConsoleVersion)
   {
      LobbyPanel.Panels.ChatPanel.ShowPanel();
   }
   bHidden = false;
   LobbyPanel.gotoAndPlay("StartShow");
   LobbyPanel.Panels.FriendsListerPanel._visible = true;
   LobbyPanel.Panels.MissionsPanel._visible = true;
   LobbyPanel.Panels.PlayerProfile._visible = true;
   LobbyPanel.Panels.LobbyBg._visible = true;
   LobbyPanel.Panels.LobbyMainPanel._visible = true;
   EnableRightClick();
}
function SetupNavDetectRollOvers()
{
   LobbyPanel.Panels.FriendsListerPanel.MouseOver.onRollOver = function()
   {
      SetLobbyNav("Friends");
   };
   LobbyPanel.Panels.MouseOver.onRollOver = function()
   {
      SetLobbyNav("Default");
   };
   LobbyPanel.Panels.InventoryPanel.MouseOver.onRollOver = function()
   {
      SetLobbyNav("Inv");
   };
}
function SetLobbyNav(strNavToSet)
{
   if(m_CurrentNav != strNavToSet)
   {
      m_CurrentNav = strNavToSet;
      LobbyPanel.Panels.FriendsListerPanel.RemoveLayout();
      LobbyPanel.Panels.InventoryPanel.RemoveLayout();
      RemoveLayout();
      LobbyPanel.Panels.FriendsListerPanel.MouseOver._visible = true;
      LobbyPanel.Panels.MouseOver._visible = true;
      LobbyPanel.Panels.InventoryPanel.MouseOver._visible = true;
      switch(strNavToSet)
      {
         case "Friends":
            LobbyPanel.Panels.FriendsListerPanel.PushLayout();
            LobbyPanel.Panels.FriendsListerPanel.MouseOver._visible = false;
            trace("-----------------------------------------FRIENDSNAV");
            break;
         case "Inv":
            LobbyPanel.Panels.InventoryPanel.PushLayout();
            LobbyPanel.Panels.InventoryPanel.MouseOver._visible = false;
            trace("-----------------------------------------INVNAV");
            break;
         default:
            PushLayout();
            LobbyPanel.Panels.MouseOver._visible = false;
            trace("-----------------------------------------DEFAULTNAV");
      }
   }
}
function PushLayout()
{
   _global.navManager.PushLayout(lobbyNav,"lobbyNav");
}
function RemoveLayout()
{
   _global.navManager.RemoveLayout(lobbyNav);
}
function RemoveAllLobbyNav()
{
   LobbyPanel.Panels.FriendsListerPanel.RemoveLayout();
   LobbyPanel.Panels.InventoryPanel.RemoveLayout();
   RemoveLayout();
}
function hidePanel()
{
   bHidden = true;
   DestroyOnHide = true;
   if(!bConsoleVersion)
   {
      LobbyPanel.Panels.ChatPanel.HidePanel();
   }
   LobbyPanel.gotoAndPlay("StartHide");
   LobbyPanel.Panels.MissionsPanel._visible = false;
}
function hidePanelNoDestroy()
{
   if(!bHidden)
   {
      if(SubPanels[ActivePanelIdx] != undefined)
      {
         SubPanels[ActivePanelIdx].Deactivated();
      }
      LobbyPanel._visible = false;
   }
   bHidden = true;
   DestroyOnHide = false;
   LobbyPanel.gotoAndPlay("StartHide");
}
function InitializeClientMatchSettings()
{
   var _loc1_ = LobbyPanel.Panels.ClientPanel;
   _loc1_.MessageTitle.text = "#SFUI_LobbyClient_StandbyTitle";
   _loc1_.MessageText.text = "#SFUI_LobbyClient_StandbyText";
   _loc1_.GameModeName.text = "#SFUI_LobbyClient_ModeWaitOnHost";
   _loc1_.MapName.text = "#SFUI_LobbyClient_MapWaitOnHost";
   _loc1_.VisibilitySetting.text = "";
}
function UpdateHostMatchSettings(bQuickmatch, CustomMode, CustomMapname)
{
   if(SubPanels[Panel_Lobby] != undefined)
   {
      SubPanels[Panel_Lobby].UpdateHostMatchSettings(bQuickmatch,CustomMode,CustomMapname);
   }
}
function UpdateSessionSettingsInScaleform(strType, strMode, strMapgroupname, strMap, strPermissions, AnyMode)
{
   if(strMode == "competitive")
   {
      bisQueuedMatch = true;
   }
   else
   {
      bisQueuedMatch = false;
   }
   numIsAnyMode = AnyMode;
   ShowHostQueueMatchUi();
   SubPanels[Panel_Lobby].UpdateClientText(strPermissions);
   trace("-------------------UpdateSessionSettingsInScaleform-------------------------------");
   trace("-------------------strMode-------------------------------" + strMode);
   trace("-------------------strMapgroupname-----------------------" + strMapgroupname);
   trace("-------------------AnyMode-------------------------------" + AnyMode);
   SubPanels[Panel_Lobby].UpdateClientMatchSettings(strMode,strMapgroupname,AnyMode);
}
function GetValueOfAnyMode()
{
   return numIsAnyMode;
}
function GetValueOfbisQueuedMatch()
{
   return bisQueuedMatch;
}
function UpdateClientMatchSettings(HostMode, HostMap, HostVisibility, AnyMode)
{
}
function UpdateQueueStatistics(strSearchTime, numServersReachable, numPlayersOnline, numServersOnline, numPlayersSearching, numServersAvailable, numOngoingMatches, strAverageWaitTime)
{
   LobbyPanel.Panels.SearchInfoPanel.SearchTime.Text.htmlText = strSearchTime;
   if(!LobbyPanel.Panels.LobbyMainPanel.m_isLobbyPrime)
   {
      LobbyPanel.Panels.SearchInfoPanel.StatusTitle.Text.htmlText = "#SFUI_LobbyPrompt_QueueSearchTitle";
   }
   else
   {
      LobbyPanel.Panels.SearchInfoPanel.StatusTitle.Text.htmlText = "#SFUI_LobbyPrompt_QueueSearchTitle_Prime";
   }
   if(strSearchTime != null && strSearchTime != "")
   {
      QueueSearchPanelAnim();
      trace("ping");
   }
   var _loc2_ = "";
   _loc2_ = _global.GameInterface.Translate("#SFUI_Lobby_SearchTitle_AverageWaitTime");
   _loc2_ = _global.ConstructString(_loc2_,strAverageWaitTime);
   LobbyPanel.Panels.SearchInfoPanel.AverageWaitTime.Text.htmlText = _loc2_;
   _loc2_ = _global.GameInterface.Translate("#SFUI_Lobby_SearchTitle_PlayersOnline");
   _loc2_ = _global.ConstructString(_loc2_,numPlayersOnline);
   LobbyPanel.Panels.SearchInfoPanel.PlayersOnline.Text.htmlText = _loc2_;
   _loc2_ = _global.GameInterface.Translate("#SFUI_Lobby_SearchTitle_PlayersSearching");
   _loc2_ = _global.ConstructString(_loc2_,numPlayersSearching);
   LobbyPanel.Panels.SearchInfoPanel.PlayersSearching.Text.htmlText = _loc2_;
   var _loc3_ = _global.CScaleformComponent_News.GetCurrentActiveAlertForUser();
   if(_loc3_ != "" && _loc3_ != undefined && _loc3_ != null)
   {
      LobbyPanel.Panels.SearchInfoPanel.ServersOnline.Text.htmlText = _global.GameInterface.Translate(_loc3_);
      LobbyPanel.Panels.SearchInfoPanel.ServersOnline.Text.textColor = "0xF7D73E";
   }
   else
   {
      _loc2_ = _global.GameInterface.Translate("#SFUI_Lobby_SearchTitle_ServersOnline");
      _loc2_ = _global.ConstructString(_loc2_,numServersOnline);
      LobbyPanel.Panels.SearchInfoPanel.ServersOnline.Text.htmlText = _loc2_;
      LobbyPanel.Panels.SearchInfoPanel.ServersOnline.Text.textColor = "0x87B0D2";
      _global.AutosizeTextDown(LobbyPanel.Panels.SearchInfoPanel.ServersOnline.Text,10);
   }
   _loc2_ = _global.GameInterface.Translate("#SFUI_Lobby_SearchTitle_ServersAvailable");
   _loc2_ = _global.ConstructString(_loc2_,numServersAvailable);
   LobbyPanel.Panels.SearchInfoPanel.ServersAvailable.Text.htmlText = _loc2_;
}
function ShowHostQueueMatchUi()
{
   var _loc2_ = false;
   if("cooperative" == _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/type"))
   {
      _loc2_ = true;
   }
   if(bisQueuedMatch || _loc2_)
   {
      if(_loc2_)
      {
         SubPanels[Panel_Lobby].gotoAndStop("Coop");
      }
      else
      {
         SubPanels[Panel_Lobby].gotoAndStop("ClanVsFive");
      }
      SubPanels[Panel_Lobby].SetTournament();
      SubPanels[Panel_Lobby].Title.TitleText.htmlText = "#SFUI_LOBBY_QUEUE_MODE_TITLE";
      LobbyPanel.Panels.LobbySideText.LobbyText.htmlText = "#SFUI_BYT_QUEUE_MODE_TITLE";
   }
   else
   {
      SubPanels[Panel_Lobby].TournamentSelect._visible = false;
      SubPanels[Panel_Lobby].gotoAndStop("Init");
      SubPanels[Panel_Lobby].Title.TitleText.htmlText = "#SFUI_LOBBYTITLE";
      LobbyPanel.Panels.LobbySideText.LobbyText.htmlText = "#SFUI_BYT_TITLE";
   }
}
function UpdateQueuedMatchmakingSearch(strStart)
{
   if(strStart != null && strStart != "")
   {
      bshowQueuedStatus = true;
      LobbyPanel.Panels.SearchInfoPanel.StatusText.Text.htmlText = strStart;
   }
   else
   {
      bshowQueuedStatus = false;
   }
   if(!bSearchQueueStarted && bshowQueuedStatus)
   {
      ShowQueuedStatusUi();
      bSearchQueueStarted = true;
   }
   else if(bSearchQueueStarted && !bshowQueuedStatus)
   {
      ShowQueuedStatusUi();
      bSearchQueueStarted = false;
   }
}
function ShowQueuedStatusUi()
{
   LobbyPanel.Panels.SearchInfoPanel.GameSettingsText.Bg.onRollOver = function()
   {
   };
   if("competitive" == _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/mode"))
   {
      LobbyPanel.Panels.SearchInfoPanel.Warning._visible = true;
   }
   else
   {
      LobbyPanel.Panels.SearchInfoPanel.Warning._visible = false;
   }
   if(_global.LobbyAPI.GetNumLobbySlots() == 1)
   {
      LobbyPanel.Panels.SearchInfoPanel._visible = bshowQueuedStatus;
      SetJournalBtn();
      LobbyPanel.Panels.SearchInfoPanel.ButtonCanelSearch._visible = bshowQueuedStatus;
      LobbyPanel.Panels.ChatPanel._visible = false;
      LobbyPanel.Panels.FriendsListerPanel._visible = false;
      LobbyPanel.Panels.MissionsPanel._visible = false;
      LobbyPanel.Panels.PlayerProfile._visible = false;
      LobbyPanel.Panels.LobbyBg._visible = false;
      LobbyPanel.Panels.LobbyMainPanel._visible = false;
      LobbyPanel.Panels.GamerClientBlocker._visible = false;
      LobbyPanel.Panels.bg._visible = false;
      LobbyPanel.Panels.LobbySideText._visible = false;
      LobbyPanel.Panels.FocusMovie._visible = false;
      LobbyPanel.Panels.TitleTextLobby._visible = false;
      LobbyPanel.Panels.SearchInfoPanel.GameSettingsText._visible = true;
      ShowInventory();
      LobbyPanel.Panels.InventoryPanel.CloseButton._visible = false;
      LobbyPanel.Panels.InventoryClose._visible = false;
      _global.MainMenuMovie.Panel.SelectPanel._visible = false;
      return undefined;
   }
   if(bIsHost)
   {
      LobbyPanel.Panels.SearchInfoPanel._visible = bshowQueuedStatus;
      LobbyPanel.Panels.PlayerProfile._visible = !bshowQueuedStatus;
      LobbyPanel.Panels.SearchInfoPanel.ButtonCanelSearch._visible = bshowQueuedStatus;
      LobbyPanel.Panels.LobbyMainPanel.StartMatchButton._visible = !bshowQueuedStatus;
      LobbyPanel.Panels.LobbyMainPanel.SetMatchOptionsButton.setDisabled(bshowQueuedStatus);
      LobbyPanel.Panels.LobbyMainPanel.ButtonPermissions.setDisabled(bshowQueuedStatus);
      LobbyPanel.Panels.LobbyMainPanel.PrimeStatus.setDisabled(bshowQueuedStatus);
      LobbyPanel.Panels.LobbyMainPanel.BackButton._visible = !bshowQueuedStatus;
      LobbyPanel.Panels.FriendsListerPanel._visible = !bshowQueuedStatus;
      if(bshowQueuedStatus)
      {
         LobbyPanel.Panels.SearchInfoPanel.gotoAndPlay("startAnim");
         SetJournalBtn();
      }
      return undefined;
   }
   LobbyPanel.Panels.SearchInfoPanel._visible = bshowQueuedStatus;
   LobbyPanel.Panels.PlayerProfile._visible = !bshowQueuedStatus;
   LobbyPanel.Panels.SearchInfoPanel.ButtonCanelSearch._visible = false;
   LobbyPanel.Panels.ClientPanel.spinner._visible = !bshowQueuedStatus;
   LobbyPanel.Panels.SearchInfoPanel.GameSettingsText._visible = !bshowQueuedStatus;
   LobbyPanel.Panels.LobbyMainPanel.SetMatchOptionsButton._visible = true;
   LobbyPanel.Panels.LobbyMainPanel.InviteFriends._visible = true;
   if(bshowQueuedStatus)
   {
      LobbyPanel.Panels.ClientPanel.MessageTitle.text = "";
      LobbyPanel.Panels.ClientPanel.MessageText.text = "#SFUI_LobbyClient_SelectedText";
      LobbyPanel.Panels.SearchInfoPanel.gotoAndPlay("startAnim");
      SetJournalBtn();
   }
   else
   {
      LobbyPanel.Panels.ClientPanel.MessageTitle.text = "#SFUI_LobbyClient_StandbyTitle";
      LobbyPanel.Panels.ClientPanel.MessageText.text = "#SFUI_LobbyClient_StandbyText";
   }
   return undefined;
}
function QueueSearchPanelAnim()
{
   if(bshowQueuedStatus)
   {
      var _loc4_ = Math.floor(Math.random() * 7) + 0;
      var _loc3_ = "mc";
      var _loc2_ = _loc3_ + _loc4_;
      var _loc1_ = LobbyPanel.Panels.SearchInfoPanel.Background.Pings[_loc2_];
      _loc1_.gotoAndPlay("startAnim");
   }
   else
   {
      _loc1_.gotoAndPlay("reset");
   }
}
function UpdateQueuedSearchReadyPanel(bMatch, numPlayers, srtHelpText)
{
   m_bFoundMatch = bMatch;
   ShowReadyPanel();
   LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.HelpText.Text.htmlText = srtHelpText;
   var _loc3_ = "dot";
   var _loc2_ = LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel;
   if("cooperative" == _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/type"))
   {
      i = 1;
      while(i <= 10)
      {
         var _loc5_ = _loc3_ + i;
         _loc2_[_loc5_]._visible = false;
         i++;
      }
      _loc3_ = "dotCoop";
      i = 9;
      while(i <= 10)
      {
         _loc5_ = _loc3_ + i;
         _loc2_[_loc5_]._visible = numPlayers > 0;
         i++;
      }
      LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.TextPlayers._visible = false;
   }
   else
   {
      _loc2_.dotCoop9._visible = false;
      _loc2_.dotCoop10._visible = false;
      i = 1;
      while(i <= 10)
      {
         _loc5_ = _loc3_ + i;
         _loc2_[_loc5_]._visible = numPlayers > 0;
         i++;
      }
      LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.TextPlayers._visible = numPlayers > 0;
   }
   i = 1;
   while(i <= numPlayers)
   {
      _loc5_ = _loc3_ + i;
      _loc2_[_loc5_].gotoAndStop("filled");
      i++;
   }
   i = 10;
   while(i > numPlayers)
   {
      _loc5_ = _loc3_ + i;
      _loc2_[_loc5_].gotoAndStop("empty");
      i--;
   }
   var _loc6_ = undefined;
   _loc6_ = _global.GameInterface.Translate("#SFUI_Lobby_MatchReadyPlayers");
   _loc6_ = _global.ConstructString(_loc6_,numPlayers);
   LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.TextPlayers.text = _loc6_;
}
function ShowReadyPanel()
{
   if(m_bFoundMatch == false)
   {
      LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel._visible = false;
      LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.ReadyButton.gotoAndStop("Init");
      LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.ReadyButton._visible = false;
      LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.ReadyButton.ReadyButton.setDisabled(true);
      trace("ShowReadyPanel: m_bFoundMatch == false:  ReadyButton._visible = true, ReadyButton.gotoAndStop(\'Init\');");
      m_bPressedButton = false;
      return undefined;
   }
   m_bFoundMatch == true;
   if(m_bPressedButton == false)
   {
      LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.ReadyButton.gotoAndStop("Init");
      LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.ReadyButton._visible = true;
      LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.ReadyButton.ReadyButton.setDisabled(false);
   }
   LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel._visible = true;
   CloseJournalOnAccept();
   trace("ShowReadyPanel: m_bFoundMatch == true;");
   return undefined;
}
function CloseJournalOnAccept()
{
   if(_global.MainMenuMovie.Panel.JournalPanel._visible)
   {
      _global.MainMenuMovie.Panel.JournalPanel.Journal.HidePanel();
   }
}
function SetJournalBtn()
{
   var _loc3_ = LobbyPanel.Panels.SearchInfoPanel.btnJournal;
   if(m_PlayerXuid == _global.CScaleformComponent_MyPersona.GetXuid())
   {
      var _loc4_ = _global.CScaleformComponent_Inventory.GetActiveSeasonCoinItemId(m_PlayerXuid);
      var _loc5_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
      if(_loc4_ != "0" && _loc4_ != null && _loc4_ != undefined && _loc4_ != "" && _loc5_ != -1)
      {
         _loc3_.dialog = this;
         _loc3_.Action = function()
         {
            OpenJournalContextMenu(this,false);
         };
         _loc3_.RolledOver = function()
         {
            m_objJournalSelection = this;
         };
         _loc3_.RolledOut = function()
         {
            m_objJournalSelection = null;
         };
         m_objHoverSelection = this;
         _loc3_._CoinId = _loc4_;
         _loc3_._visible = true;
      }
      else
      {
         _loc3_._visible = false;
      }
   }
   else
   {
      _loc3_._visible = false;
   }
}
function OpenJournalContextMenu(objTargetTile, bRightClick)
{
   var _loc11_ = _global.MainMenuMovie.Panel.TooltipContextMenu;
   var _loc14_ = {x:objTargetTile._x + objTargetTile._width,y:objTargetTile._y};
   var _loc8_ = [];
   var _loc9_ = [];
   _loc8_.push("journal");
   _loc9_.push("#SFUI_InvContextMenu_Journal");
   var _loc3_ = 1;
   while(_loc3_ <= 4)
   {
      var _loc6_ = _global.CScaleformComponent_Inventory.CheckCampaignOwnership(_loc3_);
      if(_loc6_)
      {
         _loc8_.push("campaign" + _loc3_);
         var _loc7_ = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(this["NUM_CAMPAIGN_" + _loc3_ + "_DEFINDEX"],0);
         var _loc5_ = _global.CScaleformComponent_Inventory.GetItemName(_global.CScaleformComponent_MyPersona.GetXuid(),_loc7_);
         var _loc4_ = _global.GameInterface.Translate("#SFUI_InvContextMenu_Campaign");
         _loc5_ = _global.GameInterface.Translate(_loc5_);
         _loc4_ = _global.ConstructString(_loc4_,_loc5_);
         _loc9_.push(_loc4_);
      }
      _loc3_ = _loc3_ + 1;
   }
   _loc8_.push("stats");
   _loc9_.push("#SFUI_InvContextMenu_Stats");
   _loc8_.push("leaderboards");
   _loc9_.push("#SFUI_InvContextMenu_Leaderboards");
   _loc11_.TooltipShowHide(objTargetTile);
   _loc11_.TooltipLayout(_loc8_,_loc9_,objTargetTile,this.AssignContextMenuAction);
   _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide();
}
function AssignContextMenuAction(strMenuItem, objTargetTile)
{
   switch(strMenuItem)
   {
      case "journal":
         OpenJournal(objTargetTile._CoinId,0,false);
         break;
      case "campaign1":
         OpenJournal(objTargetTile._CoinId,8,true);
         break;
      case "campaign2":
         OpenJournal(objTargetTile._CoinId,2,true);
         break;
      case "campaign3":
         OpenJournal(objTargetTile._CoinId,6,true);
         break;
      case "campaign4":
         OpenJournal(objTargetTile._CoinId,4,true);
         break;
      case "leaderboards":
         OpenJournal(objTargetTile._CoinId,12,true);
         break;
      case "stats":
         OpenJournal(objTargetTile._CoinId,10,true);
   }
}
function OpenJournal(ItemID, Page, bOpenToPage)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,ItemID,"season access");
   _global.MainMenuMovie.Panel.JournalPanel._visible = true;
   _global.MainMenuMovie.Panel.JournalPanel.Journal.ShowPanel(Page,ItemID,_loc2_,bOpenToPage);
}
function UpdateLobbyHost(leaderName, leaderXuid)
{
   SubPanels[Panel_Lobby].UpdateLobbyHost(leaderName,leaderXuid);
}
function InitLobby(leaderName, leaderXuid, isHost)
{
   if(bIsHost != isHost)
   {
      bHostChanged = true;
   }
   else
   {
      bHostChanged = false;
   }
   bIsHost = isHost;
   SubPanels[Panel_Lobby].InitLobby(leaderName,leaderXuid,isHost);
   if(!bConsoleVersion)
   {
      SubPanels[Panel_Friends] = LobbyPanel.Panels.FriendsListerPanel;
      LobbyPanel.Panels.LobbyFriendsPanel._visible = false;
   }
   else
   {
      SubPanels[Panel_Friends] = LobbyPanel.Panels.LobbyFriendsPanel;
      LobbyPanel.Panels.LobbyFriendsPanelPC._visible = false;
   }
   SubPanels[Panel_Friends].Init();
   SubPanels[Panel_Friends]._visible = true;
   SubPanels[Panel_Clan] = LobbyPanel.Panels.LobbyClanPanel;
   SubPanels[Panel_Clan].Init();
   SubPanels[Panel_Clan]._visible = false;
   if(!isHost)
   {
      Panel_First = Panel_Lobby;
      ForcePanel(Panel_Lobby);
      LobbyPanel.Panels.LobbyFriendsPanel._visible = !isHost;
      LobbyPanel.Panels.ClientPanel._visible = !isHost;
      SubPanels[Panel_Friends]._visible = isHost;
      SubPanels[Panel_Clan]._visible = isHost;
      LobbyPanel.Panels.LobbyFriendsPanel._visible = isHost;
      LobbyPanel.Panels.MissionsPanel._visible = ishost;
      LobbyPanel.Panels.LobbyMainPanel.DisplayButtonText._visible = isHost;
      LobbyPanel.Panels.LobbyMainPanel.DisplayButtonTextStatus._visible = isHost;
      LobbyPanel.Panels.LobbyMainPanel.ButtonPermissions.setDisabled(!isHost);
      InitializeClientMatchSettings();
   }
   else
   {
      Panel_First = Panel_Friends;
      ForcePanel(Panel_Friends);
      LobbyPanel.Panels.LobbyFriendsPanel._visible = isHost;
      LobbyPanel.Panels.MissionsPanel._visible = isHost;
      LobbyPanel.Panels.ClientPanel._visible = !isHost;
      LobbyPanel.Panels.LobbyMainPanel.ButtonPermissions.setDisabled(!isHost);
   }
   ApplyActivePanels();
   SetNavOptions(bWasStartActive);
   if(!bConsoleVersion && !bAlreadyLoaded)
   {
      bAlreadyLoaded = true;
      LobbyPanel.Panels.ChatPanel.AddStringToHistory(_global.GameInterface.Translate("#SFUI_Lobby_NewConnectionMessage"));
   }
   var _loc4_ = _global.CScaleformComponent_PartyList.GetPartySystemSetting("xuidHost");
   if(_global.CScaleformComponent_PartyList.GetPartySessionSetting("game/type") == "cooperative" && m_PlayerXuid == _loc4_)
   {
      var ItemId = _global.CScaleformComponent_Inventory.GetActiveSeasonCoinItemId(m_PlayerXuid);
      LobbyPanel.Panels.LobbyMainPanel.InviteFriends.SetText("#SFUI_Lobby_ShowInvites");
      LobbyPanel.Panels.LobbyMainPanel.InviteFriends.SetText("#SFUI_InvContextMenu_Campaign_Map");
      LobbyPanel.Panels.LobbyMainPanel.InviteFriends.dialog = this;
      LobbyPanel.Panels.LobbyMainPanel.InviteFriends.Action = function()
      {
         this.dialog.OpenJournal(ItemId,2,true,m_PlayerXuid);
      };
      SetButtonLayout(LobbyPanel.Panels.LobbyMainPanel.InviteFriends,"journal");
   }
   else
   {
      LobbyPanel.Panels.LobbyMainPanel.InviteFriends.Action = function()
      {
         _global.LobbyMovie.ChooseGameSettings();
      };
      SetButtonLayout(LobbyPanel.Panels.LobbyMainPanel.InviteFriends,"invite");
   }
}
function RefreshAvatarImages()
{
   if(SubPanels[Panel_Lobby] != undefined)
   {
      SubPanels[Panel_Lobby].RefreshAvatarImages();
   }
   if(SubPanels[Panel_Friends] != undefined)
   {
      SubPanels[Panel_Friends].RefreshAvatarImages();
   }
   if(SubPanels[Panel_Clan] != undefined)
   {
      SubPanels[Panel_Clan].RefreshAvatarImages();
   }
}
function ScaleformComponent_TournamentMatch_DraftUpdate()
{
   if(bIsHost)
   {
      LobbyPanel.Panels.LobbyMainPanel.BanPickPanel.SetUpPanel();
   }
}
function ScaleformComponent_FriendsList_RebuildFriendsList()
{
   SubPanels[Panel_Friends].ScaleformComponent_FriendsList_RebuildFriendsList();
   SubPanels[Panel_Lobby].ScaleformComponent_FriendsList_RebuildFriendsList();
}
function UpdateClanInfo(index, xuid, clanName, numOnline, numInGame, numChatting)
{
}
function UpdateClanMemberInfo(index, xuid, friendName, friendStatus, bInvited)
{
   SubPanels[Panel_Clan].UpdateClanMemberInfo(index,xuid,friendName,friendStatus,bInvited);
}
function HideClansAt(index)
{
   SubPanels[Panel_Clan].HideClansAt(index);
}
function UpdateLobbyPlayer(index, xuid, playerName, bSpeaking, bVacBanned, numRank, numWins, iTeamColor)
{
   SubPanels[Panel_Lobby].UpdateLobbyPlayer(index,xuid,playerName,bSpeaking,bVacBanned,numRank,numWins,iTeamColor);
}
function UpdateTeamName(bShowTeamName, strTeamName)
{
   SubPanels[Panel_Lobby].UpdateTeamName(bShowTeamName,strTeamName);
}
function HideLobbyListAt(index)
{
   SubPanels[Panel_Lobby].HideLobbyListAt(index);
}
function AddChatText(chatText)
{
   if(!bConsoleVersion)
   {
      LobbyPanel.Panels.ChatPanel.AddStringToHistory(chatText);
   }
}
function AddIMEChar(value)
{
   if(!bConsoleVersion)
   {
      LobbyPanel.Panels.ChatPanel.AddIMEChar(value);
   }
}
function SetIMECompositionString(value)
{
   if(!bConsoleVersion)
   {
      LobbyPanel.Panels.ChatPanel.SetIMECompositionString(value);
   }
}
function CancelIMEComposition(value)
{
   if(!bConsoleVersion)
   {
      LobbyPanel.Panels.ChatPanel.CancelIMEComposition(value);
   }
}
function PageUpList()
{
   if(SubPanels[ActivePanelIdx] != undefined)
   {
      SubPanels[ActivePanelIdx].PageUpList();
   }
}
function PageDownList()
{
   if(SubPanels[ActivePanelIdx] != undefined)
   {
      SubPanels[ActivePanelIdx].PageDownList();
   }
}
function FriendsListUp(bNoWrap)
{
   if(SubPanels[ActivePanelIdx] != undefined)
   {
      SubPanels[ActivePanelIdx].FriendsListUp(bNoWrap);
   }
}
function FriendsListDown(bNoWrap)
{
   if(SubPanels[ActivePanelIdx] != undefined)
   {
      SubPanels[ActivePanelIdx].FriendsListDown(bNoWrap);
   }
}
function HandleBackButton()
{
   ChooseGameSettings();
}
function ChooseGameSettings()
{
   if(bIsHost)
   {
      _global.LobbyAPI.ChooseGameSettings();
   }
   else
   {
      var _loc2_ = LobbyPanel.Panels.LobbyMainPanel;
      LobbyPanel.Panels.ClientPanel._visible = !LobbyPanel.Panels.ClientPanel._visible;
      if(LobbyPanel.Panels.ClientPanel._visible)
      {
         Panel_First = Panel_Lobby;
         ForcePanel(Panel_Lobby);
         LobbyPanel.Panels.LobbyFriendsPanel._visible = false;
         SubPanels[Panel_Friends]._visible = false;
         _loc2_.InviteFriends.SetText("#SFUI_Lobby_ShowInvites");
         SetButtonLayout(LobbyPanel.Panels.LobbyMainPanel.InviteFriends,"invite");
      }
      else
      {
         Panel_First = Panel_Friends;
         ForcePanel(Panel_Friends);
         LobbyPanel.Panels.ClientPanel._visible = false;
         _loc2_.InviteFriends.SetText("#SFUI_Lobby_ShowGameInfo");
         SetButtonLayout(LobbyPanel.Panels.LobbyMainPanel.InviteFriends,"info");
      }
      ApplyActivePanels();
   }
}
function StartMatch()
{
   var _loc2_ = _global.CScaleformComponent_MyPersona.GetMyOfficialTournamentName();
   SubPanels[Panel_Lobby].StartMatch();
   if(_loc2_ == "" || _loc2_ == undefined)
   {
      _global.LobbyAPI.LaunchGame();
   }
   else
   {
      _global.LobbyAPI.LaunchGame(_loc2_,_global.CScaleformComponent_MyPersona.GetMyOfficialTeamName(),SubPanels[Panel_Lobby].m_TournamentOpponentSelected,SubPanels[Panel_Lobby].m_TournamentStage);
   }
}
function GetActiveFriendXuid()
{
   if(SubPanels[ActivePanelIdx] != undefined)
   {
      return SubPanels[ActivePanelIdx].GetActiveFriendXuid();
   }
   return undefined;
}
function OnRightShoulderButton()
{
   if(_global.IsXbox())
   {
      _global.LobbyAPI.BasePanelRunCommand("ShowInvitePartyUI");
      return true;
   }
   if(!_global.IsPS3())
   {
      SubPanels[Panel_Lobby].ToggleLobbyType();
      return true;
   }
   return false;
}
function onUnload(mc)
{
   clearInterval(_global.LobbyUpdateInviteInterval);
   delete _global.LobbyUpdateInviteInterval;
   if(SubPanels[ActivePanelIdx] != undefined)
   {
      SubPanels[ActivePanelIdx].Deactivated();
      RemoveAllLobbyNav();
   }
   _global.tintManager.DeregisterAll(this);
   _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.Release();
   _global.LobbyMovie = null;
   _global.LobbyAPI = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onLoaded()
{
   if(_global.wantControllerShown)
   {
      bCacheController = true;
   }
   else
   {
      bCacheController = false;
   }
   setCachedUIDevice();
   _global.MainMenuMovie.HideFloatingPanels();
   LobbyPanel.Panels.LobbyMainPanel.BackButton.Action = function()
   {
      _global.LobbyMovie.ConfirmExit();
   };
   LobbyPanel.Panels.LobbyMainPanel.SetMatchOptionsButton.Action = function()
   {
      _global.LobbyMovie.ChooseGameSettings();
   };
   LobbyPanel.Panels.LobbyMainPanel.StartMatchButton.Action = function()
   {
      _global.LobbyMovie.StartMatch();
   };
   SetButtonLayout(LobbyPanel.Panels.LobbyMainPanel.SetMatchOptionsButton,"settings");
   LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.ReadyButton.ReadyButton.SetText("#SFUI_Lobby_MatchReadyButton");
   LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel.ReadyButton.ReadyButton.Action = function()
   {
      _global.LobbyMovie.MatchReady();
   };
   LobbyPanel.Panels.SearchInfoPanel.ButtonCanelSearch.Action = function()
   {
      _global.LobbyMovie.ConfirmExit();
   };
   LobbyPanel.Panels.NavigationMaster.PCButtons.PendingInviteButton._visible = _global.IsPS3();
   SubPanels[Panel_Lobby] = LobbyPanel.Panels.LobbyMainPanel;
   SubPanels[Panel_Lobby].Init();
   LobbyPanel.Panels.InventoryPanel._visible = false;
   LobbyPanel.Panels.InventoryPanel._x = LobbyPanel.Panels.InventoryPanel._x + 452;
   LobbyPanel.Panels.InventoryClose._visible = false;
   LobbyPanel.Panels.InventoryClose._x = LobbyPanel.Panels.InventoryClose._x + 452;
   if(!bConsoleVersion)
   {
      LobbyPanel.Panels.FriendsListerPanel.InitFriendsLister();
      LobbyPanel.Panels.PlayerProfile.InitPlayerProfile();
      LobbyPanel.Panels.MissionsPanel.InitMissionsPanel(false);
      LobbyPanel.Panels.MissionsPanel.SetPanelEnabledDisabled(true);
   }
   else
   {
      SubPanels[Panel_Friends] = LobbyPanel.Panels.LobbyFriendsPanel;
      SubPanels[Panel_Friends].Init();
   }
   SubPanels[Panel_Clan] = LobbyPanel.Panels.LobbyClanPanel;
   SubPanels[Panel_Clan].Init();
   SubPanels[Panel_Clan]._visible = false;
   LobbyPanel.Panels.ChatPanel._visible = !bConsoleVersion;
   if(!bConsoleVersion)
   {
      LobbyPanel.Panels.ChatPanel.Init();
      LobbyPanel.Panels.ChatPanel.ShowPanel();
   }
   LobbyPanel.Panels.ClientPanel._visible = false;
   LobbyPanel.Panels.LobbyMainPanel.BanPickPanel.HidePanel();
   Panel_First = Panel_Friends;
   ForcePanel(Panel_Friends);
   gameAPI.OnReady();
   _global.LobbyUpdateInviteInterval = setInterval(_global.LobbyAPI.UpdatePendingInvites,5000);
   SetupNavDetectRollOvers();
   SetLobbyNav("Default");
}
function SetButtonLayout(objBtn, Capabilities)
{
   var _loc2_ = "images/ui_icons/";
   objBtn.ButtonText.Text.autoSize = "left";
   objBtn.ButtonText.Text._x = 15;
   LoadImage(_loc2_ + Capabilities + ".png",objBtn.ImageHolder,28,28,false);
}
function LoadImage(imagePath, objImage, numWidth, numHeight, bCenterImage)
{
   var _loc1_ = new Object();
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
   };
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc4_ = imagePath;
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc4_,objImage.Image);
   if(bCenterImage)
   {
      objImage._x = (objImage._parent._width - numWidth) * 0.5;
   }
}
function EnableRightClick()
{
   _global.KeyDownEvent = function(key, vkey, slot, binding)
   {
      Lib.SFKey.setKeyCode(key,vkey,slot,binding);
      var _loc2_ = Lib.SFKey.KeyName(Lib.SFKey.getKeyCode());
      if(_loc2_ == "MOUSE_RIGHT")
      {
         LobbyRightClickManager();
      }
      return _global.navManager.onKeyDown();
   };
}
function LobbyRightClickManager()
{
   var _loc2_ = LobbyPanel.Panels.InventoryPanel.Inventory;
   var _loc4_ = LobbyPanel.Panels.InventoryPanel.Loadout;
   var _loc5_ = LobbyPanel.Panels.InventoryPanel.Crafting;
   var _loc8_ = LobbyPanel.Panels.LobbyMainPanel;
   var _loc6_ = LobbyPanel.Panels.FriendsListerPanel;
   var _loc3_ = LobbyPanel.Panels.MissionsPanel;
   var _loc7_ = LobbyPanel.Panels.PlayerProfile;
   var _loc9_ = LobbyPanel.Panels.SearchInfoPanel.btnJournal;
   if(LobbyPanel.Panels.InventoryPanel.hitTest(_root._xmouse,_root._ymouse,true) && LobbyPanel.Panels.InventoryPanel._visible)
   {
      if(_loc2_._visible)
      {
         _loc2_.OpenContextMenu(_loc2_.m_objInvHoverSelection,true);
         _loc2_.FilterDropdown.HideList();
         _loc2_.SortDropdown.HideList();
      }
      else if(_loc4_._visible)
      {
         _loc4_.OpenLoadoutContextMenu(_loc4_.m_objLoadoutHoverSelection,true);
         _loc4_.SortDropdown.HideList();
      }
      else if(_loc5_._visible)
      {
         _loc5_.m_objCraftingHoverSelection.Action();
         _loc5_.SortDropdown.HideList();
      }
   }
   if(LobbyPanel.Panels.LobbyMainPanel.hitTest(_root._xmouse,_root._ymouse,true) && !LobbyPanel.Panels.InventoryPanel._visible)
   {
      _loc8_.OpenContextMenu(_loc8_.m_objRightClick,true);
   }
   else if(_loc6_.objRightClick != null && _loc6_.objRightClick.hitTest(_root._xmouse,_root._ymouse,true) && !LobbyPanel.Panels.ClientPanel._visible)
   {
      _loc6_.OpenContextMenu(LobbyPanel.Panels.FriendsListerPanel.objRightClick);
   }
   else if(_loc3_.objRightClick != null && _loc3_.objRightClick.hitTest(_root._xmouse,_root._ymouse,true) && !LobbyPanel.Panels.ClientPanel._visible)
   {
      _loc3_.OpenContextMenu(_loc3_.objRightClick);
   }
   else if(_loc7_.m_objHoverSelection != null && _loc7_.m_objHoverSelection.hitTest(_root._xmouse,_root._ymouse,true) && !LobbyPanel.Panels.ClientPanel._visible)
   {
      _loc7_.OpenContextMenu(_loc3_.m_objHoverSelection);
   }
   else if(m_objJournalSelection != null && _loc9_.hitTest(_root._xmouse,_root._ymouse,true) && LobbyPanel.Panels.SearchInfoPanel.JournalButton._visible)
   {
      OpenJournalContextMenu(m_objJournalSelection);
   }
}
function ScaleformComponent_MyPersona_MedalsChanged()
{
   LobbyPanel.Panels.PlayerProfile.GetMedalsInfo();
}
function ScaleformComponent_MyPersona_NameChanged()
{
   LobbyPanel.Panels.PlayerProfile.SetPlayerData();
}
function ScaleformComponent_FriendsList_RebuildFriendsList()
{
   LobbyPanel.Panels.FriendsListerPanel.RefreshFriendsTiles();
}
function ScaleformComponent_PartyList_RebuildPartyList()
{
   LobbyPanel.Panels.LobbyMainPanel.ScaleformComponent_PartyList_RebuildPartyList();
}
function ScaleformComponent_GC_Hello()
{
   LobbyPanel.Panels.PlayerProfile.SetEloBracketInfo();
   LobbyPanel.Panels.PlayerProfile.SetCommendationsInfo();
}
function ScaleformComponent_Device_Reset()
{
   LobbyPanel.Panels.FriendsListerPanel.RefreshAvatarImage();
   LobbyPanel.Panels.PlayerProfile.RefreshAvatarImage();
}
function setCachedUIDevice()
{
   if(bCacheController)
   {
      LobbyPanel.Panels.NavigationMaster.gotoAndStop("ShowController");
   }
   else
   {
      LobbyPanel.Panels.NavigationMaster.gotoAndStop("HideController");
   }
}
function changeUIDevice()
{
   if(bCacheController != undefined && bCacheController == _global.wantControllerShown)
   {
      return undefined;
   }
   bCacheController = undefined;
   SetNavOptions(bWasStartActive);
   if(_global.wantControllerShown)
   {
      LobbyPanel.Panels.NavigationMaster.gotoAndPlay("StartShowController");
   }
   else
   {
      LobbyPanel.Panels.NavigationMaster.gotoAndPlay("StartHideController");
   }
}
function RefreshNav()
{
   bPendingInvite = _global.GameInterface.GetConvarBoolean("cl_invitation_pending");
   SetNavOptions(bWasStartActive);
}
function SetNavOptions(bStartActive)
{
   if(bStartActive == bWasStartActive && bHostChanged == false && bWasPendingInvite == bPendingInvite)
   {
      return undefined;
   }
   var _loc2_ = LobbyPanel.Panels.LobbyMainPanel;
   _loc2_.StartMatchButton.SetText("#SFUI_Lobby_StartMatchButton");
   _loc2_.StartMatchButton._visible = true;
   bWasStartActive = bStartActive;
   _loc2_.GameSettingsText._visible = true;
   _loc2_.SetMatchOptionsButton.SetText("#SFUI_Lobby_GameSettings");
   if(bIsHost)
   {
      _loc2_.GameSettingsText._visible = true;
      if(LobbyPanel.Panels.LobbyMainPanel.DoesPlayerOwnOperation() && CScaleformComponent_PartyList.GetPartySessionSetting("game/type") == "cooperative")
      {
         _loc2_.InviteFriends._visible = true;
      }
      else
      {
         _loc2_.InviteFriends._visible = false;
      }
   }
   else if(LobbyPanel.Panels.ClientPanel._visible)
   {
      _loc2_.InviteFriends.SetText("#SFUI_Lobby_ShowInvites");
      SetButtonLayout(_loc2_.InviteFriends,"invite");
      _loc2_.StartMatchButton._visible = false;
   }
   else
   {
      _loc2_.InviteFriends.SetText("#SFUI_Lobby_ShowGameInfo");
      SetButtonLayout(_loc2_.InviteFriends,"info");
   }
   var _loc9_ = _global.CScaleformComponent_MyPersona.GetMyOfficialTeamName();
   var _loc8_ = _global.CScaleformComponent_MyPersona.GetMyOfficialTournamentName();
   var _loc5_ = false;
   if("cooperative" == _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/type"))
   {
      _loc5_ = true;
   }
   if(_loc9_ != "" && _loc8_ != "" && bIsHost || _loc5_ || !bIsHost)
   {
      _loc2_.SetMatchOptionsButton.setDisabled(true);
   }
   else
   {
      _loc2_.SetMatchOptionsButton.setDisabled(false);
   }
   var _loc3_ = undefined;
   var _loc4_ = undefined;
   var _loc6_ = undefined;
   if(bPendingInvite)
   {
      _loc4_ = "#SFUI_Lobby_Help_Invite_On";
      _loc6_ = "#SFUI_Lobby_Help_Invite_On_Btn";
   }
   else
   {
      _loc4_ = "#SFUI_Lobby_Help_Invite_Off";
      _loc6_ = "#SFUI_Lobby_Help_Invite_Off_Btn";
   }
   if(bIsHost)
   {
      if(bStartActive)
      {
         _loc3_ = "#SFUI_Lobby_Help@15";
      }
      else
      {
         _loc3_ = "#SFUI_Lobby_HelpNoStart@15";
      }
   }
   else if(LobbyPanel.Panels.ClientPanel._visible)
   {
      _loc3_ = "#SFUI_Lobby_HelpClientInvite@15";
   }
   else
   {
      _loc3_ = "#SFUI_Lobby_HelpClientShowGameInfo@15";
   }
   LobbyPanel.Panels.NavigationMaster.ControllerNav.SetText(_global.GameInterface.Translate(_loc3_) + "\t" + _global.GameInterface.Translate(_loc4_));
}
function isDoubleClickActive()
{
   return bDoubleClickEnabled;
}
function startDoubleClickTimer()
{
   stopDoubleClickTimer();
   bDoubleClickEnabled = true;
   doubleClickInterval = setInterval(this,"stopDoubleClickTimer",doubleClickTiming);
}
function stopDoubleClickTimer()
{
   clearInterval(doubleClickInterval);
   bDoubleClickEnabled = false;
}
_global.LobbyMovie = this;
_global.LobbyAPI = gameAPI;
var bConsoleVersion = _global.IsXbox() || _global.IsPS3();
var Panel_Friends = 0;
var numIsAnyMode = 0;
var Panel_Clan = 2;
var Panel_Lobby = 1;
var Panel_First = Panel_Friends;
var Panel_Last = Panel_Lobby;
var ActivePanelIdx = Panel_Friends;
var SubPanels = [0,0,0];
var bModalPrompt = false;
var m_bPressedButton = false;
var DestroyOnHide = true;
var bHidden = false;
var bChatRaised = false;
var bIsHost = undefined;
var bWasStartActive = undefined;
var bWasPendingInvite = undefined;
var bHostChanged = undefined;
var bPendingInvite = undefined;
var bisQueuedMatch = undefined;
var bshowQueuedStatus = false;
var bSearchQueueStarted = false;
var m_bFoundMatch = false;
var bCanelReadyPanel = false;
var m_objJournalSelection = null;
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var strQueuedSearchStatus = "";
var bCacheController = undefined;
var bAlreadyLoaded = false;
LobbyPanel.Panels.SearchInfoPanel._visible = false;
LobbyPanel.Panels.SearchInfoPanel.MatchReadyPanel._visible = false;
LobbyPanel.Panels.FriendsListerPanel._visible = false;
LobbyPanel.Panels.MissionsPanel._visible = false;
LobbyPanel.Panels.PlayerProfile._visible = false;
LobbyPanel.Panels.LobbyBg._visible = false;
LobbyPanel.Panels.LobbyMainPanel._visible = false;
var NUM_CAMPAIGN_1_DEFINDEX = 1321;
var NUM_CAMPAIGN_2_DEFINDEX = 1319;
var NUM_CAMPAIGN_3_DEFINDEX = 1320;
var NUM_CAMPAIGN_4_DEFINDEX = 1312;
var lobbyNav = new Lib.NavLayout();
lobbyNav.ShowCursor(true);
lobbyNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.LobbyMovie.ConfirmExit();
}},"KEY_ESCAPE","KEY_XBUTTON_B");
_global.LobbyMovie.AddChatKeyHandlers(lobbyNav);
var bDoubleClickEnabled = false;
var doubleClickInterval;
var doubleClickTiming = 750;
_global.resizeManager.AddListener(this);
stop();
