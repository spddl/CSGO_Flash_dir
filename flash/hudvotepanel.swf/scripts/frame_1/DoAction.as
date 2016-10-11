function onLoaded()
{
   _global.VotePanelAPI.OnReady();
   VotePanel.gotoAndStop("LoadHidden");
   VotePanel._visible = false;
}
function onUnload(mc)
{
   delete _global.VotePanelMovie;
   delete _global.VotePanelAPI;
   _global.resizeManager.RemoveListener(this);
   _global.navManager.RemoveLayout(voteNav);
   return true;
}
function onResize(rm)
{
   rm.ResetPositionByPixel(VotePanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_TOP,600,Lib.ResizeManager.ALIGN_TOP);
   var _loc2_ = _global.VoiceStatusMovie;
   if(_loc2_ != null && _loc2_ != undefined)
   {
      _loc2_.resizeRelative(HudPanel);
   }
   setYPositionFromMoney();
}
function setYPositionFromMoney()
{
   var _loc2_ = _global.MoneyPanel;
   if(_loc2_ != undefined && _loc2_ != null)
   {
      VotePanel._y = _loc2_.GetVotePosition();
   }
}
function hideImmediate()
{
   VotePanel._visible = false;
}
function showImmediate()
{
   VotePanel._visible = true;
}
function hide()
{
   bVoteActive = false;
   VotePanel.gotoAndPlay("StartHide");
   _global.navManager.RemoveLayout(voteNav);
}
function handleShow()
{
}
function focusCastVote()
{
   _global.navManager.RemoveLayout(voteNav);
   _global.navManager.PushLayout(voteNav,"voteNav");
}
function showCastVote(headerText, voteText)
{
   handleShow();
   VotePanel.gotoAndPlay("StartShow");
   VotePanel.VotePanelInner.gotoAndStop("CastVote");
   VotePanel.VotePanelInner.NoImage._visible = true;
   VotePanel.VotePanelInner.YesImage._visible = true;
   VotePanel.VotePanelInner.Vote1Count._visible = true;
   VotePanel.VotePanelInner.Vote2Count._visible = true;
   VotePanel.VotePanelInner.ThumbBg1._visible = true;
   VotePanel.VotePanelInner.ThumbBg2._visible = true;
   VotePanel.VotePanelInner.NoImageResult._visible = false;
   VotePanel.VotePanelInner.YesImageResult._visible = false;
   VotePanel.VotePanelInner.Header.SetText(headerText);
   VotePanel.VotePanelInner.VoteText.SetText(voteText);
   VotePanel.VotePanelInner.ThumbBg1.gotoAndPlay("Init");
   setYPositionFromMoney();
}
function showOtherTeamCastVote(headerText, voteText)
{
   handleShow();
   VotePanel.gotoAndPlay("StartShow");
   VotePanel.VotePanelInner.ResultHeader.SetText(headerText);
   VotePanel.VotePanelInner.ResultVoteText.SetText(voteText);
   VotePanel.VotePanelInner.NoImage._visible = false;
   VotePanel.VotePanelInner.YesImage._visible = false;
   VotePanel.VotePanelInner.NoImageResult._visible = false;
   VotePanel.VotePanelInner.YesImageResult._visible = false;
   VotePanel.VotePanelInner.Vote1Count._visible = false;
   VotePanel.VotePanelInner.Vote2Count._visible = false;
   VotePanel.VotePanelInner.ThumbBg1._visible = false;
   VotePanel.VotePanelInner.ThumbBg2._visible = false;
   setYPositionFromMoney();
}
function showResult(headerText, voteText, bPassed, bShowResultNumbers)
{
   handleShow();
   VotePanel.gotoAndPlay("ShowQuick");
   VotePanel.VotePanelInner.gotoAndStop("Result");
   VotePanel.VotePanelInner.ResultHeader.SetText(headerText);
   VotePanel.VotePanelInner.ResultVoteText.SetText(voteText);
   VotePanel.VotePanelInner.NoImage._visible = !bPassed;
   VotePanel.VotePanelInner.YesImage._visible = bPassed;
   VotePanel.VotePanelInner.NoImage2._visible = bShowResultNumbers;
   VotePanel.VotePanelInner.YesImage2._visible = bShowResultNumbers;
   VotePanel.VotePanelInner.NoImageResult._visible = bShowResultNumbers;
   VotePanel.VotePanelInner.YesImageResult._visible = bShowResultNumbers;
   VotePanel.VotePanelInner.Vote1Count._visible = bShowResultNumbers;
   VotePanel.VotePanelInner.Vote2Count._visible = bShowResultNumbers;
   VotePanel.VotePanelInner.ThumbBg1._visible = bShowResultNumbers;
   VotePanel.VotePanelInner.ThumbBg2._visible = bShowResultNumbers;
   setYPositionFromMoney();
}
function flashYesVote()
{
   if(VotePanel.VotePanelInner.ThumbBg1._visible)
   {
      VotePanel.VotePanelInner.ThumbBg1.gotoAndPlay("Flash");
   }
}
function flashNoVote()
{
   if(VotePanel.VotePanelInner.ThumbBg2._visible)
   {
      VotePanel.VotePanelInner.ThumbBg2.gotoAndPlay("Flash");
   }
}
_global.VotePanelMovie = this;
_global.VotePanelAPI = gameAPI;
var voteNav = new Lib.NavLayout();
voteNav.AddKeyHandlerTable({KEY_F1:{onDown:function(button, control, keycode)
{
   if(!_global.wantControllerShown)
   {
      return _global.VotePanelAPI.VoteYes();
   }
   return false;
}},KEY_F2:{onDown:function(button, control, keycode)
{
   if(!_global.wantControllerShown)
   {
      return _global.VotePanelAPI.VoteNo();
   }
   return false;
}},KEY_XBUTTON_LEFT:{onDown:function(button, control, keycode)
{
   if(_global.wantControllerShown)
   {
      _global.VotePanelAPI.VoteYes();
   }
   return true;
}},KEY_XBUTTON_RIGHT:{onDown:function(button, control, keycode)
{
   if(_global.wantControllerShown)
   {
      _global.VotePanelAPI.VoteNo();
   }
   return true;
}}});
_global.resizeManager.AddListener(this);
