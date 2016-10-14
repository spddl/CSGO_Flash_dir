function enterHighlight()
{
   if(this.MiddleButton.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
   {
      if(this.LeftButton != undefined)
      {
         this.LeftButton.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
      }
      if(this.MiddleButton != undefined)
      {
         this.MiddleButton.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
      }
      if(this.RightButton != undefined)
      {
         this.RightButton.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
      }
      if(this.FocusPanel != undefined && this.FocusPanel != null)
      {
         this.FocusPanel._visible = true;
      }
   }
}
function exitHighlight()
{
   if(this.MiddleButton.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
   {
      if(this.LeftButton != undefined)
      {
         this.LeftButton.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
      }
      if(this.MiddleButton != undefined)
      {
         this.MiddleButton.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
      }
      if(this.RightButton != undefined)
      {
         this.RightButton.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
      }
      if(this.FocusPanel != undefined && this.FocusPanel != null)
      {
         this.FocusPanel._visible = false;
      }
   }
}
function PlayScrollSound()
{
   _global.navManager.PlayNavSound(scrollSound);
}
function MoveLeft()
{
   trace("Move Left");
}
function MoveRight()
{
   trace("Move Right");
}
function setDisabled(disable)
{
   this.LeftButton.setDisabled(disable);
   this.MiddleButton.setDisabled(disable);
   this.RightButton.setDisabled(disable);
}
var scrollSound = "ButtonAction";
Lib.Controls.SFText.AddSFTextBehaviorToObjectWithChild(this,MiddleButton);
Lib.Controls.SFText.MarkAsNonCollectible(this);
Lib.Controls.SFText.MarkAsNonCollectible(LeftButton);
Lib.Controls.SFText.MarkAsNonCollectible(RightButton);
Lib.Controls.SFText.MarkAsNonCollectible(MiddleButton);
var RepeatKeys = new Array();
Lib.NavLayout.AddRepeatKeysToObject(RepeatKeys,"LEFT","RIGHT");
var keyHandler = new Object();
Lib.NavLayout.AddDirectionKeyHandlersToObject({onDown:function(button, control, keycode)
{
   if(button.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
   {
      button.RightButton.setState(Lib.Controls.SFButton.BUTTON_STATE_DOWN);
      button.PlayScrollSound();
      button.MoveRight();
      RightButton.gotoAndPlay("StartOver");
   }
   return true;
},onUp:function(button, control, keycode)
{
   if(button.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
   {
      if(button != undefined && button != null && button.RightButton != undefined && button.RightButton != null)
      {
         button.RightButton.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
      }
      RightButton.gotoAndPlay("StartUp");
   }
   return true;
}},keyHandler,"RIGHT");
Lib.NavLayout.AddDirectionKeyHandlersToObject({onDown:function(button, control, keycode)
{
   if(button.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
   {
      button.LeftButton.setState(Lib.Controls.SFButton.BUTTON_STATE_DOWN);
      button.PlayScrollSound();
      button.MoveLeft();
      LeftButton.gotoAndPlay("StartOver");
   }
   return true;
},onUp:function(button, control, keycode)
{
   if(button.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
   {
      if(button != undefined && button != null && button.LeftButton != undefined && button.LeftButton != null)
      {
         button.LeftButton.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
      }
      LeftButton.gotoAndPlay("StartUp");
   }
   return true;
}},keyHandler,"LEFT");
LeftButton.ButtonParent = this;
LeftButton.Action = function()
{
   this.ButtonParent.MoveLeft();
};
LeftButton.Focus = function()
{
};
LeftButton.objectToHighlightOnMouseFocus = this;
RightButton.ButtonParent = this;
RightButton.Action = function()
{
   this.ButtonParent.MoveRight();
};
RightButton.Focus = function()
{
};
RightButton.objectToHighlightOnMouseFocus = this;
MiddleButton.Action = function()
{
};
MiddleButton.objectToHighlightOnMouseFocus = this;
this.stop();
