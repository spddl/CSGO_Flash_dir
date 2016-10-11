function onShow()
{
   _visible = true;
   gotoAndStop("StartShow");
   play();
   _global.navManager.PushLayout(OverallStatsNav,"OverallStatsNav");
   _global.GameInterface.SetConvar("player_last_medalstats_panel",0);
}
function onHide()
{
   if(_visible)
   {
      this.gotoAndPlay("StartHide");
      _global.navManager.RemoveLayout(OverallStatsNav);
   }
}
function cleanup()
{
   _global.navManager.RemoveLayout(OverallStatsNav);
}
function setOverallFavoriteWeaponAndMap(WeaponName, MapName)
{
   var _loc1_ = OverAll.WeaponIcon;
   var _loc2_ = OverAll.MapIcon;
   _loc1_.DefaultImage._visible = false;
   _loc2_.DefaultMapImage._visible = false;
   if(_loc1_.Image != undefined)
   {
      _loc1_.Image.removeMovieClip();
      delete register1.Image;
   }
   if(_loc2_.MapImage != undefined)
   {
      _loc2_.MapImage.removeMovieClip();
      delete register2.MapImage;
   }
   if(WeaponName != "weapon_none")
   {
      var _loc4_ = WeaponName.substr(WeaponName.indexOf("_") + 1) + ".movie";
      _loc1_.attachMovie(_loc4_,"Image",60);
   }
   if(MapName != "map_none")
   {
      var _loc6_ = "map-" + MapName.substr(MapName.indexOf("_") + 1) + "-overall";
      var _loc7_ = _loc2_.attachMovie(_loc6_,"MapImage",70);
   }
}
function setEloBracketIcon(EloBracket)
{
   var _loc1_ = panel.panel.OverlAll.OverAll.eloBracket;
   _loc1_._visible = true;
   ScoreBoard.InnerScoreBoard.eloBracket;
   if(_loc1_ && _loc1_.Image != undefined)
   {
      delete register1.Image;
   }
   var _loc2_ = "elo0" + nBracket;
   if(_loc2_ != "")
   {
      _loc1_.attachMovie(_loc2_,"Image",_loc1_.getDepth() + 1);
   }
}
function InitPanel()
{
   _visible = false;
}
var OverallStatsNav = new Lib.NavLayout();
OverallStatsNav.AddTabOrder([]);
OverallStatsNav.ShowCursor(true);
OverallStatsNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.dismissPanel();
}}});
OverallStatsNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.leftButtonActivated();
   _global.MedalStatsScreenMovie.switchPanel(1);
   return true;
},onUp:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.leftButtonReleased();
   return true;
}},"KEY_XBUTTON_LEFT_SHOULDER","KEY_PAGEUP");
OverallStatsNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.rightButtonActivated();
   _global.MedalStatsScreenMovie.switchPanel(1);
   return true;
},onUp:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.rightButtonReleased();
   return true;
}},"KEY_XBUTTON_RIGHT_SHOULDER","KEY_PAGEDOWN");
this.stop();
