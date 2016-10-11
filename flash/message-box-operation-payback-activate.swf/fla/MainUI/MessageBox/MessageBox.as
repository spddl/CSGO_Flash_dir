class MainUI.MessageBox.MessageBox
{
   var mOk = true;
   var mCancel = true;
   var mTertiary = false;
   var mLevel = 0;
   function MessageBox(thePanel)
   {
      this.mPanel = thePanel;
   }
   function InitDialogData(titleText, messageText, buttonLegendText, thirdButtonLabel, okButtonLabel)
   {
      this.mTitle = titleText;
      this.mMessage = messageText;
      this.mButtonLegend = buttonLegendText;
      this.mTertiaryLabel = thirdButtonLabel;
      this.mOKLabel = okButtonLabel;
   }
   function Init(level)
   {
      this.mLevel = level;
      this.mPanel.Title.SetText(this.mTitle);
      this.mPanel.Message.SetText(this.mMessage);
      _global.AutosizeTextDown(this.mPanel.Message.Message,8);
      this.mPanel.Message.Message.autoSize = "left";
      this.mPanel.NavigationMaster.ControllerNav.SetText(this.mButtonLegend);
      this.mPanel.NavigationMaster.PCButtons.ThirdButton.SetText(this.mTertiaryLabel);
      this.UpdateFlags();
   }
   function SetTitle(titleText)
   {
      this.mTitle = titleText;
      this.mPanel.Title.SetText(this.mTitle);
   }
   function SetMessage(messageText)
   {
      this.mMessage = messageText;
      this.mPanel.Message.SetText(this.mMessage);
   }
   function SetButtonLegend(buttonLegendText)
   {
      this.mButtonLegend = buttonLegendText;
      this.mPanel.NavigationMaster.ControllerNav.SetText(this.mButtonLegend);
   }
   function SetThirdButtonLabel(thirdButtonLabelText)
   {
      this.mTertiaryLabel = thirdButtonLabelText;
      this.mPanel.NavigationMaster.PCButtons.ThirdButton.SetText(thirdButtonLabelText);
   }
   function SetOKButtonLabel(okButtonLabelText)
   {
      this.mOKLabel = okButtonLabelText;
      if(this.mOKLabel == undefined || this.mOKLabel == "")
      {
         this.mPanel.NavigationMaster.PCButtons.OKButtonSetText("#SFUI_MBox_OKButton");
      }
      else
      {
         this.mPanel.NavigationMaster.PCButtons.OKButton.SetText(okButtonLabelText);
      }
   }
   function UpdateFlags()
   {
      var _loc3_ = this.mPanel.NavigationMaster.PCButtons.OKButton;
      _loc3_._visible = this.mOk;
      if(this.mOKLabel == undefined || this.mOKLabel == "")
      {
         _loc3_.SetText("#SFUI_MBox_OKButton");
      }
      else
      {
         _loc3_.SetText(this.mOKLabel);
      }
      _loc3_.mLevel = this.mLevel;
      _loc3_.Action = function()
      {
         _global.GetMessageBoxAPIAtLevel(this.mLevel).OnButtonPress(Lib.SFKey.KeyFromName("KEY_ENTER"));
      };
      var _loc4_ = this.mPanel.NavigationMaster.PCButtons.CancelButton;
      _loc4_._visible = this.mCancel;
      _loc4_.SetText("#SFUI_MBox_CancelButton");
      _loc4_.mLevel = this.mLevel;
      _loc4_.Action = function()
      {
         _global.GetMessageBoxAPIAtLevel(this.mLevel).OnButtonPress(Lib.SFKey.KeyFromName("KEY_ESCAPE"));
      };
      var _loc5_ = this.mPanel.NavigationMaster.PCButtons.ThirdButton;
      _loc5_._visible = this.mTertiary;
      _loc5_.SetText(this.mTertiaryLabel);
      _loc5_.mLevel = this.mLevel;
      _loc5_.Action = function()
      {
         _global.GetMessageBoxAPIAtLevel(this.mLevel).OnButtonPress(Lib.SFKey.KeyFromName("KEY_XBUTTON_Y"));
      };
   }
}
