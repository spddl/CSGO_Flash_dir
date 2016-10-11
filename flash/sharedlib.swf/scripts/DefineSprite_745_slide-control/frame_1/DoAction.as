function PlayScrollSound()
{
   _global.navManager.PlayNavSound(highlightSound);
}
function Decrement()
{
   if(nSlideValue >= nSlideMin)
   {
      nSlideValue--;
      SetValue(nSlideValue);
   }
}
function Increment()
{
   if(nSlideValue < nSlideMax)
   {
      nSlideValue++;
      SetValue(nSlideValue);
   }
}
function enterHighlight()
{
}
function exitHighlight()
{
}
function SetValue(nNewValue)
{
   nSlideValue = nNewValue;
   SliderBar.gotoAndStop(nNewValue);
}
function GetValue()
{
   return nSlideValue - 1;
}
function NotifyValueChange()
{
   trace("Override Me!");
}
Lib.Controls.SFButton.InitAsStandardSFButton(this);
var scrollSound = "ButtonAction";
var nSlideValue = 1;
var nSlideMin = 2;
var nSlideMax = 101;
var RepeatKeys = new Array();
Lib.NavLayout.AddRepeatKeysToObject(RepeatKeys,"LEFT","RIGHT");
var RepeatRate = 10;
var keyHandler = new Object();
Lib.NavLayout.AddDirectionKeyHandlersToObject({onDown:function(button, control, keycode)
{
   Increment();
   NotifyValueChange();
   PlayScrollSound();
   RightButton.gotoAndPlay("StartOver");
   return true;
},onUp:function(button, control, keycode)
{
   RightButton.gotoAndPlay("StartUp");
   return true;
}},keyHandler,"RIGHT");
Lib.NavLayout.AddDirectionKeyHandlersToObject({onDown:function(button, control, keycode)
{
   Decrement();
   NotifyValueChange();
   PlayScrollSound();
   LeftButton.gotoAndPlay("StartOver");
   return true;
},onUp:function(button, control, keycode)
{
   LeftButton.gotoAndPlay("StartUp");
   return true;
}},keyHandler,"LEFT");
stop();
