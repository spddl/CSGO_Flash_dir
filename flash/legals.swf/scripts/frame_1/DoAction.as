function onResize(rm)
{
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.ResetPositionByPixel(ratings,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
}
function onUnload(mc)
{
   _global.LegalsMovie = null;
   _global.LegalsAPI = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onLoaded()
{
   GetRatingsBoardForLegals();
   stop();
   gameAPI.OnReady();
}
function GetRatingsBoardForLegals()
{
   ratings.OFLC._visible = false;
   ratings.PEGI._visible = false;
   ratings.ESRB._visible = false;
   ratings.USK._visible = false;
   ratings.BBFCPEGI._visible = false;
   ratings.CERO._visible = false;
   ratings.GRB._visible = false;
   var _loc1_ = gameAPI.GetRatingsBoardForLegals();
   if(_loc1_ != null && _loc1_ != "")
   {
      var _loc2_ = true;
      switch(_loc1_)
      {
         case "OFLC":
            ratings.OFLC._visible = true;
            break;
         case "PEGI":
            ratings.PEGI._visible = true;
            break;
         case "ESRB":
            ratings.ESRB._visible = true;
            break;
         case "USK":
            ratings.USK._visible = true;
            break;
         case "BBFCPEGI":
            ratings.BBFCPEGI._visible = true;
            break;
         case "CERO":
            ratings.CERO._visible = true;
            break;
         case "GRB":
            ratings.GRB._visible = true;
            break;
         default:
            _loc2_ = false;
      }
      if(_loc2_)
      {
         ratings.gotoAndPlay(2);
      }
      else
      {
         Panel.gotoAndPlay(2);
         trace("DID NOT FIND RATING BOARD NAME  (" + _loc1_ + ")");
      }
   }
   else
   {
      Panel.gotoAndPlay(2);
   }
}
function dismissAnimation(inCertMode)
{
   if(!inCertMode && bPressSkipOnce == false)
   {
      bPressSkipOnce = true;
      Panel.gotoAndPlay("Hidden");
   }
}
function playAudio(trackNum)
{
   if(trackNum == -1)
   {
      gameAPI.PlayAudio();
   }
   else if(trackNum == 0)
   {
      gameAPI.PlayAudio("UI/valve_logo_music.mp3");
   }
}
function finishAnimation()
{
   this.gotoAndPlay("StartHide");
   _global.LegalsMovie.gameAPI.AnimationCompleted();
}
stop();
_global.LegalsMovie = this;
_global.LegalsAPI = gameAPI;
var bPressSkipOnce = false;
_global.resizeManager.AddListener(this);
