function onLoaded()
{
   gameAPI.OnReady();
}
function onUnload(mc)
{
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onResize(rm)
{
   rm.ResetPositionByPixel(Damage,Lib.ResizeManager.SCALE_NONE,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_NONE,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_NONE);
   if(!g_bShowBlood)
   {
      return undefined;
   }
   rm.ResetPositionByPixel(DamageBlood.DamageUp,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetPositionByPixel(DamageBlood.DamageDown,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,0,Lib.ResizeManager.ALIGN_BOTTOM);
   rm.ResetPositionByPixel(DamageBlood.DamageLeft,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.ResetPositionByPixel(DamageBlood.DamageRight,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_RIGHT,0,Lib.ResizeManager.ALIGN_RIGHT,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
}
function TriggerDamage(indicatorName, newPercent)
{
   var _loc4_ = 2;
   var _loc5_ = 16;
   var _loc1_ = 2;
   var _loc6_ = 15;
   if(newPercent < 0)
   {
      Damage[indicatorName].play();
   }
   else
   {
      var _loc3_ = _loc4_ + (1 - newPercent) * (_loc5_ - _loc4_);
      _loc3_ = Math.min(_loc5_,Math.max(_loc4_,_loc3_));
      Damage[indicatorName].gotoAndStop(_loc3_);
   }
   if(g_bShowBlood)
   {
      var _loc2_ = _loc1_ + (1 - newPercent) * (_loc6_ - _loc1_);
      _loc2_ = Math.min(_loc6_,Math.max(_loc1_,_loc2_));
      DamageBlood[indicatorName].gotoAndStop(_loc2_);
   }
}
function showDamageDirection(directionVal, newPercent)
{
   Damage._visible = true;
   if(g_bShowBlood)
   {
      DamageBlood._visible = true;
   }
   if(0 <= directionVal && directionVal < indicatorNameList.length)
   {
      TriggerDamage(indicatorNameList[directionVal],newPercent);
   }
   else
   {
      index = 0;
      while(index < indicatorNameList.length)
      {
         TriggerDamage(indicatorNameList[index],newPercent);
         index++;
      }
   }
}
function hideAll()
{
   Damage._visible = false;
   DamageBlood._visible = false;
   showDamageDirection(indicatorNameList.length,0);
}
var g_bShowBlood = false;
var indicatorNameList = ["DamageUp","DamageDown","DamageLeft","DamageRight"];
_global.resizeManager.AddListener(this);
stop();
