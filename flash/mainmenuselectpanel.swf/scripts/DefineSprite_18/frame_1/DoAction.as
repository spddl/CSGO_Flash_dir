function InitPlayMenu()
{
   InitPlayMenuButtons();
   onShow();
}
function onShow()
{
   MainMenuPlaySubPanel.gotoAndPlay("StartShow");
   MainMenuPlaySubPanel.RolloverDetect._visible = true;
}
function InitPlayMenuButtons()
{
   var _loc3_ = MainMenuPlaySubPanel.CustomMatchButton;
   _loc3_ = MainMenuPlaySubPanel.CustomMatchButton;
   _loc3_.SetText("#SFUI_PlayMenu_CustomMatchButton");
   _loc3_.Type = "Custom";
   _loc3_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   _loc3_ = MainMenuPlaySubPanel.PlayWithFriendsButton;
   _loc3_.SetText("#SFUI_PlayMenu_FriendsMatchButton");
   _loc3_.Type = "Friends";
   _loc3_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   if(!_global.GameInterface.GetConvarBoolean("play_with_friends_enabled"))
   {
      _loc3_.setDisabled(true);
   }
   var _loc4_ = _global.CScaleformComponent_MyPersona.GetLauncherType() != "perfectworld"?false:true;
   if(!_loc4_)
   {
      _loc3_ = MainMenuPlaySubPanel.CommunityServersButton;
      _loc3_.SetText("#SFUI_PlayMenu_BrowseServersButton");
      _loc3_.Type = "Browser";
      _loc3_.Action = function()
      {
         onSelectedButton(this.Type);
      };
   }
   MainMenuPlaySubPanel.Line._visible = _loc4_;
   MainMenuPlaySubPanel.CommunityServersButton._visible = !_loc4_;
   _loc3_ = MainMenuPlaySubPanel.OfflineButton;
   _loc3_.SetText("#SFUI_PlayMenu_WithBotsButton");
   _loc3_.Type = "Offline";
   _loc3_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   _loc3_ = MainMenuPlaySubPanel.TrainingButton;
   _loc3_.SetText("#SFUI_MainMenu_Training");
   _loc3_.Type = "Training";
   _loc3_.Action = function()
   {
      onSelectedButton(this.Type);
   };
   MainMenuPlaySubPanel.RolloverDetect.onMouseUp = function()
   {
      onClickOutsidePlay(this);
   };
   MainMenuPlaySubPanel.RolloverDetect.onRollOver = function()
   {
   };
}
function onClickOutsidePlay(objClickCheck)
{
   if(!objClickCheck.hitTest(_root._xmouse,_root._ymouse,true))
   {
      this._visible = false;
   }
   objSelectPanel.MainMenuTopBar.PlayButton.Selected._visible = false;
}
function onSelectedButton(strMenu)
{
   objSelectPanel.OpenMenu(strMenu);
   this._visible = false;
}
var playSubMenuNav = new Lib.NavLayout();
var lastHighlight = null;
var objSelectPanel = _global.MainMenuMovie.Panel.SelectPanel;
var playSubMenuList = [Button01,Button02,Button03,Button04,Button05,Button06,Button07];
playSubMenuNav.AddTabOrder(playSubMenuList);
playSubMenuNav.AddNavForObject(Button01,{UP:Button07,DOWN:Button02});
playSubMenuNav.AddNavForObject(Button02,{UP:Button01,DOWN:Button03});
playSubMenuNav.AddNavForObject(Button03,{UP:Button02,DOWN:Button04});
playSubMenuNav.AddNavForObject(Button04,{UP:Button03,DOWN:Button05});
playSubMenuNav.AddNavForObject(Button05,{UP:Button04,DOWN:Button06});
playSubMenuNav.AddNavForObject(Button06,{UP:Button05,DOWN:Button07});
playSubMenuNav.AddNavForObject(Button07,{UP:Button06,DOWN:Button01});
playSubMenuNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
{
   _global.MainMenuMovie.Panel.transitionToMainMenu();
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}},KEY_XBUTTON_Y:{onDown:function(button, control, keycode)
{
   _global.MainMenuAPI.ShowInviteOverlay();
   return true;
}}});
playSubMenuNav.SetInitialHighlight(Button05);
playSubMenuNav.ShowCursor(true);
stop();
