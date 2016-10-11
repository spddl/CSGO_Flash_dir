function InitOptionsMenu()
{
   InitButtons();
   onShow();
}
function onShow()
{
   MainMenuOptionsSubPanel.gotoAndPlay("StartShow");
   MainMenuOptionsSubPanel.RolloverDetect._visible = true;
}
function onHide()
{
   MainMenuOptionsSubPanel.gotoAndPlay("StartHide");
   MainMenuOptionsSubPanel.RolloverDetect._visible = false;
   objSelectPanel.UnselectButton();
}
function InitButtons()
{
   var _loc2_ = MainMenuOptionsSubPanel.ControllerButton;
   _loc2_ = MainMenuOptionsSubPanel.ControllerButton;
   _loc2_.SetText("#SFUI_HelpMenu_ControlsButton");
   _loc2_.Type = "Controller";
   _loc2_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   _loc2_ = MainMenuOptionsSubPanel.MouseKeyboardButton;
   _loc2_.SetText("#SFUI_HelpMenu_MouseKeyboardButton");
   _loc2_.Type = "Mouse";
   _loc2_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   _loc2_ = MainMenuOptionsSubPanel.SettingButton;
   _loc2_.SetText("#SFUI_HelpMenu_SettingsButton");
   _loc2_.Type = "Settings";
   _loc2_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   _loc2_ = MainMenuOptionsSubPanel.VideoButton;
   _loc2_.SetText("#SFUI_HelpMenu_VideoSettings");
   _loc2_.Type = "Video";
   _loc2_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   _loc2_ = MainMenuOptionsSubPanel.AudioButton;
   _loc2_.SetText("#SFUI_HelpMenu_AudioSettings");
   _loc2_.Type = "Audio";
   _loc2_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   _loc2_ = MainMenuOptionsSubPanel.CreditsButton;
   _loc2_.SetText("#SFUI_HelpMenu_CreditsButton");
   _loc2_.Type = "Credits";
   _loc2_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   _loc2_.actionSound = "ButtonNA";
   MainMenuOptionsSubPanel.RolloverDetect.onMouseUp = function()
   {
      onClickOutsideOptions(this);
   };
   MainMenuOptionsSubPanel.RolloverDetect.onRollOver = function()
   {
   };
}
function onClickOutsideOptions(objClickCheck)
{
   if(!objClickCheck.hitTest(_root._xmouse,_root._ymouse,true))
   {
      this._visible = false;
   }
   objSelectPanel.MainMenuTopBar.OptionsButton.Selected._visible = false;
}
function onSelectedButton(strMenu)
{
   objSelectPanel.OpenMenu(strMenu);
   this._visible = false;
}
var helpSubMenuNav = new Lib.NavLayout();
var lastHighlight = null;
var objSelectPanel = _global.MainMenuMovie.Panel.SelectPanel;
var helpSubMenuList = [Button1,Button2,Button3,Button4,Button5,Button6,Button7,Button8,Button9];
helpSubMenuNav.AddTabOrder(helpSubMenuList);
helpSubMenuNav.AddNavForObject(Button1,{UP:Button9,DOWN:Button2});
helpSubMenuNav.AddNavForObject(Button2,{UP:Button1,DOWN:Button3});
helpSubMenuNav.AddNavForObject(Button3,{UP:Button2,DOWN:Button4});
helpSubMenuNav.AddNavForObject(Button4,{UP:Button3,DOWN:Button5});
helpSubMenuNav.AddNavForObject(Button5,{UP:Button4,DOWN:Button6});
helpSubMenuNav.AddNavForObject(Button6,{UP:Button5,DOWN:Button7});
helpSubMenuNav.AddNavForObject(Button7,{UP:Button6,DOWN:Button8});
helpSubMenuNav.AddNavForObject(Button8,{UP:Button7,DOWN:Button9});
helpSubMenuNav.AddNavForObject(Button9,{UP:Button8,DOWN:Button1});
helpSubMenuNav.AddCancelKeyHandlers({onDown:function(button, control, keycode)
{
   _global.MainMenuMovie.Panel.transitionToMainMenu();
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}});
helpSubMenuNav.SetInitialHighlight(Button2);
helpSubMenuNav.ShowCursor(true);
stop();
