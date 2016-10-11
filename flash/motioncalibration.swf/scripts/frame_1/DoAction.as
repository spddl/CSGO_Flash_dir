function onLoaded()
{
   gameAPI.OnReady();
   slider = PanelTop.Panel.Sensitivity.SensitivityControl;
   slider.Init(false);
   slider.m_bNotifyWhileMoving = true;
   slider.NotifyValueChange = this.SensitivityValueChanged;
   slider.m_nIncrementAmount = 0.5;
   slider.DefineScaledValueRange(1,45);
   slider.m_bFlipScaledOrientation = true;
   _global.navManager.SetHighlightedObject(slider);
}
function SensitivityValueChanged()
{
   var _loc2_ = slider.GetValueScaled();
   _loc2_ = slider.m_nScaledValueMax - _loc2_;
   _global.GameInterface.SetConvar("mc_max_yaw_deg",_loc2_);
}
function RefreshSensitivitySlider()
{
   slider.SetValueScaled(_global.GameInterface.GetConvarNumber("mc_max_yaw_deg"));
}
function onUnload(mc)
{
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   _global.navManager.RemoveLayout(calibrationNav);
   delete _global.MotionCalibrationMovie;
   delete _global.MotionCalibrationGameAPI;
   return true;
}
function ShowPanel()
{
   PanelTop.Panel.NavigationMaster.gotoAndStop("ShowController");
   _global.navManager.PushLayout(calibrationNav);
   timerInterval = setInterval(gameAPI.TimerCallback,500,null);
}
function HidePanel()
{
   if(timerInterval)
   {
      clearInterval(timerInterval);
      delete timerInterval;
   }
}
function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(PanelTop,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.ResetPositionByPixel(TargetUpperLeft,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetPositionByPixel(TargetLowerLeft,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_BOTTOM,0,Lib.ResizeManager.ALIGN_BOTTOM);
   rm.ResetPositionByPixel(TargetLowerRight,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_RIGHT,0,Lib.ResizeManager.ALIGN_RIGHT,Lib.ResizeManager.REFERENCE_BOTTOM,0,Lib.ResizeManager.ALIGN_BOTTOM);
   rm.ResetPositionByPixel(TargetUpperRight,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_RIGHT,0,Lib.ResizeManager.ALIGN_RIGHT,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
}
var configYawMax = 90;
_global.MotionCalibrationMovie = this;
_global.MotionCalibrationGameAPI = gameAPI;
var timerInterval;
var calibrationNav = new Lib.NavLayout();
var slider = undefined;
calibrationNav.ShowCursor(false);
calibrationNav.DenyInputToGame(true);
calibrationNav.AddKeyHandlerTable({ACCEPT:{onDown:function(button, control, keycode)
{
   _global.MotionCalibrationGameAPI.OnAccept();
   return true;
}},CANCEL:{onDown:function(button, control, keycode)
{
   _global.MotionCalibrationGameAPI.OnCancel();
   return true;
}}});
_global.resizeManager.AddListener(this);
stop();
