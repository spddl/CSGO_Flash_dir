function chatSplitText(splitAtComposition)
{
   var _loc6_ = _global.Chat.chatString;
   var _loc2_ = undefined;
   var _loc3_ = undefined;
   if(splitAtComposition == true)
   {
      _loc2_ = compositionStartIndex;
      _loc3_ = compositionEndIndex;
   }
   else if(anchorIndex < stretchIndex)
   {
      _loc2_ = anchorIndex;
      _loc3_ = stretchIndex;
   }
   else
   {
      _loc2_ = stretchIndex;
      _loc3_ = anchorIndex;
   }
   var _loc5_ = _loc6_.substring(0,_loc2_);
   var _loc8_ = _loc6_.substring(_loc2_,_loc3_);
   var _loc4_ = _loc6_.substring(_loc3_);
   if(_loc5_ == null)
   {
      _loc5_ == "";
   }
   if(_loc8_ == null)
   {
      _loc8_ = "";
   }
   if(_loc4_ == null)
   {
      _loc4_ = "";
   }
   return {left:_loc5_,middle:_loc8_,right:_loc4_};
}
function chatRemoveSelectedText()
{
   var _loc2_ = chatSplitText();
   _global.Chat.chatString = _loc2_.left + _loc2_.right;
   insertionPoint = _loc2_.left.length;
   anchorIndex = insertionPoint;
   stretchIndex = insertionPoint;
   return _loc2_;
}
function chatRemoveCompositionText()
{
   var _loc2_ = undefined;
   if(compositionStartIndex != -1)
   {
      _loc2_ = chatSplitText(true);
      _global.Chat.chatString = _loc2_.left + _loc2_.right;
      insertionPoint = _loc2_.left.length;
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
      if(!cursor._visible)
      {
         cursor.gotoAndPlay(1);
      }
      cursor._visible = true;
   }
   else
   {
      cursor._visible = false;
   }
}
function ShowPrompt(value)
{
   Panel.ChatPanel.PromptPanel._visible = value;
   Panel.ChatPanel.SendButton.setDisabled(value);
}
function executeChat()
{
   _global.GameInterface.ConsoleCommand(commandToRun + "\"" + chatString + "\"");
   chatString = "";
   resetChatSelection();
   resetChatFocus(true);
   gameAPI.OnOK(chatString);
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
function UpdateHistory()
{
   var _loc1_ = false;
   if(Math.abs(mInitialTextFieldHeight - historyText._y - historyText.textHeight) < 5)
   {
      _loc1_ = true;
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
      if(_loc1_)
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
      _global.navManager.SetHighlightedObject(null);
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
   cursor._x = _loc1_;
   cursor.gotoAndPlay(1);
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
function onLoaded()
{
   scrollBar.Init(false);
   scrollBar.m_LightButtonsOnHighlight = false;
   scrollBar.m_nIncrementAmount = 0;
   scrollBar.SetModalNavLayout(chatNav);
   scrollBar.NotifyValueChange = function()
   {
      _global.Chat.SetSliderPercentage(this.GetValue());
   };
   scrollBar.m_bNotifyWhileMoving = true;
   pixelsToIncrementScroll = Panel.ChatPanel.PromptPanel.Text.textHeight * 10;
   maxChatWidth = chatText._width - 15;
   mInitialTextFieldHeight = historyText._height;
   historyText.wordWrap = true;
   historyText.autoSize = true;
   ClearHistory();
   Panel.gotoAndStop("hide");
   Panel.ChatPanel.SendButton.navLayout = chatNav;
   Panel.ChatPanel.SendButton.Action = function()
   {
      _global.Chat.executeChat();
   };
   Panel.ChatPanel.SendButton.SetText("#SFUI_Settings_Chat_ButtonLabel");
   Panel.ChatPanel.SendButton.objectToHighlightOnMouseFocus = null;
   Selection.addListener(this);
   var _loc3_ = Panel.ChatPanel.GotvToggle;
   _loc3_.Toggle.navLayout = chatNav;
   _loc3_.Toggle.SetText("#SFUI_Settings_Chat_EnableGotv");
   _loc3_.Toggle.Action = function()
   {
      SetGotvChatConvar();
   };
   _loc3_.Toggle.ButtonText.Text.autoSize = "left";
   _loc3_.Toggle.objectToHighlightOnMouseFocus = null;
   chatObject.onPress = function()
   {
      _global.Chat.onProxyPressed();
   };
   chatObject.onRelease = function()
   {
      _global.Chat.onProxyReleased();
   };
   chatObject.onReleaseOutside = function()
   {
      _global.Chat.onProxyReleased();
   };
   chatObject.onMouseMove = function()
   {
      _global.Chat.onProxyMouseMoved();
   };
   selectingChatWithMouse = false;
   gameAPI.OnReady();
}
function onUnload(mc)
{
   _global.navManager.RemoveLayout(chatNav);
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.RemoveListener(this);
   Selection.removeListener(this);
   delete _global.Chat;
   delete _global.ChatAPI;
   return true;
}
function UpdateContents()
{
   historyText._height = historyText.textHeight + 8;
   historyText._y = 0;
   _global.Chat.UpdateScrollBar();
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
   if(mScrollIntervalId == null)
   {
      historyText.HowToPlayScrollRateMultiplier = 1;
      mScrollIntervalId = setInterval(ScrollContents,50,historyText,delta,getTimer(),mInitialTextFieldHeight,this);
   }
}
function EndScrollContents()
{
   if(mScrollIntervalId != null)
   {
      clearInterval(mScrollIntervalId);
      mScrollIntervalId = null;
   }
}
function onResize(rm)
{
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,0,Lib.ResizeManager.ALIGN_BOTTOM);
}
function resizeRelative(healthArmorModule)
{
   var _loc2_ = (- healthArmorModule._height) * _global.resizeManager.ScalingFactors[Lib.ResizeManager.SCALE_BIGGEST];
   _global.resizeManager.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,_loc2_ * 0.76,Lib.ResizeManager.ALIGN_BOTTOM);
}
function ClearHistory()
{
   historyString = "";
   historyText.htmlText = historyString;
   JumpToStart();
   UpdateScrollBar();
   scrollBar.m_nIncrementAmount = 0;
}
function ShowPanel()
{
   if(isVisible == false)
   {
      selectingChatWithMouse = false;
      chatString = "";
      resetChatSelection();
      CancelIMEComposition();
      resetChatFocus(true);
      Panel._visible = true;
      isVisible = true;
      Panel.gotoAndPlay("StartShow");
      _global.navManager.PushLayout(chatNav,"chatNav");
      focusOnChat = true;
      Selection.setFocus(chatText);
      cursor.gotoAndPlay(1);
      ShowHideGotvEnableButton();
   }
}
function HidePanel()
{
   if(isVisible == true)
   {
      isVisible = false;
      _global.navManager.RemoveLayout(chatNav);
      Panel.gotoAndPlay("StartHide");
      selectingChatWithMouse = false;
   }
}
function SetMode(mode)
{
   if(mode == 1)
   {
      Panel.ChatPanel.PromptPanel.Text.htmlText = "#SFUI_Settings_Chat_Say";
      commandToRun = "say ";
   }
   else
   {
      Panel.ChatPanel.PromptPanel.Text.htmlText = "#SFUI_Settings_Chat_SayTeam";
      commandToRun = "say_team ";
   }
}
function ShowHideGotvEnableButton()
{
   var _loc2_ = Panel.ChatPanel.GotvToggle;
   var _loc3_ = _global.CScaleformComponent_MatchStats.GetUiExperienceType();
   _loc2_._visible = _loc3_ != "GOTV"?false:true;
   if(_loc2_._visible)
   {
      SetGotvChatToggle();
   }
}
function SetGotvChatToggle()
{
   var _loc2_ = Panel.ChatPanel.GotvToggle.Toggle;
   if(_global.GameInterface.GetConvarNumber("tv_nochat") == 0)
   {
      _loc2_.Selected._visible = true;
   }
   else
   {
      _loc2_.Selected._visible = false;
   }
}
function SetGotvChatConvar()
{
   var _loc2_ = Panel.ChatPanel.GotvToggle.Toggle;
   if(_global.GameInterface.GetConvarNumber("tv_nochat") == 0)
   {
      _global.GameInterface.ConsoleCommand("tv_nochat 1");
      _loc2_.Selected._visible = false;
   }
   else
   {
      _global.GameInterface.ConsoleCommand("tv_nochat 0");
      _loc2_.Selected._visible = true;
   }
}
_global.Chat = this;
_global.ChatAPI = gameAPI;
var isVisible = false;
var chatNav = new Lib.NavLayout();
var chatString = "";
var historyString = "";
var commandToRun = "say ";
var maxChatWidth = 0;
var chatObject = Panel.ChatPanel.ChatObject;
var chatText = chatObject.ChatText;
var historyText = Panel.ChatPanel.ScrollableText.HistoryText;
var scrollBar = Panel.ChatPanel.ScrollBar;
var mScrollIntervalId = null;
var mInitialTextFieldHeight = 0;
var MAX_HISTORY_LENGTH = 10240;
var pixelsToIncrementScroll = 0;
var cursorAnchor = {x:Panel.ChatPanel.Cursor._x,y:Panel.ChatPanel.Cursor._x};
var cursor = Panel.ChatPanel.Cursor;
var selectingChatWithMouse = false;
var focusOnChat = false;
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
var anchorIndex;
var stretchIndex;
var insertionPoint;
var compositionStartIndex = -1;
var compositionEndIndex = -1;
var focusOnChat = false;
var textSelected = false;
chatNav.DenyInputToGame(true);
chatNav.ShowCursor(true);
chatNav.MakeModal(true);
chatNav.AddRepeatKeys("LEFT","RIGHT","UP","DOWN","KEY_DELETE");
chatNav.RepeatRate = 50;
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   gameAPI.OnCancel();
   chatString = "";
}},"CANCEL","MOUSE_RIGHT");
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.Chat.executeChat();
}},"KEY_ENTER","KEY_PAD_ENTER","KEY_XBUTTON_A");
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.Chat.BeginScrollContents(4);
   return true;
},onUp:function(button, control, keycode)
{
   _global.Chat.EndScrollContents();
   return true;
}},"KEY_XSTICK2_UP","KEY_UP");
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.Chat.PageUp();
}},"KEY_XBUTTON_LEFT_SHOULDER","KEY_PAGEUP");
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.Chat.BeginScrollContents(-4);
   return true;
},onUp:function(button, control, keycode)
{
   _global.Chat.EndScrollContents();
   return true;
}},"KEY_XSTICK2_DOWN","KEY_DOWN");
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.Chat.PageDown();
}},"KEY_XBUTTON_RIGHT_SHOULDER","KEY_PAGEDOWN");
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.Chat.HomeButtonPressed();
}},"KEY_HOME");
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.Chat.EndButtonPressed();
}},"KEY_END");
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.Chat.ShiftPressed();
   return true;
},onUp:function(button, control, keycode)
{
   _global.Chat.ShiftReleased();
   return true;
}},"KEY_LSHIFT","KEY_RSHIFT");
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.Chat.LeftKeyPressed();
}},"KEY_LEFT");
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.Chat.RightKeyPressed();
}},"KEY_RIGHT");
chatNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.Chat.chatNav.onCharTyped(String.fromCharCode(_global.Chat.keyDelete));
}},"KEY_DELETE");
chatNav.onCharTyped = function(typed)
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
   if(t < 32)
   {
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
};
var originalMouseX = -1;
_global.resizeManager.AddListener(this);
stop();
