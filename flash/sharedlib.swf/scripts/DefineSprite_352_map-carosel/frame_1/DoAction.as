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
function MoveLeft()
{
   if(!bAnimating)
   {
      if(ScrollLeft())
      {
         bAnimating = true;
         MiddleButton.MapList.gotoAndPlay("ScrollLeft");
      }
   }
   else
   {
      iQueuedCommand = QUEUED_LEFT;
   }
}
function MoveRight()
{
   if(!bAnimating)
   {
      if(ScrollRight())
      {
         bAnimating = true;
         MiddleButton.MapList.gotoAndPlay("ScrollRight");
      }
   }
   else
   {
      iQueuedCommand = QUEUED_RIGHT;
   }
}
function FinishAnimation()
{
   if(bAnimating)
   {
      bAnimating = false;
      ScrollDone();
      var _loc1_ = iQueuedCommand;
      iQueuedCommand = QUEUED_NONE;
      if(_loc1_ == QUEUED_LEFT)
      {
         MoveLeft();
      }
      else if(_loc1_ == QUEUED_RIGHT)
      {
         MoveRight();
      }
   }
}
function ScrollLeft()
{
   return true;
}
function ScrollRight()
{
   return true;
}
function ScrollDone()
{
}
function SetImageData(imagePaths)
{
   var _loc4_ = 0;
   var _loc3_ = 0;
   while(_loc3_ < imagePaths.length)
   {
      var _loc2_ = 0;
      while(_loc2_ < elementNames[_loc4_].length)
      {
         var _loc1_ = elementNames[_loc4_][_loc2_];
         if(MiddleButton.MapList[_loc1_].Thumbnail.mapImage != undefined)
         {
            delete MiddleButton.MapList[_loc1_].Thumbnail.mapImage;
         }
         if(imagePaths[_loc3_] != undefined)
         {
            MiddleButton.MapList[_loc1_].Thumbnail.attachMovie(imagePaths[_loc3_],"mapImage",0);
            MiddleButton.MapList[_loc1_]._visible = true;
         }
         else
         {
            MiddleButton.MapList[_loc1_]._visible = false;
         }
         _loc2_ = _loc2_ + 1;
      }
      _loc4_ = _loc4_ + 1;
      _loc3_ = _loc3_ + 1;
   }
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
var elementNames = new Array(new Array("PPP"),new Array("PreviousPrevious"),new Array("Previous","PreviousOverlay"),new Array("Current"),new Array("Next","NextOverlay"),new Array("NextNext"),new Array("NNN"));
var QUEUED_NONE = 0;
var QUEUED_LEFT = 1;
var QUEUED_RIGHT = 2;
var bAnimating = false;
var iQueuedCommand = 0;
stop();
