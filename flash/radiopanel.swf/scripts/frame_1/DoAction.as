function initData()
{
   CreateOrder(radioKVData.Groups);
   var _loc1_ = 0;
   while(_loc1_ < radioKVData.Groups.order.length)
   {
      CreateOrder(radioKVData.Groups.order[_loc1_].Commands);
      _loc1_ = _loc1_ + 1;
   }
}
function CreateOrder(o)
{
   if(typeof o == "object")
   {
      o.order;
      o.order = new Array();
      o.ordername = new Array();
      o.ordernameToIndex = new Array();
      for(var _loc3_ in o)
      {
         var _loc2_ = o[_loc3_];
         if(_loc2_ && typeof _loc2_ == "object" && _loc3_ != "order" && _loc3_ != "ordername" && _loc3_ != "ordernameToIndex")
         {
            o.order[o[_loc3_].hotkey - 1] = _loc2_;
            o.ordername[o[_loc3_].hotkey - 1] = _loc3_;
            o.ordernameToIndex[_loc3_] = o[_loc3_].hotkey - 1;
         }
      }
   }
}
function ShowRadioGroup(groupID)
{
   groupID = groupID - 1;
   if(currentGroupID == groupID)
   {
      hidePanel();
      return undefined;
   }
   currentGroupID = groupID;
   currentGroup = radioKVData.Groups.order[groupID];
   if(currentGroup != undefined)
   {
      SetTitle(currentGroup.title);
      if(timerInterval)
      {
         clearInterval(timerInterval);
         delete timerInterval;
      }
      timerInterval = setInterval(AutoHideTimer,currentGroup.timeout * 1000,null);
      var _loc4_ = "";
      var _loc2_ = 0;
      while(_loc2_ < currentGroup.Commands.order.length)
      {
         var _loc3_ = currentGroup.Commands.order[_loc2_];
         _loc4_ = _loc4_ + (String(_loc2_ + 1) + ". " + _global.GameInterface.Translate(_loc3_.label) + "\n");
         _loc2_ = _loc2_ + 1;
      }
      _loc4_ = _loc4_ + ("\n" + _global.GameInterface.Translate("#SFUI_Radio_Exit"));
      SetMessage(_loc4_);
      var _loc6_ = Panel.Panel.Message.Message.textHeight;
      var _loc7_ = Math.max(Panel.Panel.Title.Title.textWidth,Panel.Panel.Message.Message.textWidth);
      Panel.Panel.Background._height = _loc6_ + 91;
      Panel.Panel.TitleHeader._width = _loc7_ + 30;
      Panel.Panel.Background._width = _loc7_ + 30;
      Panel.Panel.Message.Message._height = _loc6_ + 18;
   }
   showPanel();
}
function onResize(rm)
{
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   setYPositionOffset();
}
function setYPositionOffset()
{
   var _loc2_ = 0;
   if(_global.MoneyPanel != undefined && _global.MoneyPanel.isShown)
   {
      _loc2_ = _loc2_ + Math.min(_global.MoneyPanel.MoneyPanel._y + _global.MoneyPanel.MoneyPanel.scaledHeight,Stage.height * 0.5);
   }
   else
   {
      _loc2_ = _loc2_ + Stage.height * 0.4;
   }
   if(_loc2_ > 0)
   {
      Panel._y = _loc2_;
   }
}
function showPanel()
{
   if(bVisible == false && currentGroup != undefined)
   {
      onResize(_global.resizeManager);
      Panel.gotoAndPlay("StartShow");
      _global.navManager.PushLayout(radioNav);
      bVisible = true;
   }
}
function hidePanel()
{
   if(bVisible == true)
   {
      if(timerInterval)
      {
         clearInterval(timerInterval);
         delete timerInterval;
      }
      Panel.gotoAndPlay("StartHide");
      _global.navManager.RemoveLayout(radioNav);
      bVisible = false;
      currentGroupID = -1;
   }
}
function AutoHideTimer()
{
   hidePanel();
}
function SetTitle(titleText)
{
   Panel.Panel.Title.SetText(titleText);
}
function SetMessage(messageText)
{
   Panel.Panel.Message.SetText(messageText);
}
function onUnload(mc)
{
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   delete _global.RadioPanel;
   delete _global.RadioPanelAPI;
   delete radioNav;
   return true;
}
function onLoaded()
{
   initData();
   gameAPI.OnReady();
}
_global.RadioPanel = this;
_global.RadioPanelAPI = gameAPI;
var radioNav = new Lib.NavLayout();
var currentGroup = null;
var currentGroupID = -1;
var bVisible = false;
var nMyYOffset = 0;
var timerInterval;
radioKVData = _global.GameInterface.LoadKVFile("resource/ui/RadioPanel.txt");
radioNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   var _loc1_ = 0;
   if(keycode >= Lib.SFKey.KeyFromName("KEY_PAD_0"))
   {
      _loc1_ = keycode - Lib.SFKey.KeyFromName("KEY_PAD_1");
   }
   else
   {
      _loc1_ = keycode - Lib.SFKey.KeyFromName("KEY_1");
   }
   if(_loc1_ < 0)
   {
      _loc1_ = 10 + slotNumber;
   }
   RadioPanelAPI.InvokeCommand(currentGroup.Commands.order[_loc1_].cmd);
}},"KEY_1","KEY_2","KEY_3","KEY_4","KEY_5","KEY_6","KEY_7","KEY_8","KEY_9","KEY_PAD_1","KEY_PAD_2","KEY_PAD_3","KEY_PAD_4","KEY_PAD_5","KEY_PAD_6","KEY_PAD_7","KEY_PAD_8","KEY_PAD_9");
radioNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.RadioPanel.hidePanel();
   return true;
}},"CANCEL","KEY_0","KEY_ESCAPE");
_global.resizeManager.AddListener(this);
stop();
