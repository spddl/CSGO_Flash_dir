function InitializePlayerColors()
{
   trace("1111^^^^^  InitializePlayerColors!!!!!");
   ColorTrans_Player_Yellow.rb = _global.GameInterface.GetPlayerColorObject(0,0);
   ColorTrans_Player_Yellow.gb = _global.GameInterface.GetPlayerColorObject(0,1);
   ColorTrans_Player_Yellow.bb = _global.GameInterface.GetPlayerColorObject(0,2);
   ColorTrans_Player_Purple.rb = _global.GameInterface.GetPlayerColorObject(1,0);
   ColorTrans_Player_Purple.gb = _global.GameInterface.GetPlayerColorObject(1,1);
   ColorTrans_Player_Purple.bb = _global.GameInterface.GetPlayerColorObject(1,2);
   ColorTrans_Player_Green.rb = _global.GameInterface.GetPlayerColorObject(2,0);
   ColorTrans_Player_Green.gb = _global.GameInterface.GetPlayerColorObject(2,1);
   ColorTrans_Player_Green.bb = _global.GameInterface.GetPlayerColorObject(2,2);
   ColorTrans_Player_Blue.rb = _global.GameInterface.GetPlayerColorObject(3,0);
   ColorTrans_Player_Blue.gb = _global.GameInterface.GetPlayerColorObject(3,1);
   ColorTrans_Player_Blue.bb = _global.GameInterface.GetPlayerColorObject(3,2);
   ColorTrans_Player_Orange.rb = _global.GameInterface.GetPlayerColorObject(4,0);
   ColorTrans_Player_Orange.gb = _global.GameInterface.GetPlayerColorObject(4,1);
   ColorTrans_Player_Orange.bb = _global.GameInterface.GetPlayerColorObject(4,3);
   m_bPlayerColorsInitialized = true;
}
function CheckNonWideAspectRatio()
{
   if(Stage.width / Stage.height <= 1.35)
   {
      return "4x3";
   }
   if(Stage.width / Stage.height <= 1.6)
   {
      return "16x10";
   }
   return "16x9";
}
_global.gfxExtensions = 1;
_global.noInvisibleAdvance = true;
Stage.scaleMode = "noScale";
Stage.align = "TL";
var m_bPlayerColorsInitialized = false;
MovieClip.prototype.attachMovieClip = function(id, name, depth, initobj)
{
   if(!arguments.length)
   {
      return undefined;
   }
   Object.registerClass(id,arguments.callee);
   return this.attachMovie(id,name,depth,initobj);
};
MovieClip.prototype.attachMovieClip.prototype = new MovieClip();
MovieClip.prototype.attachMovieClip.prototype.onLoad = null;
_global.IsPC = function()
{
   return _global.PlatformCode == 0 || _global.PlatformCode == 3;
};
_global.IsXbox = function()
{
   return _global.PlatformCode == 1;
};
_global.IsPS3 = function()
{
   return _global.PlatformCode == 2;
};
_global.IsOSX = function()
{
   return _global.PlatformCode == 3;
};
_global.TeamID_Terrorist = 2;
_global.TeamID_CounterTerrorist = 3;
Lib.ElementLoaderList.Init();
Lib.ResizeManager.Init();
Lib.NavManager.Init();
Lib.TintManager.Init();
_global.BaseMessageBoxLevel = 500;
_global.MessageBoxLevels = new Object();
_global.AllocMessageBoxLevel = function()
{
   var _loc2_ = _global.MessageBoxLevels;
   if(_loc2_.nextLevel == undefined)
   {
      _loc2_.nextLevel = _global.BaseMessageBoxLevel;
   }
   var _loc3_ = _loc2_.nextLevel;
   _loc2_[_loc3_] = 1;
   _loc2_.nextLevel = _loc2_.nextLevel + 1;
   return _loc3_;
};
_global.SetMessageBoxAtLevel = function(level, theBox, theApi)
{
   _global.MessageBoxLevels[level] = {box:theBox,api:theApi};
};
_global.GetMessageBoxAtLevel = function(level)
{
   return _global.MessageBoxLevels[level].box;
};
_global.GetMessageBoxAPIAtLevel = function(level)
{
   return _global.MessageBoxLevels[level].api;
};
_global.FreeMessageBoxLevel = function(level)
{
   var _loc3_ = _global.MessageBoxLevels;
   _loc3_[level] = 1;
   delete register3.level;
   if(_loc3_.nextLevel == level + 1)
   {
      var _loc5_ = false;
      var _loc2_ = _loc3_.nextLevel - 1;
      while(_loc2_ >= _global.BaseMessageBoxLevel && _loc3_[_loc2_] == undefined)
      {
         _loc2_ = _loc2_ - 1;
      }
      _loc3_.nextLevel = _loc2_ + 1;
   }
};
_global.LoadExternalElement = function(url, elementName, level, gameAPI)
{
   var _loc2_ = new Lib.ElementLoader();
   var _loc3_ = new MovieClipLoader();
   _loc2_.loader = _loc3_;
   _loc2_.gameAPI = gameAPI;
   _loc2_.elementName = elementName;
   _loc2_.elementLevel = level;
   _global.elementLoaderList.AddLoader(_loc2_);
   _loc3_.addListener(_loc2_);
   _loc3_.loadClip(url,level);
   trace(" loadClip " + url);
   return _loc3_;
};
_global.RequestElement = function(elementID, gameAPI)
{
   trace(" RequestElement " + elementID);
   if(_global.ElementLoaders && _global.ElementLoaders[elementID])
   {
      _global.ElementLoaders.elementID(gameAPI);
   }
   else
   {
      gameAPI.OnLoadError(null,"No element named " + elementID + " defined");
   }
};
_global.RemoveElement = function(mc)
{
   if(mc.gameAPI == undefined)
   {
      trace(" Scaleform ERROR: RemoveElement failed! This slot will not deallocate properly!");
   }
   if(mc.gameAPI.OnUnload(mc))
   {
      if(mc.onUnload(mc) == true)
      {
         trace(" onUnload: unloadMovie");
         unloadMovie(mc);
      }
      else
      {
         trace(" onUnload");
      }
   }
};
_global.SetConvars = function(vars)
{
   for(var _loc4_ in vars)
   {
      var _loc2_ = vars[_loc4_];
      if(_loc2_ != undefined)
      {
         switch(typeof _loc2_)
         {
            case "string":
            case "number":
            case "boolean":
         }
         _global.GameInterface.SetConvar(_loc4_,_loc2_);
      }
   }
};
_global.AutosizeTextDown = function(txt, minSize)
{
   var _loc3_ = txt._width;
   var _loc4_ = txt._height;
   var _loc1_ = txt.getTextFormat();
   while((txt.textWidth > _loc3_ || txt.textHeight > _loc4_) && _loc1_.size > minSize)
   {
      _loc1_.size = int(_loc1_.size) - 1;
      txt.setTextFormat(_loc1_);
   }
};
_global.TruncateText = function(input, nTrimAt)
{
   var _loc3_ = input.length;
   if(_loc3_ <= nTrimAt)
   {
      return input;
   }
   var _loc1_ = 0;
   while(_loc1_ < _loc3_)
   {
      if(_loc1_ > nTrimAt)
      {
         return input.slice(0,_loc1_) + "...";
      }
      _loc1_ = _loc1_ + 1;
   }
   return input;
};
_global.FormatNumberToString = function(num)
{
   if(isNaN(num))
   {
      return "0";
   }
   if(num == 0)
   {
      return "0";
   }
   num = Math.round(num * 100) / 100;
   var _loc6_ = String(num);
   var _loc3_ = _loc6_.split(".");
   if(_loc3_[1].length == 1)
   {
      _loc3_[1] = _loc3_[1] + "0";
   }
   if(num > 1000)
   {
      var _loc4_ = new Array();
      var _loc2_ = undefined;
      var _loc1_ = _loc3_[0].length;
      while(_loc1_ > 0)
      {
         _loc2_ = Math.max(_loc1_ - 3,0);
         _loc4_.unshift(_loc3_[0].slice(_loc2_,_loc1_));
         _loc1_ = _loc2_;
      }
      _loc3_[0] = _loc4_.join(",");
   }
   return _loc3_.join(".");
};
_global.FormatSecondsToDaysHourString = function(numSec, bUseDDHHMMFormat, bUseMissionTimerFormat)
{
   if(numSec == 0)
   {
      return "";
   }
   var _loc3_ = new Array();
   var _loc9_ = Math.floor(numSec / 86400 / 7);
   if(_loc9_ > 0 && !bUseMissionTimerFormat)
   {
      _loc3_.push({value:_loc9_,type:"w"});
   }
   if(!bUseMissionTimerFormat)
   {
      var _loc11_ = Math.floor(numSec / 86400 % 7);
      _loc3_.push({value:_loc11_,type:"d"});
   }
   var _loc10_ = Math.floor(numSec / 3600 % 24);
   _loc3_.push({value:_loc10_,type:"hr"});
   var _loc8_ = 0;
   if(numSec < 60 && !bUseMissionTimerFormat)
   {
      _loc8_ = 1;
   }
   else
   {
      _loc8_ = Math.floor(numSec / 60 % 60);
   }
   _loc3_.push({value:_loc8_,type:"min"});
   if(bUseMissionTimerFormat)
   {
      _loc3_.push({value:Math.floor(numSec % 60),type:"sec"});
   }
   if(bUseDDHHMMFormat)
   {
      var _loc4_ = new Array();
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         if(bUseMissionTimerFormat)
         {
            _loc3_[_loc2_].type = "";
         }
         if(_loc3_[_loc2_].value < 10)
         {
            _loc4_.push("0" + _loc3_[_loc2_].value.toString() + _loc3_[_loc2_].type);
         }
         else
         {
            _loc4_.push(_loc3_[_loc2_].value.toString() + _loc3_[_loc2_].type);
         }
         _loc2_ = _loc2_ + 1;
      }
      if(bUseMissionTimerFormat)
      {
         return _loc4_.join(":");
      }
      return _loc4_.join(" : ");
   }
   if(_loc10_ <= 1 && _loc11_ <= 0)
   {
      return _global.GameInterface.Translate("#CSGO_Journal_Mission_Less_Hour");
   }
   var _loc7_ = "";
   if(_loc3_[0].value > 0)
   {
      if(_loc3_[0].value > 3)
      {
         return _loc3_[0].value + " " + _global.GameInterface.Translate("#CSGO_Journal_Mission_days");
      }
      if(_loc3_[0].value > 1)
      {
         var _loc13_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_days_and");
      }
      if(_loc3_[0].value == 1)
      {
         _loc13_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_day_and");
      }
      _loc7_ = _loc3_[0].value + " " + _loc13_;
   }
   if(_loc3_[1].value > 1 || _loc3_[1].value == 0)
   {
      var _loc12_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_hours");
   }
   if(_loc3_[1].value == 1)
   {
      _loc12_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_hour");
   }
   _loc7_ = _loc7_ + " " + _loc3_[1].value + " " + _loc12_;
   return _loc7_;
};
_global.UpdateSafeZone = function()
{
   if(_global.resizeManager != undefined)
   {
      _global.resizeManager.updateSafeZone();
   }
};
_global.SetToControllerUI = function(value)
{
   if(_global.wantControllerShown == value)
   {
      return undefined;
   }
   _global.wantControllerShown = value;
   if(_global.resizeManager != undefined)
   {
      _global.resizeManager.changeUIDevice();
   }
};
_global.UpdateTint = function()
{
   if(_global.tintManager != undefined)
   {
      _global.tintManager.UpdateTint();
   }
};
_global.KeyDownEvent = function(key, vkey, slot, binding)
{
   Lib.SFKey.setKeyCode(key,vkey,slot,binding);
   return _global.navManager.onKeyDown();
};
_global.KeyUpEvent = function(key, vkey, slot, binding)
{
   Lib.SFKey.setKeyCode(key,vkey,slot,binding);
   return _global.navManager.onKeyUp();
};
_global.CharTyped = function(typed, slot)
{
   return _global.navManager.onCharTyped(typed,slot);
};
_global.LockInputToSlot = function(slot)
{
   _global.navManager.lockInputToSlot(slot);
};
_global.UnlockInput = function()
{
   _global.navManager.clearInputLock();
};
_global.TraceObject = function(o, whitespace)
{
   if(!whitespace)
   {
      whitespace = "";
   }
   if(typeof o == "object")
   {
      if(o instanceof Array)
      {
         trace(whitespace + "[");
         var _loc2_ = 0;
         var _loc6_ = o.length;
         var _loc4_ = whitespace + "  ";
         while(_loc2_ < _loc6_)
         {
            _global.TraceObject(o[_loc2_],_loc4_);
            _loc2_ = _loc2_ + 1;
         }
         trace(whitespace + "]");
      }
      else
      {
         trace(whitespace + "{");
         _loc4_ = whitespace + "  ";
         for(name in o)
         {
            trace(_loc4_ + name + "=");
            _global.TraceObject(o[name],_loc4_);
         }
         trace(whitespace + "}");
      }
   }
   else
   {
      trace(whitespace + "  " + o.toString());
   }
};
_global.ForceResize = function()
{
   _global.resizeManager.doResize(true);
};
_global.InitSlot = function()
{
};
_global.ShutdownSlot = function()
{
   _global.resizeManager.Remove();
};
_global.ConstructString = function(formatString)
{
   var _loc2_ = undefined;
   var _loc8_ = false;
   var _loc7_ = ("__PREAMBLE__" + formatString).split("%s");
   var _loc3_ = undefined;
   var _loc4_ = undefined;
   var _loc6_ = undefined;
   _loc2_ = _loc7_[0];
   var _loc5_ = 1;
   while(_loc5_ < _loc7_.length)
   {
      _loc3_ = _loc7_[_loc5_];
      if(_loc3_.length == 0)
      {
         _loc4_ = NaN;
      }
      else
      {
         _loc6_ = _loc3_.substring(0,1);
         if(_loc6_ != undefined && _loc6_ != null)
         {
            _loc4_ = Number(_loc6_);
         }
         else
         {
            _loc4_ = NaN;
         }
      }
      if(isNaN(_loc4_))
      {
         _loc2_ = _loc2_ + "%s" + _loc3_;
      }
      else
      {
         _loc2_ = _loc2_ + arguments[_loc4_];
         if(_loc3_.length > 1)
         {
            _loc2_ = _loc2_ + _loc3_.substring(1);
         }
      }
      _loc5_ = _loc5_ + 1;
   }
   return _loc2_.substring(12);
};
var ColorTrans_Player_Default = new Object();
ColorTrans_Player_Default = {ra:"100",rb:"0",ga:"100",gb:"0",ba:"100",bb:"0"};
var ColorTrans_Player_Pink = new Object();
ColorTrans_Player_Pink = {ra:"0",ga:"0",ba:"0"};
var ColorTrans_Player_Purple = new Object();
ColorTrans_Player_Purple = {ra:"0",ga:"0",ba:"0"};
var ColorTrans_Player_Blue = new Object();
ColorTrans_Player_Blue = {ra:"0",ga:"0",ba:"0"};
var ColorTrans_Player_Green = new Object();
ColorTrans_Player_Green = {ra:"0",ga:"0",ba:"0"};
var ColorTrans_Player_Yellow = new Object();
ColorTrans_Player_Yellow = {ra:"0",ga:"0",ba:"0"};
var ColorTrans_Player_Orange = new Object();
ColorTrans_Player_Orange = {ra:"0",ga:"0",ba:"0"};
var ColorTrans_Player_LightBlue = new Object();
ColorTrans_Player_LightBlue = {ra:"0",rb:"210",ga:"0",gb:"240",ba:"0",bb:"240"};
_global.SetPlayerObjectColor = function(object, nColorIndex)
{
   if(!object)
   {
      return undefined;
   }
   var _loc2_ = new Color(object);
   if(nColorIndex == -1)
   {
      object.blendMode = 8;
      _loc2_.setTransform(ColorTrans_Player_Default);
   }
   else
   {
      object.blendMode = 1;
      var _loc3_ = GetPlayerColorObject(nColorIndex);
      _loc2_.setTransform(_loc3_);
   }
};
_global.GetPlayerColorObject = function(nSlot)
{
   if(m_bPlayerColorsInitialized == false)
   {
      InitializePlayerColors();
   }
   if(nSlot < -1)
   {
      return ColorTrans_Player_LightBlue;
   }
   if(nSlot == -1)
   {
      return ColorTrans_Player_Default;
   }
   if(nSlot == 0)
   {
      return ColorTrans_Player_Yellow;
   }
   if(nSlot == 1)
   {
      return ColorTrans_Player_Purple;
   }
   if(nSlot == 2)
   {
      return ColorTrans_Player_Green;
   }
   if(nSlot == 3)
   {
      return ColorTrans_Player_Blue;
   }
   if(nSlot == 4)
   {
      return ColorTrans_Player_Orange;
   }
   return ColorTrans_Player_Default;
};
_global.GetPlayerColorLetter = function(nSymbolStyle, nSlot)
{
   if(nSymbolStyle == 0)
   {
      if(nSlot == -1)
      {
         return "";
      }
      if(nSlot == 0)
      {
         return "Y";
      }
      if(nSlot == 1)
      {
         return "P";
      }
      if(nSlot == 2)
      {
         return "G";
      }
      if(nSlot == 3)
      {
         return "B";
      }
      if(nSlot == 4)
      {
         return "O";
      }
      if(nSlot == 10)
      {
         return "<img src=\'target_skull.png\' height=\'8\'/>";
      }
   }
   else if(nSymbolStyle == 1)
   {
      if(nSlot == -1)
      {
         return "";
      }
      if(nSlot == 0)
      {
         return "Ⓨ";
      }
      if(nSlot == 1)
      {
         return "Ⓟ";
      }
      if(nSlot == 2)
      {
         return "Ⓖ";
      }
      if(nSlot == 3)
      {
         return "Ⓑ";
      }
      if(nSlot == 4)
      {
         return "Ⓞ";
      }
   }
   else
   {
      if(nSlot == -1)
      {
         return "";
      }
      if(nSlot == 0)
      {
         return "★";
      }
      if(nSlot == 1)
      {
         return "✚";
      }
      if(nSlot == 2)
      {
         return "●";
      }
      if(nSlot == 3)
      {
         return "♦";
      }
      if(nSlot == 4)
      {
         return "■";
      }
   }
   return "";
};
_global.CheckOverRightScreenBounds = function(Pt, movie)
{
   var _loc1_ = 1280 / Stage.width;
   var _loc3_ = 960 / Stage.width;
   var _loc2_ = 1152 / Stage.width;
   var _loc4_ = (Stage.width * _loc1_ - Stage.width * _loc3_) / 2 + Stage.width * _loc3_;
   var _loc5_ = (Stage.width * _loc1_ - Stage.width * _loc2_) / 2 + Stage.width * _loc2_;
   if(CheckNonWideAspectRatio() == "16x10")
   {
      if(_loc5_ < Pt.x + movie._width)
      {
         return true;
      }
   }
   else if(CheckNonWideAspectRatio() == "4x3")
   {
      if(_loc4_ < Pt.x + movie._width)
      {
         return true;
      }
   }
   else if(Stage.width * _loc1_ < Pt.x + movie._width)
   {
      return true;
   }
   return false;
};
_global.CheckOverBottomScreenBounds = function(Pt, HeightOverride, movie)
{
   var _loc3_ = 720 / Stage.height;
   if(HeightOverride != 0 && HeightOverride != undefined)
   {
      var _loc2_ = HeightOverride;
   }
   else
   {
      _loc2_ = movie._height;
   }
   if(Stage.height * _loc3_ < Pt.y + _loc2_)
   {
      return true;
   }
   return false;
};
_global.CheckOverTopScreenBounds = function(Pt, HeightOverride, movie)
{
   var _loc3_ = 720 / Stage.height;
   if(HeightOverride != 0 && HeightOverride != undefined)
   {
      var _loc2_ = HeightOverride;
   }
   else
   {
      _loc2_ = movie._height;
   }
   if(Pt.y - _loc2_ < 0)
   {
      return true;
   }
   return false;
};
_global.RandomInt = function(minNum, maxNum)
{
   return Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum;
};
resizeManager.ApplyAdditionalScaling = false;
_global.ElementLoaders = {StartScreen:function(gameAPI)
{
   LoadExternalElement("StartScreen.swf","StartScreen",2,gameAPI);
},MainMenu:function(gameAPI)
{
   _global.FrontEndBackgroundAPI = gameAPI;
   loadMovieNum("Background.swf",1,"GET");
   LoadExternalElement("MainMenu.swf","MainMenu",31,gameAPI);
},LegalAnimation:function(gameAPI)
{
   LoadExternalElement("Legals.swf","Legals",12,gameAPI);
},CreditsAnimation:function(gameAPI)
{
   LoadExternalElement("credits.swf","credits",12,gameAPI);
},StartSinglePlayer:function(gameAPI)
{
   LoadExternalElement("single-player.swf","SinglePlayer",15,gameAPI);
},LobbyScreen:function(gameAPI)
{
   LoadExternalElement("Lobby.swf","LobbyScreen",16,gameAPI);
},LobbyBrowser:function(gameAPI)
{
   LoadExternalElement("LobbyBrowser.swf","LobbyBrowser",17,gameAPI);
},OptionsMenu:function(gameAPI)
{
   LoadExternalElement("OptionsMenu.swf","OptionsMenu",21,gameAPI);
},UpsellMenu:function(gameAPI)
{
   LoadExternalElement("UpsellMenu.swf","UpsellMenu",23,gameAPI);
},HowToPlay:function(gameAPI)
{
   LoadExternalElement("HowToPlay.swf","HowToPlay",24,gameAPI);
},MedalStatsScreen:function(gameAPI)
{
   LoadExternalElement("MedalStatsScreen.swf","MedalStatsScreen",25,gameAPI);
},LeaderBoards:function(gameAPI)
{
   LoadExternalElement("LeaderBoards.swf","LeaderBoards",30,gameAPI);
},LoadingScreen:function(gameAPI)
{
   LoadExternalElement("Loading.swf","LoadingScreen",1000,gameAPI);
},SplitScreenSignon:function(gameAPI)
{
   LoadExternalElement("SplitScreenSignon.swf","SplitScreenSignon",35,gameAPI);
},PlayerDetails:function(gameAPI)
{
   LoadExternalElement("PlayerDetails.swf","PlayerDetails",98,gameAPI);
},OverwatchResolution:function(gameAPI)
{
   LoadExternalElement("OverwatchResolution.swf","OverwatchResolution",99,gameAPI);
},PauseMenu:function(gameAPI)
{
   _global.PauseBackgroundAPI = gameAPI;
   loadMovieNum("PauseBackground.swf",3,"GET");
   LoadExternalElement("PauseMenu.swf","PauseMenu",100,gameAPI);
},MotionCalibration:function(gameAPI)
{
   LoadExternalElement("MotionCalibration.swf","MotionCalibration",125,gameAPI);
},CallVotePanel:function(gameAPI)
{
   LoadExternalElement("CallVote.swf","CallVotePanel",44,gameAPI);
},ItemPickup:function(gameAPI)
{
   LoadExternalElement("ItemPickup.swf","ItemPickup",200,gameAPI);
},MessageBox:function(gameAPI)
{
   LoadExternalElement("message-box.swf","MessageBox",_global.AllocMessageBoxLevel(),gameAPI);
},MessageBoxOperationPayback:function(gameAPI)
{
   LoadExternalElement("message-box-operation-payback.swf","MessageBoxOperationPayback",_global.AllocMessageBoxLevel(),gameAPI);
},MessageBoxOperationPaybackActivate:function(gameAPI)
{
   LoadExternalElement("message-box-operation-payback-activate.swf","MessageBoxOperationPaybackActivate",_global.AllocMessageBoxLevel(),gameAPI);
}};
this.stop();
