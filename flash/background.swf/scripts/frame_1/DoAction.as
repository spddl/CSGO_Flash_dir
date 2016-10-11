function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPosition(BackgroundMain,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.ALIGN_CENTER);
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
   var _loc3_ = _global.CScaleformComponent_MyPersona.GetMyMedalRankByType("7Operation$OperationCoin");
   var _loc4_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
   if(_loc3_ > 1 && _loc4_ != -1)
   {
      BackgroundMain.Operation._visible = true;
      BackgroundMain.Default._visible = false;
   }
   else
   {
      BackgroundMain.Operation._visible = false;
      BackgroundMain.Default._visible = true;
   }
   if(SHOULD_SNOW)
   {
      m_bIsSnowing = true;
      m_flSnowResetTime1 = getTimer();
      m_flSnowResetTime2 = getTimer() - SNOW_TRAVEL_TIME / 2;
      snowingThinkInterval = setInterval(this,"SnowThink",40);
   }
}
function SnowThink()
{
   if(!m_bIsSnowing)
   {
      return undefined;
   }
   var _loc4_ = BackgroundMain.SnowParent.Snow_1;
   var _loc3_ = BackgroundMain.SnowParent.Snow_2;
   var _loc1_ = (getTimer() - m_flSnowResetTime1) / SNOW_TRAVEL_TIME;
   if(_loc1_ >= 1)
   {
      m_flSnowResetTime1 = getTimer();
      _loc1_ = 0;
   }
   var _loc2_ = (getTimer() - m_flSnowResetTime2) / SNOW_TRAVEL_TIME;
   if(_loc2_ >= 1)
   {
      m_flSnowResetTime2 = getTimer();
      _loc2_ = 0;
   }
   var _loc5_ = SNOW_TRAVEL_LENGTH * _loc1_ - SNOW_TRAVEL_LENGTH / 2;
   _loc4_._y = _loc5_;
   _loc3_._y = SNOW_TRAVEL_LENGTH * _loc2_ - SNOW_TRAVEL_LENGTH / 2;
   BackgroundMain.SnowParent._visible = true;
}
function PlayFadeIn()
{
   BackgroundMain.gotoAndPlay("StartShow");
}
function hideBackground()
{
   BackgroundMain.gotoAndPlay("StartHide");
   if(m_bIsSnowing)
   {
      clearInterval(snowingThinkInterval);
      m_bIsSnowing = false;
   }
}
function onUnload(mc)
{
   _global.FrontEndBackgroundMovie = null;
   _global.resizeManager.RemoveListener(this);
   if(m_bIsSnowing)
   {
      clearInterval(snowingThinkInterval);
      m_bIsSnowing = false;
   }
   return true;
}
var SHOULD_SNOW = false;
var m_bIsSnowing = false;
var snowingThinkInterval;
var m_flSnowResetTime = 0;
var SNOW_TRAVEL_TIME = 18000;
var SNOW_TRAVEL_LENGTH = 1484;
BackgroundMain.Bravo._visible = false;
BackgroundMain.Default._visible = false;
BackgroundMain.SnowParent._visible = false;
_global.FrontEndBackgroundMovie = this;
_global.resizeManager.AddListener(this);
stop();
