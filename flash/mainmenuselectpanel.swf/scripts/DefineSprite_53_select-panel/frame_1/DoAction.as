function InitSelectMenu()
{
   InitTopBarButtons();
   onShow();
}
function restorePanel()
{
   UnselectButton();
}
function onShow()
{
   MainMenuTopBar.NewItemsAlert._visible = false;
   MainMenuTopBar.LiveMatchAlert._visible = false;
   gotoAndStop("StartShow");
   play();
}
function InitTopBarButtons()
{
   var _loc2_ = MainMenuTopBar.PlayButton;
   _loc2_ = MainMenuTopBar.PlayButton;
   _loc2_.SetText("#SFUI_MainMenu_PlayButton");
   _loc2_.Action = function()
   {
      onSelectedButton(this);
   };
   _loc2_.Selected._visible = false;
   _loc2_.PickEm._visible = false;
   _loc2_.actionSound = "ButtonLarge";
   _loc2_ = MainMenuTopBar.LearnButton;
   _loc2_.SetText("#SFUI_MainMenu_LearnButton");
   _loc2_.Action = function()
   {
      onSelectedButton(this);
   };
   _loc2_.Selected._visible = false;
   _loc2_.PickEm._visible = false;
   _loc2_.actionSound = "ButtonLarge";
   _loc2_ = MainMenuTopBar.InventoryButton;
   _loc2_.SetText("#SFUI_MainMenu_Inventory");
   _loc2_.Action = function()
   {
      onSelectedButton(this);
   };
   _loc2_.Selected._visible = false;
   _loc2_.PickEm._visible = false;
   _loc2_.actionSound = "ButtonLarge";
   _loc2_ = MainMenuTopBar.WatchButton;
   _loc2_.SetText("#SFUI_MainMenu_Watch");
   _loc2_.Action = function()
   {
      onSelectedButton(this);
   };
   _loc2_.Selected._visible = false;
   _loc2_.PickEm._visible = false;
   _loc2_.PickEm.htmlText = "#CSGO_Fantasy_Watch_Tab";
   _loc2_.actionSound = "ButtonLarge";
   _loc2_ = MainMenuTopBar.AwardsButton;
   _loc2_.Action = function()
   {
      onSelectedButton(this);
   };
   _loc2_.SetText("#SFUI_MainMenu_My_Awards");
   _loc2_.Selected._visible = false;
   _loc2_.PickEm._visible = false;
   _loc2_.actionSound = "ButtonLarge";
   _loc2_ = MainMenuTopBar.OptionsButton;
   _loc2_.Action = function()
   {
      onSelectedButton(this);
   };
   _loc2_.SetText("#SFUI_MainMenu_HelpButton");
   _loc2_.Selected._visible = false;
   _loc2_.PickEm._visible = false;
   _loc2_.actionSound = "ButtonLarge";
   _loc2_ = MainMenuTopBar.HomeButton;
   _loc2_.Action = function()
   {
      onSelectedButton(this);
   };
   _loc2_.Selected._visible = false;
   _loc2_.actionSound = "ButtonLarge";
   _loc2_ = MainMenuTopBar.QuitButton;
   _loc2_.Action = function()
   {
      onSelectedButton(this);
   };
   _loc2_.Selected._visible = false;
   _loc2_.actionSound = "ButtonLarge";
   _loc2_ = MainMenuTopBar.AlertButton;
   _loc2_.Action = function()
   {
      onSelectedButton(this);
   };
   _loc2_.Selected._visible = false;
   _loc2_.actionSound = "ButtonLarge";
}
function onSelectedButton(objButton)
{
   if(MainMenuTopBar.QuitButton != objButton)
   {
      objSelectedButton.Selected._visible = false;
      objSelectedButton = objButton;
   }
   switch(objButton)
   {
      case MainMenuTopBar.PlayButton:
         PlayDropdown._visible = true;
         LearnDropdown._visible = false;
         AwardsDropdown._visible = false;
         OptionsDropdown._visible = false;
         objButton.Selected._visible = true;
         PlayDropdown.InitPlayMenu();
         break;
      case MainMenuTopBar.LearnButton:
         PlayDropdown._visible = false;
         LearnDropdown._visible = true;
         AwardsDropdown._visible = false;
         OptionsDropdown._visible = false;
         objButton.Selected._visible = true;
         LearnDropdown.InitLearnMenu();
         break;
      case MainMenuTopBar.InventoryButton:
         PlayDropdown._visible = false;
         LearnDropdown._visible = false;
         AwardsDropdown._visible = false;
         OptionsDropdown._visible = false;
         Panel.PlayerProfile._visible = true;
         Panel.MissionsPanel._visible = true;
         OnInventoryPressed();
         break;
      case MainMenuTopBar.WatchButton:
         PlayDropdown._visible = false;
         LearnDropdown._visible = false;
         AwardsDropdown._visible = false;
         OptionsDropdown._visible = false;
         Panel.PlayerProfile._visible = true;
         OnWatchPressed();
         break;
      case MainMenuTopBar.AwardsButton:
         PlayDropdown._visible = false;
         LearnDropdown._visible = false;
         AwardsDropdown._visible = true;
         OptionsDropdown._visible = false;
         objButton.Selected._visible = true;
         AwardsDropdown.InitAccompMenu();
         break;
      case MainMenuTopBar.OptionsButton:
         PlayDropdown._visible = false;
         LearnDropdown._visible = false;
         AwardsDropdown._visible = false;
         OptionsDropdown._visible = true;
         objButton.Selected._visible = true;
         OptionsDropdown.InitOptionsMenu();
         break;
      case MainMenuTopBar.HomeButton:
         PlayDropdown._visible = false;
         LearnDropdown._visible = false;
         AwardsDropdown._visible = false;
         OptionsDropdown._visible = false;
         OnHomePressed();
         break;
      case MainMenuTopBar.QuitButton:
         PlayDropdown._visible = false;
         LearnDropdown._visible = false;
         AwardsDropdown._visible = false;
         OptionsDropdown._visible = false;
         OnQuitGamePressed();
         break;
      case MainMenuTopBar.AlertButton:
         PlayDropdown._visible = false;
         LearnDropdown._visible = false;
         AwardsDropdown._visible = false;
         OptionsDropdown._visible = false;
         OnAlertButtonPressed();
   }
}
function CloseAnyOpenMenus()
{
   _global.CScaleformComponent_Inventory.LaunchWeaponPreviewPanel("");
   _global.MainMenuMovie.Panel.TooltipItemPreview.ShowHidePreview(false,null,null);
   if(_global.LobbyMovie)
   {
      if(!_global.LobbyMovie.bModalPrompt)
      {
         if(_global.LobbyMovie.LobbyPanel.Panels.InventoryPanel._visible)
         {
            _global.LobbyMovie.LobbyPanel.Panels.InventoryPanel.ClosePanel();
         }
         _global.RemoveElement(_global.SinglePlayerMovie);
         _global.LobbyMovie.ConfirmExit();
         return true;
      }
   }
   if(_global.SinglePlayerMovie)
   {
      _global.RemoveElement(_global.SinglePlayerMovie);
   }
   if(_global.MainMenuMovie.Panel.InventoryPanel._visible)
   {
      _global.MainMenuMovie.Panel.InventoryPanel.ClosePanel();
   }
   if(_global.MainMenuMovie.Panel.WatchPanel._visible)
   {
      _global.MainMenuMovie.Panel.WatchPanel.ClosePanel();
   }
   if(_global.MedalStatsScreenMovie)
   {
      _global.RemoveElement(_global.MedalStatsScreenMovie);
   }
   if(_global.MedalStatsScreenMovie)
   {
      _global.RemoveElement(_global.MedalStatsScreenMovie);
   }
   if(_global.LeaderBoardsMovie)
   {
      _global.RemoveElement(_global.LeaderBoardsMovie);
   }
   if(_global.OptionsMovie)
   {
      _global.RemoveElement(_global.OptionsMovie);
   }
   if(_global.MainMenuMovie.Panel.MapVotePanel._visible)
   {
      _global.MainMenuMovie.Panel.MapVotePanel.ClosePanel();
   }
   if(_global.MainMenuMovie.Panel.Guides._visible)
   {
      _global.MainMenuMovie.Panel.Guides.HideGuidesPanel();
   }
}
function OpenMenu(strMenu)
{
   if(CloseAnyOpenMenus())
   {
      LobbyInterval = setInterval(PollLobbyIsClosed,50,strMenu);
      return undefined;
   }
   MainMenuTopBar.QuitButton.setDisabled(true);
   switch(strMenu)
   {
      case "Custom":
         if(_global.MainMenuAPI.IsMultiplayerPrivilegeEnabled("bShowWarning"))
         {
            _global.MainMenuAPI.BasePanelRunCommand("OpenCreateMultiplayerGameDialog","bHidePanel");
         }
         break;
      case "Friends":
         if(_global.IsPC())
         {
            _global.MainMenuAPI.BasePanelRunCommand("ShowJoinPartyUI","bHidePanel");
         }
         break;
      case "Community":
         if(_global.MainMenuAPI.IsMultiplayerPrivilegeEnabled("bShowWarning"))
         {
            this._visible = false;
            _global.MainMenuAPI.BasePanelRunCommand("OpenCreateMultiplayerGameCommunity","bHidePanel");
         }
         break;
      case "Browser":
         if(_global.MainMenuAPI.IsMultiplayerPrivilegeEnabled("bShowWarning"))
         {
            this._visible = false;
            _global.MainMenuAPI.BasePanelRunCommand("OpenServerBrowser","bHidePanel");
         }
         break;
      case "Offline":
         _global.MainMenuAPI.BasePanelRunCommand("OpenCreateSinglePlayerGameDialog","bHidePanel");
         break;
      case "HowPlay":
         __global.MainMenuAPI.BasePanelRunCommand("OpenHowToPlayDialog","bHidePanel");
         break;
      case "Controller":
         _global.MainMenuAPI.BasePanelRunCommand("OpenControllerDialog","bHidePanel");
         break;
      case "Settings":
         _global.MainMenuAPI.BasePanelRunCommand("OpenSettingsDialog","bHidePanel");
         break;
      case "Options":
         _global.MainMenuAPI.BasePanelRunCommand("OpenOptionsDialog","bHidePanel");
         break;
      case "Mouse":
         _global.MainMenuAPI.BasePanelRunCommand("OpenMouseDialog","bHidePanel");
         break;
      case "Video":
         _global.MainMenuAPI.BasePanelRunCommand("OpenVideoSettingsDialog","bHidePanel");
         break;
      case "Audio":
         _global.MainMenuAPI.BasePanelRunCommand("OpenAudioSettingsDialog","bHidePanel");
         break;
      case "Credits":
         this._visible = false;
         _global.MainMenuAPI.BasePanelRunCommand("PlayCreditsVideo","bHidePanel");
         break;
      case "Leaderboards":
         _global.MainMenuAPI.BasePanelRunCommand("OpenLeaderboardsDialog","bHidePanel");
         break;
      case "Awards":
         _global.MainMenuAPI.BasePanelRunCommand("OpenAchievementsBlade","bHidePanel");
         break;
      case "Medals":
         _global.MainMenuAPI.BasePanelRunCommand("OpenMedalsDialog","bHidePanel");
         break;
      case "Stats":
         _global.MainMenuAPI.BasePanelRunCommand("OpenStatsDialog","bHidePanel");
         break;
      case "OffGuides":
         var _loc4_ = _global.CScaleformComponent_SteamOverlay.GetAppID();
         var _loc3_ = _global.CScaleformComponent_SteamOverlay.GetSteamCommunityURL();
         if(_global.CScaleformComponent_SteamOverlay.IsEnabled())
         {
            _global.CScaleformComponent_SteamOverlay.OpenURL(_loc3_ + "/profiles/76561198082857351/myworkshopfiles/?section=guides&appid=" + _loc4_);
         }
         else
         {
            _global.CScaleformComponent_SteamOverlay.OpenExternalBrowserURL(_loc3_ + "/profiles/76561198082857351/myworkshopfiles/?section=guides&appid=" + _loc4_);
         }
         break;
      case "UserGuides":
         _loc4_ = _global.CScaleformComponent_SteamOverlay.GetAppID();
         _loc3_ = _global.CScaleformComponent_SteamOverlay.GetSteamCommunityURL();
         if(_global.CScaleformComponent_SteamOverlay.IsEnabled())
         {
            _global.CScaleformComponent_SteamOverlay.OpenURL(_loc3_ + "/app/" + _loc4_ + "/guides/");
         }
         else
         {
            _global.CScaleformComponent_SteamOverlay.OpenExternalBrowserURL(_loc3_ + "/app/" + _loc4_ + "/guides/");
         }
         break;
      case "TrainMaps":
         _global.MainMenuAPI.BasePanelRunCommand("OpenCreateTrainingGameDialog","bHidePanel");
         break;
      case "Training":
         _global.MainMenuAPI.LaunchTraining();
   }
}
function PollLobbyIsClosed(strMenu)
{
   if(!_global.LobbyMovie.bModalPrompt && _global.LobbyMovie._visible == true)
   {
      clearInterval(LobbyInterval);
   }
   else if(!_global.LobbyMovie)
   {
      if(strMenu == "home")
      {
         OnHomePressed();
      }
      else if(strMenu == "Inventory")
      {
         OnInventoryPressed();
      }
      else if(strMenu == "Watch")
      {
         OnWatchPressed();
      }
      else
      {
         OpenMenu(strMenu);
      }
      clearInterval(LobbyInterval);
   }
}
function OnInventoryPressed()
{
   if(_global.LobbyMovie)
   {
      _global.LobbyMovie.ShowInventory();
      return undefined;
   }
   if(CloseAnyOpenMenus())
   {
      LobbyInterval = setInterval(PollLobbyIsClosed,50,"Inventory");
      return undefined;
   }
   _global.MainMenuMovie.HideWarningOverwatchPanel();
   _global.MainMenuMovie.ShowPanelsWhenInInventory();
   _global.MainMenuMovie.Panel.InventoryPanel.InitInventoryPanelMaster();
}
function OnWatchPressed(bShowLive)
{
   if(CloseAnyOpenMenus())
   {
      LobbyInterval = setInterval(PollLobbyIsClosed,50,"Watch");
      return undefined;
   }
   _global.MainMenuMovie.HideFloatingPanels();
   _global.MainMenuMovie.Panel.WatchPanel.InitWatchPanel(bShowLive);
}
function OnQuitGamePressed()
{
   var _loc2_ = _global.MainMenuMovie.Panel.TooltipItemPreview;
   _loc2_.ShowHidePreview(false);
   if(_global.LobbyMovie)
   {
      _global.RemoveElement(_global.SinglePlayerMovie);
   }
   MainMenuTopBar.QuitButton.gotoAndStop(1);
   _global.MainMenuAPI.BasePanelRunCommand("Quit","false");
}
function OnHomePressed()
{
   if(CloseAnyOpenMenus())
   {
      LobbyInterval = setInterval(PollLobbyIsClosed,50,"home");
      return undefined;
   }
   m_bMenuIsOpen = false;
   _global.MainMenuMovie.ShowFloatingPanels();
}
function OnAlertButtonPressed()
{
   _global.MainMenuMovie.CheckForUnacknowlegedGameAlerts();
   var _loc2_ = _global.CScaleformComponent_News.GetCurrentActiveSurveyID();
   var _loc3_ = _global.CScaleformComponent_News.GetMySurveyVote();
   if(_loc2_ == 20140122 && _loc3_ == 0)
   {
      _global.MainMenuMovie.Panel.MapVotePanel.ShowPanel("MapVote");
   }
   else if(_loc2_ == 20140900 && _loc3_ == 1)
   {
      _global.MainMenuMovie.Panel.MapVotePanel.ShowPanel("CZupdate");
   }
}
function ShowNewGameAlert()
{
   var _loc2_ = 0;
   var _loc3_ = _global.CScaleformComponent_News.GetCurrentActiveSurveyID();
   var _loc4_ = _global.CScaleformComponent_News.GetMySurveyVote();
   if(_loc3_ == 20140122 && _loc4_ == 0)
   {
      _loc2_ = 1;
      ShowGameAlerts(_loc2_);
   }
   else if(_loc3_ == 20140900 && _loc4_ == 1)
   {
      _loc2_ = 1;
      ShowGameAlerts(_loc2_);
      if(!_global.MainMenuMovie.Panel.MapVotePanel._visible)
      {
         _global.MainMenuMovie.Panel.MapVotePanel.ShowPanel("CZupdate");
      }
   }
   else
   {
      MainMenuTopBar.AlertButton._visible = false;
      MainMenuTopBar.GameAlertAlert._visible = false;
      MainMenuTopBar.AlertButton.setDisabled(true);
      MainMenuTopBar.gotoAndStop("HiddenAlertsButton");
      trace("----------AlertButton.setDisabled = true ");
   }
}
function ShowGameAlerts(nNumAlerts)
{
   MainMenuTopBar.AlertButton._visible = true;
   MainMenuTopBar.AlertButton.setDisabled(false);
   trace("----------AlertButton.setDisabled = false ");
   var _loc1_ = nNumAlerts + "";
   MainMenuTopBar.GameAlertAlert._visible = true;
   MainMenuTopBar.GameAlertAlert.Text.htmlText = _loc1_;
   MainMenuTopBar.gotoAndStop("VisibleAlertsButton");
}
function ShowNewItemAlert()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemsCount();
   if(_loc3_ > 0)
   {
      var _loc2_ = "";
      if(_loc3_ < 2)
      {
         _loc2_ = _global.GameInterface.Translate("#SFUI_MainMenu_New_Items_Alerts");
      }
      else
      {
         _loc2_ = _global.GameInterface.Translate("#SFUI_MainMenu_New_Items_Alerts_Plural");
      }
      MainMenuTopBar.NewItemsAlert._visible = true;
      _loc2_ = _global.ConstructString(_loc2_,_loc3_);
      MainMenuTopBar.NewItemsAlert.Text.htmlText = _loc2_;
   }
   else
   {
      MainMenuTopBar.NewItemsAlert._visible = false;
   }
}
function HideNewItemAlert()
{
   MainMenuTopBar.NewItemsAlert._visible = false;
}
function ShowLiveMatchAlert()
{
   var _loc3_ = _global.CScaleformComponent_News.GetActiveTournamentEventID();
   var _loc2_ = "tournament:" + _loc3_;
   if(GetMatchList("live") || GetMatchList(_loc2_))
   {
      MainMenuTopBar.LiveMatchAlert._visible = true;
      MainMenuTopBar.LiveMatchAlert.Text.htmlText = "#SFUI_MainMenu_Live_Tournament_Alert";
      _global.AutosizeTextDown(MainMenuTopBar.LiveMatchAlert.Text,10);
      return undefined;
   }
   MainMenuTopBar.LiveMatchAlert._visible = false;
}
function GetMatchList(strListerType)
{
   if(_global.CScaleformComponent_MatchList.GetCount(strListerType) != undefined)
   {
      var _loc6_ = _global.CScaleformComponent_MatchList.GetCount(strListerType);
      if(_loc6_ > 0)
      {
         var _loc3_ = 0;
         while(_loc3_ < _loc6_)
         {
            var _loc4_ = _global.CScaleformComponent_MatchList.GetMatchByIndex(strListerType,_loc3_);
            var _loc2_ = _global.CScaleformComponent_MatchInfo.GetMatchTournamentName(_loc4_);
            var _loc5_ = _global.CScaleformComponent_MatchInfo.GetMatchState(_loc4_);
            if(_loc2_ != "" && _loc2_ != null && _loc2_ != undefined && _loc5_ == "live")
            {
               return true;
            }
            _loc3_ = _loc3_ + 1;
         }
      }
      return false;
   }
   return false;
}
function HideLiveMatchAlert()
{
   MainMenuTopBar.LiveMatchAlert._visible = false;
}
function EnableDisablePlayCatagory(bIsDisabled)
{
}
function IsMenuOpen()
{
   if(_global.LobbyMovie || _global.SinglePlayerMovie || _global.MedalStatsScreenMovie || _global.LeaderBoardsMovie || _global.OptionsMovie)
   {
      return true;
   }
   if(_global.MainMenuMovie.Panel.InventoryPanel._visible || _global.MainMenuMovie.Panel.WatchPanel._visible || _global.MainMenuMovie.Panel.Guides._visible)
   {
      return true;
   }
   return false;
}
function IsQuitSelected()
{
   if(objSelectedButton == MainMenuTopBar.QuitButton)
   {
      return true;
   }
   return false;
}
function ResetSeletedButton()
{
   objSelectedButton = null;
}
function ExecClientCmd(szCommand)
{
   trace("ExecClientCmd: " + szCommand);
   _global.MainMenuAPI.ExecClientCmd(szCommand);
}
function onHide()
{
   gotoAndStop("Hide");
}
function onHideImmediate()
{
   gotoAndStop("Hide");
}
var strCurrentMenu = "";
var lastHighlight = null;
var DownloadButton = undefined;
var objSelectedButton = null;
var m_bMenuIsOpen = false;
PlayDropdown._visible = false;
LearnDropdown._visible = false;
AwardsDropdown._visible = false;
OptionsDropdown._visible = false;
this.stop();
