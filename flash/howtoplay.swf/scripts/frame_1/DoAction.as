function onResize(rm)
{
   rm.ResetPosition(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.ALIGN_CENTER);
}
function setUIDevice()
{
   if(_global.wantControllerShown)
   {
      _global.HowToPlayMovie.UpdateNavString();
      _global.HowToPlayMovie.Panel.Panel.NavigationMaster.gotoAndStop("ShowController");
   }
   else
   {
      _global.HowToPlayMovie.Panel.Panel.NavigationMaster.gotoAndStop("HideController");
   }
}
function changeUIDevice()
{
   if(_global.wantControllerShown)
   {
      _global.HowToPlayMovie.UpdateNavString();
      _global.HowToPlayMovie.Panel.Panel.NavigationMaster.gotoAndPlay("StartShowController");
   }
   else
   {
      _global.HowToPlayMovie.Panel.Panel.NavigationMaster.gotoAndPlay("StartHideController");
   }
}
function showPanel()
{
   Panel.gotoAndPlay("StartShow");
   Panel.Panel.onShow();
}
function hidePanel()
{
   Panel.gotoAndPlay("StartHide");
   Panel.Panel.onHide();
}
function InitDialogData()
{
   Panel.Panel.dialog.InitDialogData();
}
function UpdateNavString()
{
   _global.HowToPlayMovie.Panel.Panel.NavigationMaster.ControllerNavl.NavLabel.ConfirmOrCancel.htmlText = "#SFUI_How_to_Play_Navigation@15";
}
function onUnload(mc)
{
   Panel.Panel.Cleanup();
   _global.HowToPlayMovie = null;
   _global.HowToPlayAPI = null;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   return true;
}
function onLoaded()
{
   Panel.Panel.InitDialog();
   _global.HowToPlayMovie.Panel.Panel.NavigationMaster.PCButtons.Done.Action = function()
   {
      _global.HowToPlayMovie.hidePanel();
   };
   _global.HowToPlayMovie.Panel.Panel.NavigationMaster.PCButtons.Done.SetText("#SFUI_Back");
   setUIDevice();
   gameAPI.OnReady();
}
_global.HowToPlayMovie = this;
_global.HowToPlayAPI = gameAPI;
_global.resizeManager.AddListener(this);
stop();
