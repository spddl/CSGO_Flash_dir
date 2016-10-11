function onResize(rm)
{
   rm.ResetPositionByPixel(startText,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_RIGHT,0,Lib.ResizeManager.ALIGN_RIGHT,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,0,Lib.ResizeManager.ALIGN_BOTTOM);
}
function showPanel()
{
   if(!visible)
   {
      onResize(_global.resizeManager);
      startText.gotoAndPlay("StartShow");
      visible = true;
   }
}
function hidePanel()
{
   if(visible)
   {
      startText.gotoAndPlay("StartHide");
      visible = false;
   }
}
function hidePanelImmediate()
{
   startText.gotoAndStop("Hide");
   visible = false;
}
function setPlayer2Name(name)
{
   player2Name = name;
   if(player2Name != null)
   {
      startText.Animator.Text.SetText(_global.ConstructString(_global.GameInterface.Translate("#SFUI_MainMenu_Player2Leave"),name));
   }
   else
   {
      startText.Animator.Text.SetText("#SFUI_MainMenu_Player2Join");
   }
}
function clearPlayer2Name()
{
   setPlayer2Name(null);
}
function onUnload(mc)
{
   _global.SplitScreenSignon = null;
   _global.SplitScreenSignonAPI = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onLoaded()
{
   gameAPI.OnReady();
}
_global.SplitScreenSignon = this;
_global.SplitScreenSignonAPI = gameAPI;
var visible = False;
var player2Name = null;
_global.resizeManager.AddListener(this);
stop();
