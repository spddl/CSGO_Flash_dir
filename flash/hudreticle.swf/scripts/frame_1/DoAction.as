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
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(Crosshair1,Lib.ResizeManager.SCALE_NONE,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_NONE,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_NONE);
   rm.ResetPositionByPixel(Crosshair2,Lib.ResizeManager.SCALE_NONE,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_NONE,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_NONE);
   rm.ResetPositionByPixel(Crosshair3,Lib.ResizeManager.SCALE_NONE,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_NONE,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_NONE);
   rm.ResetPositionByPixel(Crosshair4,Lib.ResizeManager.SCALE_NONE,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_NONE,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_NONE);
   rm.ResetPositionByPixel(Crosshair99,Lib.ResizeManager.SCALE_NONE,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_NONE,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_NONE);
   rm.ResetPositionByPixel(Observer,Lib.ResizeManager.SCALE_NONE,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_NONE,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_NONE);
   rm.DisableAdditionalScaling = false;
   rm.ResetPositionByPercentage(TargetID,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0.05,Lib.ResizeManager.ALIGN_TOP);
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPercentage(FlashedBlind,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_NONE);
   rm.DisableAdditionalScaling = false;
}
function Init()
{
}
function onUpdateColor(nColorID)
{
   var _loc2_ = "Crosshair" + nColorID.toString();
   if(this[_loc2_] == undefined)
   {
      _loc2_ = "Crosshair1";
   }
   currentCrosshair._visible = false;
   currentCrosshair = this[_loc2_];
   currentCrosshair.FriendCrosshair._visible = false;
   gameAPI.SwapReticle(currentCrosshair._name);
}
function setFlashIcon(movieClip, flFlashFrac)
{
   var _loc1_ = movieClip.FlashedIcon;
   if(flFlashFrac >= 1)
   {
      _loc1_._visible = false;
      return undefined;
   }
   _loc1_._visible = true;
   var _loc2_ = int(flFlashFrac * 65);
   _loc1_.Icon.gotoAndStop(_loc2_);
}
function hideFlashIcon(movieClip)
{
   movieClip.FlashedIcon.Icon.gotoAndStop(nFrame);
   movieClip.FlashedIcon._visible = false;
}
function AddNewPlayerID()
{
   nextDynamicPanelLevel++;
   var _loc3_ = "PlayerIDPanel" + nextDynamicPanelLevel;
   var _loc2_ = this.attachMovie("FloatingPlayerName",_loc3_,this.getNextHighestDepth() + nextDynamicPanelLevel);
   hideFlashIcon(_loc2_);
   return _loc2_;
}
function RemovePlayerID(movieClip)
{
   this[movieClip._name].removeMovieClip();
}
function setIDTeamColor(movieClip, nTeam, bFriend, nColorID)
{
   var _loc5_ = new flash.geom.ColorTransform();
   var _loc2_ = new flash.geom.ColorTransform();
   var _loc7_ = new flash.geom.ColorTransform();
   _loc7_.rgb = 6220817;
   var _loc4_ = movieClip.IDArrow;
   var _loc3_ = movieClip.IDArrowBorder;
   var _loc14_ = movieClip.iconChat;
   var _loc6_ = movieClip.IDArrowFriend;
   if(nTeam == 3)
   {
      _loc5_.rgb = 5146074;
      _loc2_.rgb = 5146074;
   }
   else
   {
      _loc5_.rgb = 14789700;
      _loc2_.rgb = 14789700;
   }
   var _loc11_ = new flash.geom.Transform(_loc4_);
   _loc11_.colorTransform = _loc5_;
   _loc4_._alpha = 60;
   var _loc10_ = new flash.geom.Transform(_loc3_);
   _loc10_.colorTransform = _loc2_;
   _loc3_._alpha = 46;
   var _loc15_ = new flash.geom.Transform(_loc6_);
   _loc15_.colorTransform = _loc7_;
   _loc6_._alpha = 60;
   _loc14_._alpha = 180;
   if(nColorID != -1)
   {
      var _loc9_ = _global.GetPlayerColorObject(nColorID);
      var _loc13_ = new Color(_loc4_);
      _loc13_.setTransform(_loc9_);
      var _loc12_ = new Color(_loc3_);
      _loc12_.setTransform(_loc9_);
   }
}
function UpdateBGSize(movieClip)
{
   var _loc1_ = movieClip.IDClip.IDText.textWidth;
   movieClip.IDTextBG._width = _loc1_ + 50;
}
Crosshair1._visible = false;
Crosshair2._visible = false;
Crosshair3._visible = false;
Crosshair4._visible = false;
Crosshair99._visible = false;
currentCrosshair = this["Crosshair" + _global.GameInterface.GetConvarNumber("cl_crosshaircolor").toString()];
var nextDynamicPanelLevel = 0;
var currentCrosshair = Crosshair1;
_global.resizeManager.AddListener(this);
stop();
