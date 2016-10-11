var m_scrollSound = "ButtonAction";
var m_nSlideValue = 0;
var m_nSlideMin = 0;
var m_nSlideMax = 0;
var m_bDraggingMouse = false;
var m_nBoundingX = 0;
var m_nBoundingY = 0;
var m_nBoundingWidth = 0;
var m_nBoundingHeight = 0;
var m_nDefaultScrollPipWidth = 1;
var m_LightButtonsOnHighlight = true;
var m_nIncrementAmount = 1;
var navLayout = null;
var m_bDisabled = false;
var m_bNotifyWhileMoving = true;
var m_nScaledValueMin = 0;
var m_nScaledValueMax = 0;
var m_nScaledValueRange = 0;
var m_strConvar = undefined;
var m_bforceInputFieldSignSwap = false;
var RepeatKeys = new Array();
Lib.NavLayout.AddRepeatKeysToObject(RepeatKeys,"LEFT","RIGHT");
var RepeatRate = 10;
var keyHandler = new Object();
Lib.NavLayout.AddDirectionKeyHandlersToObject({onDown:function(button, control, keycode)
{
   if(!m_bDisabled)
   {
      Increment();
      NotifyValueChange();
      Play_scrollSound();
   }
   RightButton.gotoAndPlay("StartOver");
   return true;
},onUp:function(button, control, keycode)
{
   RightButton.gotoAndPlay("StartUp");
   return true;
}},keyHandler,"RIGHT");
Lib.NavLayout.AddDirectionKeyHandlersToObject({onDown:function(button, control, keycode)
{
   if(!m_bDisabled)
   {
      Decrement();
      NotifyValueChange();
      Play_scrollSound();
   }
   LeftButton.gotoAndPlay("StartOver");
   return true;
},onUp:function(button, control, keycode)
{
   LeftButton.gotoAndPlay("StartUp");
   return true;
}},keyHandler,"LEFT");
ScrollPip.onPress = function()
{
   if(!isModalLockedOut())
   {
      m_bDraggingMouse = true;
      startDrag(this,0,m_nSlideMin,m_nBoundingY + this.SlideBar._height / 2,m_nSlideMax,m_nBoundingY + this.SlideBar._height / 2);
   }
};
ScrollPip.onRelease = function()
{
   Released();
};
ScrollPip.onReleaseOutside = function()
{
   Released();
};
ScrollPip.onMouseMove = function()
{
   if(m_bDraggingMouse)
   {
      if(m_bNotifyWhileMoving)
      {
         NotifyValueChange();
      }
      Play_scrollSound();
   }
};
function DefineScaledValueRange(nScaledMin, nScaledMax)
{
   m_nScaledValueMin = nScaledMin;
   m_nScaledValueMax = nScaledMax;
   m_nScaledValueRange = nScaledMax - nScaledMin;
}
function DefinePipBarWidth(nMaxVisible, nMaxTotal)
{
   var _loc2_ = m_nBoundingWidth;
   var _loc3_ = 25;
   var _loc1_ = nMaxVisible / nMaxTotal * _loc2_;
   if(_loc1_ > _loc2_)
   {
      _loc1_ = _loc2_;
   }
   if(_loc1_ < _loc3_)
   {
      _loc1_ = _loc3_;
   }
   ScrollPip._width = _loc1_;
   trace("DefinePipBarWidth: setting width to " + _loc1_ + ", nMaxWidth = " + _loc2_ + ", nMaxVisible = " + nMaxVisible + ", nMaxTotal = " + nMaxTotal);
}
function GetValueScaled()
{
   return m_nScaledValueMin + GetValue() / 100 * m_nScaledValueRange;
}
function SetValueScaled(nScaledValue)
{
   var _loc1_ = nScaledValue - m_nScaledValueMin;
   SetValue(_loc1_ / m_nScaledValueRange * 100);
}
function SetModalNavLayout(navlayout)
{
   navLayout = navlayout;
   LeftButton.navLayout = navlayout;
   RightButton.navLayout = navlayout;
}
function notifyExecuteInput()
{
}
function executeInputCallback(input)
{
   if(m_strConvar != undefined)
   {
      if(m_bforceInputFieldSignSwap)
      {
         input = String(Number(input) * -1);
      }
      _global.GameInterface.SetConvar(m_strConvar,input);
      notifyExecuteInput();
   }
}
function deleteCharAt(strTarget, nTargetPos)
{
   strTarget = strTarget.slice(0,nTargetPos).toString() + strTarget.substr(nTargetPos + 1).toString();
   return strTarget;
}
function UpdateConvar(strConvar)
{
   if(InputField != undefined)
   {
      m_strConvar = strConvar;
      m_bforceInputFieldSignSwap = _global.GameInterface.GetConvarNumber(m_strConvar) < 0;
   }
}
function Init(strConvar)
{
   if(strConvar == false || strConvar == true)
   {
      strConvar = undefined;
   }
   m_strConvar = strConvar;
   if(InputField != undefined)
   {
      Lib.Controls.SFInputField.InitInputFieldObject(InputField);
      InputField.maxInputWidth = InputField.maxInputWidth * 3;
      InputField.executeInputCallback = executeInputCallback;
      InputField.validChars = "0123456789.";
      InputField.maxLength = 4;
      if(_global.GameInterface.GetConvarNumber(m_strConvar) < 0)
      {
         m_bforceInputFieldSignSwap = true;
      }
      InputField.ExternalFilter = function(input)
      {
         var _loc4_ = input.indexOf(".");
         var _loc3_ = input.lastIndexOf(".");
         while(_loc4_ != _loc3_)
         {
            input = deleteCharAt(input,_loc3_);
            _loc4_ = input.indexOf(".");
            _loc3_ = input.lastIndexOf(".");
         }
         var _loc2_ = input.indexOf("-");
         while(_loc2_ != -1)
         {
            input = deleteCharAt(input,_loc2_);
            _loc2_ = input.indexOf("-");
         }
         if(input.length > InputField.maxLength)
         {
            input = input.slice(0,InputField.maxLength);
         }
         return input;
      };
   }
   m_nBoundingX = this.SlideBar._x;
   m_nBoundingY = this.SlideBar._y;
   m_nBoundingWidth = this.SlideBar._width;
   m_nBoundingHeight = this.SlideBar._height;
   m_nDefaultScrollPipWidth = ScrollPip._width;
   var _loc6_ = this.ScrollPip._x;
   m_nSlideMin = _loc6_;
   m_nSlideMax = m_nBoundingX + m_nBoundingWidth;
   m_nSlideMax = m_nSlideMax - (ScrollPip._width + (_loc6_ - m_nBoundingX));
}
function Play_scrollSound()
{
   _global.navManager.PlayNavSound(highlightSound);
}
function Decrement()
{
   var _loc1_ = m_nSlideValue - m_nIncrementAmount;
   if(_loc1_ < 0)
   {
      _loc1_ = 0;
   }
   if(_loc1_ != m_nSlideValue)
   {
      SetValue(_loc1_);
      NotifyValueChange();
   }
}
function Increment()
{
   var _loc1_ = m_nSlideValue + m_nIncrementAmount;
   if(_loc1_ > 100)
   {
      _loc1_ = 100;
   }
   if(_loc1_ != m_nSlideValue)
   {
      SetValue(_loc1_);
      NotifyValueChange();
   }
}
function enterHighlight()
{
   if(m_LightButtonsOnHighlight)
   {
      if(this.LeftButton != undefined)
      {
         this.LeftButton.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
      }
      if(this.ScrollPip != undefined)
      {
         this.ScrollPip.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
      }
      if(this.RightButton != undefined)
      {
         this.RightButton.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
      }
   }
   if(this.FocusPanel != undefined && this.FocusPanel != null)
   {
      this.FocusPanel._visible = true;
   }
   if(InputField != undefined)
   {
      Selection.setFocus(null);
   }
}
function exitHighlight()
{
   if(this.LeftButton != undefined)
   {
      this.LeftButton.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
   }
   if(this.ScrollPip != undefined)
   {
      this.ScrollPip.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
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
function RefreshInputField()
{
   if(m_strConvar != undefined)
   {
      var _loc2_ = _global.GameInterface.GetConvarNumber(m_strConvar);
      if(_loc2_ == null)
      {
         _loc2_ = 0;
      }
      _loc2_ = Math.round(_loc2_ = _loc2_ * 10000) / 10000;
      if(InputField != undefined)
      {
         InputField.updateString(_loc2_.toString());
      }
      SlideBarFull._width = ScrollPip._x - SlideBarFull._x;
   }
}
function SetValue(nNewValue)
{
   var _loc1_ = (m_nSlideMax - m_nSlideMin) / 100 * Math.min(Math.max(nNewValue,0),100) + m_nSlideMin;
   ScrollPip._x = _loc1_;
   m_nSlideValue = nNewValue;
   if(m_strConvar != undefined)
   {
      RefreshInputField();
   }
}
function GetValue()
{
   var _loc1_ = undefined;
   _loc1_ = ScrollPip._x;
   var _loc2_ = (_loc1_ - m_nSlideMin) / (m_nSlideMax - m_nSlideMin) * 100;
   return Math.ceil(_loc2_);
}
function NotifyValueChange()
{
   trace("Override Me!");
}
function setDisabled(bDisabled)
{
   m_bDisabled = bDisabled;
   if(bDisabled)
   {
      gotoAndStop("Disabled");
   }
   else
   {
      gotoAndStop("Active");
   }
}
function isDisabled()
{
   return m_bDisabled;
}
function Released()
{
   if(m_bDraggingMouse)
   {
      m_bDraggingMouse = false;
      this.stopDrag();
      SetValue(GetValue());
      NotifyValueChange();
   }
}
function isModalLockedOut()
{
   if(_global.navManager != null)
   {
      if(_global.navManager.IsTopLayoutModal())
      {
         return navLayout == null || !_global.navManager.IsTopLayoutEqualTo(navLayout);
      }
   }
   return false;
}
if(InputField != undefined)
{
   InputField.RolledOver = function()
   {
      trace("override inputfield[rolledover]");
   };
   InputField.onRollOver = function()
   {
      if(!m_bDisabled)
      {
         this.RolledOver();
      }
   };
}
SlideBar.onPress = function()
{
   if(!m_bDisabled)
   {
      ScrollPip._x = _xmouse - ScrollPip._width / 2;
      SetValue(GetValue());
      NotifyValueChange();
   }
};
ScrollPip.onRollOver = function()
{
};
LeftButton.ButtonParent = this;
LeftButton.Action = function()
{
   if(!m_bDisabled)
   {
      Decrement();
   }
};
LeftButton.Focus = function()
{
};
LeftButton.objectToHighlightOnMouseFocus = this;
RightButton.ButtonParent = this;
RightButton.Action = function()
{
   if(!m_bDisabled)
   {
      Increment();
   }
};
RightButton.Focus = function()
{
};
RightButton.objectToHighlightOnMouseFocus = this;
ScrollPip.objectToHighlightOnMouseFocus = this;
stop();
