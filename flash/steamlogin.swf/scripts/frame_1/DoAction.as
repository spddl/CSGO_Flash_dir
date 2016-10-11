function onResize(rm)
{
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_SMALLEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
}
function onUnload(mc)
{
   _global.SteamLoginMovie = null;
   _global.SteamLoginAPI = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onLoaded()
{
   stop();
   Panel.gotoAndPlay(1);
   gameAPI.OnReady();
}
_global.SteamLoginMovie = this;
_global.SteamLoginAPI = gameAPI;
_global.resizeManager.AddListener(this);
stop();
