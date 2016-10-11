function Show()
{
   _visible = true;
   bFadingOut = false;
   this.gotoAndStop(0);
   this.FlashIcon.Icon.gotoAndStop(0);
}
function Hide()
{
   _visible = false;
   bFadingOut = false;
}
function FlashFade(flFlashFrac)
{
   if(flFlashFrac >= 1)
   {
      this._visible = false;
      return undefined;
   }
   this._visible = true;
   var _loc4_ = int(flFlashFrac * 40);
   var _loc3_ = int(flFlashFrac * 65);
   this.gotoAndStop(_loc4_);
   this.FlashIcon.Icon.gotoAndStop(_loc3_);
}
function FadeOut()
{
   gotoAndStop("FadeOut");
   play();
   bFadingOut = true;
}
var bFadingOut = false;
_visible = false;
stop();
