function onLoaded()
{
   gameAPI.OnReady();
   FreezePanel._visible = false;
}
function onUnload(mc)
{
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   return true;
}
function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPercentage(FreezePanel,Lib.ResizeManager.SCALE_SMALLEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,-0.35,Lib.ResizeManager.ALIGN_NONE);
}
function hide()
{
   FreezePanel.gotoAndPlay("StartHide");
}
function show()
{
   var _loc1_ = FreezePanel.FreezePanel.GamerPic;
   avatarSize = new flash.geom.Rectangle(_loc1_.DefaultCT._x,_loc1_.DefaultCT._y,_loc1_.DefaultCT._width,_loc1_.DefaultCT._height);
   FreezePanel._visible = true;
   FreezePanel.gotoAndPlay("StartShow");
}
function setKillerHealth(health)
{
   var _loc4_ = 100;
   var _loc2_ = 2;
   var _loc1_ = FreezePanel.FreezePanel.HealthBar;
   var _loc3_ = _loc2_ + health / 100 * (_loc4_ - _loc2_);
   _loc1_.HealthBarRed._visible = health <= 50;
   _loc1_.HealthBar._visible = health > 50;
   _loc1_.HealthBar.gotoAndStop(_loc3_);
   _loc1_.HealthBarRed.gotoAndStop(_loc3_);
}
function RefreshAvatarImage()
{
   cachedXuid = undefined;
}
function showAvatar(xuidAsText, isCT, playerNameText)
{
   var _loc3_ = FreezePanel.FreezePanel.GamerPic;
   var _loc5_ = false;
   if(xuidAsText == "0" && !_loc5_)
   {
      _loc3_.DefaultCT._visible = isCT;
      _loc3_.DefaultT._visible = !isCT;
      _loc3_.GamerPic._visible = false;
      _loc3_.GamerPic.unloadMovie();
   }
   else
   {
      if(cachedXuid == undefined || cachedXuid == null || cachedXuid != xuid || nameText != playerNameText)
      {
         var _loc6_ = "img://avatar_" + xuidAsText;
         if(_loc5_)
         {
            _loc6_ = _global.GameInterface.GetPAXAvatarFromName(playerNameText);
         }
         if(FreezePanel.FreezePanel.GamerPic.GamerPic != undefined)
         {
            FreezePanel.FreezePanel.GamerPic.GamerPic.unloadMovie();
         }
         var _loc4_ = new MovieClipLoader();
         _loc4_.addListener(this);
         _loc4_.loadClip(_loc6_,FreezePanel.FreezePanel.GamerPic.GamerPic);
      }
      _loc3_.DefaultCT._visible = false;
      _loc3_.DefaultT._visible = false;
      _loc3_.GamerPic._visible = true;
   }
   cachedXuid = xuid;
   nameText = playerNameText;
}
function onLoadInit(movieClip)
{
   movieClip._x = avatarSize.x;
   movieClip._y = avatarSize.y;
   movieClip._width = avatarSize.width;
   movieClip._height = avatarSize.height;
}
var avatarSize;
var cachedXuid = undefined;
_global.resizeManager.AddListener(this);
stop();
