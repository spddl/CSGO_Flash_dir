var teamSelectNav = new Lib.NavLayout();
var selection;
teamSelectNav.ShowCursor(true);
teamSelectNav.DenyInputToGame(true);
function showPanel(bInstantShow, preassignedTeam)
{
   trace(" ChooseTeam: showPanel");
   var _loc3_ = !_global.TeamSelectAPI.IsInitialTeamMenu();
   NavPanel.NavigationMaster.PCButtons.CancelButton._visible = _loc3_;
   if(_global.TeamSelectAPI.IsQueuedMatchmaking())
   {
      IsQueuedMatch(preassignedTeam);
      trace(" ChooseTeam: showPanel: IsQueuedMatch");
      return undefined;
   }
   _global.navManager.PushLayout(teamSelectNav,"teamSelectNav");
   trace(" ChooseTeam: showPanel: _global.navManager.PushLayout(teamSelectNav))");
   if(!bInstantShow)
   {
      this.gotoAndPlay("StartShow");
   }
   else
   {
      this.gotoAndPlay("Show");
   }
}
function hidePanel()
{
   trace(" ChooseTeam: hidePanel");
   this.gotoAndPlay("StartHide");
   NavPanel.ErrorBar.ForceHide();
   RemoveNavLayouts();
}
function OnTeamHighlight()
{
   _global.TeamSelectAPI.OnTeamHighlight(_global.TeamSelectMovie.Panel.selection);
}
function selectCounterTerrorists()
{
   if(_global.TeamSelectMovie.Panel.selection != 3)
   {
      _global.TeamSelectMovie.Panel.NavPanel.gotoAndStop("CTSelected");
      _global.TeamSelectMovie.Panel.selection = 3;
      OnTeamHighlight();
   }
}
function selectTerrorists()
{
   if(_global.TeamSelectMovie.Panel.selection != 2)
   {
      _global.TeamSelectMovie.Panel.NavPanel.gotoAndStop("TSelected");
      _global.TeamSelectMovie.Panel.selection = 2;
      OnTeamHighlight();
   }
}
function setTFull(bFull)
{
   NavPanel.T_LabelHuman._visible = !bFull;
   NavPanel.T_LabelBot._visible = !bFull;
   NavPanel.T_CountHuman._visible = !bFull;
   NavPanel.T_CountBot._visible = !bFull;
   NavPanel.T_LabelFull._visible = bFull;
}
function setCTFull(bFull)
{
   NavPanel.CT_LabelHuman._visible = !bFull;
   NavPanel.CT_LabelBot._visible = !bFull;
   NavPanel.CT_CountHuman._visible = !bFull;
   NavPanel.CT_CountBot._visible = !bFull;
   NavPanel.CT_LabelFull._visible = bFull;
}
function IsQueuedMatch(team)
{
   trace(" ChooseTeam: IsQueuedMatch");
   _global.TeamSelectMovie.Panel.gotoAndStop("show");
   if(team == 2)
   {
      NavPanel.gotoAndStop("QuickT");
      NavPanel.QuickTFade.gotoAndPlay("startAnim");
   }
   else
   {
      NavPanel.gotoAndStop("QuickCT");
      NavPanel.QuickCTFade.gotoAndPlay("startAnim");
   }
}
function selectTeam(button, control, keycode)
{
   _global.TeamSelectAPI.OnOk(_global.TeamSelectMovie.Panel.selection);
   return true;
}
function setUIDevice()
{
   if(_global.wantControllerShown)
   {
      _global.TeamSelectAPI.UpdateNavText();
      _global.TeamSelectMovie.Panel.NavPanel.NavigationMaster.gotoAndStop("ShowController");
   }
   else
   {
      _global.TeamSelectMovie.Panel.NavPanel.NavigationMaster.gotoAndStop("HideController");
   }
}
function changeUIDevice()
{
   if(_global.wantControllerShown)
   {
      _global.TeamSelectAPI.UpdateNavText();
      _global.TeamSelectMovie.Panel.NavPanel.NavigationMaster.gotoAndPlay("StartShowController");
   }
   else
   {
      _global.TeamSelectMovie.Panel.NavPanel.NavigationMaster.gotoAndPlay("StartHideController");
   }
}
function RemoveNavLayouts()
{
   trace(" ChooseTeam: RemoveNavLayouts");
   _global.navManager.RemoveLayout(teamSelectNav);
}
function onUnload()
{
   trace(" ChooseTeam: onUnload");
   NavPanel.ErrorBar.onUnload();
   RemoveNavLayouts();
}
function onLoaded()
{
   trace(" ChooseTeam: onLoaded");
   selectCounterTerrorists();
   this.gotoAndStop("StartShow");
   NavPanel.NavigationMaster.PCButtons.CancelButton.Action = function()
   {
      _global.TeamSelectAPI.OnCancel();
   };
   NavPanel.NavigationMaster.PCButtons.CancelButton.SetText("#SFUI_TeamButtonCancel");
   NavPanel.NavigationMaster.PCButtons.SpectatorButton.Action = function()
   {
      _global.TeamSelectAPI.OnSpectate();
   };
   NavPanel.NavigationMaster.PCButtons.SpectatorButton.SetText("#SFUI_TeamButtonSpectate");
   NavPanel.NavigationMaster.PCButtons.AutoSelectButton.Action = function()
   {
      _global.TeamSelectAPI.OnAutoSelect();
   };
   NavPanel.NavigationMaster.PCButtons.AutoSelectButton.SetText("#SFUI_TeamButtonAuto");
   NavPanel.CTMouseBox.onDragOver = selectCounterTerrorists;
   NavPanel.CTMouseBox.onRollOver = selectCounterTerrorists;
   NavPanel.CTMouseBox.onRelease = selectTeam;
   NavPanel.TMouseBox.onDragOver = selectTerrorists;
   NavPanel.TMouseBox.onRollOver = selectTerrorists;
   NavPanel.TMouseBox.onRelease = selectTeam;
   NavPanel.ErrorBar.onLoaded();
   setUIDevice();
}
if(_global.IsPS3())
{
   teamSelectNav.AddKeyHandlers({onDown:function(button, control, keycode)
   {
      _global.TeamSelectAPI.OnShowScoreboard();
      return true;
   },onUp:function(button, control, keycode)
   {
      return true;
   }},"KEY_XBUTTON_Y");
}
teamSelectNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.TeamSelectMovie.selectCounterTerrorists();
   selectTeam();
}},"KEY_2");
teamSelectNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.TeamSelectMovie.selectTerrorists();
   selectTeam();
}},"KEY_1");
teamSelectNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.TeamSelectAPI.OnSpectate();
}},"KEY_XBUTTON_LEFT_SHOULDER","KEY_6");
teamSelectNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.TeamSelectAPI.OnAutoSelect();
}},"KEY_XBUTTON_X","KEY_5");
teamSelectNav.AddKeyHandlerTable({LEFT:{onDown:function(button, control, keycode)
{
   _global.TeamSelectMovie.selectCounterTerrorists();
}},RIGHT:{onDown:function(button, control, keycode)
{
   _global.TeamSelectMovie.selectTerrorists();
}},CANCEL:{onDown:function(button, control, keycode)
{
   if(!_global.TeamSelectAPI.IsInitialTeamMenu())
   {
      _global.TeamSelectAPI.OnCancel();
   }
}},ACCEPT:{onDown:selectTeam,onUp:function(button, control, keycode)
{
   return true;
}}});
this.stop();
