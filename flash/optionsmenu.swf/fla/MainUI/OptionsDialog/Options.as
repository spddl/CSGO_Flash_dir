class MainUI.OptionsDialog.Options extends MovieClip
{
   var strOldText = "default";
   var m_nCurrentWidget = 0;
   var nQueuedWidgetLoads = 0;
   var IsGlyphControl = false;
   var IsEditingGlyphControl = false;
   var m_nDefaultTipWidth = 1;
   static var DIALOG_MODE_MOUSE_KEYBOARD = 0;
   static var DIALOG_MODE_CONTROLLER = 1;
   static var DIALOG_MODE_SETTINGS = 2;
   static var DIALOG_MODE_MOTION_CONTROLLER = 3;
   static var DIALOG_MODE_MOTION_CONTROLLER_MOVE = 4;
   static var DIALOG_MODE_MOTION_CONTROLLER_SHARPSHOOTER = 5;
   static var DIALOG_MODE_VIDEO = 6;
   static var DIALOG_MODE_VIDEO_ADVANCED = 7;
   static var DIALOG_MODE_AUDIO = 8;
   static var DIALOG_MODE_SCREENRESIZE = 9;
   function Options(thePanel, gameAPI)
   {
      super();
      this.m_Panel = thePanel;
      this.m_gameAPI = gameAPI;
   }
   function InitDialog(rgSlots, mode)
   {
      this.m_rgWidgetSlots = rgSlots;
      this.UpdateDialogMode(mode);
      _root.attachMovie("tooltip-context-menu","OptionsTooltip",999);
      this.m_Tooltip = _root.OptionsTooltip;
      this.m_Tooltip._visible = false;
      this.m_nDefaultTipWidth = this.m_Tooltip._width;
   }
   function GetMode()
   {
      return this.m_DialogMode;
   }
   function UpdateDialogMode(mode)
   {
      this.m_DialogMode = mode;
      if(this.m_DialogMode == MainUI.OptionsDialog.Options.DIALOG_MODE_MOUSE_KEYBOARD)
      {
         this.m_strBindType = "btn-keyboard";
      }
      else
      {
         this.m_strBindType = "glyph-panel";
      }
      this.m_rgWidgetTypes = ["slide-control_number","btn-main-master","dropdown-options",this.m_strBindType];
      trace("Options: UpdateDialogMode - m_rgWidgetTypes initialized!");
   }
   function GetCurrentWidget()
   {
      return this.m_rgWidgetSlots[this.m_nCurrentWidget];
   }
   function GetCurrentWidgetIndex()
   {
      return this.m_nCurrentWidget;
   }
   function UpdateHighlight(nIndex)
   {
      if(!this.IsEditingGlyphControl)
      {
         if(this.m_nCurrentWidget != nIndex)
         {
            this.GetCurrentHighlight().setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
         }
         this.m_nCurrentWidget = Number(nIndex);
         trace("!!     m_nCurrentWidget = " + this.m_nCurrentWidget);
         if(this.GetCurrentHighlight().buttonState != Lib.Controls.SFButton.BUTTON_STATE_OVER)
         {
            this.GetCurrentHighlight().setState(Lib.Controls.SFButton.BUTTON_STATE_DOWN);
         }
         _global.navManager.SetHighlightedObject(this.GetCurrentHighlight().myWidget.Widget);
         this.m_gameAPI.OnHighlightWidget(this.m_nCurrentWidget);
         _global.OptionsMovie.UpdateDeadZoneWidget();
         this.m_Panel.SetNavState();
         if(this.GetHighlightedControl().hitTest(_root._xmouse,_root._ymouse,true))
         {
            this.ShowToolTip(true,this.GetCurrentHighlight().myWidget.Widget,this.GetCurrentHighlight().myWidget.Tooltip);
         }
         else
         {
            this.ShowToolTip(true,this.GetCurrentHighlight(),"");
         }
      }
   }
   function GetCurrentHighlight()
   {
      return this.m_Panel.Control_Dummy["Control_" + this.m_nCurrentWidget].Highlight;
   }
   function GetHighlightedControl()
   {
      return this.m_Panel.Control_Dummy["Control_" + this.m_nCurrentWidget];
   }
   function GetHighlight(nIndex)
   {
      return this.m_Panel.Control_Dummy["Control_" + nIndex.toString()].Highlight;
   }
   function CompleteLayout()
   {
      trace("!!!!!!!CompleteLayoutCompleteLayoutCompleteLayoutCompleteLayout!!!!!");
      var _instance = this;
      var _loc3_ = 0;
      while(_loc3_ < this.m_rgWidgetSlots.length)
      {
         var _loc5_ = this.m_Panel.Control_Dummy["Control_" + _loc3_.toString()];
         var _loc4_ = _loc5_.Control_Widget;
         var _loc2_ = _loc5_.Highlight;
         _loc4_.myHighlight = _loc2_;
         _loc4_.myIndex = _loc3_;
         _loc2_.myWidget = _loc4_;
         _loc2_.myIndex = _loc3_;
         _loc2_.Action = function()
         {
            _instance.UpdateHighlight(this.myIndex);
         };
         _loc2_.RolledOut = function()
         {
            _instance.GetCurrentHighlight().setState(Lib.Controls.SFButton.BUTTON_STATE_DOWN);
            _instance.ShowToolTip(true,this,"");
         };
         _loc2_.SetFocusFromMouse = function()
         {
         };
         _loc2_.onRollOver = function()
         {
            if(!this.isModalLockedOut())
            {
               if(this.m_nCurrentWidget != this.myIndex && this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
               {
                  this.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
                  this.PlayHighlightSound();
                  this.RolledOver();
               }
               _instance.ShowToolTip(true,this.myWidget.Widget,this.myWidget.Tooltip);
            }
         };
         _loc3_ = _loc3_ + 1;
      }
      this.UpdateHighlight(this.m_nCurrentWidget);
      this.m_gameAPI.OnLayoutComplete();
   }
   function LayoutUpdateHighlight(nIndex)
   {
      this.m_nCurrentWidget = nIndex;
      this.UpdateHighlight(this.m_nCurrentWidget);
   }
   function StartKeyPressed()
   {
      var _loc2_ = this;
      if(this.IsEditingGlyphControl)
      {
         this.IsEditingGlyphControl = false;
         this.GetCurrentWidget().Widget.htmlText = this.strOldText;
      }
   }
   function RefreshWidgetLayout()
   {
      var _instance = this;
      var _loc4_ = new Array();
      var _loc3_ = 0;
      while(_loc3_ < this.m_rgWidgetSlots.length)
      {
         _loc4_[_loc3_] = this.m_rgWidgetSlots[_loc3_].Widget;
         if(this.m_rgWidgetSlots[_loc3_].Type == "btn-main-master")
         {
            _loc4_[_loc3_].MoveLeft = function()
            {
               _instance.UpdateValue(_instance.m_rgWidgetSlots[this._parent.Index].Index,-1);
            };
            _loc4_[_loc3_].MoveRight = function()
            {
               _instance.UpdateValue(_instance.m_rgWidgetSlots[this._parent.Index].Index,1);
            };
            _loc4_[_loc3_].LeftButton.RolledOver = function()
            {
               this._parent._parent.myHighlight.onRollOver();
            };
            _loc4_[_loc3_].RightButton.RolledOver = function()
            {
               this._parent._parent.myHighlight.onRollOver();
            };
            _loc4_[_loc3_].MiddleButton.RolledOver = function()
            {
               this._parent._parent.myHighlight.onRollOver();
            };
            _loc4_[_loc3_].MiddleButton.Action = function()
            {
               _instance.UpdateHighlight(this._parent.myIndex);
            };
            _loc4_[_loc3_].LeftButton.RolledOut = function()
            {
               this._parent._parent.myHighlight.onRollOut();
            };
            _loc4_[_loc3_].RightButton.RolledOut = function()
            {
               this._parent._parent.myHighlight.onRollOut();
            };
            _loc4_[_loc3_].MiddleButton.RolledOut = function()
            {
               this._parent._parent.myHighlight.onRollOut();
            };
         }
         else if(this.m_rgWidgetSlots[_loc3_].Type == "dropdown-options")
         {
            _loc4_[_loc3_].Dropdown.RolledOver = function()
            {
               this._parent._parent.myHighlight.onRollOver();
            };
            _loc4_[_loc3_].Dropdown.RolledOut = function()
            {
               this._parent._parent.myHighlight.onRollOut();
            };
            _loc4_[_loc3_].Catagory.RolledOver = function()
            {
               this._parent._parent.myHighlight.onRollOver();
            };
            _loc4_[_loc3_].Catagory.RolledOut = function()
            {
               this._parent._parent.myHighlight.onRollOut();
            };
            _loc4_[_loc3_].NotifyValueChange = function()
            {
               trace("dropdown NotifyValueChange!!!!!!!!!!!!!!");
               _instance.UpdateValue(_instance.m_rgWidgetSlots[this._parent.Index].Index,this.GetSelectedIndex());
               _instance.UpdateHighlight(this._parent._parent.myIndex);
            };
            _loc4_[_loc3_].CreateInit = function()
            {
               this.defaultDepth = this._parent._parent.getDepth();
               this._parent._parent.swapDepths(this.defaultDepth);
               trace("dropdown CreateInit!!!!!!!!!!!!!!");
            };
            _loc4_[_loc3_].DropDownCloseNotify = function()
            {
               this.defaultDepth = this._parent._parent.getDepth();
               this._parent._parent.swapDepths(this.defaultDepth);
               trace("dropdown DropDownCloseNotify!!!!!!!!!!!!!!");
               _instance.UpdateValue(_instance.m_rgWidgetSlots[this._parent.Index].Index,this.GetSelectedIndex());
               _instance.UpdateHighlight(this._parent._parent.myIndex);
            };
            _loc4_[_loc3_].DropDownOpenNotify = function()
            {
               this.defaultDepth = this._parent._parent.getDepth();
               this._parent._parent.swapDepths(-1);
               trace("dropdown DropDownOpenNotify!!!!!!!!!!!!!!");
               _instance.UpdateValue(_instance.m_rgWidgetSlots[this._parent.Index].Index,this.GetSelectedIndex());
               _instance.UpdateHighlight(this._parent._parent.myIndex);
            };
         }
         else if(this.m_rgWidgetSlots[_loc3_].Type == "slide-control_number")
         {
            _loc4_[_loc3_].NotifyValueChange = function()
            {
               _instance.UpdateValue(_instance.m_rgWidgetSlots[this._parent.Index].Index,this.GetValue());
               _instance.UpdateHighlight(this._parent._parent.myIndex);
            };
            _loc4_[_loc3_].notifyExecuteInput = function()
            {
               _instance.m_gameAPI.OnRefreshValues();
               _instance.UpdateHighlight(this._parent._parent.myIndex);
            };
            _loc4_[_loc3_].LeftButton.RolledOver = function()
            {
               if(this.isDisabled() == false)
               {
                  this._parent._parent.myHighlight.onRollOver();
               }
            };
            _loc4_[_loc3_].RightButton.RolledOver = function()
            {
               if(this.isDisabled() == false)
               {
                  this._parent._parent.myHighlight.onRollOver();
               }
            };
            _loc4_[_loc3_].InputField.RolledOver = function()
            {
               if(this.isDisabled() == false)
               {
                  this._parent._parent.myHighlight.onRollOver();
               }
            };
            _loc4_[_loc3_].ScrollPip.RolledOver = function()
            {
               if(this.isDisabled() == false)
               {
                  this._parent._parent.myHighlight.onRollOver();
               }
            };
            _loc4_[_loc3_].SlideBar.RolledOver = function()
            {
               if(this.isDisabled() == false)
               {
                  this._parent._parent.myHighlight.onRollOver();
               }
            };
            _loc4_[_loc3_].LeftButton.RolledOut = function()
            {
               if(this.isDisabled() == false)
               {
                  this._parent._parent.myHighlight.onRollOut();
               }
            };
            _loc4_[_loc3_].RightButton.RolledOut = function()
            {
               if(this.isDisabled() == false)
               {
                  this._parent._parent.myHighlight.onRollOut();
               }
            };
            _loc4_[_loc3_].InputField.RolledOut = function()
            {
               if(this.isDisabled() == false)
               {
                  this._parent._parent.myHighlight.onRollOut();
               }
            };
            _loc4_[_loc3_].ScrollPip.RolledOut = function()
            {
               if(this.isDisabled() == false)
               {
                  this._parent._parent.myHighlight.onRollOut();
               }
            };
            _loc4_[_loc3_].SlideBar.RolledOut = function()
            {
               if(this.isDisabled() == false)
               {
                  this._parent._parent.myHighlight.onRollOut();
               }
            };
         }
         else if(this.m_rgWidgetSlots[_loc3_].Type == this.m_strBindType)
         {
            _loc4_[_loc3_].RolledOver = function()
            {
               this._parent.myHighlight.onRollOver();
            };
            _loc4_[_loc3_].RolledOut = function()
            {
               this._parent.myHighlight.onRollOut();
            };
            _loc4_[_loc3_].Action = function()
            {
               _instance.UpdateHighlight(this._parent.myIndex);
               _instance.ModifyBind();
            };
         }
         _loc3_ = _loc3_ + 1;
      }
      _global.navManager.SetHighlightedObject(_instance.GetCurrentWidget().Widget);
   }
   function UpdateValue(nWidgetIndex, nNewValue)
   {
      this.m_rgWidgetSlots[nWidgetIndex].Data = nNewValue;
      if(!this.m_rgWidgetSlots[nWidgetIndex].m_bDisabled)
      {
         trace("OnUpdateValue: nWidgetIndex = " + nWidgetIndex + ", nNewValue = " + nNewValue);
         this.m_gameAPI.OnUpdateValue(nWidgetIndex,nNewValue);
      }
      if(this.m_rgWidgetSlots[nWidgetIndex].Type == "slide-control_number")
      {
         _global.OptionsMovie.UpdateDeadZoneWidget();
      }
   }
   function ModifyBind()
   {
      if(this.GetCurrentWidget().Type == "btn-keyboard" || this.GetCurrentWidget().Type == "glyph-panel")
      {
         if(_global.wantControllerShown && this.m_DialogMode == MainUI.OptionsDialog.Options.DIALOG_MODE_MOUSE_KEYBOARD || !_global.wantControllerShown && this.m_DialogMode != MainUI.OptionsDialog.Options.DIALOG_MODE_MOUSE_KEYBOARD)
         {
            _global.navManager.PlayNavSound("ButtonNA");
            return undefined;
         }
         if(!this.IsEditingGlyphControl)
         {
            this.strOldText = this.GetCurrentWidget().Widget.htmlText;
            this.GetCurrentWidget().Widget.SetText("#SFUI_Controls_Modify");
            this.IsEditingGlyphControl = true;
            this.m_Panel.NavigationMaster.PCButtons.EditKeyButton.setDisabled(true);
            this.m_Panel.NavigationMaster.PCButtons.ClearKeyButton.setDisabled(true);
            this.m_Panel.NavigationMaster.PCButtons.UseDefaultsButton.setDisabled(true);
         }
         else
         {
            if(this.m_gameAPI.OnUpdateValue(this.m_nCurrentWidget,0) == true)
            {
               this.IsEditingGlyphControl = false;
               this.m_Panel.NavPanel.Nav.Text.htmlText = "#SFUI_Controls_Nav";
            }
            else
            {
               _global.navManager.PlayNavSound("ButtonNA");
            }
            this.m_Panel.NavigationMaster.PCButtons.EditKeyButton.setDisabled(false);
            this.m_Panel.NavigationMaster.PCButtons.ClearKeyButton.setDisabled(false);
            this.m_Panel.NavigationMaster.PCButtons.UseDefaultsButton.setDisabled(false);
         }
      }
   }
   function ClearBind()
   {
      if(this.m_strBindType == "glyph-panel" || this.GetCurrentWidget().Type == "btn-keyboard")
      {
         this.GetCurrentWidget().Widget.SetText("");
         this.m_gameAPI.OnClearBind(this.m_nCurrentWidget,0);
      }
   }
   function DisableWidget(nWidgetIndex, bDisabled)
   {
      if(this.m_rgWidgetSlots[nWidgetIndex].m_bDisabled != bDisabled)
      {
         this.m_rgWidgetSlots[nWidgetIndex].Widget.setDisabled(bDisabled);
         this.m_rgWidgetSlots[nWidgetIndex].m_bDisabled = bDisabled;
      }
   }
   function RefreshInputField(nWidgetIndex)
   {
      this.m_rgWidgetSlots[nWidgetIndex].Widget.RefreshInputField();
   }
   function onUpdateWidget(nWidgetIndex, nWidgetType, Data, Convar, DataArray, strTooltip)
   {
      var _instance = this;
      if(this.m_rgWidgetSlots[nWidgetIndex].Type != this.m_rgWidgetTypes[nWidgetType])
      {
         if(this.m_rgWidgetSlots[nWidgetIndex].Widget)
         {
            _global.tintManager.DeregisterAll(this.m_rgWidgetSlots[nWidgetIndex]);
            this.removeMovieClip();
         }
         var _loc9_ = this.m_Panel.getNextHighestDepth();
         this.m_rgWidgetSlots[nWidgetIndex].Type = this.m_rgWidgetTypes[nWidgetType];
         this.m_rgWidgetSlots[nWidgetIndex].TypeID = nWidgetType;
         this.m_rgWidgetSlots[nWidgetIndex].Index = nWidgetIndex;
         this.m_rgWidgetSlots[nWidgetIndex].Widget._visible = false;
         this.m_rgWidgetSlots[nWidgetIndex].Data = Data;
         this.m_rgWidgetSlots[nWidgetIndex].Convar = Convar;
         this.m_rgWidgetSlots[nWidgetIndex].DataArray = DataArray;
         this.m_rgWidgetSlots[nWidgetIndex].Tooltip = strTooltip;
         var _loc6_ = this.m_Panel.Control_Dummy["Control_" + nWidgetIndex];
         if(nWidgetType == 5)
         {
            _loc6_.Dividers._visible = false;
            _loc6_.Control_Text.textColor = 6987441;
            return undefined;
         }
         _loc6_.Control_Text.textColor = 16777215;
         _loc6_.Dividers._visible = true;
         var _loc4_ = this.m_rgWidgetSlots[nWidgetIndex].attachMovieClip(this.m_rgWidgetTypes[nWidgetType],"Widget",_loc9_);
         if(nWidgetType == 2)
         {
         }
         trace("*** " + this.m_rgWidgetSlots[nWidgetIndex]._parent + ".getDepth() [" + nWidgetIndex + "]:  " + this.m_rgWidgetSlots[nWidgetIndex]._parent.getDepth());
         _loc4_._visible = false;
         _loc4_.Data = Data;
         _loc4_.Convar = Convar;
         _loc4_.DataArray = DataArray;
         _loc4_.Tooltip = strTooltip;
         this.nQueuedWidgetLoads = this.nQueuedWidgetLoads + 1;
         trace("onUpdateWidget: nQueuedWidgetLoads = " + this.nQueuedWidgetLoads + ", WidgetIndex = " + nWidgetType + ", Type = " + this.m_rgWidgetSlots[nWidgetIndex].Type);
         switch(nWidgetType)
         {
            case 0:
               _loc4_.onLoad = function()
               {
                  this.Init(this.Convar);
                  this.SetValue(this.Data);
                  _instance.nQueuedWidgetLoads--;
                  trace("onLoad: this.Convar = " + this.Convar + ", nQueuedWidgetLoads = " + _instance.nQueuedWidgetLoads);
                  this._visible = true;
                  if(_instance.nQueuedWidgetLoads == 0)
                  {
                     _instance.CompleteLayout();
                  }
               };
               break;
            case 1:
               _loc4_.onLoad = function()
               {
                  this.SetText(Data);
                  _instance.nQueuedWidgetLoads--;
                  trace("onLoad: this.Convar = " + this.Convar + ", nQueuedWidgetLoads = " + _instance.nQueuedWidgetLoads);
                  this._visible = true;
                  if(_instance.nQueuedWidgetLoads == 0)
                  {
                     _instance.CompleteLayout();
                  }
               };
               break;
            case 2:
               _loc4_.onLoad = function()
               {
                  this.SetUpDropDownForOptions(DataArray,"",Data);
                  _instance.nQueuedWidgetLoads--;
                  trace("onLoad: this.Convar = " + this.Convar + ", nQueuedWidgetLoads = " + _instance.nQueuedWidgetLoads);
                  this._visible = true;
                  if(_instance.nQueuedWidgetLoads == 0)
                  {
                     _instance.CompleteLayout();
                  }
               };
               break;
            case 3:
               _loc4_.onLoad = function()
               {
                  if(_instance.m_strBindType == "glyph-panel")
                  {
                     _instance.m_gameAPI.OnPopulateGlyphRequest(this.GlyphPanel,Data);
                  }
                  else
                  {
                     var _loc2_ = Data;
                     var _loc3_ = _loc2_.toUpperCase();
                     this.SetText(_loc3_);
                  }
                  _instance.nQueuedWidgetLoads--;
                  trace("onLoad: this.Convar = " + this.Convar + ", nQueuedWidgetLoads = " + _instance.nQueuedWidgetLoads);
                  this._visible = true;
                  if(_instance.nQueuedWidgetLoads == 0)
                  {
                     _instance.CompleteLayout();
                  }
               };
         }
      }
      else
      {
         _loc6_ = this.m_Panel.Control_Dummy["Control_" + nWidgetIndex];
         _loc6_.Dividers._visible = true;
         _loc6_.Control_Text.textColor = 16777215;
         switch(nWidgetType)
         {
            case 0:
               this.m_rgWidgetSlots[nWidgetIndex].Widget.UpdateConvar(Convar);
               this.m_rgWidgetSlots[nWidgetIndex].Widget.SetValue(Data);
               break;
            case 1:
               this.m_rgWidgetSlots[nWidgetIndex].Widget.SetText(Data);
               break;
            case 2:
               this.m_rgWidgetSlots[nWidgetIndex].Widget.SetUpDropDownForOptions(DataArray,"",Data);
               break;
            case 3:
               this.m_rgWidgetSlots[nWidgetIndex].Widget._visible = true;
               var _loc8_ = Data;
               var _loc10_ = _loc8_.toUpperCase();
               this.m_rgWidgetSlots[nWidgetIndex].Widget.SetText(_loc10_);
               break;
            case 5:
               _loc6_.Dividers._visible = false;
               _loc6_.Control_Text.textColor = 6987441;
         }
         this.m_rgWidgetSlots[nWidgetIndex].Type = this.m_rgWidgetTypes[nWidgetType];
         this.m_rgWidgetSlots[nWidgetIndex].TypeID = nWidgetType;
         this.m_rgWidgetSlots[nWidgetIndex].Index = nWidgetIndex;
         this.m_rgWidgetSlots[nWidgetIndex].Data = Data;
         this.m_rgWidgetSlots[nWidgetIndex].Convar = Convar;
         this.m_rgWidgetSlots[nWidgetIndex].DataArray = DataArray;
         this.m_rgWidgetSlots[nWidgetIndex].Tooltip = strTooltip;
      }
   }
   function ShowToolTip(bShow, parent, strText)
   {
      if(bShow && strText)
      {
         this.m_Tooltip.Text.htmlText = strText;
         this.m_Tooltip.Text.autoSize = true;
         this.m_Tooltip._visible = true;
         trace("ShowToolTip ---  strText: " + strText + ", Tooltip.Text._height: " + this.m_Tooltip.Text._height + ", m_Tooltip._x = " + this.m_Tooltip._x + ", m_Tooltip._y = " + this.m_Tooltip._y);
         this.m_Tooltip.Bg._height = this.m_Tooltip.Text._height + 24;
         var _loc6_ = 270;
         var _loc8_ = _loc6_ / this.m_nDefaultTipWidth;
         trace("ShowToolTip ---  parent._width: " + parent._width + ", m_nDefaultTipWidth: " + this.m_nDefaultTipWidth + ", m_Panel._yscale: " + this.m_Panel._yscale + ", flSizeRatio = " + _loc8_);
         this.m_Tooltip._xscale = Stage.height / 1024 * 94.8;
         this.m_Tooltip._yscale = Stage.height / 1024 * 94.8;
         var _loc9_ = parent._x;
         var _loc7_ = parent._y + 24;
         var _loc3_ = {x:_loc9_,y:_loc7_};
         if(_global.CheckOverBottomScreenBounds(_loc3_,this.m_Tooltip.Bg._height,this.m_Tooltip))
         {
            _loc3_.y = parent._y - this.m_Tooltip.Bg._height;
         }
         parent.localToGlobal(_loc3_);
         this.m_Tooltip._x = _loc3_.x;
         this.m_Tooltip._y = _loc3_.y;
      }
      else
      {
         this.m_Tooltip._visible = false;
      }
   }
}
