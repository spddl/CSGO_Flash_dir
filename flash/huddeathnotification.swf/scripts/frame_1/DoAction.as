function AddPanel()
{
   nDepthOffset++;
   var _loc2_ = Panel.Notice.DeathText1.attachMovie("death-text","NoticePanel" + nDepthOffset,this.getNextHighestDepth() + nDepthOffset);
   _loc2_._visible = false;
   return _loc2_;
}
function SetPanelText(notice, text, isVictim, isKiller)
{
   notice._visible = false;
   notice._y = 0;
   notice.TextPanel.Text.htmlText = text;
   notice.PanelAttacker._visible = isKiller;
   notice.PanelVictim._visible = isVictim;
   notice.IDTextBG._visible = !isKiller;
   return notice._height;
}
function RemovePanel(movieClip)
{
   Panel.Notice.DeathText1[movieClip._name].removeMovieClip();
}
function UpdateWidth(movieClip)
{
   movieClip.PanelAttacker.KillerHighlight._width = movieClip.TextPanel.Text.textWidth + 20;
   movieClip.PanelAttacker.KillerHighlight._x = movieClip.TextPanel._x + (movieClip.TextPanel._width - movieClip.PanelAttacker.KillerHighlight._width) + 10;
   movieClip.PanelVictim.VictimHighlight._width = movieClip.PanelAttacker.KillerHighlight._width;
   movieClip.PanelVictim.VictimHighlight._x = movieClip.PanelAttacker.KillerHighlight._x;
   movieClip.IDTextBG._width = movieClip.PanelVictim.VictimHighlight._width + 15;
   movieClip.IDTextBG._x = 15;
}
function onLoaded()
{
   nScaledHeight = Panel.Notice.DeathText1._height * _global.resizeManager.ScalingFactors[Lib.ResizeManager.SCALE_BIGGEST] * _global.GameInterface.GetConvarNumber("hud_scaling");
   nDepthOffset = 0;
   gameAPI.SetConfig(nNumberOfNotices * Panel.StatusPanel.Notice._height,nScrollInTime,nFadeOutTime,nNoticeLifetime,strCTColor,strTColor,nLocalPlayerLifetimeMod);
   gameAPI.OnReady();
   Panel.Notice.DeathText1.PanelAttacker._visible = false;
   Panel.Notice.DeathText1.PanelVictim._visible = false;
   Panel.Notice.DeathText1.IDTextBG._visible = false;
}
function onUnload(mc)
{
   _global.DeathNotificationMovie = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onResize(rm)
{
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_RIGHT,-10,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_TOP,25,Lib.ResizeManager.ALIGN_TOP);
}
_global.DeathNotificationMovie = this;
var nNumberOfNotices = 7;
var nScrollInTime = 0.01;
var nFadeOutTime = 1;
var nNoticeLifetime = 5;
var strCTColor = "#6f9ce6";
var strTColor = "#eabe54";
var nLocalPlayerLifetimeMod = 1.5;
var nDepthOffset;
_global.resizeManager.AddListener(this);
stop();
