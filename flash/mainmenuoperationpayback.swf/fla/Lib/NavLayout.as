class Lib.NavLayout
{
   var _parentage = new Object();
   var _nav = new Object();
   var _initialHighlight = null;
   var _showCursor = false;
   var _exclusive = false;
   var _disableAnalogStickNavigation = false;
   var _denyInputToGame = false;
   var _modal = false;
   var _forceHighlightOnPop = false;
   static var _noHighlightMarker = new Object();
   function NavLayout()
   {
   }
   function AddRepeatKeys()
   {
      var _loc5_ = this.RepeatKeys;
      if(_loc5_ == null || _loc5_ == undefined)
      {
         _loc5_ = new Array();
         this.RepeatKeys = _loc5_;
      }
      var _loc4_ = 0;
      while(_loc4_ < arguments.length)
      {
         var _loc3_ = arguments[_loc4_];
         if(_loc3_ == "UP" || _loc3_ == "DOWN" || _loc3_ == "RIGHT" || _loc3_ == "LEFT")
         {
            Lib.NavLayout.AddRepeatKeysToObject(_loc5_,"KEY_" + _loc3_,"KEY_XBUTTON_" + _loc3_,"KEY_XSTICK1_" + _loc3_);
         }
         else
         {
            _loc5_.push(_loc3_);
         }
         _loc4_ = _loc4_ + 1;
      }
   }
   function AddKeyHandlers(handler)
   {
      var _loc6_ = this.keyHandler;
      if(_loc6_ == null || _loc6_ == undefined)
      {
         _loc6_ = new Object();
         this.keyHandler = _loc6_;
      }
      var _loc4_ = 1;
      while(_loc4_ < arguments.length)
      {
         var _loc3_ = arguments[_loc4_];
         if(_loc3_ == "UP" || _loc3_ == "DOWN" || _loc3_ == "RIGHT" || _loc3_ == "LEFT")
         {
            this.AddDirectionKeyHandlers(handler,_loc3_);
         }
         else if(_loc3_ == "CANCEL")
         {
            this.AddCancelKeyHandlers(handler);
         }
         else if(_loc3_ == "ACCEPT")
         {
            this.AddAcceptKeyHandlers(handler);
         }
         else
         {
            _loc6_[_loc3_] = handler;
         }
         _loc4_ = _loc4_ + 1;
      }
   }
   function AddDirectionKeyHandlers(handler, key)
   {
      this.AddKeyHandlers(handler,"KEY_" + key,"KEY_XBUTTON_" + key,"KEY_XSTICK1_" + key);
   }
   function AddCancelKeyHandlers(handler)
   {
      this.AddKeyHandlers(handler,"KEY_ESCAPE","KEY_XBUTTON_B","MOUSE_RIGHT");
   }
   function AddAcceptKeyHandlers(handler)
   {
      this.AddKeyHandlers(handler,"KEY_ENTER","KEY_SPACE","KEY_XBUTTON_A","KEY_XBUTTON_TRIGGER");
   }
   function AddKeyHandlerTable(obj)
   {
      var _loc3_ = this.keyHandler;
      if(_loc3_ == null || _loc3_ == undefined)
      {
         _loc3_ = new Object();
         this.keyHandler = _loc3_;
      }
      for(var _loc4_ in obj)
      {
         if(_loc4_ == "UP" || _loc4_ == "DOWN" || _loc4_ == "RIGHT" || _loc4_ == "LEFT")
         {
            this.AddDirectionKeyHandlers(obj[_loc4_],_loc4_);
         }
         else if(_loc4_ == "CANCEL")
         {
            this.AddCancelKeyHandlers(obj[_loc4_]);
         }
         else if(_loc4_ == "ACCEPT")
         {
            this.AddAcceptKeyHandlers(obj[_loc4_]);
         }
         else
         {
            _loc3_[_loc4_] = obj[_loc4_];
         }
      }
   }
   function AddChildrenOfObject(theParent, theChildren)
   {
      if(theChildren)
      {
         var _loc3_ = theChildren.length;
         if(_loc3_)
         {
            var _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               this._parentage[theChildren[_loc2_]] = theParent;
               _loc2_ = _loc2_ + 1;
            }
         }
      }
   }
   function AddNavForObject(theObject, theNav)
   {
      var _loc3_ = this._nav[theObject];
      if(!_loc3_)
      {
         this._nav[theObject] = theNav;
      }
      else
      {
         for(var _loc4_ in theNav)
         {
            _loc3_[_loc4_] = theNav[_loc4_];
            if(_loc4_ == "UP" || _loc4_ == "DOWN" || _loc4_ == "RIGHT" || _loc4_ == "LEFT")
            {
               Lib.NavLayout.AddKeyHandlersToObject(theNav[_loc4_],_loc3_,"KEY_" + _loc4_,"KEY_XBUTTON_" + _loc4_,"KEY_XSTICK1_" + _loc4_);
            }
         }
      }
   }
   function AddNavDirectionForObject(theObject, theKey, theOtherObject)
   {
      var _loc2_ = this._nav[theObject];
      if(!_loc2_)
      {
         _loc2_ = new Object();
         this._nav[theObject] = _loc2_;
      }
      _loc2_[theKey] = theOtherObject;
   }
   function AddTabOrder(tabOrder)
   {
      var _loc5_ = tabOrder.length;
      var _loc3_ = undefined;
      var _loc4_ = tabOrder[_loc5_ - 1];
      if(this._initialHighlight == null && _loc5_ > 0)
      {
         this._initialHighlight = tabOrder[0];
      }
      var _loc2_ = 0;
      while(_loc2_ < _loc5_)
      {
         _loc3_ = tabOrder[_loc2_];
         this.AddNavDirectionForObject(_loc4_,"KEY_TAB",_loc3_);
         _loc4_ = _loc3_;
         _loc2_ = _loc2_ + 1;
      }
   }
   function SetInitialHighlight(highlight)
   {
      if(highlight == null)
      {
         this._initialHighlight = Lib.NavLayout._noHighlightMarker;
      }
      else
      {
         this._initialHighlight = highlight;
      }
   }
   function GetInitialHighlight()
   {
      if(this._initialHighlight == null)
      {
         this._initialHighlight = Lib.NavLayout._noHighlightMarker;
         return null;
      }
      if(this._initialHighlight == Lib.NavLayout._noHighlightMarker)
      {
         return null;
      }
      return this._initialHighlight;
   }
   function ShowCursor(value)
   {
      this._showCursor = value;
   }
   function MakeExclusive(value)
   {
      this._exclusive = value;
   }
   function ForceHighlightOnPop(value)
   {
      this._forceHighlightOnPop = value;
   }
   function GetParentOf(object)
   {
      return this._parentage[object];
   }
   function DisableAnalogStickNavigation(value)
   {
      this._disableAnalogStickNavigation = value;
   }
   function DenyInputToGame(value)
   {
      this._denyInputToGame = value;
   }
   function MakeModal(value)
   {
      this._modal = value;
   }
   function GetNextHighlight(object, key)
   {
      if(object == null || object == undefined)
      {
         return this.GetInitialHighlight();
      }
      var _loc3_ = this._nav[object];
      if(_loc3_ != null && _loc3_ != undefined)
      {
         var _loc2_ = _loc3_[key];
         if(_loc2_ != null && _loc2_ != undefined)
         {
            return _loc2_;
         }
      }
      return null;
   }
   static function AddKeyHandlersToObject(handler, object)
   {
      var _loc2_ = 2;
      while(_loc2_ < arguments.length)
      {
         object[arguments[_loc2_]] = handler;
         _loc2_ = _loc2_ + 1;
      }
   }
   static function AddDirectionKeyHandlersToObject(handler, object)
   {
      var _loc3_ = 2;
      while(_loc3_ < arguments.length)
      {
         var _loc2_ = arguments[_loc3_];
         if(_loc2_ == "UP" || _loc2_ == "DOWN" || _loc2_ == "RIGHT" || _loc2_ == "LEFT")
         {
            Lib.NavLayout.AddKeyHandlersToObject(handler,object,"KEY_" + _loc2_,"KEY_XBUTTON_" + _loc2_,"KEY_XSTICK1_" + _loc2_);
         }
         else
         {
            object[arguments[_loc3_]] = handler;
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   static function AddRepeatKeysToObject(object)
   {
      var _loc3_ = 1;
      while(_loc3_ < arguments.length)
      {
         var _loc2_ = arguments[_loc3_];
         if(_loc2_ == "UP" || _loc2_ == "DOWN" || _loc2_ == "RIGHT" || _loc2_ == "LEFT")
         {
            Lib.NavLayout.AddRepeatKeysToObject(object,"KEY_" + _loc2_,"KEY_XBUTTON_" + _loc2_,"KEY_XSTICK1_" + _loc2_);
         }
         else
         {
            object.push(_loc2_);
         }
         _loc3_ = _loc3_ + 1;
      }
   }
}
