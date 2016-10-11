class Lib.NavManager
{
   var _layouts = new Array();
   var _savedHighlights = new Array();
   var _mouseOverControls = new Array();
   var _processKeyEvents = true;
   var _highlightedObject = null;
   var _keepFocusCount = 0;
   var _downKeys = new Object();
   var _heldDownTime = 0;
   var _layoutTransitionDepth = 0;
   var _inputLockedToSlot = -1;
   var _nLastLayoutLength = 0;
   static var KEY_INTERVAL_TIME = 50;
   static var INITIAL_KEY_DELAY = 400;
   static var KEY_DELAY = 200;
   function NavManager()
   {
      this._highlightSound = "ButtonRollover";
   }
   function InLayoutTransition()
   {
      return this._layoutTransitionDepth > 0;
   }
   function InitSounds()
   {
      this._soundFileMap = {ButtonRollover:"UI\\\\buttonrollover.wav",StoreRollover:"UI\\\\csgo_ui_store_rollover.wav",ButtonAction:"UI\\\\buttonclick.wav",ButtonNA:"UI\\\\menu_invalid.wav",NotYours:"UI\\\\weapon_cant_buy.wav",ButtonLarge:"UI\\\\csgo_ui_button_rollover_large.wav",PageScroll:"UI\\\\csgo_ui_page_scroll.wav",ItemScroll:"UI\\\\csgo_ui_crate_item_scroll.wav",StickerScroll:"UI\\\\item_scroll_sticker_01.wav",OpenCrate:"UI\\\\csgo_ui_crate_open.wav",NewItem:"UI\\\\csgo_ui_crate_display.wav",TypeWriter1:"UI\\\\csgo_ui_contract_type1.wav",TypeWriter2:"UI\\\\csgo_ui_contract_type2.wav",TypeWriter3:"UI\\\\csgo_ui_contract_type3.wav",TypeWriter4:"UI\\\\csgo_ui_contract_type4.wav",TypeWriter5:"UI\\\\csgo_ui_contract_type5.wav",AcceptSeal:"UI\\\\csgo_ui_contract_seal.wav",ScrapeSticker1:"UI\\\\sticker_scratch1.wav",ScrapeSticker2:"UI\\\\sticker_scratch2.wav",ScrapeSticker3:"UI\\\\sticker_scratch3.wav",ApplySticker:"UI\\\\sticker_apply.wav",InspectItem:"UI\\\\item_inspect_01.wav",ConfirmSticker:"UI\\\\item_sticker_apply_confirm.wav",InspectSticker:"UI\\\\item_showcase_sticker_01.wav",BookClose:"UI\\\\ui_book_close.wav",BookOpen:"UI\\\\ui_book_open.wav",PageBack:"UI\\\\ui_book_page_bwd.wav",PageForward:"UI\\\\ui_book_page_fwd.wav",RareItemReveal:"UI\\\\item_reveal3_rare.wav",MythicalItemReveal:"UI\\\\item_reveal4_mythical.wav",LedendaryItemReveal:"UI\\\\item_reveal5_legendary.wav",AncientItemReveal:"UI\\\\item_reveal6_ancient.wav",InspectItem:"UI\\\\item_inspect_01.wav",ConfirmSticker:"UI\\\\item_sticker_apply_confirm.wav",InspectSticker:"UI\\\\item_showcase_sticker_01.wav",BookClose:"UI\\\\ui_book_close.wav",BookOpen:"UI\\\\ui_book_open.wav",PageBack:"UI\\\\ui_book_page_bwd.wav",PageForward:"UI\\\\ui_book_page_fwd.wav",RareItemReveal:"UI\\\\item_reveal3_rare.wav",MythicalItemReveal:"UI\\\\item_reveal4_mythical.wav",LedendaryItemReveal:"UI\\\\item_reveal5_legendary.wav",AncientItemReveal:"UI\\\\item_reveal6_ancient.wav",XPLevelUp:"UI\\\\xp_levelup.wav",XPLevelUp2:"UI\\\\item_showcase_knife_01.wav",XPBarSound1:"UI\\\\xp_milestone_01.wav",XPBarSound2:"UI\\\\xp_milestone_02.wav",XPBarSound3:"UI\\\\xp_milestone_03.wav",XPBarSound4:"UI\\\\xp_milestone_04.wav",XPBarSound5:"UI\\\\xp_milestone_05.wav",XPRemaining:"UI\\\\xp_remaining.wav"};
   }
   function GetSoundFile(name)
   {
      if(this._soundFileMap == undefined)
      {
         this.InitSounds();
      }
      return this._soundFileMap[name];
   }
   function PlayNavSound(filename)
   {
      if(!this.InLayoutTransition())
      {
         if(filename != undefined && filename != null)
         {
            var _loc3_ = this.GetSoundFile(filename);
            if(_loc3_ != undefined && _loc3_ != null)
            {
               _global.GameInterface.PlaySound(_loc3_);
            }
         }
      }
   }
   function addMouseOverControl(ctrl)
   {
      var _loc3_ = this._mouseOverControls.length;
      var _loc2_ = undefined;
      _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this._mouseOverControls[_loc2_] == ctrl)
         {
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
      this._mouseOverControls.push(ctrl);
   }
   function removeMouseOverControl(ctrl)
   {
      var _loc3_ = this._mouseOverControls.length;
      var _loc2_ = undefined;
      _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this._mouseOverControls[_loc2_] == ctrl)
         {
            if(_loc2_ == 0)
            {
               this._mouseOverControls.shift();
            }
            else if(_loc2_ == _loc3_ - 1)
            {
               this._mouseOverControls.pop();
            }
            else
            {
               this._mouseOverControls = this._mouseOverControls.slice(0,_loc2_).concat(this._mouseOverControls.slice(_loc2_ + 1,_loc3_));
            }
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function unsetMouseOverControls(highlight)
   {
      var _loc4_ = this._mouseOverControls.length;
      var _loc2_ = undefined;
      var _loc3_ = undefined;
      _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         _loc3_ = this._mouseOverControls[_loc2_];
         if(_loc3_ != highlight)
         {
            _loc3_.UnsetState();
         }
         _loc2_ = _loc2_ + 1;
      }
      this.clearMouseOverControls();
   }
   function clearMouseOverControls()
   {
      this._mouseOverControls = new Array();
   }
   function onKeyDownInterval()
   {
      var _loc6_ = _global.navManager._downKeys;
      var _loc7_ = false;
      for(var _loc8_ in _loc6_)
      {
         if(typeof _loc8_ == "string")
         {
            var _loc2_ = _loc6_[_loc8_];
            if(_loc2_ != undefined && _loc2_ != null && typeof _loc2_ == "object" && _loc2_.keyTime != undefined)
            {
               var _loc3_ = _loc2_.keyTime;
               _loc7_ = true;
               _loc3_ = _loc3_ - Lib.NavManager.KEY_INTERVAL_TIME;
               if(_loc3_ < 0)
               {
                  var _loc4_ = _loc2_.keyTarget;
                  var _loc5_ = 0;
                  if(_loc4_.RepeatRate != undefined)
                  {
                     _loc5_ = _loc4_.RepeatRate;
                  }
                  else
                  {
                     _loc5_ = _loc5_ + Lib.NavManager.KEY_DELAY;
                  }
                  _loc3_ = _loc3_ + _loc5_;
                  if(_loc4_)
                  {
                     _global.navManager.TryPassKeyToObject(_loc4_,Lib.SFKey.onDown,_loc8_,_loc2_.keyBinding,_loc2_.keyCode);
                  }
                  else
                  {
                     _global.navManager.TryChangeHighlight(_loc8_);
                  }
               }
               _loc2_.keyTime = _loc3_;
            }
         }
      }
      if(_loc7_)
      {
         _global.navManager._heldDownTime = _global.navManager._heldDownTime + Lib.NavManager.KEY_INTERVAL_TIME;
         if(_global.navManager._heldDownTime > 60000)
         {
            trace(" *****************************************");
            trace(" *     key interval may be stuck down    *");
            trace(" * uncomment the traces in NavManager.as *");
            trace(" *****************************************");
            clearInterval(_global.navManager._intervalTimer);
            delete _global.navManager._intervalTimer;
            _global.navManager._heldDownTime = -7200000;
         }
      }
      else
      {
         clearInterval(_global.navManager._intervalTimer);
         delete _global.navManager._intervalTimer;
      }
   }
   function AddRepeatKey(keyName, keyBinding, keyCode, target)
   {
      if(target != null && target != undefined)
      {
         var _loc3_ = target.RepeatKeys;
         if(_loc3_ != null && _loc3_ != undefined)
         {
            var _loc6_ = _loc3_.length;
            if(_loc6_ != null && _loc6_ != undefined)
            {
               var _loc2_ = 0;
               while(_loc2_ < _loc6_)
               {
                  if(_loc3_[_loc2_] == keyName || _loc3_[_loc2_] == keyBinding)
                  {
                     this.AddDownKey(keyName,keyBinding,keyCode,target);
                     return undefined;
                  }
                  _loc2_ = _loc2_ + 1;
               }
            }
         }
      }
   }
   function AddDownKey(keyName, keyBinding, keyCode, target)
   {
      var _loc3_ = this._downKeys[keyName];
      if(_loc3_ == undefined || _loc3_ == null)
      {
         _loc3_ = new Object();
         this._downKeys[keyName] = _loc3_;
      }
      _loc3_.keyTime = Lib.NavManager.INITIAL_KEY_DELAY;
      _loc3_.keyCode = keyCode;
      _loc3_.keyTarget = target;
      _loc3_.keyBinding = keyBinding;
      if(this._intervalTimer == undefined)
      {
         this._heldDownTime = 0;
         this._intervalTimer = setInterval(_global.navManager.onKeyDownInterval,Lib.NavManager.KEY_INTERVAL_TIME);
      }
   }
   function RemoveDownKey(keyName)
   {
      if(this._downKeys[keyName] != undefined)
      {
         delete this._downKeys.keyName;
      }
   }
   function ResetAllDownKeys()
   {
      for(var _loc3_ in this._downKeys)
      {
         if(typeof _loc3_ == "string")
         {
            delete this._downKeys.register3;
         }
      }
      clearInterval(_global.navManager._intervalTimer);
      delete _global.navManager._intervalTimer;
   }
   function IncrFocusCount()
   {
      if(this._keepFocusCount == 0)
      {
         _global.GameInterface.AddInputConsumer();
      }
      this._keepFocusCount = this._keepFocusCount + 1;
   }
   function DecrFocusCount()
   {
      if(this._keepFocusCount == 1)
      {
         _global.GameInterface.RemoveInputConsumer();
      }
      this._keepFocusCount = this._keepFocusCount - 1;
   }
   function TraceLayouts()
   {
      var _loc4_ = this._layouts.length;
      if(_loc4_ > 0)
      {
         var _loc3_ = "LAYOUTS: " + _loc4_ + ": ";
         var _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = _loc3_ + this._layouts[_loc2_].parent + "  ";
            _loc2_ = _loc2_ + 1;
         }
         trace(_loc3_);
      }
      else if(_loc4_ != this._nLastLayoutLength)
      {
         trace("LAYOUTS: 0");
      }
      this._nLastLayoutLength = _loc4_;
   }
   function RemoveAllNavLayouts()
   {
      trace("RemoveAllNavLayouts");
      var _loc2_ = this._layouts.length - 1;
      while(_loc2_ >= 0)
      {
         this.RemoveLayout(this._layouts[_loc2_]);
         _loc2_ = _loc2_ - 1;
      }
   }
   function PushLayout(layout, parent)
   {
      this._layoutTransitionDepth = this._layoutTransitionDepth + 1;
      if(parent)
      {
         layout.parent = parent;
         trace(" -------- PushLayout: parent = " + parent);
      }
      if(layout._exclusive)
      {
         this.RemoveAllNavLayouts();
      }
      else
      {
         this.RemoveLayout(layout);
      }
      var _loc4_ = this._layouts.length;
      if(_loc4_ > 0 && this._layouts[_loc4_ - 1]._modal && !layout._modal)
      {
         var _loc2_ = _loc4_ - 1;
         while(_loc2_ >= 0 && this._layouts[_loc2_]._modal)
         {
            _loc2_ = _loc2_ - 1;
         }
         _loc2_ = _loc2_ + 1;
         this._layouts.splice(_loc2_,0,layout);
         this._savedHighlights.splice(_loc2_,0,layout.GetInitialHighlight());
         trace(" PushLayout: _layouts.splice: (" + layout.GetInitialHighlight.name + ")");
         this.IncrFocusCount();
      }
      else
      {
         if(_loc4_ > 0)
         {
            this.UnapplyLayout(this._layouts[_loc4_ - 1]);
            this._savedHighlights.push(this._highlightedObject);
         }
         this.ApplyLayout(layout);
         this.IncrFocusCount();
         this._layouts.push(layout);
         this._highlightedObject = null;
         this.SetHighlightedObject(layout.GetInitialHighlight());
      }
      this._layoutTransitionDepth = this._layoutTransitionDepth - 1;
      this.TraceLayouts();
   }
   function UnapplyLayout(layout)
   {
      trace(" UnapplyLayout: (" + layout.parent + ")");
      if(layout._disableAnalogStickNavigation)
      {
         _global.GameInterface.DisableAnalogStickNavigation(false);
         trace(" UnapplyLayout: DisableAnalogStickNavigation = false");
      }
      if(layout._denyInputToGame)
      {
         _global.GameInterface.DenyInputToGame(false);
         trace(" UnapplyLayout: DenyInputToGame = false");
      }
      if(layout._showCursor)
      {
         _global.GameInterface.HideCursor();
         trace(" UnapplyLayout: HideCursor");
      }
      this.ResetAllDownKeys();
      this.clearMouseOverControls();
      trace(" UnapplyLayout: clearMouseOverControls");
   }
   function ApplyLayout(layout)
   {
      trace(" ApplyLayout: (" + layout.parent + ")");
      if(layout._disableAnalogStickNavigation)
      {
         _global.GameInterface.DisableAnalogStickNavigation(true);
         trace(" ApplyLayout: DisableAnalogStickNavigation = true");
      }
      if(layout._denyInputToGame)
      {
         _global.GameInterface.DenyInputToGame(true);
         trace(" ApplyLayout: DenyInputToGame = true");
      }
      if(layout._showCursor)
      {
         _global.GameInterface.ShowCursor();
         trace(" ApplyLayout: ShowCursor");
      }
   }
   function PopLayout()
   {
      this._layoutTransitionDepth = this._layoutTransitionDepth + 1;
      var _loc2_ = this._layouts.length;
      if(_loc2_ != 0)
      {
         this.SetHighlightedObject(null);
         this.UnapplyLayout(this._layouts[_loc2_ - 1]);
         this._layouts.pop();
         _loc2_ = this._layouts.length;
         trace(" PopLayout: SetHighlightedObject = null");
         if(this._layouts.length > 0)
         {
            if(this._layouts[this._layouts.length - 1]._forceHighlightOnPop)
            {
               this.SetHighlightedObject(this._savedHighlights[this._savedHighlights.length - 1]);
            }
            else
            {
               this._highlightedObject = this._savedHighlights[this._savedHighlights.length - 1];
            }
            this._savedHighlights.pop();
            this.ApplyLayout(this._layouts[this._layouts.length - 1]);
            trace(" PopLayout: ApplyLayout");
         }
         else
         {
            this._highlightedObject = null;
         }
         this.DecrFocusCount();
      }
      this._layoutTransitionDepth = this._layoutTransitionDepth - 1;
   }
   function RemoveLayout(layout)
   {
      this._layoutTransitionDepth = this._layoutTransitionDepth + 1;
      var _loc3_ = this._layouts.length;
      if(this._layouts.length != 0)
      {
         var _loc2_ = this._layouts.length - 1;
         while(_loc2_ >= 0)
         {
            if(this._layouts[_loc2_] == layout)
            {
               trace(" Removing Layout: (" + layout.parent + "), nLayoutLength == " + _loc3_);
               if(_loc2_ == _loc3_ - 1)
               {
                  trace(" RemoveLayout: PopLayout: break");
                  this.PopLayout();
                  break;
               }
               if(_loc2_ == 0)
               {
                  trace(" RemoveLayout: shift");
                  this._layouts.shift();
                  this._savedHighlights.shift();
               }
               else
               {
                  trace(" RemoveLayout: slicing");
                  this._layouts = this._layouts.slice(0,_loc2_).concat(this._layouts.slice(_loc2_ + 1,_loc3_));
                  this._savedHighlights = this._savedHighlights.slice(0,_loc2_).concat(this._savedHighlights.slice(_loc2_ + 1,this._savedHighlights.length - 1));
               }
               this.DecrFocusCount();
               trace(" RemoveLayout: ( " + this._layouts[_loc2_].parent + " ), (_layouts.length) = " + this._layouts.length);
               break;
            }
            _loc2_ = _loc2_ - 1;
         }
      }
      this._layoutTransitionDepth = this._layoutTransitionDepth - 1;
      this.TraceLayouts();
   }
   function SetHighlightedObject(obj)
   {
      if(obj != this._highlightedObject)
      {
         var _loc3_ = this._highlightedObject;
         if(this._highlightedObject)
         {
            this._highlightedObject.exitHighlight(obj);
         }
         this._highlightedObject = obj;
         trace(" SetHighlightedObject: (" + obj + ")");
         if(this._highlightedObject)
         {
            this.unsetMouseOverControls(this._highlightedObject);
            this._highlightedObject.enterHighlight(_loc3_);
            if(this._highlightedObject.SuppressHighlightSound == undefined || !this._highlightedObject.SuppressHighlightSound())
            {
               this.PlayNavSound(this._highlightSound);
            }
         }
      }
   }
   function ClaimInputFocus()
   {
      this.IncrFocusCount();
      this._processKeyEvents = false;
   }
   function ReleaseInputFocus()
   {
      this._processKeyEvents = true;
      this.DecrFocusCount();
   }
   function TryPassKeyToObject(object, operation, keyName, keyBinding, keyCode)
   {
      var _loc5_ = false;
      if(object != undefined && object != null)
      {
         var _loc2_ = object.keyHandler;
         if(_loc2_ != undefined && _loc2_ != null)
         {
            var _loc3_ = 0;
            while(_loc3_ < 3)
            {
               if(_loc3_ == 0)
               {
                  _loc2_ = object.keyHandler[keyName];
               }
               else if(_loc3_ == 1)
               {
                  if(keyBinding != null && keyBinding != undefined && keyBinding.length != 0)
                  {
                     _loc2_ = object.keyHandler[keyBinding];
                  }
                  else
                  {
                     _loc2_ = undefined;
                  }
               }
               else if(_loc3_ == 2)
               {
                  _loc2_ = object.keyHandler.ANY;
               }
               if(_loc2_ != undefined && _loc2_ != null)
               {
                  var _loc4_ = _loc2_[operation];
                  if(_loc4_ != undefined && _loc4_ != null)
                  {
                     _loc5_ = _loc4_(this._highlightedObject,object,keyCode);
                     if(_loc5_ == undefined)
                     {
                        _loc5_ = true;
                     }
                  }
                  else if(operation == Lib.SFKey.onUp && _loc2_[Lib.SFKey.onDown] != undefined && _loc2_[Lib.SFKey.onDown] != null)
                  {
                     _loc5_ = true;
                  }
                  break;
               }
               _loc3_ = _loc3_ + 1;
            }
         }
      }
      return _loc5_;
   }
   function TryPassKeyToLayout(operation, keyName, keyBinding, keyCode)
   {
      var _loc8_ = this._layouts.length;
      if(_loc8_)
      {
         var _loc7_ = this._layouts[_loc8_ - 1];
         if(this._highlightedObject)
         {
            var _loc2_ = _loc7_.GetParentOf(this._highlightedObject);
            while(_loc2_)
            {
               if(_loc2_.isNavigable() && this.TryPassKeyToObject(_loc2_,operation,keyName,keyBinding,keyCode))
               {
                  if(operation == Lib.SFKey.onDown)
                  {
                     this.AddRepeatKey(keyName,keyBinding,keyCode,_loc2_);
                  }
                  return true;
               }
               _loc2_ = _loc7_.GetParentOf(_loc2_);
            }
         }
         if(this.TryPassKeyToObject(_loc7_,operation,keyName,keyBinding,keyCode))
         {
            if(operation == Lib.SFKey.onDown)
            {
               this.AddRepeatKey(keyName,keyBinding,keyCode,_loc7_);
            }
            return true;
         }
      }
      return false;
   }
   function TryChangeHighlight(keyName)
   {
      var _loc6_ = this._layouts.length;
      if(_loc6_)
      {
         var _loc4_ = this._layouts[_loc6_ - 1];
         var _loc2_ = undefined;
         var _loc3_ = this._highlightedObject;
         while(true)
         {
            _loc2_ = _loc4_.GetNextHighlight(_loc3_,keyName);
            if(!_loc2_)
            {
               return false;
            }
            if(!_loc2_.isNavigable())
            {
               _loc3_ = _loc2_;
               continue;
            }
            this.SetHighlightedObject(_loc2_);
            return true;
         }
      }
      return false;
   }
   function GetKeyCode()
   {
      var _loc1_ = Lib.SFKey.getKeyCode();
      return _loc1_;
   }
   function onKeyDown()
   {
      var _loc2_ = false;
      if(this._inputLockedToSlot == -1 || Lib.SFKey.getKeySlot() == this._inputLockedToSlot)
      {
         if(this._processKeyEvents)
         {
            _loc2_ = this.handleKeyDown(this.GetKeyCode(),Lib.SFKey.getKeyBinding());
         }
      }
      if(this.IsInPauseMenu())
      {
         _loc2_ = true;
      }
      return _loc2_;
   }
   function handleKeyDown(keyCode, keyBinding)
   {
      var _loc2_ = Lib.SFKey.KeyName(keyCode);
      if(_loc2_ == null)
      {
         return false;
      }
      var _loc3_ = false;
      this.IncrFocusCount();
      if(this._highlightedObject != undefined && this._highlightedObject != null)
      {
         if(this.TryPassKeyToObject(this._highlightedObject,Lib.SFKey.onDown,_loc2_,keyBinding,keyCode))
         {
            this.AddRepeatKey(_loc2_,keyBinding,keyCode,this._highlightedObject);
            _loc3_ = true;
         }
      }
      if(!_loc3_)
      {
         if(this.TryPassKeyToLayout(Lib.SFKey.onDown,_loc2_,keyBinding,keyCode))
         {
            _loc3_ = true;
         }
         else if(this.TryChangeHighlight(_loc2_))
         {
            this.AddDownKey(_loc2_,keyBinding,null,null);
            _loc3_ = true;
         }
      }
      this.DecrFocusCount();
      return _loc3_;
   }
   function onKeyUp()
   {
      var _loc2_ = false;
      if(this._inputLockedToSlot == -1 || Lib.SFKey.getKeySlot() == this._inputLockedToSlot)
      {
         _loc2_ = this.handleKeyUp(this.GetKeyCode(),Lib.SFKey.getKeyBinding());
      }
      if(this.IsInPauseMenu())
      {
         _loc2_ = true;
      }
      return _loc2_;
   }
   function handleKeyUp(keyCode, keyBinding)
   {
      var _loc2_ = Lib.SFKey.KeyName(keyCode);
      if(_loc2_ == null)
      {
         return false;
      }
      this.RemoveDownKey(_loc2_);
      var _loc3_ = false;
      this.IncrFocusCount();
      if(this._processKeyEvents)
      {
         if(this.TryPassKeyToObject(this._highlightedObject,Lib.SFKey.onUp,_loc2_,keyBinding,keyCode))
         {
            _loc3_ = true;
         }
         else
         {
            _loc3_ = this.TryPassKeyToLayout(Lib.SFKey.onUp,_loc2_,keyBinding,keyCode);
         }
      }
      this.DecrFocusCount();
      return _loc3_;
   }
   function onCharTyped(typed, slot)
   {
      if(this._inputLockedToSlot != -1 && this._inputLockedToSlot != slot)
      {
         return false;
      }
      var _loc3_ = this._layouts.length;
      if(_loc3_ == 0)
      {
         return false;
      }
      var _loc2_ = this._layouts[_loc3_ - 1];
      if(_loc2_.onCharTyped == undefined)
      {
         return false;
      }
      return _loc2_.onCharTyped(typed);
   }
   function lockInputToCurrentSlot()
   {
      this._inputLockedToSlot = Lib.SFKey.getKeySlot();
   }
   function lockInputToSlot(slot)
   {
      this._inputLockedToSlot = slot;
   }
   function clearInputLock()
   {
      this._inputLockedToSlot = -1;
   }
   function IsInPauseMenu()
   {
      var _loc2_ = _global.PauseBackgroundMovie;
      return _loc2_ != null && _loc2_ != undefined;
   }
   function IsTopLayoutModal()
   {
      var _loc2_ = this._layouts.length;
      return this._layouts[_loc2_ - 1]._modal;
   }
   function IsTopLayoutEqualTo(navLayout)
   {
      var _loc2_ = this._layouts.length;
      return this._layouts[_loc2_ - 1] == navLayout;
   }
   static function Init()
   {
      if(_global.navManager == null)
      {
         Selection.disableFocusKeys = true;
         _global.navManager = new Lib.NavManager();
         Object.prototype.isNavigable = function()
         {
            return this._visible;
         };
      }
   }
}
