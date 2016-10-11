function onShow()
{
   _visible = true;
   gotoAndStop("StartShow");
   play();
   _global.navManager.PushLayout(LastMatchStatsNav,"LastMatchStatsNav");
   _global.GameInterface.SetConvar("player_last_medalstats_panel",1);
}
function onHide()
{
   if(_visible)
   {
      this.gotoAndPlay("StartHide");
      _global.navManager.RemoveLayout(LastMatchStatsNav);
   }
}
function cleanup()
{
   _global.navManager.RemoveLayout(LastMatchStatsNav);
}
function setLastMatchFavoriteWeapon(WeaponName)
{
   var _loc1_ = LastMatch.WeaponIcon;
   if(_loc1_ == undefined)
   {
      return undefined;
   }
   _loc1_.DefaultImage._visible = false;
   if(_loc1_.Image != undefined)
   {
      _loc1_.Image.removeMovieClip();
      delete register1.Image;
   }
   if(WeaponName != "weapon_none")
   {
      var _loc2_ = WeaponName.substr(WeaponName.indexOf("_") + 1) + ".movie";
      _loc1_.attachMovie(_loc2_,"Image",60);
   }
}
function InitPanel()
{
   _visible = false;
}
var LastMatchStatsNav = new Lib.NavLayout();
LastMatchStatsNav.AddTabOrder([]);
LastMatchStatsNav.ShowCursor(true);
LastMatchStatsNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.dismissPanel();
}}});
LastMatchStatsNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.leftButtonActivated();
   _global.MedalStatsScreenMovie.switchPanel(0);
},onUp:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.leftButtonReleased();
   return true;
}},"KEY_XBUTTON_LEFT_SHOULDER","KEY_PAGEUP");
LastMatchStatsNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.rightButtonActivated();
   _global.MedalStatsScreenMovie.switchPanel(0);
},onUp:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.rightButtonReleased();
   return true;
}},"KEY_XBUTTON_RIGHT_SHOULDER","KEY_PAGEDOWN");
this.stop();
