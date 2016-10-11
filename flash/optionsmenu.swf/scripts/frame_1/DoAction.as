function onLoaded()
{
   gameAPI.OnReady();
   TopPanel.gotoAndStop("StartShow");
   ResizeTop.gotoAndStop("StartShow");
   TopPanel.Panel.SetNavState();
}
function Init(nNumberOfWidgetsSlots, nMode)
{
   MinSafeZoneX = gameAPI.GetSafeZoneXMin();
   MaxSafeZoneX = _global.GameInterface.GetConvarNumberMax("safezonex");
   MinSafeZoneY = _global.GameInterface.GetConvarNumberMin("safezoney");
   MaxSafeZoneY = _global.GameInterface.GetConvarNumberMax("safezoney");
   var _loc4_ = SafeZoneSliderInterval / (MaxSafeZoneX - MinSafeZoneX) * 100;
   ResizeTop.ResizePanel.HorizontalResize.SensitivityControl.Init(true);
   ResizeTop.ResizePanel.HorizontalResize.SensitivityControl.DefineScaledValueRange(MinSafeZoneX,MaxSafeZoneX);
   ResizeTop.ResizePanel.HorizontalResize.SensitivityControl.m_bNotifyWhileMoving = true;
   ResizeTop.ResizePanel.HorizontalResize.SensitivityControl.NotifyValueChange = this.HorizontalSizeSliderValueChanged;
   ResizeTop.ResizePanel.HorizontalResize.SensitivityControl.m_nIncrementAmount = _loc4_;
   ResizeTop.ResizePanel.VerticalResize.SensitivityControl.Init(true);
   ResizeTop.ResizePanel.VerticalResize.SensitivityControl.DefineScaledValueRange(MinSafeZoneY,MaxSafeZoneY);
   ResizeTop.ResizePanel.VerticalResize.SensitivityControl.m_bNotifyWhileMoving = true;
   ResizeTop.ResizePanel.VerticalResize.SensitivityControl.NotifyValueChange = this.VerticalSizeSliderValueChanged;
   ResizeTop.ResizePanel.VerticalResize.SensitivityControl.m_nIncrementAmount = _loc4_;
   ResizeTop.ResizePanel.NavigationMaster.PCButtons.BackButton.SetText("#SFUI_Back");
   ResizeTop.ResizePanel.NavigationMaster.PCButtons.BackButton.Action = function()
   {
      _global.OptionsMovie.StopResize();
   };
   ResizeTop.ResizePanel.keyboardup.Action = function()
   {
      gameAPI.OnResizeVertical(1);
   };
   ResizeTop.ResizePanel.keyboarddown.Action = function()
   {
      gameAPI.OnResizeVertical(-1);
   };
   ResizeTop.ResizePanel.keyboardleft.Action = function()
   {
      gameAPI.OnResizeHorizontal(-1);
   };
   ResizeTop.ResizePanel.keyboardright.Action = function()
   {
      gameAPI.OnResizeHorizontal(1);
   };
   ResizeTop._visible = false;
   showResizeBars(false);
   nSlotCount = nNumberOfWidgetsSlots;
   var _loc3_ = undefined;
   switch(nMode)
   {
      case MainUI.OptionsDialog.Options.DIALOG_MODE_MOUSE_KEYBOARD:
         _loc3_ = _global.GameInterface.Translate("#SFUI_CONTROLLS_MOUSE_KEYBOARD");
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_CONTROLLER:
         _loc3_ = _global.GameInterface.Translate("#SFUI_PLAYER_CONTROLS");
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_SCREENRESIZE:
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_MOTION_CONTROLLER:
         _loc3_ = _global.GameInterface.Translate("#SFUI_HelpMenu_MotionController");
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_MOTION_CONTROLLER_MOVE:
         _loc3_ = _global.GameInterface.Translate("#SFUI_HelpMenu_MotionControllerMove");
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_MOTION_CONTROLLER_SHARPSHOOTER:
         _loc3_ = _global.GameInterface.Translate("#SFUI_HelpMenu_MotionControllerSharpshooter");
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_VIDEO:
         _loc3_ = _global.GameInterface.Translate("#SFUI_HelpMenu_VideoSettings");
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_VIDEO_ADVANCED:
         _loc3_ = _global.GameInterface.Translate("#SFUI_Settings_Video_Advanced");
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_AUDIO:
         _loc3_ = _global.GameInterface.Translate("#SFUI_HelpMenu_AudioSettings");
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_SETTINGS:
         _loc3_ = _global.GameInterface.Translate("#SFUI_PLAYER_SETTINGS");
   }
   TopPanel.Title.SideText.htmlText = _loc3_;
   TopPanel.Panel.Init(nNumberOfWidgetsSlots,nMode);
}
function onUnload(mc)
{
   delete TopPanel.Panel.dialog;
   delete TopPanel.Panel.navMouseKeyboard;
   delete TopPanel.Panel.navScreenResize;
   delete TopPanel.Panel.navController;
   delete TopPanel.Panel.arraySlots;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   _global.OptionsMovie = null;
   _global.OptionsGameAPI = null;
   return true;
}
function changeUIDevice()
{
   if(!bShowResize)
   {
      TopPanel.Panel.UpdateNav();
   }
   else if(_global.wantControllerShown)
   {
      ResizeTop.ResizePanel.NavigationMaster.gotoAndPlay("StartShowController");
      ResizeTop.ResizePanel.DpadGlyph._visible = true;
   }
   else
   {
      ResizeTop.ResizePanel.NavigationMaster.gotoAndPlay("StartHideController");
      ResizeTop.ResizePanel.DpadGlyph._visible = false;
   }
}
function RefreshAudioNav()
{
   TopPanel.Panel.RefreshAudioNav();
}
function ShowApplyButton()
{
   TopPanel.Panel.ShowApplyButton();
}
function HideApplyButton()
{
   TopPanel.Panel.HideApplyButton();
}
function ShowSetupMic()
{
   TopPanel.Panel.ShowSetupMic();
}
function HideSetupMic()
{
   TopPanel.Panel.HideSetupMic();
}
function ShowPushToTalk()
{
   TopPanel.Panel.ShowPushToTalk();
}
function HidePushToTalk()
{
   TopPanel.Panel.HidePushToTalk();
}
function DisableWidget(nWidgetID, bDisabled)
{
   TopPanel.Panel.DisableWidget(nWidgetID,bDisabled);
}
function StopResize()
{
   gameAPI.OnSaveProfile();
   bShowResize = false;
   showResizeBars(false);
   ResizeTop.gotoAndStop("StartShow");
   TopPanel.Panel.UpdateNav();
   TopPanel.Panel._visible = true;
   TopPanel.gotoAndPlay("StartShow");
   changeUIDevice();
}
function StartResize()
{
   ResizeTop._visible = true;
   bShowResize = true;
   TopPanel.Panel.UpdateNav();
   TopPanel.Panel.UpdateScreenSizeSliders();
   TopPanel.Panel._visible = false;
   TopPanel.gotoAndPlay("StartHide");
   changeUIDevice();
   if(_global.wantControllerShown)
   {
      ResizeTop.ResizePanel.DpadGlyph._visible = true;
   }
   else
   {
      ResizeTop.ResizePanel.DpadGlyph._visible = false;
   }
}
function HorizontalSizeSliderValueChanged()
{
   TopPanel.Panel.HightlightHorizontalSizeSlider();
   gameAPI.OnSetSizeHorizontal(ResizeTop.ResizePanel.HorizontalResize.SensitivityControl.GetValueScaled());
}
function VerticalSizeSliderValueChanged()
{
   TopPanel.Panel.HightlightVerticalSizeSlider();
   gameAPI.OnSetSizeVertical(ResizeTop.ResizePanel.VerticalResize.SensitivityControl.GetValueScaled());
}
function showResizeBars(bShow)
{
   if(bShow == false)
   {
      Bracket1._visible = false;
      Bracket2._visible = false;
      Bracket3._visible = false;
      Bracket4._visible = false;
      LineTop._visible = false;
      LineBottom._visible = false;
      LineLeft._visible = false;
      LineRight._visible = false;
      ResizeTop._visible = false;
      NavPanel.Nav.Nav.Text.htmlText = "#SFUI_Settings_Nav";
   }
   else
   {
      Bracket1._visible = true;
      Bracket2._visible = true;
      Bracket3._visible = true;
      Bracket4._visible = true;
      LineTop._visible = true;
      LineBottom._visible = true;
      LineLeft._visible = true;
      LineRight._visible = true;
      gameAPI.OnResizeVertical(0);
      gameAPI.OnResizeHorizontal(0);
      ResizeTop._visible = true;
      NavPanel.Nav.Nav.Text.htmlText = "#SFUI_Settings_Nav";
   }
}
function ShowPanel()
{
   TopPanel.gotoAndPlay("StartShow");
   TopPanel.Panel.ShowPanel();
}
function HidePanel()
{
   TopPanel.gotoAndPlay("StartHide");
   TopPanel.Panel.HidePanel();
}
function DisableUpNav()
{
   TopPanel.Panel.DisableUpNav();
}
function DisableDownNav()
{
   TopPanel.Panel.DisableDownNav();
}
function EnableUpNav()
{
   TopPanel.Panel.EnableUpNav();
}
function EnableDownNav()
{
   TopPanel.Panel.EnableDownNav();
}
function StartKeyPressed()
{
   TopPanel.Panel.StartKeyPressed();
}
function RefreshWidgetLayout()
{
   TopPanel.Panel.RefreshWidgetLayout();
}
function onUpdateWidget(nWidgetIndex, nWidgetType, Name, Convar, Data, strTooltip)
{
   TopPanel.Panel.onUpdateWidget(nWidgetIndex,nWidgetType,Name,Convar,Data,strTooltip);
}
function RefreshInputField(nWidgetIndex)
{
   TopPanel.Panel.RefreshInputField(nWidgetIndex);
}
function UpdateDeadZoneWidget()
{
   if(DeadZone._visible)
   {
      if(_global.GameInterface.GetConvarBoolean("cl_test_calibration"))
      {
         DeadZone.DeadZoneScale.gotoAndStop(99);
      }
      else
      {
         var _loc2_ = _global.GameInterface.GetConvarNumber("mc_dead_zone_radius");
         DeadZone.DeadZoneScale.gotoAndStop(_loc2_ * 100);
      }
   }
}
function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(TopPanel,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_NONE);
   rm.ResetPositionByPixel(ResizeTop,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.ResetPositionByPixel(Bracket1,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetPositionByPixel(Bracket2,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_RIGHT,0,Lib.ResizeManager.ALIGN_RIGHT,Lib.ResizeManager.REFERENCE_SAFE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetPositionByPixel(Bracket3,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,0,Lib.ResizeManager.ALIGN_BOTTOM);
   rm.ResetPositionByPixel(Bracket4,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_RIGHT,0,Lib.ResizeManager.ALIGN_RIGHT,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,0,Lib.ResizeManager.ALIGN_BOTTOM);
   rm.ResetPositionByPixel(LineTop,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetPositionByPixel(LineBottom,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.ResetPositionByPixel(LineLeft,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.ResetPositionByPixel(LineRight,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_RIGHT,0,Lib.ResizeManager.ALIGN_RIGHT,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.ResetPositionByPixel(DeadZone,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
}
_global.OptionsMovie = this;
_global.OptionsGameAPI = gameAPI;
var bShowResize = false;
var nSlotCount = 0;
var MinSafeZoneX = 0.5;
var MaxSafeZoneX = 1;
var MinSafeZoneY = 0.85;
var MaxSafeZoneY = 1;
var SafeZoneSliderInterval = 0.005;
_global.resizeManager.AddListener(this);
stop();
