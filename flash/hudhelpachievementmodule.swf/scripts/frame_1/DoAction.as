function onLoaded()
{
   gameAPI.OnReady();
}
function onUnload(mc)
{
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   return true;
}
function onResize(rm)
{
   var _loc2_ = Lib.ResizeManager.REFERENCE_SAFE_BOTTOM;
   rm.ResetPositionByPixel(HudPanelMedal,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,- Stage.height / 2 / 1.8,Lib.ResizeManager.ALIGN_BOTTOM);
   rm.ResetPositionByPixel(HudPanelDefuse,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,- Stage.height / 2 / 1.5,Lib.ResizeManager.ALIGN_BOTTOM);
   rm.ResetPositionByPixel(HudPanelHelp,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,- Stage.height / 2 / 1.8,Lib.ResizeManager.ALIGN_BOTTOM);
   rm.ResetPositionByPixel(HudPanelCenter,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,- Stage.height / 2 / 1.8,Lib.ResizeManager.ALIGN_BOTTOM);
}
function setDefuseProgress(progressPercent)
{
   var _loc2_ = 60;
   var _loc1_ = 2;
   var _loc3_ = _loc1_ + progressPercent * (_loc2_ - _loc1_);
   HudPanelDefuse.Panel.DefuseTextTitle.DefuseBar.gotoAndStop(_loc3_);
}
function setMedalAnnouncement(medalName)
{
   var _loc1_ = HudPanelMedal.Panel.MedalIcon;
   if(_loc1_.Image != undefined)
   {
      delete register1.Image;
   }
   _loc1_.attachMovie(medalName,"Image",_loc1_.getDepth() + 1);
}
function hideAll(bShow)
{
   trace("HudHelpMedalAchievementModule: hideAll");
   HudPanelMedal.gotoAndStop("Hide");
   HudPanelDefuse.gotoAndStop("Hide");
   HudPanelHelp.gotoAndStop("Hide");
   HudPanelCenter.gotoAndStop("Hide");
}
function showPanel(whichPanel)
{
   onResize(_global.resizeManager);
   trace("HUD info: showing panels " + whichPanel);
   switch(whichPanel)
   {
      case HUD_PanelAll:
      case HUD_PanelHelp:
         if(!HudPanelHelp._visible && !HudPanelMedal._visible && !HudPanelCenter._visible)
         {
            HudPanelHelp._visible = true;
            HudPanelHelp.gotoAndPlay("StartShow");
            trace("HudPanelHelp : StartShow");
         }
         if(whichPanel != 0)
         {
         }
      case HUD_PanelDefuse:
         HudPanelDefuse._visible = true;
         HudPanelDefuse.gotoAndPlay("StartShow");
         if(whichPanel != 0)
         {
         }
      case HUD_PanelMedal:
         hidePanel(HUD_PanelHelp);
         hidePanel(HUD_PanelCenter);
         HudPanelMedal._visible = true;
         HudPanelMedal.gotoAndPlay("StartShow");
         if(whichPanel == 0)
         {
            break;
         }
      case HUD_PanelCenter:
         break;
      default:
   }
   if(!HudPanelMedal._visible)
   {
      hidePanel(HUD_PanelHelp);
      HudPanelCenter._visible = true;
      HudPanelCenter.gotoAndPlay("StartShow");
   }
   if(whichPanel != 0)
   {
   }
}
function flashCenterText()
{
   trace("flashCenterText");
   if(HudPanelCenter._visible && HudPanelCenter.FlashMovie != undefined)
   {
      HudPanelCenter.FlashMovie.gotoAndPlay("StartShow");
   }
}
function hidePanel(whichPanel)
{
   trace("HUD info: hiding panels " + whichPanel);
   switch(whichPanel)
   {
      case HUD_PanelAll:
      case HUD_PanelHelp:
         if(HudPanelHelp._visible)
         {
            HudPanelHelp.gotoAndPlay("StartHide");
            trace("HudPanelHelp : StartHide");
         }
         else
         {
            HudPanelHelp.gotoAndStop("Hide");
            trace("HudPanelHelp : Hide");
         }
         if(whichPanel != 0)
         {
         }
      case HUD_PanelDefuse:
         if(HudPanelDefuse._visible)
         {
            HudPanelDefuse.gotoAndPlay("StartHide");
         }
         else
         {
            HudPanelDefuse.gotoAndStop("Hide");
         }
         if(whichPanel != 0)
         {
         }
      case HUD_PanelMedal:
         if(HudPanelMedal._visible)
         {
            HudPanelMedal.gotoAndPlay("StartHide");
         }
         else
         {
            HudPanelMedal.gotoAndStop("Hide");
         }
         if(whichPanel == 0)
         {
            break;
         }
      case HUD_PanelCenter:
         break;
      default:
   }
   if(HudPanelCenter._visible)
   {
      HudPanelCenter.gotoAndPlay("StartHide");
   }
   else
   {
      HudPanelCenter.gotoAndStop("Hide");
   }
   if(whichPanel != 0)
   {
   }
}
var m_nPixelOffsetBottom = -340;
var HUD_PanelAll = 0;
var HUD_PanelHelp = 1;
var HUD_PanelDefuse = 2;
var HUD_PanelMedal = 3;
var HUD_PanelCenter = 4;
_global.resizeManager.AddListener(this);
stop();
