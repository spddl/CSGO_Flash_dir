function InitAccompMenu()
{
   InitButtons();
   onShow();
}
function onShow()
{
   MainMenuAccompSubPanel.gotoAndPlay("StartShow");
   MainMenuAccompSubPanel.RolloverDetect._visible = true;
}
function onHide()
{
   MainMenuAccompSubPanel.gotoAndPlay("StartHide");
   MainMenuAccompSubPanel.RolloverDetect._visible = false;
   objSelectPanel.UnselectButton();
}
function InitButtons()
{
   var _loc2_ = MainMenuAccompSubPanel.Stats;
   _loc2_ = MainMenuAccompSubPanel.StatsButton;
   _loc2_.SetText("#SFUI_MainMenu_StatsButton");
   _loc2_.Type = "Stats";
   _loc2_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   _loc2_ = MainMenuAccompSubPanel.MedalsButton;
   _loc2_.SetText("#SFUI_MainMenu_MedalButton");
   _loc2_.Type = "Medals";
   _loc2_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   _loc2_ = MainMenuAccompSubPanel.LeaderboardsButton;
   _loc2_.SetText("#SFUI_MainMenu_LeaderboardsButton");
   _loc2_.Type = "Leaderboards";
   _loc2_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   MainMenuAccompSubPanel.RolloverDetect.onMouseUp = function()
   {
      onClickOutsideAccomp(this);
   };
   MainMenuAccompSubPanel.RolloverDetect.onRollOver = function()
   {
   };
}
function onClickOutsideAccomp(objClickCheck)
{
   if(!objClickCheck.hitTest(_root._xmouse,_root._ymouse,true))
   {
      this._visible = false;
   }
   objSelectPanel.MainMenuTopBar.AwardsButton.Selected._visible = false;
}
function onSelectedButton(strMenu)
{
   objSelectPanel.OpenMenu(strMenu);
   this._visible = false;
}
var profileSubMenuNav = new Lib.NavLayout();
var lastHighlight = null;
var objSelectPanel = _global.MainMenuMovie.Panel.SelectPanel;
var profileSubMenuList = [Button1,Button2,Button3,Button4];
profileSubMenuNav.AddTabOrder(profileSubMenuList);
profileSubMenuNav.AddNavForObject(Button1,{UP:Button4,DOWN:Button2});
profileSubMenuNav.AddNavForObject(Button2,{UP:Button1,DOWN:Button3});
profileSubMenuNav.AddNavForObject(Button3,{UP:Button2,DOWN:Button4});
profileSubMenuNav.AddNavForObject(Button4,{UP:Button3,DOWN:Button1});
profileSubMenuNav.AddCancelKeyHandlers({onDown:function(button, control, keycode)
{
   _global.MainMenuMovie.Panel.transitionToMainMenu();
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}});
profileSubMenuNav.SetInitialHighlight(Button1);
profileSubMenuNav.ShowCursor(true);
stop();
