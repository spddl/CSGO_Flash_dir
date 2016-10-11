function onShow()
{
   if(lastHighlight == null)
   {
      subMenuNav.SetInitialHighlight(Button1);
   }
   else
   {
      subMenuNav.SetInitialHighlight(lastHighlight);
   }
   _global.navManager.PushLayout(subMenuNav,"subMenuNav");
   _global.PauseMenuMovie.Panel.NavToShow = this;
   BackButton._visible = !_global.wantControllerShown;
   BackButton.SetText("#SFUI_Back");
   BackButton.Action = function()
   {
      _global.PauseMenuMovie.Panel.MainMenuNav.BackToMain();
   };
   NavTextMovie._visible = _global.wantControllerShown;
   gotoAndStop("StartShow");
   play();
   _visible = true;
}
function onHide()
{
   BackButton._visible = false;
   _global.navManager.RemoveLayout(subMenuNav);
   gotoAndStop("StartHide");
   play();
   _visible = false;
}
function InitButtons(MenuName, ButtonSetup)
{
   HelpTitle.SetText(MenuName);
   var _loc7_ = ButtonSetup.length;
   if(_loc7_ > MaximumButtons)
   {
      trace(" PAUSE MENU WARNING: Only " + MaximumButtons + " buttons MAXIMUM supported in the Pause Sub Menu!");
      _loc7_ = MaximumButtons;
   }
   backPanel._height = backpanelDefaultHeight;
   BackButton._y = backbuttonDefaultY;
   NavTextMovie._y = navtextDefaultY;
   var _loc4_ = 0;
   while(_loc4_ < MaximumButtons)
   {
      var _loc6_ = "Button" + (_loc4_ + 1);
      var _loc3_ = this[_loc6_];
      if(_loc4_ < _loc7_)
      {
         _loc3_._visible = true;
         _loc3_.SetText(ButtonSetup[_loc4_].Name);
         _loc3_.Action = _global.PauseMenuMovie.MakeActionFunction(ButtonSetup[_loc4_].Action,this[_loc6_],this);
         if(ButtonSetup[_loc4_].Enabled != undefined)
         {
            _loc3_.setDisabled(!ButtonSetup[_loc4_].Enabled);
         }
         else
         {
            _loc3_.setDisabled(false);
         }
      }
      else
      {
         backPanel._height = backPanel._height - _loc3_._height;
         BackButton._y = BackButton._y - _loc3_._height;
         NavTextMovie._y = NavTextMovie._y - _loc3_._height;
         _loc3_._visible = false;
      }
      _loc4_ = _loc4_ + 1;
   }
}
var MaximumButtons = 9;
var lastHighlight = null;
var backpanelDefaultHeight = backPanel._height;
var backbuttonDefaultY = BackButton._y;
var navtextDefaultY = NavTextMovie._y;
var subMenuNav = new Lib.NavLayout();
subMenuNav.AddTabOrder([Button1,Button2,Button3,Button4,Button5,Button6,Button7,Button8,Button9,BackButton]);
subMenuNav.AddNavForObject(Button1,{UP:BackButton,DOWN:Button2});
subMenuNav.AddNavForObject(Button2,{UP:Button1,DOWN:Button3});
subMenuNav.AddNavForObject(Button3,{UP:Button2,DOWN:Button4});
subMenuNav.AddNavForObject(Button4,{UP:Button3,DOWN:Button5});
subMenuNav.AddNavForObject(Button5,{UP:Button4,DOWN:Button6});
subMenuNav.AddNavForObject(Button6,{UP:Button5,DOWN:Button7});
subMenuNav.AddNavForObject(Button7,{UP:Button6,DOWN:Button8});
subMenuNav.AddNavForObject(Button8,{UP:Button7,DOWN:Button9});
subMenuNav.AddNavForObject(Button9,{UP:Button8,DOWN:BackButton});
subMenuNav.AddNavForObject(BackButton,{UP:Button9,DOWN:Button1});
subMenuNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
{
   _global.PauseMenuMovie.Panel.MainMenuNav.BackToMain();
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}},KEY_XBUTTON_START:{onDown:function(button, control, keycode)
{
   _global.PauseMenuMovie.Panel.MainMenuNav.OnResumePressed();
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}}});
subMenuNav.SetInitialHighlight(Button1);
subMenuNav.ForceHighlightOnPop(true);
subMenuNav.ShowCursor(true);
stop();
