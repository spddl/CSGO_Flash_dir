function onLoaded()
{
   Panel.gotoAndStop("Hide");
   Panel._visible = false;
   _global.resizeManager.AddListener(this);
   onResize(_global.resizeManager);
   gameAPI.OnReady();
}
function onUnload(mc)
{
   _global.resizeManager.RemoveListener(this);
   delete _global.Autodisconnect;
   return true;
}
function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPercentage(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_RIGHT,0,Lib.ResizeManager.ALIGN_RIGHT,Lib.ResizeManager.REFERENCE_SAFE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   rm.DisableAdditionalScaling = false;
}
function ShowPanel()
{
   if(Panel._visible == false)
   {
      Panel._visible = true;
      Panel.gotoAndPlay("StartShow");
   }
}
function HidePanel()
{
   if(Panel._visible == true)
   {
      Panel.gotoAndPlay("StartHide");
   }
}
_global.Autodisconnect = this;
_global.AutodisconnectAPI = gameAPI;
stop();
