function chatSplitText(splitAtComposition)
{
   var _loc5_ = chatString;
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
   var _loc7_ = _loc5_.substring(_loc1_,_loc2_);
   var _loc3_ = _loc5_.substring(_loc2_);
   if(_loc4_ == null)
   {
      _loc4_ == "";
   }
   if(_loc7_ == null)
   {
      _loc7_ = "";
   }
   if(_loc3_ == null)
   {
      _loc3_ = "";
   }
   return {left:_loc4_,middle:_loc7_,right:_loc3_};
}
function chatRemoveSelectedText()
{
   var _loc1_ = chatSplitText();
   chatString = _loc1_.left + _loc1_.right;
   insertionPoint = _loc1_.left.length;
   anchorIndex = insertionPoint;
   stretchIndex = insertionPoint;
   return _loc1_;
}
function chatRemoveCompositionText()
{
   var _loc1_ = undefined;
   if(compositionStartIndex != -1)
   {
      _loc1_ = chatSplitText(true);
      chatString = _loc1_.left + _loc1_.right;
      insertionPoint = _loc1_.left.length;
      anchorIndex = insertionPoint;
      stretchIndex = insertionPoint;
      compositionStartIndex = -1;
   }
}
function setInsertionPoint(index)
{
   insertionPoint = Math.max(0,Math.min(chatString.length,index));
   anchorIndex = index;
   stretchIndex = index;
}
function extendSelection(index)
{
   stretchIndex = Math.max(0,Math.min(chatString.length,index));
   if(stretchIndex <= anchorIndex)
   {
      insertionPoint = stretchIndex;
   }
}
function chatInsertText(newText, clip, isComposition)
{
   if(clip == null || clip == undefined)
   {
      clip = chatSplitText();
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
   chatString = clip.left + _loc3_ + clip.right;
   insertionPoint = clip.left.length + _loc3_.length;
   anchorIndex = insertionPoint;
   stretchIndex = insertionPoint;
   if(isComposition == true)
   {
      compositionStartIndex = clip.left.length;
      compositionEndIndex = insertionPoint;
   }
   resetChatFocus(true);
}
function resetChatSelection()
{
   insertionPoint = chatString.length;
   anchorIndex = insertionPoint;
   stretchIndex = insertionPoint;
}
function resetChatFocus(resetString)
{
   if(resetString)
   {
      if(chatString.length == 0)
      {
         chatText.htmlText = "";
      }
      else
      {
         chatText.htmlText = _global.GameInterface.MakeStringSafe(chatString);
      }
   }
   if(chatString.length == 0)
   {
      ShowPrompt(true);
   }
   else
   {
      ShowPrompt(false);
   }
   var _loc2_ = false;
   if(focusOnChat)
   {
      if(compositionStartIndex != -1)
      {
         chatText.selectionBkgColor = compositionBackgroundColor;
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
            chatText.selectionBkgColor = selectionBackgroundColor;
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
   SendButton.setDisabled(value);
}
function executeChat()
{
   if(chatString != "")
   {
      _global.LobbyAPI.SendChatText(chatString);
      chatString = "";
      resetChatSelection();
      resetChatFocus(true);
   }
}
function AddIMEChar(value)
{
   if(anchorIndex != stretchIndex)
   {
      chatRemoveSelectedText();
   }
   chatRemoveCompositionText();
   chatInsertText(value);
}
function SetIMECompositionString(value)
{
   if(anchorIndex != stretchIndex)
   {
      chatRemoveSelectedText();
   }
   chatRemoveCompositionText();
   chatInsertText(value,null,true);
}
function CancelIMEComposition(value)
{
   if(compositionStartIndex != -1)
   {
      chatRemoveCompositionText();
      compositionStartIndex = -1;
      resetChatFocus(true);
   }
}
function AddStringToHistory(line)
{
   if(typeof line != "string" || line.length == 0)
   {
      return undefined;
   }
   var _loc2_ = false;
   if(Math.abs(mInitialTextFieldHeight - historyText._y - historyText.textHeight) < 5)
   {
      _loc2_ = true;
   }
   historyString = historyString + line + "\n";
   var _loc1_ = 0;
   while(historyString.length > MAX_HISTORY_LENGTH)
   {
      _loc1_ = historyString.indexOf("\n") + 1;
      if(_loc1_ == 0 || _loc1_ >= historyString.length)
      {
         historyString = "";
      }
      else
      {
         historyString = historyString.substr(_loc1_);
      }
   }
   historyText.htmlText = historyString;
   if(historyText.textHeight <= mInitialTextFieldHeight)
   {
      scrollBar.m_nIncrementAmount = 0;
      JumpToStart();
   }
   else
   {
      scrollBar.m_nIncrementAmount = pixelsToIncrementScroll * 100 / (historyText.textHeight - mInitialTextFieldHeight);
      if(_loc2_)
      {
         JumpToEnd();
      }
      else
      {
         UpdateScrollBar();
      }
   }
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
   if(focusOnChat)
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
      resetChatFocus(false);
   }
}
function RightKeyPressed()
{
   if(focusOnChat)
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
      resetChatFocus(false);
   }
}
function HomeButtonPressed()
{
   if(focusOnChat)
   {
      if(shiftKeyDown)
      {
         extendSelection(0);
      }
      else
      {
         setInsertionPoint(0);
      }
      resetChatFocus(false);
   }
   else
   {
      JumpToStart();
   }
}
function EndButtonPressed()
{
   if(focusOnChat)
   {
      if(shiftKeyDown)
      {
         extendSelection(chatString.length);
      }
      else
      {
         setInsertionPoint(chatString.length);
      }
      resetChatFocus(false);
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
   focusOnChat = newfocus == chatText;
   if(focusOnChat)
   {
      _global.navManager.SetHighlightedObject(chatObject);
   }
   resetChatFocus(false);
}
function updateCursor()
{
   var _loc1_ = cursorAnchor.x;
   if(insertionPoint == -1)
   {
      _loc1_ = _loc1_ + chatText.textWidth;
   }
   else if(insertionPoint > 0)
   {
      var _loc2_ = chatText.getCharBoundaries(insertionPoint - 1);
      _loc1_ = _loc1_ + (_loc2_.right - chatText.hscroll);
   }
   Cursor._x = _loc1_;
   Cursor.gotoAndPlay(1);
}
function chatStringTyped(typed)
{
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
         executeChat();
         return true;
      }
      if(t != keyCtrlA && t != keyCtrlC && t != keyCtrlV && t != keyCtrlX && t != keyBackspace && t != keyDelete)
      {
         return false;
      }
   }
   if(t == keyCtrlA)
   {
      if(focusOnChat)
      {
         setInsertionPoint(0);
         extendSelection(chatString.length);
         resetChatFocus(false);
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
   if(!focusOnChat)
   {
      return true;
   }
   if(anchorIndex != stretchIndex)
   {
      chatRemoveSelectedText();
      resetChatFocus(true);
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
         var clip = chatSplitText();
         chatString = clip.left.slice(0,insertionPoint - 1) + clip.right;
         setInsertionPoint(insertionPoint - 1);
         resetChatFocus(true);
      }
      return true;
   }
   if(t == keyDelete)
   {
      if(insertionPoint != chatString.length)
      {
         var clip = chatSplitText();
         chatString = clip.left + clip.right.slice(1);
         resetChatFocus(true);
      }
      return true;
   }
   if(t == keyCtrlV)
   {
      chatInsertText(getClipboard());
   }
   else
   {
      chatInsertText(typed);
   }
   return true;
}
function getCharIndex(x, right_side)
{
   var _loc2_ = chatObject._height / 2;
   var _loc1_ = undefined;
   if(x > chatText.textWidth)
   {
      _loc1_ = chatString.length;
   }
   else
   {
      _loc1_ = chatText.getCharIndexAtPoint(x,_loc2_);
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
   selectingChatWithMouse = true;
   Selection.setFocus(chatText);
   originalMouseX = chatObject._xmouse;
   setInsertionPoint(getCharIndex(chatObject._xmouse + chatText.hscroll,false));
   resetChatFocus(false);
}
function onProxyMouseMoved()
{
   if(selectingChatWithMouse)
   {
      Selection.setFocus(chatText);
      if(originalMouseX != -1 && Math.abs(chatObject._xmouse - originalMouseX) > 2)
      {
         extendSelection(getCharIndex(chatObject._xmouse + chatText.hscroll,true));
      }
      resetChatFocus(false);
   }
}
function onProxyReleased()
{
   selectingChatWithMouse = false;
   originalMouseX = -1;
   Selection.setFocus(chatText);
}
function ShowPanel()
{
   if(isVisible == false)
   {
      selectingChatWithMouse = false;
      resetChatSelection();
      CancelIMEComposition();
      resetChatFocus(false);
      isVisible = true;
      focusOnChat = true;
      Selection.setFocus(chatText);
      Cursor.gotoAndPlay(1);
   }
}
function HidePanel()
{
   if(isVisible == true)
   {
      isVisible = false;
      selectingChatWithMouse = false;
   }
}
function Init()
{
   scrollBar.Init(false);
   scrollBar.m_LightButtonsOnHighlight = false;
   scrollBar.m_nIncrementAmount = 0;
   scrollBar.NotifyValueChange = function()
   {
      _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.SetSliderPercentage(this.GetValue());
   };
   scrollBar.m_bNotifyWhileMoving = true;
   pixelsToIncrementScroll = PromptPanel.Text.textHeight * 10;
   maxChatWidth = chatText._width - 15;
   mInitialTextFieldHeight = historyText._height;
   historyText.wordWrap = true;
   historyText.autoSize = true;
   ClearHistory();
   resetChatFocus(true);
   SendButton.Action = function()
   {
      _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.executeChat();
   };
   SendButton.SetText("#SFUI_Settings_Chat_ButtonLabel");
   SendButton.objectToHighlightOnMouseFocus = null;
   Selection.addListener(this);
   bMicEnabled = _global.LobbyAPI.GetVoiceChatEnabled();
   MicToggle.Action = function()
   {
      ToggleMic();
   };
   SetMicEnabled(bMicEnabled);
   chatObject.onPress = function()
   {
      _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.onProxyPressed();
   };
   chatObject.onRelease = function()
   {
      _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.onProxyReleased();
   };
   chatObject.onReleaseOutside = function()
   {
      _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.onProxyReleased();
   };
   chatObject.onMouseMove = function()
   {
      _global.LobbyMovie.LobbyPanel.Panels.ChatPanel.onProxyMouseMoved();
   };
   selectingChatWithMouse = false;
}
function Release()
{
   Selection.removeListener(this);
}
function UpdateContents()
{
   historyText._height = historyText.textHeight + 8;
   historyText._y = 0;
   UpdateScrollBar();
   updateAfterEvent();
}
function UpdateScrollBar()
{
   scrollBar.SetValue(GetSliderPercentage());
}
function ScrollContents(textField, delta, startTime, initialTextFieldHeight, dialog)
{
   var _loc1_ = getTimer() - startTime;
   if(_loc1_ > 3000)
   {
      textField.HowToPlayScrollRateMultiplier = Math.min(Math.pow(_loc1_ - 2000,2) / 1000000,8);
   }
   dialog.JumpBy(delta * textField.HowToPlayScrollRateMultiplier);
   updateAfterEvent();
}
function JumpToEnd()
{
   JumpTo(- historyText._height);
}
function JumpToStart()
{
   JumpTo(0);
}
function PageDown()
{
   JumpBy(mInitialTextFieldHeight * -3 / 4);
}
function PageUp()
{
   JumpBy(mInitialTextFieldHeight * 3 / 4);
}
function JumpBy(jumpsize)
{
   JumpTo(historyText._y + jumpsize);
}
function JumpTo(position)
{
   var _loc1_ = historyText;
   _loc1_._y = position;
   if(_loc1_.textHeight < mInitialTextFieldHeight)
   {
      _loc1_._y = mInitialTextFieldHeight - _loc1_.textHeight;
   }
   else if(_loc1_._y > 0)
   {
      _loc1_._y = 0;
   }
   else if(_loc1_._y < - _loc1_.textHeight - mInitialTextFieldHeight)
   {
      _loc1_._y = - _loc1_.textHeight - mInitialTextFieldHeight;
   }
   UpdateScrollBar();
}
function SetSliderPercentage(pct)
{
   var _loc1_ = historyText;
   var _loc2_ = _loc1_.textHeight - mInitialTextFieldHeight;
   if(_loc2_ <= 0)
   {
      JumpTo(0);
   }
   else
   {
      _loc1_._y = - _loc2_ * pct / 100;
      UpdateScrollBar();
   }
}
function GetSliderPercentage(pct)
{
   var _loc1_ = historyText;
   var _loc2_ = _loc1_.textHeight - mInitialTextFieldHeight;
   if(_loc2_ <= 0)
   {
      return 0;
   }
   return _loc1_._y * -100 / _loc2_;
}
function BeginScrollContents(delta)
{
   historyText.HowToPlayScrollRateMultiplier = 1;
   mScrollIntervalId = setInterval(ScrollContents,50,historyText,delta,getTimer(),mInitialTextFieldHeight,this);
}
function EndScrollContents()
{
   if(mScrollIntervalId != null)
   {
      clearInterval(mScrollIntervalId);
      mScrollIntervalId = null;
   }
}
function ClearHistory()
{
   historyString = "";
   historyText.htmlText = historyString;
   JumpToStart();
   UpdateScrollBar();
   scrollBar.m_nIncrementAmount = 0;
}
function SetMicEnabled(bMicEnabled)
{
   MicToggle.Enabled._visible = bMicEnabled;
   MicToggle.Disabled._visible = !bMicEnabled;
   _global.LobbyAPI.SetVoiceChatEnabled(bMicEnabled);
}
function ToggleMic()
{
   bMicEnabled = !bMicEnabled;
   SetMicEnabled(bMicEnabled);
}
var isVisible = false;
var chatString = "";
var historyString = "";
var maxChatWidth = 0;
var chatObject = ChatObject;
var chatText = chatObject.ChatText;
var historyText = ScrollableText.HistoryText;
var scrollBar = ScrollBar;
var mScrollIntervalId = null;
var mInitialTextFieldHeight = 0;
var MAX_HISTORY_LENGTH = 10240;
var pixelsToIncrementScroll = 0;
var cursorAnchor = {x:Cursor._x,y:Cursor._x};
var selectingChatWithMouse = false;
var focusOnChat = false;
var bMicEnabled = false;
var selectionBackgroundColor = chatText.selectionBkgColor;
var compositionBackgroundColor = 4280295488;
var shiftKeyDown = false;
var maxCharacters = 1024;
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
