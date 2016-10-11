function onResize(rm)
{
   rm.ResetPosition(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.ALIGN_CENTER);
}
function showPanel()
{
   Panel.gotoAndPlay("StartShow");
   Panel.Panel.onShow();
   setUIDevice();
   Panel._visible = true;
}
function hidePanel()
{
   Panel.Panel.onHide();
   Panel.gotoAndPlay("StartHide");
}
function hidePanelImmediate()
{
   Panel.Panel.onHide();
   Panel.gotoAndStop("Hide");
}
function InitDialogData(titleText, messageText, buttonLegendText, thirdButtonLabel, okButtonLabel)
{
   Panel.Panel.dialog.InitDialogData(titleText,messageText,buttonLegendText,thirdButtonLabel,okButtonLabel);
}
function SetTitle(titleText)
{
   Panel.Panel.dialog.SetTitle(titleText);
}
function SetMessage(messageText)
{
   Panel.Panel.dialog.SetMessage(messageText);
}
function SetButtonLegend(buttonLegendText)
{
   Panel.Panel.dialog.SetButtonLegend(buttonLegendText);
}
function SetThirdButtonLabel(thirdButtonLabelText)
{
   Panel.Panel.dialog.SetThirdButtonLabel(thirdButtonLabelText);
}
function SetOKButtonLabel(okButtonLabelText)
{
   Panel.Panel.dialog.SetOKButtonLabel(okButtonLabelText);
}
function SetFlagOk(flagOn)
{
   Panel.Panel.dialog.mOk = flagOn;
   if(flagOn)
   {
      Panel.Panel.spinner._visible = false;
   }
}
function SetFlagCancel(flagOn)
{
   Panel.Panel.dialog.mCancel = flagOn;
}
function SetFlagTertiary(flagOn)
{
   Panel.Panel.dialog.mTertiary = flagOn;
}
function setUIDevice()
{
   if(_global.wantControllerShown)
   {
      Panel.Panel.NavigationMaster.gotoAndStop("ShowController");
   }
   else
   {
      Panel.Panel.NavigationMaster.gotoAndStop("HideController");
   }
}
function changeUIDevice()
{
   if(_global.wantControllerShown)
   {
      Panel.Panel.NavigationMaster.gotoAndPlay("StartShowController");
   }
   else
   {
      Panel.Panel.NavigationMaster.gotoAndPlay("StartHideController");
   }
}
function onUnload(mc)
{
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   _global.FreeMessageBoxLevel(elementLevel);
   delete MainUI.MessageBox.MessageBox;
   return true;
}
function onLoaded()
{
   _global.SetMessageBoxAtLevel(elementLevel,this,gameAPI);
   Panel.MBLevel = elementLevel;
   setUIDevice();
   Panel.Panel.InitDialog(elementLevel);
   gameAPI.OnReady();
   _global.resizeManager.AddListener(this);
   onResize(_global.resizeManager);
}
Panel._visible = false;
stop();
