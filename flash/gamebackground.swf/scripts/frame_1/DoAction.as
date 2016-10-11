function onResize(rm)
{
   rm.ResetXYPositionByPixel(GameBackgroundFill,Lib.ResizeManager.SCALE_USING_HORIZONTAL,true,Lib.ResizeManager.SCALE_USING_VERTICAL,true,Lib.ResizeManager.REFERENCE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
}
function onUIHide(mc, rm)
{
   hideBackground();
}
function onUIShow(mc, rm)
{
   showBackground();
}
function showBackground()
{
   GameBackgroundFill._visible = true;
}
function hideBackground()
{
   GameBackgroundFill._visible = false;
}
function onUnload(mc)
{
   _global.GameBackgroundMovie = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
_global.GameBackgroundMovie = this;
_global.resizeManager.AddListener(this);
stop();
