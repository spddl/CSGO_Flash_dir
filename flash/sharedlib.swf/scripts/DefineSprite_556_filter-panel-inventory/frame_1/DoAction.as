function AddFilterKeyHandlers(navFilter)
{
   navFilter.AddKeyHandlers({onDown:function(button, control, keycode)
   {
      executeFilter();
   }},"KEY_ENTER");
   navFilter.AddKeyHandlers({onDown:function(button, control, keycode)
   {
      HomeButtonPressed();
   }},"KEY_HOME");
   navFilter.AddKeyHandlers({onDown:function(button, control, keycode)
   {
      EndButtonPressed();
   }},"KEY_END");
   navFilter.AddKeyHandlers({onDown:function(button, control, keycode)
   {
      ShiftPressed();
      return true;
   },onUp:function(button, control, keycode)
   {
      ShiftReleased();
      return true;
   }},"KEY_LSHIFT","KEY_RSHIFT");
   navFilter.AddKeyHandlers({onDown:function(button, control, keycode)
   {
      filterStringTyped(String.fromCharCode(keyDelete));
   }},"KEY_DELETE");
   navFilter.onCharTyped = function(typed)
   {
      var _loc3_ = typed.charCodeAt(0);
      if(_loc3_ == keyBackquote)
      {
         return false;
      }
      if(_loc3_ == keyEscape)
      {
         return false;
      }
      if(_global.GameInterface.GetConvarNumber("console_window_open") == 0)
      {
         _global.navManager.SetHighlightedObject(this.FilterObject);
         filterStringTyped(typed);
         if(m_bAutoExecuteTimerMode)
         {
            EndAutoExecuteTimer();
            StartAutoExecuteTimer();
         }
         return true;
      }
      return false;
   };
}
function filterSplitText(splitAtComposition)
{
   var _loc5_ = filterString;
   var _loc1_ = undefined;
   var _loc2_ = undefined;
   if(splitAtComposition == true)
   {
      _loc1_ = compositionStartIndex;
      _loc2_ = compositionEndIndex;
   }
   else if(anchorIndex < stretchIndex)
   {
      _loc1_ = anchorIndex;
      _loc2_ = stretchIndex;
   }
   else
   {
      _loc1_ = stretchIndex;
      _loc2_ = anchorIndex;
   }
   var _loc4_ = _loc5_.substring(0,_loc1_);
   var _loc8_ = _loc5_.substring(_loc1_,_loc2_);
   var _loc3_ = _loc5_.substring(_loc2_);
   if(_loc4_ == null)
   {
      _loc4_ == "";
   }
   if(_loc8_ == null)
   {
      _loc8_ = "";
   }
   if(_loc3_ == null)
   {
      _loc3_ = "";
   }
   return {left:_loc4_,middle:_loc8_,right:_loc3_};
}
function filterRemoveSelectedText()
{
   var _loc1_ = filterSplitText();
   filterString = _loc1_.left + _loc1_.right;
   insertionPoint = _loc1_.left.length;
   anchorIndex = insertionPoint;
   stretchIndex = insertionPoint;
   return _loc1_;
}
function filterRemoveCompositionText()
{
   var _loc1_ = undefined;
   if(compositionStartIndex != -1)
   {
      _loc1_ = filterSplitText(true);
      filterString = _loc1_.left + _loc1_.right;
      insertionPoint = _loc1_.left.length;
      anchorIndex = insertionPoint;
      stretchIndex = insertionPoint;
      compositionStartIndex = -1;
   }
}
function setInsertionPoint(index)
{
   insertionPoint = Math.max(0,Math.min(filterString.length,index));
   anchorIndex = index;
   stretchIndex = index;
}
function extendSelection(index)
{
   stretchIndex = Math.max(0,Math.min(filterString.length,index));
   if(stretchIndex <= anchorIndex)
   {
      insertionPoint = stretchIndex;
   }
}
function filterInsertText(newText, clip, isComposition)
{
   if(clip == null || clip == undefined)
   {
      clip = filterSplitText();
   }
   var _loc5_ = newText.length;
   var _loc3_ = undefined;
   var _loc4_ = clip.left.length + clip.right.length + _loc5_;
   if(_loc4_ > maxCharacters)
   {
      _global.navManager.PlayNavSound("ButtonNA");
      _loc3_ = newText.substring(0,_loc5_ - (_loc4_ - maxCharacters));
      if(_loc3_ == null)
      {
         _loc3_ = "";
      }
   }
   else
   {
      _loc3_ = newText;
   }
   filterString = clip.left + _loc3_ + clip.right;
   insertionPoint = clip.left.length + _loc3_.length;
   anchorIndex = insertionPoint;
   stretchIndex = insertionPoint;
   if(isComposition == true)
   {
      compositionStartIndex = clip.left.length;
      compositionEndIndex = insertionPoint;
   }
   resetFilterFocus(true);
}
function resetFilterSelection()
{
   insertionPoint = filterString.length;
   anchorIndex = insertionPoint;
   stretchIndex = insertionPoint;
}
function resetFilterFocus(resetString)
{
   if(resetString)
   {
      if(filterString.length == 0)
      {
         filterText.htmlText = "";
      }
      else
      {
         filterText.htmlText = _global.GameInterface.MakeStringSafe(filterString);
      }
   }
   if(filterString.length == 0)
   {
      ShowPrompt(true);
   }
   else
   {
      ShowPrompt(false);
   }
   var _loc2_ = false;
   if(focusOnFilter)
   {
      if(compositionStartIndex != -1)
      {
         filterText.selectionBkgColor = compositionBackgroundColor;
         Selection.setSelection(compositionStartIndex,compositionEndIndex);
         _loc2_ = true;
      }
      else
      {
         if(anchorIndex == stretchIndex)
         {
            _loc2_ = true;
         }
         else
         {
            filterText.selectionBkgColor = selectionBackgroundColor;
         }
         if(anchorIndex < stretchIndex)
         {
            Selection.setSelection(anchorIndex,stretchIndex);
         }
         else
         {
            Selection.setSelection(stretchIndex,anchorIndex);
         }
      }
   }
   if(_loc2_)
   {
      updateCursor();
      if(!Cursor._visible)
      {
         Cursor.gotoAndPlay(1);
      }
      Cursor._visible = true;
   }
   else
   {
      Cursor._visible = false;
   }
}
function ShowPrompt(value)
{
   PromptPanel._visible = value;
}
function executeFilter(FuncToCall)
{
   if(filterString != PreviousFilterString)
   {
      PreviousFilterString = filterString;
      m_FunctionToCallOnEnter();
      resetFilterSelection();
      resetFilterFocus(true);
   }
}
function ClearExecuteFilter()
{
   if(filterString != "")
   {
      filterString = "";
      resetFilterSelection();
      resetFilterFocus(true);
   }
}
function StripSpaces(FilterStringOrig)
{
   var _loc1_ = FilterStringOrig.split(" ");
   return _loc1_.join(",");
}
function ShiftPressed()
{
   shiftKeyDown = true;
}
function ShiftReleased()
{
   shiftKeyDown = false;
}
function LeftKeyPressed()
{
   if(focusOnFilter)
   {
      if(shiftKeyDown)
      {
         extendSelection(stretchIndex - 1);
      }
      else if(stretchIndex != anchorIndex)
      {
         setInsertionPoint(insertionPoint);
      }
      else
      {
         setInsertionPoint(insertionPoint - 1);
      }
      resetFilterFocus(false);
   }
}
function RightKeyPressed()
{
   if(focusOnFilter)
   {
      if(shiftKeyDown)
      {
         extendSelection(stretchIndex + 1);
      }
      else if(stretchIndex != anchorIndex)
      {
         setInsertionPoint(Math.max(anchorIndex,stretchIndex));
      }
      else
      {
         setInsertionPoint(insertionPoint + 1);
      }
      resetFilterFocus(false);
   }
}
function HomeButtonPressed()
{
   if(focusOnFilter)
   {
      if(shiftKeyDown)
      {
         extendSelection(0);
      }
      else
      {
         setInsertionPoint(0);
      }
      resetFilterFocus(false);
   }
   else
   {
      JumpToStart();
   }
}
function EndButtonPressed()
{
   if(focusOnFilter)
   {
      if(shiftKeyDown)
      {
         extendSelection(filterString.length);
      }
      else
      {
         setInsertionPoint(filterString.length);
      }
      resetFilterFocus(false);
   }
   else
   {
      JumpToEnd();
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
   var _loc2_ = _global.GameInterface.GetClipboardText();
   if(_loc2_ == null)
   {
      _loc2_ = "";
   }
   else
   {
      _loc2_ = replaceInString(_loc2_,"\"","\'");
      _loc2_ = replaceInString(_loc2_,String.fromCharCode(13),"[ret]");
   }
   return _loc2_;
}
function onSetFocus(oldfocus, newfocus)
{
   focusOnFilter = newfocus == filterText;
   if(focusOnFilter)
   {
      _global.navManager.SetHighlightedObject(filterObject);
   }
   resetFilterFocus(false);
}
function updateCursor()
{
   var _loc1_ = cursorAnchor.x;
   if(insertionPoint == -1)
   {
      _loc1_ = _loc1_ + filterText.textWidth;
   }
   else if(insertionPoint > 0)
   {
      var _loc2_ = filterText.getCharBoundaries(insertionPoint - 1);
      _loc1_ = _loc1_ + (_loc2_.right - filterText.hscroll);
   }
   Cursor._x = _loc1_;
   Cursor.gotoAndPlay(1);
}
function filterStringTyped(typed)
{
   isVisible = true;
   if(!isVisible)
   {
      return false;
   }
   if(typed == "\"")
   {
      typed = "\'";
   }
   var t = typed.charCodeAt(0);
   if(t == keyBackquote)
   {
      return false;
   }
   if(t < 32)
   {
      if(t == keyEnter)
      {
         if(m_bAutoExecuteTimerMode)
         {
            return true;
         }
         executeFilter();
         return true;
      }
      if(t != keyCtrlA && t != keyCtrlC && t != keyCtrlV && t != keyCtrlX && t != keyBackspace && t != keyDelete)
      {
         return false;
      }
   }
   if(t == keyCtrlA)
   {
      if(focusOnFilter)
      {
         setInsertionPoint(0);
         extendSelection(filterString.length);
         resetFilterFocus(false);
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
         if(focusObject == historyText)
         {
            Selection.setSelection(0,historyString.length);
         }
      }
      return true;
   }
   if(t == keyCtrlC || t == keyCtrlX)
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
      if(t == keyCtrlC || !focusPath)
      {
         return true;
      }
   }
   if(!focusOnFilter)
   {
      return true;
   }
   if(anchorIndex != stretchIndex)
   {
      filterRemoveSelectedText();
      resetFilterFocus(true);
      if(t == keyCtrlX || t == keyBackspace || t == keyDelete)
      {
         return true;
      }
   }
   if(t == keyCtrlX)
   {
      return true;
   }
   if(t == keyBackspace)
   {
      if(insertionPoint != 0)
      {
         var clip = filterSplitText();
         filterString = clip.left.slice(0,insertionPoint - 1) + clip.right;
         setInsertionPoint(insertionPoint - 1);
         resetFilterFocus(true);
      }
      return true;
   }
   if(t == keyDelete)
   {
      if(insertionPoint != filterString.length)
      {
         var clip = filterSplitText();
         filterString = clip.left + clip.right.slice(1);
         resetFilterFocus(true);
      }
      return true;
   }
   if(t == keyCtrlV)
   {
      filterInsertText(getClipboard());
   }
   else
   {
      filterInsertText(typed);
   }
   return true;
}
function getCharIndex(x, right_side)
{
   var _loc2_ = filterObject._height / 2;
   var _loc1_ = undefined;
   if(x > filterText.textWidth)
   {
      _loc1_ = filterString.length;
   }
   else
   {
      _loc1_ = filterText.getCharIndexAtPoint(x,_loc2_);
      if(_loc1_ < 0)
      {
         _loc1_ = 0;
      }
      else if(right_side)
      {
         _loc1_ = _loc1_ + 1;
      }
   }
   return _loc1_;
}
function onProxyPressed()
{
   selectingFilterWithMouse = true;
   Selection.setFocus(filterText);
   originalMouseX = filterObject._xmouse;
   setInsertionPoint(getCharIndex(filterObject._xmouse + filterText.hscroll,false));
   resetFilterFocus(false);
   trace("--------------------------------->Filter Init");
}
function onProxyMouseMoved()
{
   if(selectingFilterWithMouse)
   {
      Selection.setFocus(filterText);
      if(originalMouseX != -1 && Math.abs(filterObject._xmouse - originalMouseX) > 2)
      {
         extendSelection(getCharIndex(filterObject._xmouse + filterText.hscroll,true));
      }
      resetFilterFocus(false);
   }
}
function onProxyReleased()
{
   selectingFilterWithMouse = false;
   originalMouseX = -1;
   Selection.setFocus(filterText);
}
function ShowPanel()
{
   if(isVisible == false)
   {
      selectingFilterWithMouse = false;
      resetFilterSelection();
      CancelIMEComposition();
      resetFilterFocus(false);
      isVisible = true;
      focusOnFilter = true;
      Selection.setFocus(filterText);
      Cursor.gotoAndPlay(1);
   }
}
function HidePanel()
{
   if(isVisible == true)
   {
      isVisible = false;
      selectingFilterWithMouse = false;
   }
}
function Init(Prompt, MaxChar, FuncToCall)
{
   maxFilterWidth = filterText._width - 15;
   mInitialTextFieldHeight = historyText._height;
   historyText.wordWrap = true;
   historyText.autoSize = true;
   filterString = "";
   filterText.htmlText = "";
   maxCharacters = MaxChar;
   resetFilterFocus(true);
   m_FunctionToCallOnEnter = FuncToCall;
   SendButton.Action = function()
   {
      executeFilter();
   };
   SendButton.SetText("");
   SendButton.objectToHighlightOnMouseFocus = null;
   PromptPanel.Text.htmlText = Prompt;
   Selection.addListener(this);
   bMicEnabled = false;
   MicToggle.Action = function()
   {
      ToggleMic();
   };
   ToggleMic();
   filterObject.onPress = function()
   {
      onProxyPressed();
   };
   filterObject.onRelease = function()
   {
      onProxyReleased();
   };
   filterObject.onReleaseOutside = function()
   {
      onProxyReleased();
   };
   filterObject.onMouseMove = function()
   {
      onProxyMouseMoved();
   };
   selectingFilterWithMouse = false;
}
function Release()
{
   Selection.removeListener(this);
}
function EnableAutoExecuteTimer()
{
   m_bAutoExecuteTimerMode = true;
}
function StartAutoExecuteTimer()
{
   var numLoop = 0;
   this.onEnterFrame = function()
   {
      if(numLoop > 8)
      {
         executeFilter();
         EndAutoExecuteTimer();
         return undefined;
      }
      numLoop++;
   };
}
function EndAutoExecuteTimer()
{
   delete this.onEnterFrame;
}
var isVisible = false;
var filterString = "";
var PreviousFilterString = "";
var maxFilterWidth = 0;
var filterObject = FilterObject;
var filterText = filterObject.FilterText;
var mScrollIntervalId = null;
var cursorAnchor = {x:Cursor._x,y:Cursor._x};
var selectingfilterWithMouse = false;
var focusOnfilter = false;
var bMicEnabled = false;
var m_FunctionToCallOnEnter;
var m_bAutoExecuteTimerMode = false;
var selectionBackgroundColor = filterText.selectionBkgColor;
var compositionBackgroundColor = 11776947;
var shiftKeyDown = false;
var maxCharacters = 25;
var keyCtrlA = 1;
var keyDelete = 31;
var keyCtrlC = 3;
var keyCtrlX = 24;
var keyCtrlV = 22;
var keyEnter = 13;
var keyBackspace = 8;
var keyBackquote = 96;
var keyEscape = 27;
var anchorIndex;
var stretchIndex;
var insertionPoint;
var compositionStartIndex = -1;
var compositionEndIndex = -1;
var originalMouseX = -1;
stop();
