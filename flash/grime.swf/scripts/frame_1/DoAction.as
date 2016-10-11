function onResize(rm)
{
   rm.ResetPosition(Grime,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.ALIGN_CENTER);
}
function onUnload(mc)
{
   _global.GrimeMovie = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
_global.GrimeMovie = this;
_global.resizeManager.AddListener(this);
this.stop();
