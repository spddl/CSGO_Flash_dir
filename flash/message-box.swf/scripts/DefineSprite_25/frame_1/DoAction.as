function InitDialog(level)
{
   dialog.Init(level);
}
function onShow()
{
   this.NavigationMaster.PCButtons.OKButton.navLayout = messageBoxNav;
   this.NavigationMaster.PCButtons.CancelButton.navLayout = messageBoxNav;
   this.NavigationMaster.PCButtons.ThirdButton.navLayout = messageBoxNav;
   _global.navManager.PushLayout(messageBoxNav,"messageBoxNav");
   timerInterval = setInterval(_global.GetMessageBoxAPIAtLevel(dialog.mLevel).OnTimerCallback,200,null);
   if(MoreInfoBtn)
   {
      this.MoreInfoBtn.navLayout = messageBoxNav;
      SetUpPayback();
   }
}
function onHide()
{
   _global.navManager.RemoveLayout(messageBoxNav);
   if(timerInterval)
   {
      clearInterval(timerInterval);
      delete timerInterval;
   }
}
function SetUpPayback()
{
   this.MoreInfoBtn.dialog = this;
   this.MoreInfoBtn.SetText("#CSGO_MessageBox_More_Info_Button");
   this.MoreInfoBtn.Action = function()
   {
      this.dialog.onMoreInfo(this);
   };
}
function onMoreInfo()
{
   _global.CScaleformComponent_SteamOverlay.OpenURL("http://blog.counter-strike.net/operationvanguard/");
}
var timerInterval;
var dialog = new MainUI.MessageBox.MessageBox(this);
var messageBoxNav = new Lib.NavLayout();
messageBoxNav.SetInitialHighlight(null);
messageBoxNav.MakeModal(true);
messageBoxNav.DenyInputToGame(true);
messageBoxNav.ShowCursor(true);
messageBoxNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
{
   if(dialog.mCancel)
   {
      _global.GetMessageBoxAPIAtLevel(dialog.mLevel).OnButtonPress(Lib.SFKey.KeyFromName("KEY_ESCAPE"));
   }
}},ACCEPT:{onDown:function(button, control, keycode)
{
   if(dialog.mOk)
   {
      _global.GetMessageBoxAPIAtLevel(dialog.mLevel).OnButtonPress(Lib.SFKey.KeyFromName("KEY_ENTER"));
   }
}},KEY_XBUTTON_Y:{onDown:function(button, control, keycode)
{
   if(dialog.mTertiary)
   {
      _global.GetMessageBoxAPIAtLevel(dialog.mLevel).OnButtonPress(Lib.SFKey.KeyFromName("KEY_XBUTTON_Y"));
   }
}}});
stop();
