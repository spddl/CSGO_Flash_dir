function onLoaded()
{
   Panel.gotoAndStop("hide");
   Panel._visible = false;
   gameAPI.OnReady();
}
function onUnload(mc)
{
   _global.resizeManager.RemoveListener(this);
   delete _global.TrialTimer;
   return true;
}
function onResize(rm)
{
   rm.ResetPositionByPercentage(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_TOP,0.25,Lib.ResizeManager.ALIGN_TOP);
   setYPositionFromRadar();
}
function setYPositionFromRadar()
{
   var _loc2_ = _global.SFRadar;
   if(_loc2_ != undefined && _loc2_ != null)
   {
      Panel._y = _loc2_.getTrialTimerYPosition();
   }
}
function ShowPanel()
{
   if(isVisible == false)
   {
      Panel._visible = true;
      isVisible = true;
      Panel.gotoAndPlay("StartShow");
   }
}
function HidePanel()
{
   if(isVisible == true)
   {
      Panel._visible = false;
      isVisible = false;
      Panel.gotoAndPlay("StartHide");
   }
}
var isVisible = false;
_global.TrialTimer = this;
_global.resizeManager.AddListener(this);
stop();
