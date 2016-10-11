function UpdateScrollBar()
{
   ScrollBar.SetValue(dialog.GetSliderPercentage());
}
function InitDialog()
{
   ScrollBar.Init(false);
   ScrollBar.NotifyValueChange = function()
   {
      _global.HowToPlayMovie.Panel.Panel.dialog.SetSliderPercentage(this.GetValue());
   };
   ScrollBar.m_bNotifyWhileMoving = true;
   dialog.Init();
}
function onShow()
{
   _global.navManager.PushLayout(howToPlayNav,"howToPlayNav");
}
function onHide()
{
   _global.navManager.RemoveLayout(howToPlayNav);
}
function Cleanup()
{
   _global.navManager.RemoveLayout(howToPlayNav);
   delete dialog;
   delete howToPlayNav;
}
var dialog = new MainUI.HowToPlay.HowToPlay(this);
var howToPlayNav = new Lib.NavLayout();
howToPlayNav.AddTabOrder([Button0,Button1,Button2,Button3,Button4,Button5,Button6,Button7,Button8]);
var buttonCount = 9;
var index = 0;
while(index < buttonCount)
{
   var prevButton = this["Button" + (index - 1 + 100 * buttonCount) % buttonCount];
   var targetButton = this["Button" + index];
   var nextButton = this["Button" + (index + 1 + 100 * buttonCount) % buttonCount];
   targetButton._visbile = false;
   howToPlayNav.AddNavDirectionForObject(targetButton,"KEY_XBUTTON_UP",prevButton);
   howToPlayNav.AddNavDirectionForObject(targetButton,"KEY_XSTICK1_UP",prevButton);
   howToPlayNav.AddNavDirectionForObject(targetButton,"KEY_XBUTTON_DOWN",nextButton);
   howToPlayNav.AddNavDirectionForObject(targetButton,"KEY_XSTICK1_DOWN",nextButton);
   index++;
}
howToPlayNav.SetInitialHighlight(Button0);
howToPlayNav.ShowCursor(true);
howToPlayNav.AddRepeatKeys("KEY_XBUTTON_LEFT_SHOULDER","KEY_PAGEUP","KEY_XBUTTON_RIGHT_SHOULDER","KEY_PAGEDOWN");
howToPlayNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
{
   _global.HowToPlayMovie.hidePanel();
}}});
howToPlayNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   dialog.BeginScrollContents(4);
   return true;
},onUp:function(button, control, keycode)
{
   dialog.EndScrollContents();
   return true;
}},"KEY_XSTICK2_UP","KEY_UP","KEY_RIGHT");
howToPlayNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   dialog.PageUp();
}},"KEY_XBUTTON_LEFT_SHOULDER","KEY_PAGEUP");
howToPlayNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   dialog.BeginScrollContents(-4);
   return true;
},onUp:function(button, control, keycode)
{
   dialog.EndScrollContents();
   return true;
}},"KEY_XSTICK2_DOWN","KEY_DOWN","KEY_LEFT");
howToPlayNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   dialog.PageDown();
}},"KEY_XBUTTON_RIGHT_SHOULDER","KEY_PAGEDOWN");
howToPlayNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   dialog.JumpToStart();
}},"KEY_HOME");
howToPlayNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   dialog.JumpToEnd();
}},"KEY_END");
Lib.TintManager.StaticRegisterForTint(ChooseClassHeaderTerrorist,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(TitleBar,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(ButtonBar,Lib.TintManager.TintRegister_All);
stop();
