function onShow()
{
   InventoryPanel._x = 24;
   InventoryPanel._visible = false;
   LoadoutBlack._visible = false;
   Close._visible = false;
   Close.dialog = this;
   Close.Action = function()
   {
      this.dialog.OnCloseLoadout();
   };
   if(lastHighlight == null)
   {
      pauseMenuNav.SetInitialHighlight(Button1);
   }
   else
   {
      pauseMenuNav.SetInitialHighlight(lastHighlight);
   }
   _global.navManager.PushLayout(pauseMenuNav,"pauseMenuNav");
   _global.PauseMenuMovie.Panel.NavToShow = this;
   _visible = true;
   MainMenuNav._visible = true;
}
function onHide()
{
   InventoryPanel.RemoveLayout();
   _global.navManager.RemoveLayout(pauseMenuNav);
   this._parent.TooltipItemPreview.ShowHidePreview(false);
   this._parent.TooltipItem._visible = false;
   this._parent.TooltipContextMenu._visible = false;
   _visible = false;
}
function TransitionToSubmenu()
{
   onHide();
   _global.PauseMenuMovie.Panel.SubMenuNavHelp.lastHighlight = null;
   _global.PauseMenuMovie.Panel.SubMenuNavHelp.onShow();
}
function BackToMain()
{
   _global.PauseMenuMovie.Panel.SubMenuNavHelp.onHide();
   onShow();
}
function OnResumePressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("ResumeGame","bCloseMenu");
}
function OnOpenLoadout()
{
   InventoryPanel.InitInventoryPanelMaster(false);
   InventoryPanel.MouseOver._visible = false;
   LoadoutBlack._visible = true;
   Close._visible = true;
   InventoryPanel.PushLayout();
}
function OnOpenLoadoutGift()
{
   InventoryPanel.InitInventoryPanelMaster(true);
   InventoryPanel.MouseOver._visible = false;
   LoadoutBlack._visible = true;
   Close._visible = true;
}
function OnCloseLoadout()
{
   InventoryPanel._visible = false;
   _global.CScaleformComponent_Inventory.LaunchWeaponPreviewPanel("");
   Close._visible = false;
   LoadoutBlack._visible = false;
   this._parent.TooltipItem._visible = false;
   this._parent.TooltipContextMenu._visible = false;
   InventoryPanel.RemoveLayout();
}
function LoadoutWarning()
{
   Loadout.SpawningWarning._visible = true;
   Loadout.SpawningWarning.gotoAndPlay("StartAnim");
}
function OnSwitchTeamsPressed()
{
   _global.PauseMenuAPI.SwitchTeams();
}
function OnInvitePressed()
{
   var _loc2_ = undefined;
   if(!_global.IsXbox())
   {
      _loc2_ = new Array({Name:"#SFUI_PauseMenu_InviteFriendsButton",Action:function()
      {
         OnInviteFriendsPressed();
      }});
   }
   else
   {
      _loc2_ = new Array({Name:"#SFUI_PauseMenu_InviteXboxLiveButton",Action:function()
      {
         OnInviteXboxLivePartyPressed();
      }},{Name:"#SFUI_PauseMenu_InviteFriendsButton",Action:function()
      {
         OnInviteFriendsPressed();
      }});
   }
   _global.PauseMenuMovie.Panel.SubMenuNavHelp.InitButtons("#SFUI_PauseMenu_InviteSubmenuTitle",_loc2_);
   TransitionToSubmenu();
}
function OnInviteXboxLivePartyPressed()
{
   if(!_global.IsPC())
   {
      _global.PauseMenuAPI.BasePanelRunCommand("ShowInvitePartyUI");
   }
   else
   {
      trace(" Invite Xbox Live Party Pressed");
   }
}
function OnInviteFriendsPressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("ShowInviteFriendsUI");
}
function OnLeaderboardsPressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenLeaderboardsDialog","bHideMenu");
}
function OnAchievementsPressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenAchievementsBlade");
   if(_global.IsPC())
   {
      trace(" Achievements Button Pressed");
   }
}
function OnMedalsPressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenMedalsDialog","bHideMenu");
}
function OnStatsPressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenStatsDialog","bHideMenu");
}
function OnCallVotePressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenCallVoteDialog","bHideMenu");
}
function OnHelpPressed()
{
   var _loc2_ = new Array();
   var _loc3_ = 0;
   if(_loc3_ == 0)
   {
      _loc2_.push({Name:"#SFUI_HelpMenu_HowToPlayButton",Action:function()
      {
         OnHowToPlayPressed();
      }});
   }
   _loc2_.push({Name:"#SFUI_HelpMenu_ControlsButton",Action:function()
   {
      OnControlsPressed();
   }});
   _loc2_.push({Name:"#SFUI_HelpMenu_SettingsButton",Action:function()
   {
      OnSettingsPressed();
   }});
   if(!_global.IsXbox())
   {
      _loc2_.push({Name:"#SFUI_HelpMenu_MouseKeyboardButton",Action:function()
      {
         OnOpenMouseDialog();
      }});
      if(_global.IsPS3())
      {
         _loc2_.push({Name:"#SFUI_HelpMenu_MotionControllerMove",Action:function()
         {
            OnOpenMotionControllerMoveDialog();
         }});
         _loc2_.push({Name:"#SFUI_HelpMenu_MotionControllerSharpshooter",Action:function()
         {
            OnOpenMotionControllerSharpshooterDialog();
         }});
      }
      else if(!_global.IsOSX())
      {
         _loc2_.push({Name:"#SFUI_HelpMenu_MotionController",Action:function()
         {
            OnOpenMotionControllerDialog();
         },Enabled:false});
      }
   }
   if(_global.IsPC())
   {
      _loc2_.push({Name:"#SFUI_HelpMenu_VideoSettings",Action:function()
      {
         OnOpenVideoSettingsDialog();
      }});
      _loc2_.push({Name:"#SFUI_HelpMenu_AudioSettings",Action:function()
      {
         OnOpenAudioSettingsDialog();
      }});
   }
   var _loc4_ = _global.PauseMenuMovie.Panel.SubMenuNavHelp;
   _loc4_.InitButtons("#SFUI_PauseMenu_HelpAndOptionsTitle",_loc2_);
   TransitionToSubmenu();
}
function OnHowToPlayPressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenHowToPlayDialog","bHideMenu");
}
function OnControlsPressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenControllerDialog","bHideMenu");
}
function OnSettingsPressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenSettingsDialog","bHideMenu");
}
function OnPCControlsSettingsPressed()
{
   if(_global.IsPC())
   {
      _global.PauseMenuAPI.BasePanelRunCommand("OpenOptionsDialog","bHideMenu");
   }
}
function OnOpenMouseDialog()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenMouseDialog","bHideMenu");
}
function OnOpenMotionControllerDialog()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenMotionControllerDialog","bHideMenu");
}
function OnOpenMotionControllerMoveDialog()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenMotionControllerMoveDialog","bHideMenu");
}
function OnOpenMotionControllerSharpshooterDialog()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenMotionControllerSharpshooterDialog","bHideMenu");
}
function OnOpenVideoSettingsDialog()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenVideoSettingsDialog","bHideMenu");
}
function OnOpenAudioSettingsDialog()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenAudioSettingsDialog","bHideMenu");
}
function OnExitGamePressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("Disconnect","bHideMenu");
}
function OnMyAwardsPressed()
{
   var _loc2_ = new Array();
   var _loc5_ = 0;
   _loc2_.push({Name:"#SFUI_MainMenu_StatsButton",Action:function()
   {
      OnStatsPressed();
   }});
   _loc2_.push({Name:"#SFUI_MainMenu_MedalButton",Action:function()
   {
      OnMedalsPressed();
   }});
   if(_global.IsXbox())
   {
      _loc2_.push({Name:"#SFUI_PauseMenu_AchievementsButton",Action:function()
      {
         OnAchievementsPressed();
      }});
   }
   var _loc3_ = _global.PauseMenuMovie.Panel.SubMenuNavHelp;
   _loc3_.InitButtons("#SFUI_MainMenu_My_Awards",_loc2_);
   TransitionToSubmenu();
}
function OnBrowseServersPressed()
{
   _global.PauseMenuAPI.BasePanelRunCommand("OpenServerBrowser","bHideMenu");
}
function OnInviteFriends()
{
   _global.CScaleformComponent_SteamOverlay.OpenInviteFriends();
}
function OnReportServerPressed()
{
   _global.PauseMenuAPI.OpenPlayerDetailsPanel(0,"ServerReport");
   _global.PauseMenuAPI.BasePanelRunCommand("ResumeGame","bCloseMenu");
}
function OnViewMapInWorkshop()
{
   _global.PauseMenuAPI.ViewMapInWorkshop();
   _global.PauseMenuAPI.BasePanelRunCommand("ResumeGame","bCloseMenu");
}
function UpdateInventoryButton()
{
   if(_global.CScaleformComponent_Loadout.IsLoadoutAllowed())
   {
      Button2.setDisabled(false);
   }
   else
   {
      Button2.setDisabled(true);
      if(_global.PauseMenuAPI.IsQueuedMatchmaking())
      {
         Button2.SetText("#SFUI_PauseMenu_OpenLoadout_Competitive");
      }
      else
      {
         Button2.SetText("#SFUI_PauseMenu_OpenLoadout_Disabled");
      }
   }
}
function DisableInventoryButton()
{
   if(_global.PauseMenuAPI.IsQueuedMatchmaking())
   {
      Button2.SetText("#SFUI_PauseMenu_OpenLoadout_Competitive");
   }
   else
   {
      Button2.SetText("#SFUI_PauseMenu_OpenLoadout_Disabled");
   }
   Button2.setDisabled(true);
}
function InitButtons()
{
   var _loc4_ = 1;
   var _loc6_ = 0;
   _loc4_;
   var _loc3_ = this["Button" + _loc4_++];
   _loc3_.SetText("#SFUI_PauseMenu_ResumeGameButton");
   _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnResumePressed,null,this);
   _loc4_;
   _loc3_ = this["Button" + _loc4_++];
   _loc3_.SetText("#SFUI_PauseMenu_OpenLoadout");
   _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnOpenLoadout,null,this);
   UpdateInventoryButton();
   _global.CScaleformComponent_Inventory.SetInventorySortAndFilters(_global.CScaleformComponent_MyPersona.GetXuid(),"newest",false,"only_gifts");
   if(_global.CScaleformComponent_Inventory.GetInventoryCount() > 0 && !_global.CScaleformComponent_Loadout.IsLoadoutAllowed() && _global.PauseMenuAPI.IsMultiplayer())
   {
      _loc4_;
      _loc3_ = this["Button" + _loc4_++];
      _loc3_.SetText("#SFUI_PauseMenu_OpenLoadoutGift");
      _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnOpenLoadoutGift,null,this);
   }
   if(_global.PauseMenuAPI.IsTraining() == false && _global.PauseMenuAPI.IsQueuedMatchmaking() == false && _global.PauseMenuAPI.IsGotvSpectating() == false)
   {
      _loc4_;
      _loc3_ = this["Button" + _loc4_++];
      _loc3_.SetText("#SFUI_PauseMenu_SwitchTeamsButton");
      _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnSwitchTeamsPressed,_loc3_,this);
   }
   if(_global.PauseMenuAPI.IsTraining() == false && ((_global.PauseMenuAPI.IsMultiplayer() || _global.IsPC()) && _loc6_ == 0) && _global.PauseMenuAPI.IsGotvSpectating() == false)
   {
      _loc4_;
      _loc3_ = this["Button" + _loc4_++];
      _loc3_.SetText("#SFUI_PauseMenu_CallVoteButton");
      _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnCallVotePressed,_loc3_,this);
   }
   if(_global.PauseMenuAPI.IsTraining() == false && _global.PauseMenuAPI.IsQueuedMatchmaking() == false && _global.PauseMenuAPI.IsGotvSpectating() == false)
   {
      _loc4_;
      _loc3_ = this["Button" + _loc4_++];
      _loc3_.SetText("#SFUI_PlayMenu_BrowseServersButton");
      _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnBrowseServersPressed,_loc3_,this);
   }
   if(_global.PauseMenuAPI.NeedsInviteFriends() && _global.PauseMenuAPI.IsTraining() == false)
   {
      _loc4_;
      _loc3_ = this["Button" + _loc4_++];
      _loc3_.SetText("#SFUI_PauseMenu_InviteFriendsButton");
      _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnInviteFriends,_loc3_,this);
   }
   else if(_global.PauseMenuAPI.IsMultiplayer() && _loc6_ == 0 && _global.PauseMenuAPI.IsGotvSpectating() == false)
   {
      _loc4_;
      _loc3_ = this["Button" + _loc4_++];
      _loc3_.SetText("#SFUI_PlayMenu_ReportServer");
      _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnReportServerPressed,_loc3_,this);
   }
   if(_global.PauseMenuAPI.IsTraining() == false && _global.PauseMenuAPI.IsQueuedMatchmaking() == false && _global.PauseMenuAPI.IsWorkshopMap() == true)
   {
      _loc4_;
      _loc3_ = this["Button" + _loc4_++];
      _loc3_.SetText("#SFUI_PlayMenu_OpenWorkshopMap");
      _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnViewMapInWorkshop,_loc3_,this);
   }
   if(_loc6_ == 0)
   {
      _loc4_;
      _loc3_ = this["Button" + _loc4_++];
      _loc3_.SetText("#SFUI_MainMenu_My_Awards");
      _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnMyAwardsPressed,_loc3_,this);
   }
   _loc4_;
   _loc3_ = this["Button" + _loc4_++];
   _loc3_.SetText("#SFUI_PauseMenu_HelpButton");
   _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnHelpPressed,_loc3_,this);
   _loc4_;
   _loc3_ = this["Button" + _loc4_++];
   _loc3_.SetText("#SFUI_PauseMenu_ExitGameButton");
   _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(OnExitGamePressed,_loc3_,this);
   backPanel._height = backpanelDefaultHeight;
   var _loc5_ = 10;
   while(_loc4_ <= _loc5_)
   {
      _loc4_;
      _loc3_ = this["Button" + _loc4_++];
      backPanel._height = backPanel._height - _loc3_._height;
      _loc3_._visible = false;
   }
}
var backpanelDefaultHeight = backPanel._height;
var pauseMenuNav = new Lib.NavLayout();
var lastHighlight = null;
pauseMenuNav.AddTabOrder([Button1,Button2,Button3,Button4,Button5,Button6,Button7,Button8,Button9]);
pauseMenuNav.AddNavForObject(Button1,{UP:Button9,DOWN:Button2});
pauseMenuNav.AddNavForObject(Button2,{UP:Button1,DOWN:Button3});
pauseMenuNav.AddNavForObject(Button3,{UP:Button2,DOWN:Button4});
pauseMenuNav.AddNavForObject(Button4,{UP:Button3,DOWN:Button5});
pauseMenuNav.AddNavForObject(Button5,{UP:Button4,DOWN:Button6});
pauseMenuNav.AddNavForObject(Button6,{UP:Button5,DOWN:Button7});
pauseMenuNav.AddNavForObject(Button7,{UP:Button6,DOWN:Button8});
pauseMenuNav.AddNavForObject(Button8,{UP:Button7,DOWN:Button9});
pauseMenuNav.AddNavForObject(Button9,{UP:Button8,DOWN:Button1});
pauseMenuNav.AddCancelKeyHandlers({onDown:function(button, control, keycode)
{
   _global.PauseMenuMovie.Panel.MainMenuNav.OnResumePressed();
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}});
pauseMenuNav.AddKeyHandlerTable({KEY_XBUTTON_START:{onDown:function(button, control, keycode)
{
   _global.PauseMenuMovie.Panel.MainMenuNav.OnResumePressed();
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}}});
pauseMenuNav.SetInitialHighlight(Button1);
pauseMenuNav.ForceHighlightOnPop(true);
pauseMenuNav.ShowCursor(true);
stop();
