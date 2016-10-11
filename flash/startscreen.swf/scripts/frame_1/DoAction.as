function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
}
function onUnload(mc)
{
   _global.StartScreenMovie = null;
   _global.StartScreenAPI = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onLoaded()
{
   gameAPI.OnReady();
}
function ShowStartLogo()
{
   Panel.gotoAndPlay("ShowStart");
}
_global.StartScreenMovie = this;
_global.StartScreenAPI = gameAPI;
_global.resizeManager.AddListener(this);
stop();
