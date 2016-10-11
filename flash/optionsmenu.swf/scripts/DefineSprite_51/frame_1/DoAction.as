function Init(nNumberOfWidgetsSlots, nMode)
{
   if(nNumberOfWidgetsSlots > m_nMaxWidgetSlots)
   {
      trace("WARNING!!!!  Options screen is initializing " + nNumberOfWidgetsSlots + " slots when the max is " + m_nMaxWidgetSlots + "!!  Truncating to " + m_nMaxWidgetSlots);
      nNumberOfWidgetsSlots = m_nMaxWidgetSlots;
   }
   var _loc5_ = 0;
   var _loc4_ = 0;
   var _loc2_ = 0;
   while(_loc2_ < nNumberOfWidgetsSlots)
   {
      this.Control_Dummy.attachMovie("OptionControlPanel","Control_" + _loc2_.toString(),this.Control_Dummy.getDepth() + _loc2_ + 1);
      var _loc3_ = this.Control_Dummy["Control_" + _loc2_.toString()];
      if(_loc3_)
      {
         _loc3_._x = _loc5_;
         _loc3_._y = _loc4_;
         trace("INIT: Widget " + _loc2_ + ", setting nPosX to " + _loc5_ + " and nPosY to " + _loc4_);
         arraySlots[_loc2_] = _loc3_.Control_Widget;
         _loc4_ = _loc4_ + m_nWidgetOffsetY;
      }
      _loc2_ = _loc2_ + 1;
   }
   dialog.InitDialog(arraySlots,nMode);
   InitNavigation();
   scrollBar.Init(false);
   var _loc7_ = gameAPI.GetTotalOptionsSlots();
   scrollBar.DefinePipBarWidth(m_nMaxWidgetSlotsPage,_loc7_);
   scrollBar.Init(false);
   scrollBar.m_LightButtonsOnHighlight = false;
   scrollBar.SetModalNavLayout(navCurrent);
   scrollBar.NotifyValueChange = function()
   {
      SetSliderPercentage(this.GetValue());
   };
   scrollBar.m_bNotifyWhileMoving = true;
}
function InitNavigation()
{
   ScrollButtonDown.Action = function()
   {
      if(ScrollButtonDown.Disabled != true)
      {
         OnRequestScroll(12);
      }
   };
   ScrollButtonUp.Action = function()
   {
      if(ScrollButtonUp.Disabled != true)
      {
         OnRequestScroll(-12);
      }
   };
}
function ShowSetupMic()
{
   NavigationMaster.PCButtons.ClearKeyButton.setDisabled(false);
}
function HideSetupMic()
{
   NavigationMaster.PCButtons.ClearKeyButton.setDisabled(true);
}
function ShowApplyButton()
{
   NavigationMaster.PCButtons.ClearKeyButton.setDisabled(false);
}
function HideApplyButton()
{
   NavigationMaster.PCButtons.ClearKeyButton.setDisabled(true);
}
function ShowPushToTalk()
{
   NavigationMaster.PCButtons.EditKeyButton.setDisabled(false);
}
function HidePushToTalk()
{
   NavigationMaster.PCButtons.EditKeyButton.setDisabled(true);
}
function SetupPushToTalkNav()
{
   voice_modenable = _global.GameInterface.GetConvarBoolean("voice_modenable");
   voice_enable = _global.GameInterface.GetConvarBoolean("voice_enable");
   voice_vox = _global.GameInterface.GetConvarBoolean("voice_vox");
   resultString = _global.GameInterface.Translate("#SFUI_Settings_General_nav");
   if(voice_enable && voice_modenable)
   {
      resultString = resultString + _global.GameInterface.Translate("#SFUI_Settings_mic_nav");
      ShowSetupMic();
      if(!voice_vox)
      {
         ShowPushToTalk();
         resultString = resultString + _global.GameInterface.Translate("#SFUI_Settings_push_to_talk_nav");
      }
   }
   return resultString;
}
function RefreshAudioNav()
{
   NavigationMaster.PCButtons.EditKeyButton.setDisabled(true);
   NavigationMaster.PCButtons.ClearKeyButton.setDisabled(true);
   NavigationMaster.ControllerNavl.Text.Text.htmlText = SetupPushToTalkNav();
}
function UpdateNav()
{
   NavigationMaster.PCButtons.EditKeyButton.Action = function()
   {
      dialog.ModifyBind();
   };
   NavigationMaster.PCButtons.ClearKeyButton.Action = function()
   {
      dialog.ClearBind();
   };
   NavigationMaster.PCButtons.UseDefaultsButton.Action = function()
   {
      gameAPI.OnResetToDefaults();
   };
   NavigationMaster.PCButtons.UseDefaultsButton.SetText("#SFUI_Controls_Confirm_Default_Title");
   NavigationMaster.PCButtons.BackButton.Action = function()
   {
      _global.OptionsGameAPI.OnCancel();
   };
   NavigationMaster.PCButtons.EditKeyButton.setDisabled(true);
   NavigationMaster.PCButtons.ClearKeyButton.setDisabled(true);
   if(navCurrent != undefined)
   {
      _global.navManager.RemoveLayout(navCurrent);
   }
   var _loc3_ = undefined;
   if(_parent._parent.bShowResize)
   {
      _loc3_ = navScreenResize;
      adjustingVerticalScreenSize = false;
      _global.OptionsMovie.ResizeTop.ResizePanel.gotoAndStop("HorizontalFocus");
   }
   else if(_global.wantControllerShown)
   {
      _loc3_ = navController;
      ButtonBlock._visible = false;
      ScrollButtonUp._visible = false;
      ScrollButtonDown._visible = false;
      if(navCurrent == undefined)
      {
         NavigationMaster.gotoAndStop("ShowController");
      }
      else if(navCurrent != navController)
      {
         NavigationMaster.gotoAndPlay("StartShowController");
      }
   }
   else
   {
      _loc3_ = navMouseKeyboard;
      ButtonBlock._visible = false;
      ScrollButtonUp._visible = false;
      ScrollButtonDown._visible = false;
      if(navCurrent == undefined)
      {
         NavigationMaster.gotoAndStop("HideController");
      }
      else if(navCurrent != navMouseKeyboard)
      {
         NavigationMaster.gotoAndPlay("StartHideController");
      }
   }
   SetNavState();
   navCurrent = _loc3_;
   _global.navManager.PushLayout(_loc3_,"optionsNewNav");
   if(!_parent._parent.bShowResize)
   {
      _global.navManager.SetHighlightedObject(arraySlots[dialog.GetCurrentWidgetIndex()].Widget);
   }
   var _loc5_ = gameAPI.GetTotalOptionsSlots();
   if(_loc5_ <= m_nMaxWidgetSlotsPage)
   {
      scrollBar._visible = false;
   }
   else
   {
      scrollBar._visible = true;
      var _loc4_ = 100 / _loc5_;
      if(_loc4_ < 1)
      {
         _loc4_ = 1;
      }
      scrollBar.m_nIncrementAmount = _loc4_;
   }
}
function SetNavState()
{
   var _loc3_ = undefined;
   var _loc4_ = dialog.GetCurrentWidget().Type == "glyph-panel" || dialog.GetCurrentWidget().Type == "btn-keyboard";
   NavigationMaster.PCButtons.BackButton.SetText("#SFUI_Back");
   NavigationMaster.PCButtons.BackButton.setDisabled(false);
   switch(dialog.GetMode())
   {
      case MainUI.OptionsDialog.Options.DIALOG_MODE_MOUSE_KEYBOARD:
         _loc3_ = _global.GameInterface.Translate("#SFUI_Controls_Nav_Limit");
         NavigationMaster.PCButtons.EditKeyButton.setDisabled(!_loc4_);
         NavigationMaster.PCButtons.ClearKeyButton.setDisabled(!_loc4_);
         NavigationMaster.PCButtons.EditKeyButton._visible = _loc4_;
         NavigationMaster.PCButtons.ClearKeyButton._visible = _loc4_;
         NavigationMaster.PCButtons.EditKeyButton.SetText("#SFUI_Controls_Edit");
         NavigationMaster.PCButtons.ClearKeyButton.SetText("#SFUI_Controls_Clear");
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_CONTROLLER:
         NavigationMaster.PCButtons.EditKeyButton._visible = false;
         NavigationMaster.PCButtons.ClearKeyButton._visible = false;
         NavigationMaster.PCButtons.EditKeyButton.SetText("#SFUI_Controls_Edit");
         NavigationMaster.PCButtons.ClearKeyButton.SetText("#SFUI_Controls_Clear");
         if(_loc4_)
         {
            _loc3_ = _global.GameInterface.Translate("#SFUI_Controls_Nav");
         }
         else
         {
            _loc3_ = _global.GameInterface.Translate("#SFUI_Controls_Nav_Limit");
         }
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_SCREENRESIZE:
         _loc3_ = _global.GameInterface.Translate("#SFUI_Settings_Resize");
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_AUDIO:
         NavigationMaster.PCButtons.ClearKeyButton.Action = function()
         {
            gameAPI.OnSetupMic();
         };
         NavigationMaster.PCButtons.ClearKeyButton.SetText("#SFUI_Settings_Setup_Microphone");
         NavigationMaster.PCButtons.EditKeyButton.Action = function()
         {
            ShowBindScreen();
         };
         NavigationMaster.PCButtons.EditKeyButton.SetText("#SFUI_Settings_Push_To_Talk_Key");
         _loc3_ = SetupPushToTalkNav();
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_VIDEO:
         NavigationMaster.PCButtons.EditKeyButton.Action = function()
         {
            _parent._parent.StartResize();
         };
         NavigationMaster.PCButtons.EditKeyButton.SetText("#SFUI_Settings_Screen_Resize");
         NavigationMaster.PCButtons.EditKeyButton.setDisabled(false);
         NavigationMaster.PCButtons.ClearKeyButton.Action = function()
         {
            gameAPI.OnApplyChanges();
         };
         NavigationMaster.PCButtons.ClearKeyButton.SetText("#SFUI_Settings_Apply");
         _loc3_ = _global.GameInterface.Translate("#SFUI_Settings_Nav_Video");
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_MOTION_CONTROLLER:
      case MainUI.OptionsDialog.Options.DIALOG_MODE_MOTION_CONTROLLER_MOVE:
      case MainUI.OptionsDialog.Options.DIALOG_MODE_MOTION_CONTROLLER_SHARPSHOOTER:
         _loc3_ = _global.GameInterface.Translate("#SFUI_Settings_Calibrate_Nav");
         NavigationMaster.PCButtons.EditKeyButton._visible = true;
         NavigationMaster.PCButtons.EditKeyButton.Action = function()
         {
            gameAPI.OnMCCalibrate();
         };
         NavigationMaster.PCButtons.EditKeyButton.SetText("#SFUI_Calibrate_Calibrate");
         NavigationMaster.PCButtons.EditKeyButton.setDisabled(false);
         NavigationMaster.PCButtons.ClearKeyButton._visible = false;
         break;
      case MainUI.OptionsDialog.Options.DIALOG_MODE_SETTINGS:
         _loc3_ = _global.GameInterface.Translate("#SFUI_Settings_Nav");
         NavigationMaster.PCButtons.EditKeyButton._visible = false;
         NavigationMaster.PCButtons.ClearKeyButton._visible = false;
   }
   NavigationMaster.ControllerNavl.Text.Text.htmlText = _loc3_;
}
function OnRequestScroll(nAmount)
{
   trace("OnRequestScroll: nAmount = " + nAmount);
   var _loc5_ = gameAPI.OnRequestScroll(nAmount);
   if(_loc5_)
   {
      var _loc2_ = this.Control_Dummy;
      var _loc3_ = m_nWidgetOffsetY * nAmount;
      _loc2_._y = _loc2_._y - _loc3_;
   }
}
function ShowBindScreen()
{
   gameAPI.OnCancel();
   _global.RemoveElement(_global.OptionsMovie);
   if(_global.MainMenuMovie)
   {
      _global.MainMenuMovie.Panel.SelectPanel.OpenMenu(!_global.wantControllerShown?"Mouse":"Controller");
   }
   else if(_global.PauseMenuMovie)
   {
      if(_global.wantControllerShown)
      {
         _global.PauseMenuMovie.Panel.MainMenuNav.OnControlsPressed();
      }
      else
      {
         _global.PauseMenuMovie.Panel.MainMenuNav.OnOpenMouseDialog();
      }
   }
}
function ShowPanel()
{
   UpdateNav();
}
function HidePanel()
{
   _global.navManager.RemoveLayout(navCurrent);
}
function DisableUpNav()
{
   ScrollButtonUp.gotoAndPlay("Disabled");
   ScrollButtonUp.Disabled = true;
}
function DisableDownNav()
{
   ScrollButtonDown.gotoAndPlay("Disabled");
   ScrollButtonDown.Disabled = true;
}
function EnableUpNav()
{
   ScrollButtonUp.gotoAndStop("Up");
   ScrollButtonUp.Disabled = false;
}
function EnableDownNav()
{
   ScrollButtonDown.gotoAndStop("Up");
   ScrollButtonDown.Disabled = false;
}
function RefreshWidgetLayout()
{
   dialog.RefreshWidgetLayout();
}
function onUpdateWidget(nWidgetIndex, nWidgetType, Name, Convar, Data, strTooltip)
{
   dialog.onUpdateWidget(nWidgetIndex,nWidgetType,Name,Convar,Data,strTooltip);
}
function RefreshInputField(nWidgetIndex)
{
   dialog.RefreshInputField(nWidgetIndex);
}
function StartKeyPressed()
{
   dialog.StartKeyPressed();
}
function DisableWidget(nWidgetID, bDisabled)
{
   dialog.DisableWidget(nWidgetID,bDisabled);
}
function UpdateNavBySelectedWidget()
{
   if(dialog.GetCurrentWidget().Type == "glyph-panel" || dialog.GetCurrentWidget().Type == "btn-keyboard")
   {
      NavigationMaster.ControllerNavl.Text.Text.htmlText = _global.GameInterface.Translate("#SFUI_Controls_Nav");
      NavigationMaster.PCButtons.EditKeyButton.setDisabled(false);
      NavigationMaster.PCButtons.ClearKeyButton.setDisabled(false);
   }
   else
   {
      NavigationMaster.ControllerNavl.Text.Text.htmlText = _global.GameInterface.Translate("#SFUI_Controls_Nav_Limit");
      NavigationMaster.PCButtons.EditKeyButton.setDisabled(false);
      NavigationMaster.PCButtons.ClearKeyButton.setDisabled(false);
   }
}
function Navigate(direction, bFromScrollbar)
{
   if(direction == 0)
   {
      return undefined;
   }
   if(!dialog.IsEditingGlyphControl)
   {
      if(bFromScrollbar)
      {
         dialog.GetCurrentHighlight().UnsetState();
      }
      result = dialog.GetCurrentWidgetIndex() + direction;
      trace("Navigate: direction = " + direction + ", arraySlots.length = " + arraySlots.length + ", result = " + result);
      var _loc3_ = gameAPI.GetCurrentScrollOffset();
      if(result >= _loc3_ && result < _loc3_ + m_nMaxWidgetSlotsPage)
      {
         dialog.UpdateHighlight(dialog.GetCurrentWidgetIndex() + direction);
      }
      else if(direction > 0)
      {
         OnRequestScroll(1);
      }
      else
      {
         OnRequestScroll(-1);
      }
      _global.navManager.SetHighlightedObject(arraySlots[dialog.GetCurrentWidgetIndex()].Widget);
      SetNavState();
      if(bFromScrollbar == false)
      {
         UpdateScrollBar();
      }
   }
}
function UpdateScrollBar()
{
   scrollBar.SetValue(GetSliderPercentage());
}
function SetSliderPercentage(pct)
{
   var _loc7_ = dialog.GetCurrentWidgetIndex();
   var _loc1_ = gameAPI.GetTotalOptionsSlots();
   var _loc3_ = gameAPI.GetCurrentScrollOffset();
   if(_loc1_ == 0)
   {
      return undefined;
   }
   var _loc2_ = _loc1_ - m_nMaxWidgetSlotsPage;
   if(_loc2_ < 0)
   {
      _loc2_ = 0;
   }
   trace("SetSliderPercentage: nCur = " + _loc3_ + ", nTotal = " + _loc1_ + ", m_nMaxWidgetSlotsPage = " + m_nMaxWidgetSlotsPage);
   var _loc5_ = pct / 100;
   var _loc4_ = int(_loc2_ * _loc5_);
   var _loc6_ = _loc4_ - _loc3_;
   dialog.GetCurrentHighlight().UnsetState();
   Navigate(_loc6_,true);
}
function GetSliderPercentage()
{
   var _loc2_ = gameAPI.GetTotalOptionsSlots();
   var _loc3_ = gameAPI.GetCurrentScrollOffset();
   if(_loc2_ == 0)
   {
      return 0;
   }
   var _loc1_ = _loc2_ - m_nMaxWidgetSlotsPage;
   if(_loc1_ < 0)
   {
      _loc1_ = 0;
   }
   return _loc3_ / _loc1_ * 100;
}
function UpdateScreenSizeSliders()
{
   var _loc2_ = _global.GameInterface.GetConvarNumber("safezonex");
   var _loc3_ = _global.GameInterface.GetConvarNumber("safezoney");
   _global.OptionsMovie.ResizeTop.ResizePanel.HorizontalResize.SensitivityControl.SetValueScaled(_loc2_);
   _global.OptionsMovie.ResizeTop.ResizePanel.VerticalResize.SensitivityControl.SetValueScaled(_loc3_);
}
function HightlightHorizontalSizeSlider()
{
   _global.navManager.SetHighlightedObject(ResizeTop.ResizePanel.HorizontalResize.SensitivityControl);
   _global.OptionsMovie.ResizeTop.ResizePanel.gotoAndStop("HorizontalFocus");
   adjustingVerticalScreenSize = false;
}
function HightlightVerticalSizeSlider()
{
   _global.navManager.SetHighlightedObject(ResizeTop.ResizePanel.VerticalResize.SensitivityControl);
   _global.OptionsMovie.ResizeTop.ResizePanel.gotoAndStop("VerticalFocus");
   adjustingVerticalScreenSize = true;
}
var m_nMaxWidgetSlots = 60;
var m_nMaxWidgetSlotsPage = 20;
var arraySlots = new Array();
var m_nWidgetOffsetY = 25;
gameAPI = _global.OptionsGameAPI;
var dialog = new MainUI.OptionsDialog.Options(this,gameAPI);
var navController = new Lib.NavLayout();
navController.ShowCursor(true);
var navScreenResize = new Lib.NavLayout();
navScreenResize.ShowCursor(true);
var scrollBar = ScrollBar;
var mScrollIntervalId = null;
var mInitialTextFieldHeight = 0;
var navMouseKeyboard = new Lib.NavLayout();
navMouseKeyboard.ShowCursor(true);
var navCurrent = undefined;
var adjustingVerticalScreenSize = false;
navController.AddRepeatKeys("DOWN","UP");
navController.AddKeyHandlerTable({UP:{onDown:function(button, control, keycode)
{
   if(!dialog.IsEditingGlyphControl)
   {
      if(!ScrollButtonUp.Disabled)
      {
         ScrollButtonUp.gotoAndPlay("StartOver");
      }
      Navigate(-1,false);
   }
   else
   {
      dialog.ModifyBind();
   }
   return true;
},onUp:function(button, control, keycode)
{
   if(!ScrollButtonUp.Disabled)
   {
      ScrollButtonUp.gotoAndPlay("StartUp");
   }
   return true;
}},DOWN:{onDown:function(button, control, keycode)
{
   if(!dialog.IsEditingGlyphControl)
   {
      if(!ScrollButtonDown.Disabled)
      {
         ScrollButtonDown.gotoAndPlay("StartUp");
      }
      Navigate(1,false);
   }
   else
   {
      dialog.ModifyBind();
   }
   if(!ScrollButtonDown.Disabled)
   {
      ScrollButtonDown.gotoAndPlay("StartOver");
   }
   return true;
},onUp:function(button, control, keycode)
{
   if(!ScrollButtonDown.Disabled)
   {
      ScrollButtonDown.gotoAndPlay("StartUp");
   }
   return true;
}},ACCEPT:{onDown:function(button, control, keycode)
{
   if(dialog.GetMode() == MainUI.OptionsDialog.Options.DIALOG_MODE_AUDIO)
   {
      ShowBindScreen();
   }
   else
   {
      dialog.ModifyBind();
   }
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}},KEY_XBUTTON_Y:{onDown:function(button, control, keycode)
{
   if(!dialog.IsEditingGlyphControl)
   {
      gameAPI.OnResetToDefaults();
   }
   else
   {
      dialog.ModifyBind();
   }
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}},KEY_XBUTTON_X:{onDown:function(button, control, keycode)
{
   if(dialog.IsEditingGlyphControl)
   {
      dialog.ModifyBind();
   }
   else if(dialog.GetMode() != MainUI.OptionsDialog.Options.DIALOG_MODE_VIDEO)
   {
      if(dialog.GetMode() == MainUI.OptionsDialog.Options.DIALOG_MODE_VIDEO_ADVANCED || dialog.GetMode() == MainUI.OptionsDialog.Options.DIALOG_MODE_SETTINGS)
      {
         _parent._parent.StartResize();
      }
      else if(dialog.GetMode() == MainUI.OptionsDialog.Options.DIALOG_MODE_MOTION_CONTROLLER || dialog.GetMode() == MainUI.OptionsDialog.Options.DIALOG_MODE_MOTION_CONTROLLER_MOVE || dialog.GetMode() == MainUI.OptionsDialog.Options.DIALOG_MODE_MOTION_CONTROLLER_SHARPSHOOTER)
      {
         gameAPI.OnMCCalibrate();
      }
      else
      {
         dialog.ClearBind();
      }
   }
   return true;
}},CANCEL:{onDown:function(button, control, keycode)
{
   if(!dialog.IsEditingGlyphControl)
   {
      gameAPI.OnCancel();
   }
   else
   {
      dialog.ModifyBind();
   }
}},KEY_XBUTTON_RIGHT_SHOULDER:{onDown:function(button, control, keycode)
{
   if(!dialog.IsEditingGlyphControl)
   {
      gameAPI.OnApplyChanges();
   }
   else
   {
      dialog.ModifyBind();
   }
   return true;
}},ANY:{onDown:function(button, control, keycode)
{
   if(dialog.IsEditingGlyphControl)
   {
      dialog.ModifyBind();
   }
}}});
navScreenResize.AddRepeatKeys("DOWN","UP","LEFT","RIGHT");
navScreenResize.RepeatRate = 1;
navScreenResize.AddKeyHandlerTable({UP:{onDown:function(button, control, keycode)
{
   HightlightHorizontalSizeSlider();
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}},DOWN:{onDown:function(button, control, keycode)
{
   HightlightVerticalSizeSlider();
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}},LEFT:{onDown:function(button, control, keycode)
{
   if(adjustingVerticalScreenSize)
   {
      gameAPI.OnResizeVertical(-1);
   }
   else
   {
      gameAPI.OnResizeHorizontal(-1);
   }
   UpdateScreenSizeSliders();
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}},RIGHT:{onDown:function(button, control, keycode)
{
   if(adjustingVerticalScreenSize)
   {
      gameAPI.OnResizeVertical(1);
   }
   else
   {
      gameAPI.OnResizeHorizontal(1);
   }
   UpdateScreenSizeSliders();
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}},CANCEL:{onDown:function(button, control, keycode)
{
   _parent._parent.StopResize();
}}});
navMouseKeyboard.AddRepeatKeys("DOWN","UP");
navMouseKeyboard.AddKeyHandlerTable({UP:{onDown:function(button, control, keycode)
{
   if(!dialog.IsEditingGlyphControl)
   {
      if(!ScrollButtonUp.Disabled)
      {
         ScrollButtonUp.gotoAndPlay("StartOver");
      }
      Navigate(-1,false);
   }
   else
   {
      dialog.ModifyBind();
   }
   return true;
},onUp:function(button, control, keycode)
{
   if(!ScrollButtonUp.Disabled)
   {
      ScrollButtonUp.gotoAndPlay("StartUp");
   }
   return true;
}},DOWN:{onDown:function(button, control, keycode)
{
   if(!dialog.IsEditingGlyphControl)
   {
      if(!ScrollButtonDown.Disabled)
      {
         ScrollButtonDown.gotoAndPlay("StartUp");
      }
      Navigate(1,false);
   }
   else
   {
      dialog.ModifyBind();
   }
   if(!ScrollButtonDown.Disabled)
   {
      ScrollButtonDown.gotoAndPlay("StartOver");
   }
   return true;
},onUp:function(button, control, keycode)
{
   if(!ScrollButtonDown.Disabled)
   {
      ScrollButtonDown.gotoAndPlay("StartUp");
   }
   return true;
}},CANCEL:{onDown:function(button, control, keycode)
{
   if(!dialog.IsEditingGlyphControl)
   {
      gameAPI.OnCancel();
   }
   else
   {
      dialog.ModifyBind();
   }
}},ANY:{onDown:function(button, control, keycode)
{
   if(dialog.IsEditingGlyphControl)
   {
      dialog.ModifyBind();
   }
}},MOUSE_WHEEL_UP:{onDown:function(button, control, keycode)
{
   if(dialog.IsEditingGlyphControl)
   {
      dialog.ModifyBind();
   }
   else
   {
      dialog.GetCurrentHighlight().UnsetState();
      if(GetSliderPercentage() <= 0)
      {
         return undefined;
      }
      OnRequestScroll(-1);
      _global.navManager.SetHighlightedObject(arraySlots[dialog.GetCurrentWidgetIndex()].Widget);
      UpdateScrollBar();
   }
}},MOUSE_WHEEL_DOWN:{onDown:function(button, control, keycode)
{
   if(dialog.IsEditingGlyphControl)
   {
      dialog.ModifyBind();
   }
   else
   {
      dialog.GetCurrentHighlight().UnsetState();
      if(GetSliderPercentage() >= 100)
      {
         return undefined;
      }
      OnRequestScroll(1);
      _global.navManager.SetHighlightedObject(arraySlots[dialog.GetCurrentWidgetIndex()].Widget);
      UpdateScrollBar();
   }
}}});
stop();
