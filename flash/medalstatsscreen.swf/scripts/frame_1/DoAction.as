function onResize(rm)
{
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_NONE);
   rm.DisableAdditionalScaling = true;
}
function showPanel(nType)
{
   if(nType < 2)
   {
      var _loc2_ = Math.floor(_global.GameInterface.GetConvarNumber("player_last_medalstats_panel"));
      if(_loc2_ < 0)
      {
         _loc2_ = 0;
      }
      if(_loc2_ > 1)
      {
         _loc2_ = 1;
      }
      nType = _loc2_;
      DialogType = constTypeStats;
      Panel.MenuTitle.SetText("#SFUI_Stats_Title");
   }
   else
   {
      DialogType = constTypeMedals;
      Panel.MenuTitle.SetText("#SFUI_Medals_Title");
   }
   _global.GameInterface.ShowCursor();
   bForcedCursor = true;
   switchPanel(nType);
   Panel.gotoAndPlay("StartShow");
   updateNavButtons();
}
function hidePanel()
{
   if(bForcedCursor)
   {
      _global.GameInterface.HideCursor();
      bForcedCursor = false;
   }
   Panel.gotoAndPlay("StartHide");
   switchPanel(-1);
}
function dismissPanel()
{
   hidePanel();
}
function SwitchPanelGeneric(bCycleLeft)
{
   if(OverallStatsPanel._visible)
   {
      if(bCycleLeft)
      {
         switchPanel(1);
      }
      else
      {
         switchPanel(1);
      }
   }
   else if(LastMatchStatsPanel._visible)
   {
      if(bCycleLeft)
      {
         switchPanel(0);
      }
      else
      {
         switchPanel(0);
      }
   }
}
function leftButtonActivated()
{
   if(PrevPanelButton != undefined)
   {
      PrevPanelButton.gotoAndPlay("StartOver");
   }
}
function leftButtonReleased()
{
   if(PrevPanelButton != undefined)
   {
      PrevPanelButton.gotoAndPlay("StartUp");
   }
}
function rightButtonActivated()
{
   if(NextPanelButton != undefined)
   {
      NextPanelButton.gotoAndPlay("StartOver");
   }
}
function rightButtonReleased()
{
   if(NextPanelButton != undefined)
   {
      NextPanelButton.gotoAndPlay("StartUp");
   }
}
function switchPanel(newPanelToShow)
{
   switch(newPanelToShow)
   {
      case 0:
         LastMatchStatsPanel.onHide();
         MedalsPanel.onHide();
         OverallStatsPanel.onShow();
         break;
      case 1:
         OverallStatsPanel.onHide();
         MedalsPanel.onHide();
         LastMatchStatsPanel.onShow();
         break;
      case 2:
         OverallStatsPanel.onHide();
         LastMatchStatsPanel.onHide();
         MedalsPanel.onShow();
         break;
      default:
         OverallStatsPanel.onHide();
         LastMatchStatsPanel.onHide();
         MedalsPanel.onHide();
   }
}
function prevMedalCategory()
{
   MedalsPanel.prevMedalCategory();
}
function nextMedalCategory()
{
   MedalsPanel.nextMedalCategory();
}
function medalsUp()
{
   MedalsPanel.medalsUp();
}
function medalsDown()
{
   MedalsPanel.medalsDown();
}
function medalsLeft()
{
   MedalsPanel.medalsLeft();
}
function medalsRight()
{
   MedalsPanel.medalsRight();
}
function setMedalsProgress(NumPoints, GoalPoints)
{
   var _loc1_ = !(NumPoints < 0 && GoalPoints < 0);
   mProgressText._visible = _loc1_;
   mProgressBar._visible = _loc1_;
   var _loc4_ = NumPoints + "/" + GoalPoints;
   var _loc3_ = Math.floor(100 * NumPoints / GoalPoints);
   mProgressText.SetText(_loc4_);
   mProgressBar.ProgressBar.gotoAndStop(_loc3_);
}
function setLastMatchFavoriteWeapon(WeaponName)
{
   LastMatchStatsPanel.setLastMatchFavoriteWeapon(WeaponName);
}
function setOverallFavoriteWeaponAndMap(WeaponName, MapName)
{
   OverallStatsPanel.setOverallFavoriteWeaponAndMap(WeaponName,MapName);
}
function InitDialogData()
{
}
function updateNavButtons()
{
   RootPanel.LeftButton._visible = false;
   RootPanel.RightButton._visible = false;
   RootPanel.L1Button._visible = false;
   RootPanel.R1Button._visible = false;
   RootPanel.LBButton._visible = false;
   RootPanel.RBButton._visible = false;
   if(_global.IsPS3())
   {
      PrevPanelButton = RootPanel.L1Button;
      NextPanelButton = RootPanel.R1Button;
   }
   else if(_global.IsXbox() || _global.IsPC() && _global.wantControllerShown)
   {
      PrevPanelButton = RootPanel.LBButton;
      NextPanelButton = RootPanel.RBButton;
   }
   else
   {
      PrevPanelButton = RootPanel.LeftButton;
      NextPanelButton = RootPanel.RightButton;
   }
   if(DialogType == constTypeStats)
   {
      PrevPanelButton._visible = true;
      NextPanelButton._visible = true;
      PrevPanelButton.Action = function()
      {
         _global.MedalStatsScreenMovie.SwitchPanelGeneric(true);
      };
      NextPanelButton.Action = function()
      {
         _global.MedalStatsScreenMovie.SwitchPanelGeneric(false);
      };
   }
   else
   {
      PrevPanelButton._visible = false;
      NextPanelButton._visible = false;
      panel.panel.Highlight0._visible = false;
      MedalsPanel.Medals.Text.MedalsTitle._visible = false;
      Panel.Panel.TitleCat._visible = false;
   }
   if(_global.wantControllerShown)
   {
      RootPanel.NavigationMaster.ControllerNavl.SetText("#SFUI_MedalsStats_Help@15");
   }
   MedalsPanel.updateNavButtons();
}
function setUIDevice()
{
   if(_global.wantControllerShown)
   {
      RootPanel.NavigationMaster.gotoAndStop("ShowController");
   }
   else
   {
      RootPanel.NavigationMaster.gotoAndStop("HideController");
   }
   updateNavButtons();
}
function changeUIDevice()
{
   if(_global.wantControllerShown)
   {
      RootPanel.NavigationMaster.gotoAndPlay("StartShowController");
   }
   else
   {
      RootPanel.NavigationMaster.gotoAndPlay("StartHideController");
   }
   updateNavButtons();
}
function cleanup()
{
   OverallStatsPanel.cleanup();
   LastMatchStatsPanel.cleanup();
   MedalsPanel.cleanup();
   if(bForcedCursor)
   {
      _global.GameInterface.HideCursor();
      bForcedCursor = false;
   }
}
function onUnload(mc)
{
   cleanup();
   _global.MedalStatsScreenMovie = null;
   _global.MedalStatsScreenAPI = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function setEloBracketIcon(EloBracket)
{
   var _loc1_ = Panel.Panel.OverAll.OverAll.eloBracket;
   _loc1_._visible = true;
   if(_loc1_ && _loc1_.Image != undefined)
   {
      delete register1.Image;
   }
   var _loc2_ = "elo0" + EloBracket;
   if(_loc2_ != "")
   {
      _loc1_.attachMovie(_loc2_,"Image",_loc1_.getDepth() + 1);
   }
}
function onLoaded()
{
   OverallStatsPanel = Panel.Panel.OverAll;
   LastMatchStatsPanel = Panel.Panel.LastMatch;
   MedalsPanel = Panel.Panel.Medals;
   RootPanel = Panel.Panel.RootPanel;
   RootPanel.NavigationMaster.PCButtons.BackButton.Action = function()
   {
      _global.MedalStatsScreenMovie.dismissPanel();
   };
   mProgressText = MedalsPanel.Medals.Text.TotalCount;
   mProgressBar = MedalsPanel.Medals.ProgressBar;
   OverallStatsPanel.InitPanel();
   LastMatchStatsPanel.InitPanel();
   MedalsPanel.InitPanel();
   setUIDevice();
   gameAPI.OnReady();
}
_global.MedalStatsScreenMovie = this;
_global.MedalStatsScreenAPI = gameAPI;
var OverallStatsPanel = null;
var LastMatchStatsPanel = null;
var MedalsPanel = null;
var RootPanel = null;
var mProgressText = null;
var mProgressBar = null;
var PrevPanelButton = undefined;
var NextPanelButton = undefined;
var DialogType = 1;
var constTypeStats = 1;
var constTypeMedals = 2;
var bForcedCursor = false;
_global.resizeManager.AddListener(this);
stop();
