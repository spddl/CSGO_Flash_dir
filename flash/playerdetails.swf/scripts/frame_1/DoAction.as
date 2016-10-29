_global.PlayerDetailsMovie = this;
_global.PlayerDetailsAPI = gameAPI;
var avatarSize;
var m_selectedPlayerIndex = -1;
var m_selectedPlayerXuid = "";
var bHasPrevCommendation = false;
var bCommendationResponseFailed = false;
var bAskedServersForCommendation = false;
var bHasChangedCommendations = false;
var bIsServerReport = false;
var srtServerName = "";
var _feedbackReportArray = new Array();
var _feedbackCommendArray = new Array();
function InitConfirmNav()
{
   navConfirm.DenyInputToGame(true);
   navConfirm.ShowCursor(true);
   playerDetailsNav.AddTabOrder([Panel.SubmittedPanel.SubmitOkButton]);
   navConfirm.SetInitialHighlight(Panel.SubmittedPanel.SubmitOkButton);
   playerDetailsNav.AddKeyHandlerTable({onDown:function(button, control, keycode)
   {
      HideFromScript();
   }},"KEY_ENTER");
}
function InitPlayerDetailsNav()
{
   playerDetailsNav.DenyInputToGame(true);
   playerDetailsNav.ShowCursor(true);
   playerDetailsNav.AddTabOrder([Panel.ViewProfile,Panel.MutePlayer,Panel.CommendTabButton,Panel.ReportTabButton]);
   playerDetailsNav.SetInitialHighlight(Panel.MutePlayer);
   playerDetailsNav.AddNavForObject(Panel.ViewProfile,{UP:Panel.ReportTabButton,DOWN:Panel.MutePlayer});
   playerDetailsNav.AddNavForObject(Panel.MutePlayer,{UP:Panel.ViewProfile,DOWN:Panel.CommendTabButton});
   playerDetailsNav.AddNavForObject(Panel.CommendTabButton,{UP:Panel.MutePlayer,DOWN:Panel.ReportTabButton});
   playerDetailsNav.AddNavForObject(Panel.ReportTabButton,{UP:Panel.CommendTabButton,DOWN:Panel.ViewProfile});
   playerDetailsNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
   {
      HideFromScript();
   },onUp:function(button, control, keycode)
   {
      return true;
   }}});
}
function InitNavCommend()
{
   navCommend.DenyInputToGame(true);
   navCommend.ShowCursor(true);
   navCommend.AddTabOrder([Panel.CommendPanel.Button_Friendly,Panel.CommendPanel.Button_Teacher,Panel.CommendPanel.Button_Leader,Panel.Cancel,Panel.Accept]);
   navCommend.SetInitialHighlight(Panel.CommendPanel.Button_Friendly);
   navCommend.AddNavForObject(Panel.CommendPanel.Button_Friendly,{UP:Panel.Accept,DOWN:Panel.CommendPanel.Button_Teacher});
   navCommend.AddNavForObject(Panel.CommendPanel.Button_Teacher,{UP:Panel.CommendPanel.Button_Friendly,DOWN:Panel.CommendPanel.Button_Leader});
   navCommend.AddNavForObject(Panel.CommendPanel.Button_Leader,{UP:Panel.CommendPanel.Button_Teacher,DOWN:Panel.Cancel});
   navCommend.AddNavForObject(Panel.Cancel,{UP:Panel.CommendPanel.Button_Teacher,DOWN:Panel.Accept});
   navCommend.AddNavForObject(Panel.Accept,{UP:Panel.Cancel,DOWN:Panel.CommendPanel.Button_Friendly});
   navCommend.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
   {
      InitPlayerDetailsSelection();
   },onUp:function(button, control, keycode)
   {
      return true;
   }}});
}
function InitNavReport()
{
   navReport.DenyInputToGame(true);
   navReport.ShowCursor(true);
   navReport.AddTabOrder([Panel.ReportPanel.Button_AbusiveText,Panel.ReportPanel.Button_AbusiveVoice,Panel.ReportPanel.Button_Griefing,Panel.ReportPanel.Button_SpeedHack,Panel.ReportPanel.Button_WallHack,Panel.ReportPanel.Button_AimHack,Panel.Cancel,Panel.Accept]);
   navReport.SetInitialHighlight(Panel.ReportPanel.Button_AbusiveText);
   navReport.AddNavForObject(Panel.ReportPanel.Button_AbusiveText,{UP:Panel.Accept,DOWN:Panel.ReportPanel.Button_AbusiveVoice});
   navReport.AddNavForObject(Panel.ReportPanel.Button_AbusiveVoice,{UP:Panel.ReportPanel.Button_AbusiveText,DOWN:Panel.ReportPanel.Button_Griefing});
   navReport.AddNavForObject(Panel.ReportPanel.Button_Griefing,{UP:Panel.ReportPanel.Button_AbusiveVoice,DOWN:Panel.ReportPanel.Button_SpeedHack});
   navReport.AddNavForObject(Panel.ReportPanel.Button_SpeedHack,{UP:Panel.ReportPanel.Button_Griefing,DOWN:Panel.ReportPanel.Button_WallHack});
   navReport.AddNavForObject(Panel.ReportPanel.Button_WallHack,{UP:Panel.Button_SpeedHack,DOWN:Pane.Button_AimHack});
   navReport.AddNavForObject(Panel.Button_AimHack,{UP:Panel.Button_WallHack,DOWN:Panel.Cancel});
   navReport.AddNavForObject(Panel.Cancel,{UP:Panel.Button_AimHack,DOWN:Panel.Accept});
   navReport.AddNavForObject(Panel.Accept,{UP:Panel.Cancel,DOWN:Panel.Button_AbusiveText});
   navReport.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
   {
      InitPlayerDetailsSelection();
   },onUp:function(button, control, keycode)
   {
      return true;
   }}});
}
function onResize(rm)
{
   rm.ResetPosition(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.ALIGN_CENTER);
}
function showPanel()
{
   Panel._visible = true;
   _global.navManager.PushLayout(playerDetailsNav,"playerDetailsNav");
   Panel.gotoAndStop("ProfileBasic");
   Panel.ReportPanel._visible = false;
   Panel.CommendPanel._visible = false;
   Panel.ServerReportPanel._visible = false;
   Panel.Cancel.setDisabled(false);
   Panel.Cancel._visible = true;
   Panel.Accept.ButtonText.SetText("#SFUI_Accept");
   Panel.Accept.setDisabled(true);
   Panel.Accept._visible = false;
   Panel.SubmittedPanel._visible = false;
   bHasChangedCommendations = false;
   var _loc2_ = gameAPI.IsCommendationAvailable();
   if(gameAPI.IsSelectedPlayerMuted())
   {
      Panel.MutePlayer.ButtonText.SetText("#SFUI_PlayerDetails_Mute");
      Panel.MutePlayer.Selected._visible = true;
   }
   else
   {
      Panel.MutePlayer.ButtonText.SetText("#SFUI_PlayerDetails_Mute");
      Panel.MutePlayer.Selected._visible = false;
   }
   Panel.PlayerProfile.IsPlayerDetailsVisible(true);
}
function HideFromScript()
{
   gameAPI.HideFromScript();
   trace("------------------------------HIDE-------------");
}
function hidePanel()
{
   _global.navManager.RemoveLayout(playerDetailsNav);
   _global.navManager.RemoveLayout(navCommend);
   _global.navManager.RemoveLayout(navReport);
   _global.navManager.RemoveLayout(navConfirm);
   Panel._visible = false;
   _feedbackReportArray.length = 0;
   _feedbackReportArray = [];
   _feedbackCommendArray.length = 0;
   _feedbackCommendArray = [];
   Panel.CommendTabButton.Selected._visible = false;
   Panel.ReportTabButton.Selected._visible = false;
   Panel.CommendPanel.Button_Friendly.Selected._visible = false;
   Panel.CommendPanel.Button_Teacher.Selected._visible = false;
   Panel.CommendPanel.Button_Leader.Selected._visible = false;
   Panel.ReportPanel.Button_AbusiveText.Selected._visible = false;
   Panel.ReportPanel.Button_AbusiveVoice.Selected._visible = false;
   Panel.ReportPanel.Button_Griefing.Selected._visible = false;
   Panel.ReportPanel.Button_SpeedHack.Selected._visible = false;
   Panel.ReportPanel.Button_WallHack.Selected._visible = false;
   Panel.ReportPanel.Button_AimHack.Selected._visible = false;
   Panel.PlayerProfile.IsPlayerDetailsVisible(false);
}
function onUnload(mc)
{
   _global.PlayerDetailsMovie = null;
   _global.PlayerDetailsAPI = null;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   return true;
}
function onLoaded()
{
   InitPlayerDetailsNav();
   SetUpButtons();
   gameAPI.OnReady();
}
function ScaleformComponent_MyPersona_MedalsChanged()
{
   Panel.PlayerProfile.GetMedalsInfo();
}
function ScaleformComponent_MyPersona_NameChanged()
{
   Panel.PlayerProfile.SetPlayerData();
}
function ScaleformComponent_Device_Reset()
{
   Panel.PlayerProfile.RefreshAvatarImage();
}
function ScaleformComponent_FriendsList_ProfileUpdated()
{
   Panel.PlayerProfile.InitPlayerProfile(m_selectedPlayerXuid);
}
function InitPlayerDetailsSelection()
{
   _global.navManager.RemoveLayout(navCommend);
   _global.navManager.RemoveLayout(navReport);
   InitNavCommend();
   _global.navManager.PushLayout(playerDetailsNav,"playerDetailsNav");
}
function InitCommendSelection()
{
   _global.navManager.RemoveLayout(playerDetailsNav);
   _global.navManager.RemoveLayout(navReport);
   InitNavCommend();
   _global.navManager.PushLayout(navCommend,"navCommend");
}
function InitReportSelection()
{
   _global.navManager.RemoveLayout(navCommend);
   _global.navManager.RemoveLayout(playerDetailsNav);
   InitNavReport();
   _global.navManager.PushLayout(navReport,"navReport");
}
function InitConfirmSelection()
{
   _global.navManager.RemoveLayout(navCommend);
   _global.navManager.RemoveLayout(navReport);
   _global.navManager.RemoveLayout(playerDetailsNav);
   InitConfirmNav();
   _global.navManager.PushLayout(navConfirm,"navConfirm");
}
function InitFeedbackButton(type, mcButton)
{
   mcButton.Selected._visible = false;
   mcButton.type = type;
   mcButton.RolledOver = function()
   {
      this.Focus(true);
   };
   mcButton.Action = function()
   {
      ToggleSelectFeedback(this);
   };
}
function SetUpButtons()
{
   Panel.ViewProfile.ButtonText.SetText("#SFUI_PlayerDetails_Profile");
   Panel.Trade.ButtonText.SetText("#SFUI_PlayerDetails_Trade");
   Panel.MutePlayer.ButtonText.SetText("#SFUI_PlayerDetails_Mute");
   Panel.CommendTabButton.Action = OpenCommendTab;
   Panel.ReportTabButton.Action = OpenReportTab;
   Panel.CommendTabButton.ButtonText.SetText("#SFUI_PlayerDetails_Commend");
   Panel.ReportTabButton.ButtonText.SetText("#SFUI_PlayerDetails_Report");
   Panel.ReportTabButton.setDisabled(false);
   Panel.CommendTabButton.setDisabled(false);
   Panel.Cancel.Action = function()
   {
      HideFromScript();
   };
   Panel.Accept.Action = SubmitFeedback;
   Panel.ViewProfile.Action = ShowPlayerProfile;
   Panel.Trade.Action = ShowPlayerTrade;
   Panel.MutePlayer.Action = ToggleMuteOnPlayer;
   InitFeedbackButton("friendly",Panel.CommendPanel.Button_Friendly);
   InitFeedbackButton("teaching",Panel.CommendPanel.Button_Teacher);
   InitFeedbackButton("leader",Panel.CommendPanel.Button_Leader);
   InitFeedbackButton("textabuse",Panel.ReportPanel.Button_AbusiveText);
   InitFeedbackButton("voiceabuse",Panel.ReportPanel.Button_AbusiveVoice);
   InitFeedbackButton("grief",Panel.ReportPanel.Button_Griefing);
   InitFeedbackButton("speedhack",Panel.ReportPanel.Button_SpeedHack);
   InitFeedbackButton("wallhack",Panel.ReportPanel.Button_WallHack);
   InitFeedbackButton("aimbot",Panel.ReportPanel.Button_AimHack);
   InitFeedbackButton("perf",Panel.ServerReportPanel.Button_PoorPerf);
   InitFeedbackButton("models",Panel.ServerReportPanel.Button_AbusiveModels);
   InitFeedbackButton("motd",Panel.ServerReportPanel.Button_Motd);
   InitFeedbackButton("listing",Panel.ServerReportPanel.Button_Listing);
   InitFeedbackButton("inventory",Panel.ServerReportPanel.Button_Inventory);
   Panel.CommendPanel.LoadingPanel.Loading._visible = false;
   Panel.CommendPanel.LoadingPanel.FailedLoading._visible = false;
   Panel.SubmittedPanel.SubmitOkButton.ButtonText.SetText("#SFUI_PlayerDetails_Ok");
   Panel.SubmittedPanel.SubmitOkButton.setDisabled(false);
   Panel.SubmittedPanel.SubmitOkButton.Action = HideFromScript;
   Panel.SubmittedPanel._visible = false;
}
function ToggleSelectFeedback(button)
{
   var _loc2_ = true;
   if(Panel.ReportPanel._visible || Panel.ServerReportPanel._visible)
   {
      _loc2_ = false;
   }
   if(button.Selected._visible)
   {
      button.Selected._visible = false;
      if(_loc2_)
      {
         RemoveFeedbackFromArray(_feedbackCommendArray,button.type);
         bHasChangedCommendations = true;
      }
      else
      {
         RemoveFeedbackFromArray(_feedbackReportArray,button.type);
      }
      trace(">>>>>>>>> RemoveFeedbackFromArray ");
   }
   else
   {
      button.Selected._visible = true;
      if(_loc2_)
      {
         AddFeedbackToArray(_feedbackCommendArray,button.type);
         bHasChangedCommendations = true;
      }
      else
      {
         AddFeedbackToArray(_feedbackReportArray,button.type);
      }
      trace(">>>>>>>>> AddFeedbackToArray ");
   }
   UpdateAcceptButton();
}
function AddFeedbackToArray(theArray, type)
{
   var _loc2_ = theArray.length;
   var _loc1_ = undefined;
   _loc1_ = 0;
   while(_loc1_ < _loc2_)
   {
      if(theArray[_loc1_] == type)
      {
         return undefined;
      }
      _loc1_ = _loc1_ + 1;
   }
   theArray.push(type);
   trace(">>>>>>>>>>>>>> Adding " + type);
}
function RemoveFeedbackFromArray(theArray, type)
{
   var _loc3_ = theArray.length;
   var _loc1_ = undefined;
   _loc1_ = 0;
   while(_loc1_ < _loc3_)
   {
      if(theArray[_loc1_] == type)
      {
         trace(">>>>>>>>>>>>>> Removing " + type);
         if(_loc1_ == 0)
         {
            theArray.shift();
         }
         else if(_loc1_ == _loc3_ - 1)
         {
            theArray.pop();
         }
         else
         {
            theArray = theArray.slice(0,_loc1_).concat(theArray.slice(_loc1_ + 1,_loc3_));
         }
         return undefined;
      }
      _loc1_ = _loc1_ + 1;
   }
}
function UpdateAcceptButton()
{
   if(Panel.ReportPanel._visible == false && Panel.CommendPanel._visible == false && Panel.ServerName._visible == false)
   {
      Panel.Accept._visible = false;
      Panel.Accept.setDisabled(false);
      return undefined;
   }
   Panel.Accept._visible = true;
   var _loc1_ = 0;
   if(Panel.ReportPanel._visible || Panel.ServerReportPanel._visible)
   {
      _loc1_ = _feedbackReportArray.length;
   }
   else
   {
      _loc1_ = _feedbackCommendArray.length;
   }
   if(numTokens == 0 && Panel.CommendPanel._visible)
   {
      Panel.Accept.setDisabled(true);
   }
   else if(Panel.CommendPanel._visible && bHasPrevCommendation)
   {
      if(!bHasChangedCommendations)
      {
         Panel.Accept.setDisabled(true);
      }
      else
      {
         Panel.Accept.setDisabled(false);
      }
   }
   else
   {
      Panel.Accept.setDisabled(_loc1_ <= 0);
   }
}
function ShowPlayerProfile()
{
   PlayerDetailsAPI.ShowGamerCard();
}
function ShowPlayerTrade()
{
   _global.CScaleformComponent_SteamOverlay.StartTradeWithUser(m_selectedPlayerXuid);
}
function ToggleMuteOnPlayer()
{
   if(gameAPI.IsSelectedPlayerMuted())
   {
      Panel.MutePlayer.ButtonText.SetText("#SFUI_PlayerDetails_Mute");
      Panel.MutePlayer.Selected._visible = false;
   }
   else
   {
      Panel.MutePlayer.ButtonText.SetText("#SFUI_PlayerDetails_Mute");
      Panel.MutePlayer.Selected._visible = true;
   }
   PlayerDetailsAPI.ToggleMute();
}
function ShowAvatar(xuid, playerNameText, bIsSelf, bIsFriend, strPanelType)
{
   var _loc5_ = PlayerDetailsAPI.IsLocalPlayerPlayingMatch();
   var _loc6_ = _global.CScaleformComponent_FriendsList.IsFriendPlayingCSGO(xuid);
   var _loc2_ = _global.CScaleformComponent_MyPersona.GetLauncherType() != "perfectworld"?false:true;
   m_selectedPlayerXuid = xuid;
   Panel.SubmittedPanel.NameText.Text.htmlText = playerNameText;
   if(m_selectedPlayerXuid == _global.CScaleformComponent_MyPersona.GetXuid())
   {
      strPanelType = "ProfileBasic";
   }
   trace("--------------------------------------------strPanelType---------------------------strPanelType:" + strPanelType);
   Panel.CommendTabButton._visible = false;
   Panel.ReportTabButton._visible = false;
   Panel.PlayerProfile._visible = false;
   Panel.SubmittedPanel.NameText._visible = false;
   Panel.ServerName._visible = false;
   Panel.SubmittedPanel.ServerNameText._visible = false;
   Panel.Accept._visible = false;
   Panel.PlayerProfile._visible = false;
   Panel.ViewProfile._visible = !_loc2_;
   Panel.ServerReportPanel._visible = false;
   Panel.ReportTabButton.setDisabled(false);
   Panel.CommendTabButton.setDisabled(false);
   Panel.MutePlayer._visible = !bIsSelf && _loc5_;
   Panel.Trade.setDisabled(bIsSelf);
   switch(strPanelType)
   {
      case "SpectatorProfile":
         Panel.PlayerProfile._visible = true;
         Panel.Accept._visible = true;
         Panel.CommendTabButton._visible = true;
         Panel.ReportTabButton._visible = true;
         Panel.SubmittedPanel.NameText._visible = true;
         Panel.PlayerProfile.InitPlayerProfile(xuid);
         Panel.Trade._visible = true && !_loc2_;
         OpenCommendTab();
         break;
      case "ProfileCommend":
         Panel.PlayerProfile._visible = true;
         Panel.Accept._visible = true;
         Panel.CommendTabButton._visible = true;
         Panel.ReportTabButton._visible = true;
         Panel.SubmittedPanel.NameText._visible = true;
         Panel.Trade._visible = true && !_loc2_;
         Panel.PlayerProfile.InitPlayerProfile(xuid);
         OpenCommendTab();
         break;
      case "ProfileReport":
         Panel.PlayerProfile._visible = true;
         Panel.Accept._visible = true;
         Panel.CommendTabButton._visible = true;
         Panel.ReportTabButton._visible = true;
         Panel.SubmittedPanel.NameText._visible = true;
         Panel.Trade._visible = true && !_loc2_;
         Panel.PlayerProfile.InitPlayerProfile(xuid);
         OpenReportTab();
         break;
      case "ServerReport":
         srtServerName = gameAPI.GetServerName();
         trace("----->GetServerName: " + srtServerName);
         if(srtServerName != "")
         {
            Panel.ServerName.Name_Text.Text.htmlText = srtServerName;
            Panel.SubmittedPanel.ServerNameText.Text.htmlText = srtServerName;
            Panel.SubmittedPanel.ServerNameText._visible = true;
         }
         Panel.ServerName._visible = true;
         Panel.ServerReportPanel._visible = true;
         Panel.Accept._visible = true;
         Panel.ViewProfile._visible = false;
         Panel.MutePlayer._visible = false;
         Panel.Trade._visible = false;
         OpenServerReportTab();
         break;
      default:
         Panel.PlayerProfile.InitPlayerProfile(xuid);
         Panel.PlayerProfile._visible = true;
         Panel.Trade._visible = !_loc2_;
   }
   Panel.gotoAndStop(strPanelType);
}
function onLoadInit(movieClip)
{
   movieClip._x = avatarSize.x;
   movieClip._y = avatarSize.y;
   movieClip._width = avatarSize.width;
   movieClip._height = avatarSize.height;
}
function OpenCommendTab()
{
   InitCommendSelection();
   Panel.ReportPanel._visible = false;
   Panel.CommendPanel._visible = true;
   Panel.ReportTabButton.Selected._visible = false;
   Panel.CommendTabButton.Selected._visible = true;
   Panel.gotoAndStop("ProfileCommend");
   Panel.CommendPanel.Button_Friendly.ButtonText.SetText("#SFUI_PlayerDetails_IsFriendly");
   Panel.CommendPanel.Button_Teacher.ButtonText.SetText("#SFUI_PlayerDetails_GoodTeacher");
   Panel.CommendPanel.Button_Leader.ButtonText.SetText("#SFUI_PlayerDetails_GoodLeader");
   _feedbackReportArray.length = 0;
   _feedbackReportArray = [];
   CheckAndShowPreviousCommends();
}
function CheckAndShowPreviousCommends()
{
   bAskedServersForCommendation = gameAPI.QueryServersForCommendation();
   if(bAskedServersForCommendation)
   {
      bCommendationResponseFailed = false;
      Panel.CommendPanel.LoadingPanel._visible = false;
      var _loc2_ = gameAPI.GetCommendationFlags();
      var _loc3_ = gameAPI.GetCommendationTokensAvailable();
      if(_loc3_ == 0)
      {
         Panel.CommendPanel.CommendHint.Text.htmlText = "#SFUI_PlayerDetails_NoCommendations_Left";
         Panel.CommendPanel.CommendHint._visible = true;
         Panel.CommendPanel.CommendUpdateHint._visible = false;
      }
      else if(_loc2_ != "")
      {
         Panel.CommendPanel.CommendHint.Text.htmlText = "#SFUI_PlayerDetails_Previously_Submitted";
         Panel.CommendPanel.CommendHint._visible = true;
         Panel.CommendPanel.CommendUpdateHint._visible = true;
         _feedbackCommendArray = _loc2_.split(",");
         bHasPrevCommendation = true;
      }
      else
      {
         customStr = _global.GameInterface.Translate("#SFUI_PlayerDetails_Commendations_Left");
         customStr = _global.ConstructString(customStr,_loc3_);
         Panel.CommendPanel.CommendHint.Text.htmlText = customStr;
         Panel.CommendPanel.CommendHint._visible = true;
         Panel.CommendPanel.CommendUpdateHint._visible = false;
         bHasPrevCommendation = false;
      }
      Panel.CommendPanel.Button_Friendly.Selected._visible = _loc2_.indexOf("friendly") != -1;
      Panel.CommendPanel.Button_Friendly.setDisabled(_loc3_ == 0);
      Panel.CommendPanel.Button_Teacher.Selected._visible = _loc2_.indexOf("teaching") != -1;
      Panel.CommendPanel.Button_Teacher.setDisabled(_loc3_ == 0);
      Panel.CommendPanel.Button_Leader.Selected._visible = _loc2_.indexOf("leader") != -1;
      Panel.CommendPanel.Button_Leader.setDisabled(_loc3_ == 0);
      Panel.CommendPanel.Astrex_Friendly._visible = Panel.CommendPanel.Button_Friendly.Selected._visible;
      Panel.CommendPanel.Astrex_Teacher._visible = Panel.CommendPanel.Button_Teacher.Selected._visible;
      Panel.CommendPanel.Astrex_Leader._visible = Panel.CommendPanel.Button_Leader.Selected._visible;
   }
   else
   {
      if(!bCommendationResponseFailed)
      {
         Panel.CommendPanel.LoadingPanel.Loading._visible = true;
         Panel.CommendPanel.LoadingPanel.FailedLoading._visible = false;
         LoadingInterval = setInterval(CancelLoading,10000);
      }
      else
      {
         Panel.CommendPanel.LoadingPanel.Loading._visible = false;
         Panel.CommendPanel.LoadingPanel.FailedLoading._visible = true;
      }
      Panel.CommendPanel.Button_Friendly.setDisabled(true);
      Panel.CommendPanel.Button_Teacher.setDisabled(true);
      Panel.CommendPanel.Button_Leader.setDisabled(true);
      Panel.CommendPanel.Astrex_Friendly._visible = false;
      Panel.CommendPanel.Astrex_Teacher._visible = false;
      Panel.CommendPanel.Astrex_Leader._visible = false;
      Panel.CommendPanel.CommendHint._visible = false;
   }
   UpdateAcceptButton();
}
function CancelLoading()
{
   bCommendationResponseFailed = true;
   CheckAndShowPreviousCommends();
   clearInterval(LoadingInterval);
}
function NotifyCommendationResponseReceived()
{
   bCommendationResponseFailed = false;
   CheckAndShowPreviousCommends();
}
function NotifyCommendationResponseFailed()
{
   bCommendationResponseFailed = true;
   clearInterval(LoadingInterval);
   CheckAndShowPreviousCommends();
}
function OpenServerReportTab()
{
   InitReportSelection();
   Panel.gotoAndStop("ServerReport");
   _feedbackCommendArray.length = 0;
   _feedbackCommendArray = [];
   var _loc2_ = _global.CScaleformComponent_MatchStats.IsServerWhitelistedValveOfficial();
   Panel.ServerReportPanel.Button_PoorPerf.ButtonText.SetText("#SFUI_PlayerDetails_PoorPerf");
   Panel.ServerReportPanel.Button_PoorPerf.Selected._visible = false;
   Panel.ServerReportPanel.Button_PoorPerf.setDisabled(false);
   Panel.ServerReportPanel.Button_AbusiveModels.ButtonText.SetText("#SFUI_PlayerDetails_AbusiveModels");
   Panel.ServerReportPanel.Button_AbusiveModels.Selected._visible = false;
   Panel.ServerReportPanel.Button_AbusiveModels.setDisabled(_loc2_);
   Panel.ServerReportPanel.Button_Motd.ButtonText.SetText("#SFUI_PlayerDetails_Motd");
   Panel.ServerReportPanel.Button_Motd.Selected._visible = false;
   Panel.ServerReportPanel.Button_Motd.setDisabled(_loc2_);
   Panel.ServerReportPanel.Button_Listing.ButtonText.SetText("#SFUI_PlayerDetails_Listing");
   Panel.ServerReportPanel.Button_Listing.Selected._visible = false;
   Panel.ServerReportPanel.Button_Listing.setDisabled(_loc2_);
   Panel.ServerReportPanel.Button_Inventory.ButtonText.SetText("#SFUI_PlayerDetails_Inventory");
   Panel.ServerReportPanel.Button_Inventory.Selected._visible = false;
   Panel.ServerReportPanel.Button_Inventory.setDisabled(_loc2_);
   UpdateAcceptButton();
}
function OpenReportTab()
{
   InitReportSelection();
   Panel.gotoAndStop("ProfileReport");
   _feedbackCommendArray.length = 0;
   _feedbackCommendArray = [];
   Panel.ReportPanel._visible = true;
   Panel.CommendPanel._visible = false;
   Panel.ReportTabButton.Selected._visible = true;
   Panel.CommendTabButton.Selected._visible = false;
   Panel.ReportPanel.Button_AbusiveText.ButtonText.SetText("#SFUI_PlayerDetails_AbusiveTextChat");
   Panel.ReportPanel.Button_AbusiveText.Selected._visible = false;
   Panel.ReportPanel.Button_AbusiveText.setDisabled(false);
   Panel.ReportPanel.Button_AbusiveVoice.ButtonText.SetText("#SFUI_PlayerDetails_AbusiveVoiceChat");
   Panel.ReportPanel.Button_AbusiveVoice.Selected._visible = false;
   Panel.ReportPanel.Button_AbusiveVoice.setDisabled(false);
   Panel.ReportPanel.Button_Griefing.ButtonText.SetText("#SFUI_PlayerDetails_Griefing");
   Panel.ReportPanel.Button_Griefing.Selected._visible = false;
   var _loc1_ = gameAPI.IsReportCategoryEnabledForSelectedPlayer("grief");
   Panel.ReportPanel.Button_Griefing.setDisabled(!_loc1_);
   Panel.ReportPanel.Button_SpeedHack.ButtonText.SetText("#SFUI_PlayerDetails_SpeedHacking");
   Panel.ReportPanel.Button_SpeedHack.Selected._visible = false;
   Panel.ReportPanel.Button_SpeedHack.setDisabled(false);
   Panel.ReportPanel.Button_WallHack.ButtonText.SetText("#SFUI_PlayerDetails_WallHacking");
   Panel.ReportPanel.Button_WallHack.Selected._visible = false;
   Panel.ReportPanel.Button_WallHack.setDisabled(false);
   Panel.ReportPanel.Button_AimHack.ButtonText.SetText("#SFUI_PlayerDetails_AimHacking");
   Panel.ReportPanel.Button_AimHack.Selected._visible = false;
   Panel.ReportPanel.Button_AimHack.setDisabled(false);
   UpdateAcceptButton();
}
function SubmitFeedback()
{
   var _loc5_ = true;
   if(Panel.ReportPanel._visible || Panel.ServerReportPanel._visible)
   {
      _loc5_ = false;
   }
   if(_loc5_)
   {
      var _loc6_ = _feedbackCommendArray.length;
      if(_loc6_ >= 0)
      {
         var _loc2_ = "";
         _loc2_ = _feedbackCommendArray.join();
         gameAPI.SubmitCommendation(_loc2_);
         trace(">>>>>>>>> Sending _feedbackCommendArray ::::  " + _loc2_);
         Panel.SubmittedPanel.SubmitText.Text.htmlText = _global.GameInterface.Translate("#SFUI_PlayerDetails_SubmittedCommend");
      }
   }
   else if(Panel.ServerReportPanel._visible)
   {
      var _loc4_ = _feedbackReportArray.length;
      trace(">>>>>>>>> nNumReports =  " + _loc4_);
      if(_loc4_ > 0)
      {
         var _loc3_ = "";
         _loc3_ = _feedbackReportArray.join();
         gameAPI.SubmitServerReport(_loc3_);
         trace(">>>>>>>>> Sending Server _feedbackReportArray ::::  " + _loc3_);
         Panel.SubmittedPanel.SubmitText.Text.htmlText = _global.GameInterface.Translate("#SFUI_PlayerDetails_SubmittedReport");
      }
   }
   else
   {
      _loc4_ = _feedbackReportArray.length;
      trace(">>>>>>>>> nNumReports =  " + _loc4_);
      if(_loc4_ > 0)
      {
         _loc3_ = "";
         _loc3_ = _feedbackReportArray.join();
         gameAPI.SubmitReport(_loc3_);
         trace(">>>>>>>>> Sending _feedbackReportArray ::::  " + _loc3_);
         Panel.SubmittedPanel.SubmitText.Text.htmlText = _global.GameInterface.Translate("#SFUI_PlayerDetails_SubmittedReport");
      }
   }
   Panel.SubmittedPanel.gotoAndPlay("StartAnim");
   Panel.SubmittedPanel._visible = true;
   Panel.ReportTabButton.setDisabled(true);
   Panel.CommendTabButton.setDisabled(true);
   Panel.Accept._visible = false;
   Panel.CommendPanel._visible = false;
   Panel.ReportPanel._visible = false;
   Panel.ServerReportPanel._visible = false;
   InitConfirmSelection();
}
if(_global.playerDetailsNav != undefined)
{
   return undefined;
}
var playerDetailsNav = new Lib.NavLayout();
var navCommend = new Lib.NavLayout();
var navReport = new Lib.NavLayout();
var navConfirm = new Lib.NavLayout();
_global.resizeManager.AddListener(this);
stop();
