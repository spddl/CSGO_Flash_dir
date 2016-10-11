function startTimer()
{
   TrialTime.Text._visible = false;
}
function stopTimer()
{
   TrialTime.Text._visible = false;
   clearInterval(_global.PauseMenuInterval);
   delete _global.PauseMenuInterval;
}
function onShow()
{
   startTimer();
   NavToShow = MainMenuNav;
   MainMenuNav.lastHighlight = null;
   SubMenuNavHelp.onHide();
   gotoAndStop("StartShow");
   play();
}
function onHide()
{
   stopTimer();
   gotoAndStop("StartHide");
   play();
   MainMenuNav.onHide();
   SubMenuNavHelp.onHide();
}
function restorePanel()
{
   startTimer();
   gotoAndStop("StartShow");
   play();
}
function updateTrialTime()
{
}
var NavToShow = null;
Lib.TintManager.StaticRegisterForTint(PlayerNameBox.PlayerName,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(MainText.MainText,Lib.TintManager.TintRegister_All);
this.stop();
