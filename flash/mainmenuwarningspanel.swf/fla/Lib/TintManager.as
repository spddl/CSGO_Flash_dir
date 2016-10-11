class Lib.TintManager
{
   var CurrentTint = Lib.TintManager.Tint_None;
   var Tints = new Array();
   var Tint_Receivers = new Array();
   var bDisabled = true;
   static var TintRegister_None = 0;
   static var TintRegister_TeamOnly = 3;
   static var TintRegister_HUD = 7;
   static var TintRegister_All = 255;
   static var Tint_None = 0;
   static var Tint_CounterTerrorist = 1;
   static var Tint_Terrorist = 2;
   static var Tint_GunGameKnife = 4;
   static var Tint_WinPanelDraw = 8;
   static var Tint_CEGFail = 16;
   static var TintNames = [undefined,"Tint_CT","Tint_T","Tint_GunGunKnife","Tint_Win","Tint_CEGFail"];
   function TintManager()
   {
   }
   function TintIndex(TintValue)
   {
      var _loc2_ = 0;
      var _loc1_ = TintValue;
      while(_loc1_ > 0)
      {
         _loc1_ = _loc1_ >> 1;
         _loc2_ = _loc2_ + 1;
      }
      return _loc2_;
   }
   function UpdateTint()
   {
      var _loc3_ = _global.GameInterface.GetConvarNumber("sf_ui_tint");
      if(_loc3_ == null || _loc3_ == undefined)
      {
         _loc3_ = Lib.TintManager.Tint_None;
      }
      if(_loc3_ < 0)
      {
         Lib.TintManager.DumpTintState();
         if(_loc3_ <= -2)
         {
            trace("Clearing all tint objects...");
            _global.tintManager.ClearAll();
            Lib.TintManager.DumpTintState();
         }
         _global.GameInterface.SetConvar("sf_ui_tint",this.CurrentTint);
      }
      else
      {
         this.SetNewTint(_loc3_);
      }
   }
   function SetNewTint(newTintValue)
   {
      if(newTintValue != this.CurrentTint)
      {
         this.CurrentTint = newTintValue;
         if(this.bDisabled)
         {
            return undefined;
         }
         var _loc2_ = 0;
         while(_loc2_ < this.Tint_Receivers.length)
         {
            this.ApplyTint(this.Tint_Receivers[_loc2_]);
            _loc2_ = _loc2_ + 1;
         }
      }
   }
   function MultiRegisterForTint(objList, tintRegistration)
   {
      var _loc2_ = 0;
      while(_loc2_ < objList.length)
      {
         this.RegisterForTint(objList[_loc2_],tintRegistration);
         _loc2_ = _loc2_ + 1;
      }
   }
   function DeRegisterForTint(objList)
   {
      if(this.bDisabled)
      {
         return undefined;
      }
      var _loc2_ = 0;
      while(_loc2_ < objList.length)
      {
         var _loc4_ = objList[_loc2_];
         var _loc3_ = -1;
         if(_loc4_.__tint_registered__ != undefined)
         {
            delete register4.__tint_registered__;
            _loc3_ = this.GetListenerIndex(_loc4_,-1);
         }
         if(_loc3_ >= 0)
         {
            var _loc5_ = this.Tint_Receivers[_loc3_];
            _loc5_.tintColor.setTransform(this.Tints[Lib.TintManager.Tint_None]);
            this.RemoveListener(_loc5_);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function DeregisterAll(obj)
   {
      if(!this.bDisabled && obj != null && obj != undefined)
      {
         if(obj.__tint_deregistered__ == undefined)
         {
            obj.__tint_deregistered__ = true;
            this.DeRegisterForTint([obj]);
            if(obj instanceof MovieClip)
            {
               for(var _loc3_ in obj)
               {
                  this.DeregisterAll(obj[_loc3_]);
               }
            }
            delete obj.__tint_deregistered__;
         }
      }
   }
   function ClearAll()
   {
      if(this.bDisabled)
      {
         return undefined;
      }
      var _loc4_ = this.Tint_Receivers.length - 1;
      var _loc3_ = 0;
      while(_loc3_ <= _loc4_)
      {
         var _loc2_ = this.Tint_Receivers[_loc3_];
         delete register2.tintColor;
         false;
         _loc3_ = _loc3_ + 1;
      }
      this.Tint_Receivers.length = 0;
   }
   function RegisterForTint(obj, tintRegistration)
   {
      if(this.bDisabled || obj == undefined || obj == null)
      {
         return undefined;
      }
      var _loc3_ = new Object();
      _loc3_ = {tintObj:obj,tintRegistration:tintRegistration,tintColor:new Color(obj)};
      if(this.AddListener(_loc3_))
      {
         obj.__tint_registered__ = true;
         this.ApplyTint(_loc3_);
      }
   }
   function ApplyTint(tintEntry)
   {
      if(this.bDisabled)
      {
         return undefined;
      }
      var _loc7_ = undefined;
      var _loc6_ = false;
      var _loc3_ = this.CurrentTint;
      var _loc4_ = 0;
      while(_loc3_ != 0)
      {
         if(_loc3_ & 1)
         {
            var _loc2_ = 1 << _loc4_;
            if(_loc2_ & tintEntry.tintRegistration)
            {
               _loc6_ = true;
               tintEntry.tintColor.setTransform(this.Tints[this.TintIndex(_loc2_)]);
            }
         }
         _loc4_ = _loc4_ + 1;
         _loc3_ = _loc3_ >> 1;
      }
      if(!_loc6_)
      {
         tintEntry.tintColor.setTransform(this.Tints[Lib.TintManager.Tint_None]);
      }
   }
   function GetListenerIndex(tintListener, len)
   {
      var _loc2_ = 0;
      if(len == -1)
      {
         len = this.Tint_Receivers.length - 1;
      }
      while(_loc2_ <= len)
      {
         var _loc3_ = this.Tint_Receivers[_loc2_].tintObj;
         if(_loc3_ == tintListener || _loc3_ == tintListener.tintObj)
         {
            return _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return -1;
   }
   function AddListener(tintListener)
   {
      if(!this.bDisabled && this.GetListenerIndex(tintListener,-1) == -1)
      {
         this.Tint_Receivers.push(tintListener);
         return true;
      }
      return false;
   }
   function RemoveListener(tintListener)
   {
      var _loc3_ = this.Tint_Receivers.length - 1;
      var _loc2_ = this.GetListenerIndex(tintListener,_loc3_);
      if(_loc2_ == -1)
      {
         return undefined;
      }
      this.RemoveListenerIdx(_loc2_);
   }
   function RemoveListenerIdx(i)
   {
      var _loc2_ = this.Tint_Receivers.length - 1;
      if(i == _loc2_)
      {
         this.Tint_Receivers.length = _loc2_;
      }
      else if(i == 0)
      {
         this.Tint_Receivers.shift();
      }
      else
      {
         this.Tint_Receivers = this.Tint_Receivers.slice(0,i).concat(this.Tint_Receivers.slice(i + 1,_loc2_ + 1));
      }
   }
   function onLoadInit(_mc)
   {
      var _loc2_ = 0;
      while(_loc2_ < Lib.TintManager.TintNames.length)
      {
         if(Lib.TintManager.TintNames[_loc2_] == undefined || _mc[Lib.TintManager.TintNames[_loc2_]] == undefined)
         {
            var _loc4_ = new Object();
            _loc4_ = {ra:"100",rb:"0",ga:"100",gb:"0",ba:"100",bb:"0",aa:"100",ab:"0"};
            this.Tints[_loc2_] = _loc4_;
            if(Lib.TintManager.TintNames[_loc2_] != undefined)
            {
               trace("************************************************************************");
               trace("TintManager: ERROR! Tint object NOT FOUND in colorlib.swf: " + Lib.TintManager.TintNames[_loc2_]);
               trace("************************************************************************");
            }
         }
         else
         {
            var _loc3_ = _mc[Lib.TintManager.TintNames[_loc2_]].transform.colorTransform;
            _loc4_ = new Object();
            _loc4_ = {ra:"0",ga:"0",ba:"0",aa:"100",ab:"0",rb:_loc3_.redOffset,gb:_loc3_.greenOffset,bb:_loc3_.blueOffset};
            this.Tints[_loc2_] = _loc4_;
         }
         _loc2_ = _loc2_ + 1;
      }
      unloadMovie(_mc);
   }
   function Remove()
   {
      this.Tints.length = 0;
      this.Tint_Receivers.length = 0;
      Stage.removeListener(this);
      _global.tintManager = null;
   }
   static function StaticRegisterForTint(obj, tintRegistration)
   {
      if(_global.tintManager != null)
      {
         _global.tintManager.RegisterForTint(obj,tintRegistration);
      }
   }
   static function DeregisterList(objArray)
   {
      if(_global.tintManager != null)
      {
         _global.tintManager.DeRegisterForTint(objArray);
      }
   }
   static function Deregister(obj)
   {
      if(_global.tintManager != null)
      {
         _global.tintManager.DeRegisterForTint([obj]);
      }
   }
   static function Init()
   {
      if(_global.tintManager == null)
      {
         var _loc2_ = new Lib.TintManager();
         var _loc3_ = new MovieClipLoader();
         _loc3_.addListener(_loc2_);
         _loc3_.loadClip("colorlib.swf",500);
         Stage.addListener(_loc2_);
         _global.tintManager = _loc2_;
      }
   }
   static function DumpTintState()
   {
      var _loc4_ = _global.tintManager;
      if(_loc4_ == null)
      {
         trace("TintManager: NOT ACTIVE.");
         return undefined;
      }
      var _loc6_ = _loc4_.CurrentTint;
      trace("TintManager: Current Active Tint: " + _loc6_);
      var _loc5_ = _loc4_.Tints[_loc4_.TintIndex(_loc6_)];
      trace("TintManager: Actual Color: [R:" + _loc5_.rb + " G:" + _loc5_.gb + " B:" + _loc5_.bb + "]");
      var _loc2_ = 0;
      while(_loc2_ < _loc4_.Tint_Receivers.length)
      {
         var _loc3_ = _loc4_.Tint_Receivers[_loc2_];
         trace(" ---  [" + _loc2_ + "] = TintedObject: \"" + _loc3_.tintObj + "\" , registered for: " + _loc3_.tintRegistration);
         _loc2_ = _loc2_ + 1;
      }
   }
}
