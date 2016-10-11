function Show()
{
   if(!shown)
   {
      _visible = true;
      gotoAndStop("StartShow");
      play();
      shown = true;
   }
}
function ShowNow()
{
   if(!shown)
   {
      _visible = true;
      gotoAndStop("Show");
      shown = true;
   }
}
function Hide()
{
   if(shown)
   {
      gotoAndStop("StartHide");
      play();
      shown = false;
   }
}
function HideNow()
{
   if(shown)
   {
      gotoAndStop("Hide");
      shown = false;
   }
}
var shown = false;
_visible = false;
stop();
