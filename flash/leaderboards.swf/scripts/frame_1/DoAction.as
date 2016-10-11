function onResize(rm)
{
   rm.ResetPositionByPixel(LeaderBoards,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_NONE);
   rm.DisableAdditionalScaling = true;
}
function showPanel()
{
   LeaderBoards.gotoAndPlay("StartShow");
   LeaderBoards.Panel.onShow();
}
function hidePanel()
{
   LeaderBoards.gotoAndPlay("StartHide");
   LeaderBoards.Panel.onHide();
}
function PrevLeaderBoard()
{
   LeaderBoards.Panel.PrevLeaderBoard();
}
function NextLeaderBoard()
{
   LeaderBoards.Panel.NextLeaderBoard();
}
function CycleMode()
{
   NextMode();
}
function CycleFilter()
{
   LeaderBoards.Panel.CycleFilter();
}
function CycleInputDevice()
{
   LeaderBoards.Panel.CycleInputDevice();
}
function PrevMode()
{
   LeaderBoards.Panel.PrevMode();
}
function NextMode()
{
   LeaderBoards.Panel.NextMode();
}
function UpPressed()
{
   LeaderBoards.Panel.UpPressed();
}
function DownPressed()
{
   LeaderBoards.Panel.DownPressed();
}
function onClickedRow(button)
{
   LeaderBoards.Panel.onClickedRow(button);
}
function DisplayCurrentRowUserInfo()
{
   LeaderBoards.Panel.DisplayCurrentRowUserInfo();
}
function InitDialogData()
{
   LeaderBoards.Panel.InitPanel();
   if(_global.IsPS3())
   {
      LeaderBoards.Panel.Navigation.SetText("#SFUI_Leaderboards_Navigation_PS3");
   }
}
function NotifyResults()
{
   LeaderBoards.Panel.NotifyResults();
}
function setUIDevice()
{
   if(_global.wantControllerShown)
   {
      LeaderBoards.Panel.NavigationMaster.gotoAndStop("ShowController");
   }
   else
   {
      LeaderBoards.Panel.NavigationMaster.gotoAndStop("HideController");
   }
   UpdateGlyphText();
}
function changeUIDevice()
{
   if(_global.wantControllerShown)
   {
      LeaderBoards.Panel.NavigationMaster.gotoAndPlay("StartShowController");
   }
   else
   {
      LeaderBoards.Panel.NavigationMaster.gotoAndPlay("StartHideController");
   }
   UpdateGlyphText();
}
function UpdateGlyphText()
{
   var _loc2_ = LeaderBoards.Panel;
   _loc2_.ModeGlyph._visible = _global.wantControllerShown;
   _loc2_.FilterGlyph._visible = _global.wantControllerShown;
   _loc2_.DeviceGlyph._visible = _global.wantControllerShown && LeaderBoards.Panel.DeviceGlyph.wantsDeviceForBoard;
   if(_global.wantControllerShown)
   {
      _loc2_.ModeGlyph.SetText("#SFUI_LBMode_X");
      _loc2_.FilterGlyph.SetText("#SFUI_LBFilter_Y");
      _loc2_.DeviceGlyph.SetText("#SFUI_LBDevice_LS");
      _loc2_.NavigationMaster.ControllerNav.SetText("#SFUI_Leaderboards_Navigation@15");
   }
   _loc2_.LBButton._visible = false;
   _loc2_.RBButton._visible = false;
   _loc2_.L1Button._visible = false;
   _loc2_.R1Button._visible = false;
   _loc2_.LeftButton._visible = false;
   _loc2_.RightButton._visible = false;
   if(_global.IsPS3())
   {
      PrevCatButton = _loc2_.L1Button;
      NextCatButton = _loc2_.R1Button;
   }
   else if(_global.IsXbox() || _global.IsPC() && _global.wantControllerShown)
   {
      PrevCatButton = _loc2_.LBButton;
      NextCatButton = _loc2_.RBButton;
   }
   else
   {
      PrevCatButton = _loc2_.LeftButton;
      NextCatButton = _loc2_.RightButton;
   }
   PrevCatButton._visible = true;
   NextCatButton._visible = true;
   PrevCatButton.Action = function()
   {
      _global.LeaderBoardsMovie.PrevLeaderBoard();
   };
   NextCatButton.Action = function()
   {
      _global.LeaderBoardsMovie.NextLeaderBoard();
   };
   PrevCatButton.gotoAndStop("Up");
}
function onUnload(mc)
{
   LeaderBoards.Panel.cleanup();
   _global.tintManager.DeregisterAll(this);
   _global.LeaderBoardsMovie = null;
   _global.LeaderBoardsAPI = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onLoaded()
{
   setUIDevice();
   LeaderBoards.Panel.NavigationMaster.PCButtons.BackButton.Action = function()
   {
      _global.LeaderBoardsMovie.hidePanel();
   };
   LeaderBoards.Panel.NavigationMaster.PCButtons.BackButton.SetText("#SFUI_Back");
   LeaderBoards.Panel.NavigationMaster.PCButtons.ShowProfile.Action = function()
   {
      _global.LeaderBoardsMovie.DisplayCurrentRowUserInfo();
   };
   LeaderBoards.Panel.NavigationMaster.PCButtons.ShowProfile.SetText("#SFUI_Leaderboards_Show_Profile");
   LeaderBoards.Panel.NavigationMaster.PCButtons.ShowProfile._visible = !_global.IsPS3();
   gameAPI.OnReady();
}
function isDoubleClickActive()
{
   return bDoubleClickEnabled;
}
function startDoubleClickTimer()
{
   stopDoubleClickTimer();
   bDoubleClickEnabled = true;
   doubleClickInterval = setInterval(this,"stopDoubleClickTimer",doubleClickTiming);
}
function stopDoubleClickTimer()
{
   clearInterval(doubleClickInterval);
   bDoubleClickEnabled = false;
}
_global.LeaderBoardsMovie = this;
_global.LeaderBoardsAPI = gameAPI;
var PrevCatButton = undefined;
var NextCatButton = undefined;
var bDoubleClickEnabled = false;
var doubleClickInterval;
var doubleClickTiming = 750;
_global.resizeManager.AddListener(this);
stop();
