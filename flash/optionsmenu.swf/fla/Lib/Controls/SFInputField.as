class Lib.Controls.SFInputField extends MovieClip
{
   var inputNav = undefined;
   var inputString = "";
   var maxInputWidth = 0;
   var inputObject = undefined;
   var inputText = undefined;
   var Cursor = undefined;
   var CursorAnchor = undefined;
   var selectingInputWithMouse = false;
   var focusOnInput = false;
   var shiftKeyDown = false;
   var textSelected = false;
   var validChars = undefined;
   var maxLength = 256;
   static var keyCtrlA = 1;
   static var keyDelete = 31;
   static var keyCtrlC = 3;
   static var keyCtrlX = 24;
   static var keyCtrlV = 22;
   static var keyEnter = 13;
   static var keyBackspace = 8;
   static var keyBackquote = 96;
   static var keyEscape = 27;
   function SFInputField()
   {
      super();
   }
   function inputSplitText()
   {
      var _loc6_ = this.inputString;
      var _loc4_ = undefined;
      var _loc5_ = undefined;
      if(this.anchorIndex < this.stretchIndex)
      {
         _loc4_ = this.anchorIndex;
         _loc5_ = this.stretchIndex;
      }
      else
      {
         _loc4_ = this.stretchIndex;
         _loc5_ = this.anchorIndex;
      }
      var _loc3_ = _loc6_.substring(0,_loc4_);
      var _loc8_ = _loc6_.substring(_loc4_,_loc5_);
      var _loc2_ = _loc6_.substring(_loc5_);
      if(_loc3_ == null)
      {
         _loc3_ == "";
      }
      if(_loc8_ == null)
      {
         _loc8_ = "";
      }
      if(_loc2_ == null)
      {
         _loc2_ = "";
      }
      return {left:_loc3_,middle:_loc8_,right:_loc2_};
   }
   function inputRemoveSelectedText()
   {
      var _loc2_ = this.inputSplitText();
      this.inputString = _loc2_.left + _loc2_.right;
      this.insertionPoint = _loc2_.left.length;
      this.anchorIndex = this.insertionPoint;
      this.stretchIndex = this.insertionPoint;
      return _loc2_;
   }
   function setInsertionPoint(index)
   {
      this.insertionPoint = Math.max(0,Math.min(this.inputString.length,index));
      this.anchorIndex = index;
      this.stretchIndex = index;
   }
   function extendSelection(index)
   {
      this.stretchIndex = Math.max(0,Math.min(this.inputString.length,index));
      if(this.stretchIndex <= this.anchorIndex)
      {
         this.insertionPoint = this.stretchIndex;
      }
   }
   function IsTextRestricted(text)
   {
      var _loc2_ = 0;
      while(_loc2_ < text.length)
      {
         if(this.validChars.indexOf(text.charAt(_loc2_)) == -1)
         {
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
   function inputInsertText(text, clip)
   {
      if(this.IsTextRestricted(text))
      {
         return undefined;
      }
      if(clip == null || clip == undefined)
      {
         clip = this.inputSplitText();
      }
      this.inputString = clip.left + text + clip.right;
      this.insertionPoint = clip.left.length + text.length;
      this.anchorIndex = this.insertionPoint;
      this.stretchIndex = this.insertionPoint;
   }
   function resetInputSelection()
   {
      this.insertionPoint = this.inputString.length;
      this.anchorIndex = this.insertionPoint;
      this.stretchIndex = this.insertionPoint;
   }
   function getString()
   {
      return this.inputString;
   }
   function updateString(strUpdate)
   {
      this.inputString = strUpdate;
      this.inputString = this.ExternalFilter(this.inputString);
      this.resetInputFocus(true);
   }
   function resetInputFocus(resetString)
   {
      if(resetString)
      {
         if(this.inputString.length == 0)
         {
            this.inputText.htmlText = "";
         }
         else
         {
            this.inputText.htmlText = _global.GameInterface.MakeStringSafe(this.inputString);
         }
      }
      var _loc3_ = false;
      if(this.focusOnInput)
      {
         if(this.anchorIndex < this.stretchIndex)
         {
            Selection.setSelection(this.anchorIndex,this.stretchIndex);
         }
         else
         {
            Selection.setSelection(this.stretchIndex,this.anchorIndex);
         }
         _loc3_ = true;
         this.updateCursor();
      }
      if(_loc3_)
      {
         if(!this.Cursor._visible)
         {
            this.Cursor.gotoAndPlay(1);
         }
         this.Cursor._visible = true;
      }
      else
      {
         this.Cursor._visible = false;
      }
   }
   function executeInputCallback(input)
   {
   }
   function executeInput()
   {
      this.resetInputSelection();
      this.resetInputFocus(false);
      Selection.setFocus(null);
      this.executeInputCallback(this.inputString);
   }
   function ShiftPressed()
   {
      this.shiftKeyDown = true;
   }
   function ShiftReleased()
   {
      this.shiftKeyDown = false;
   }
   function LeftKeyPressed()
   {
      if(this.focusOnInput)
      {
         if(this.shiftKeyDown)
         {
            this.extendSelection(this.stretchIndex - 1);
         }
         else if(this.stretchIndex != this.anchorIndex)
         {
            this.setInsertionPoint(this.insertionPoint);
         }
         else
         {
            this.setInsertionPoint(this.insertionPoint - 1);
         }
         this.resetInputFocus(false);
      }
   }
   function RightKeyPressed()
   {
      if(this.focusOnInput)
      {
         if(this.shiftKeyDown)
         {
            this.extendSelection(this.stretchIndex + 1);
         }
         else if(this.stretchIndex != this.anchorIndex)
         {
            this.setInsertionPoint(Math.max(this.anchorIndex,this.stretchIndex));
         }
         else
         {
            this.setInsertionPoint(this.insertionPoint + 1);
         }
         this.resetInputFocus(false);
      }
   }
   function HomeButtonPressed()
   {
      if(this.focusOnInput)
      {
         if(this.shiftKeyDown)
         {
            this.extendSelection(0);
         }
         else
         {
            this.setInsertionPoint(0);
         }
         this.resetInputFocus(false);
      }
   }
   function EndButtonPressed()
   {
      if(this.focusOnInput)
      {
         if(this.shiftKeyDown)
         {
            this.extendSelection(this.inputString.length);
         }
         else
         {
            this.setInsertionPoint(this.inputString.length);
         }
         this.resetInputFocus(false);
      }
   }
   function replaceInString(instring, replacethis, withthis)
   {
      var _loc3_ = replacethis.length;
      var _loc2_ = instring.indexOf(replacethis);
      while(_loc2_ != -1)
      {
         if(_loc2_ == 0)
         {
            if(instring.length == _loc3_)
            {
               return "";
            }
            instring = instring.substring(_loc3_);
         }
         else if(_loc2_ == instring.length - _loc3_)
         {
            instring = instring.substring(0,_loc2_) + withthis;
         }
         else
         {
            instring = instring.substring(0,_loc2_) + withthis + instring.substring(_loc2_ + _loc3_);
         }
         _loc2_ = instring.indexOf(replacethis);
      }
      return instring;
   }
   function getClipboard()
   {
      var _loc3_ = _global.GameInterface.GetClipboardText();
      if(_loc3_ == null)
      {
         _loc3_ = "";
      }
      else
      {
         _loc3_ = this.replaceInString(_loc3_,"\"","\'");
         _loc3_ = this.replaceInString(_loc3_,String.fromCharCode(13),"[ret]");
      }
      return _loc3_;
   }
   function sizeInput()
   {
      var _loc4_ = this.maxInputWidth;
      this.inputText.htmlText = _global.GameInterface.MakeStringSafe(this.inputString);
      var _loc3_ = this.inputString.length;
      this.insertionPoint = Math.min(_loc3_,this.insertionPoint);
      this.anchorIndex = Math.min(_loc3_,this.anchorIndex);
      this.stretchIndex = Math.min(_loc3_,this.stretchIndex);
   }
   function onSetFocus(oldfocus, newfocus)
   {
      this.focusOnInput = newfocus == this.inputText;
      if(this.focusOnInput)
      {
         if(_global.CurrentInputField != this)
         {
            _global.navManager.PushLayout(this.inputNav,"inputNav");
            _global.CurrentInputField = this.inputObject;
         }
      }
      else if(_global.CurrentInputField == this)
      {
         _global.navManager.RemoveLayout(this.inputNav);
         _global.CurrentInputField = undefined;
      }
      this.resetInputFocus(false);
   }
   function updateCursor()
   {
      var _loc4_ = this.inputText.getLineMetrics(0);
      var _loc2_ = this.CursorAnchor.x + _loc4_.x;
      if(this.insertionPoint == -1)
      {
         _loc2_ = _loc2_ + this.inputText.textWidth;
      }
      else if(this.insertionPoint > 0)
      {
         var _loc3_ = this.inputText.getExactCharBoundaries(this.insertionPoint - 1);
         _loc2_ = _loc2_ + (_loc3_.right - this.inputText.hscroll);
         _loc2_ = Math.min(_loc2_,this.inputObject._x + this.inputText._width);
      }
      this.Cursor._x = _loc2_;
      this.Cursor.gotoAndPlay(1);
   }
   function getCharIndex(x, right_side)
   {
      var _loc6_ = this.inputObject._height / 2;
      var _loc4_ = -1;
      if(x > this.inputText.textWidth)
      {
         _loc4_ = this.inputString.length;
      }
      else
      {
         var _loc5_ = x + this.inputText.hscroll;
         var _loc2_ = 0;
         while(_loc2_ < this.inputText.length)
         {
            var _loc3_ = this.inputText.getExactCharBoundaries(_loc2_);
            if(_loc3_.contains(_loc5_,_loc3_.bottom / 2))
            {
               _loc4_ = _loc2_;
               break;
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      return _loc4_;
   }
   function onProxyPressed()
   {
      Selection.setFocus(this.inputText);
      var _loc2_ = this.getCharIndex(this.inputObject._xmouse,false);
      if(this.insertionPoint == _loc2_)
      {
         this.setInsertionPoint(0);
         this.extendSelection(this.inputString.length);
      }
      else if(_loc2_ > -1)
      {
         this.setInsertionPoint(_loc2_);
      }
      this.resetInputFocus(false);
   }
   function onProxyMouseMoved()
   {
      if(this.selectingInputWithMouse)
      {
         Selection.setFocus(this.inputText);
         this.extendSelection(this.getCharIndex(this.inputObject._xmouse,false));
         this.resetInputFocus(false);
      }
   }
   function onProxyReleased()
   {
      this.selectingInputWithMouse = false;
      Selection.setFocus(this.inputText);
   }
   function inputStringTyped(typed)
   {
      if(typed == "\"")
      {
         typed = "\'";
      }
      var t = typed.charCodeAt(0);
      if(t == Lib.Controls.SFInputField.keyBackquote)
      {
         return false;
      }
      if(t < 32)
      {
         if(t == Lib.Controls.SFInputField.keyEnter)
         {
            this.executeInput();
            return true;
         }
         if(t != Lib.Controls.SFInputField.keyCtrlA && t != Lib.Controls.SFInputField.keyCtrlC && t != Lib.Controls.SFInputField.keyCtrlV && t != Lib.Controls.SFInputField.keyCtrlX && t != Lib.Controls.SFInputField.keyBackspace && t != Lib.Controls.SFInputField.keyDelete)
         {
            return false;
         }
      }
      if(t == Lib.Controls.SFInputField.keyCtrlA)
      {
         if(this.focusOnInput)
         {
            this.setInsertionPoint(0);
            this.extendSelection(this.inputString.length);
            this.resetInputFocus(false);
         }
         else
         {
            var focusPath = Selection.getFocus();
            if(focusPath == null)
            {
               return true;
            }
            var focusObject = eval(focusPath);
            if(focusObject == null)
            {
               return true;
            }
         }
         return true;
      }
      if(t == Lib.Controls.SFInputField.keyCtrlC || t == Lib.Controls.SFInputField.keyCtrlX)
      {
         var focusPath = Selection.getFocus();
         if(focusPath == null)
         {
            return true;
         }
         var focusObject = eval(focusPath);
         if(focusObject == null)
         {
            return true;
         }
         focusObject.copyToClipboard(false);
         if(t == Lib.Controls.SFInputField.keyCtrlC || !focusPath)
         {
            return true;
         }
      }
      if(!this.focusOnInput)
      {
         return true;
      }
      if(this.anchorIndex != this.stretchIndex)
      {
         this.inputRemoveSelectedText();
         this.resetInputFocus(true);
         if(t == Lib.Controls.SFInputField.keyCtrlX || t == Lib.Controls.SFInputField.keyBackspace || t == Lib.Controls.SFInputField.keyDelete)
         {
            return true;
         }
      }
      if(t == Lib.Controls.SFInputField.keyCtrlX)
      {
         return true;
      }
      if(t == Lib.Controls.SFInputField.keyBackspace)
      {
         if(this.insertionPoint != 0)
         {
            var clip = this.inputSplitText();
            this.inputString = clip.left.slice(0,this.insertionPoint - 1) + clip.right;
            this.setInsertionPoint(this.insertionPoint - 1);
            this.resetInputFocus(true);
         }
         return true;
      }
      if(t == Lib.Controls.SFInputField.keyDelete)
      {
         if(this.insertionPoint != this.inputString.length)
         {
            var clip = this.inputSplitText();
            this.inputString = clip.left + clip.right.slice(1);
            this.resetInputFocus(true);
         }
         return true;
      }
      var textToInsert = typed;
      if(t == Lib.Controls.SFInputField.keyCtrlV)
      {
         textToInsert = this.getClipboard();
      }
      if(this.inputText.textWidth < this.maxInputWidth)
      {
         this.inputInsertText(textToInsert,clip);
         this.inputString = this.ExternalFilter(this.inputString);
         if(this.inputString.length > this.maxLength)
         {
            this.inputString = this.inputString.slice(0,this.maxLength);
         }
         this.sizeInput();
      }
      this.resetInputFocus(true);
      return true;
   }
   function ExternalFilter(input)
   {
      return input;
   }
   function InitNav()
   {
      this.inputNav.ShowCursor(true);
      this.inputNav.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.CurrentInputField.resetInputFocus(true);
         Selection.setFocus(null);
      }},"CANCEL","MOUSE_RIGHT");
      this.inputNav.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.CurrentInputField.HomeButtonPressed();
      }},"KEY_HOME");
      this.inputNav.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.CurrentInputField.EndButtonPressed();
      }},"KEY_END");
      this.inputNav.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.CurrentInputField.ShiftPressed();
         return true;
      },onUp:function(button, control, keycode)
      {
         _global.CurrentInputField.ShiftReleased();
         return true;
      }},"KEY_LSHIFT","KEY_RSHIFT");
      this.inputNav.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.CurrentInputField.LeftKeyPressed();
         return true;
      }},"KEY_LEFT");
      this.inputNav.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.CurrentInputField.RightKeyPressed();
         return true;
      }},"KEY_RIGHT");
      this.inputNav.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         _global.CurrentInputField.inputNav.onCharTyped(String.fromCharCode(Lib.Controls.SFInputField.keyDelete));
      }},"KEY_DELETE");
      this.inputNav.onCharTyped = function(typed)
      {
         if(_global.GameInterface.GetConvarNumber("console_window_open") == 0)
         {
            _global.CurrentInputField.inputStringTyped(typed);
            return true;
         }
         return false;
      };
   }
   static function InitInputFieldObject(targetMovie)
   {
      targetMovie.__proto__ = Lib.Controls.SFInputField.prototype;
      targetMovie.inputObject = targetMovie;
      targetMovie.inputText = targetMovie.inputObject.InputField;
      targetMovie.maxInputWidth = targetMovie.inputText._width;
      targetMovie.inputNav = new Lib.NavLayout();
      targetMovie.Cursor = targetMovie._parent.Cursor;
      targetMovie.CursorAnchor = {x:targetMovie.inputObject._x,y:targetMovie.inputObject._y};
      targetMovie.Cursor._visible = false;
      targetMovie.InitNav();
      Selection.addListener(targetMovie);
      targetMovie.inputObject.onPress = function()
      {
         this.onProxyPressed();
      };
      targetMovie.inputObject.onRelease = function()
      {
         this.onProxyReleased();
      };
      targetMovie.inputObject.onReleaseOutside = function()
      {
         this.onProxyReleased();
      };
      targetMovie.inputObject.onMouseMove = function()
      {
         this.onProxyMouseMoved();
      };
   }
}
