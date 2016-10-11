function SetUpDropDown(aDropdownOptions, strTitle, strNameString, funcToCallOnEntryPressed, DefaultTitle)
{
   var _loc7_ = _global.GameInterface.Translate(strNameString + DefaultTitle);
   m_nNumVisibleButtons = 0;
   m_aDropdownOptions = aDropdownOptions;
   Dropdown._visible = false;
   DisabledBar._visible = false;
   OnDropDownClose();
   Title.htmlText = strTitle;
   SetDropDownSelectedText(_loc7_);
   Catagory.dialog = this;
   Catagory.Action = function()
   {
      if(!m_bDisabled)
      {
         this.dialog.onShowDropDown();
      }
   };
   Dropdown.Background.onMouseDown = function()
   {
      HideList();
   };
   var _loc3_ = 0;
   while(_loc3_ < DROPDOWN_NUM_OPTIONS_BUTTONS)
   {
      var _loc4_ = Dropdown["Button" + _loc3_];
      if(_loc3_ > m_aDropdownOptions.length - 1)
      {
         _loc4_._visible = false;
      }
      else
      {
         SetUpDropdownListButton(_loc4_,m_aDropdownOptions[_loc3_],strNameString,funcToCallOnEntryPressed);
         m_nNumVisibleButtons++;
      }
      _loc3_ = _loc3_ + 1;
   }
   Dropdown.Background._height = m_nNumVisibleButtons * Dropdown.Button1._height + 10;
}
function SetUpDropDownForOptions(aDropdownOptions, strTitle, nSelectedIndex)
{
   m_nNumVisibleButtons = 0;
   m_nSelectedIndex = nSelectedIndex;
   m_aDropdownOptions = aDropdownOptions;
   Dropdown._visible = false;
   Dropdown_Top._visible = false;
   DisabledBar._visible = false;
   CreateInit();
   this.gotoAndStop("Init");
   Catagory.dialog = this;
   Catagory.Action = function()
   {
      if(!m_bDisabled)
      {
         this.dialog.onShowDropDown();
      }
   };
   Dropdown.ScrollUp.dialog = this;
   Dropdown.ScrollUp.Action = function()
   {
      this.dialog.ScrollDropdownUp();
   };
   Dropdown.ScrollDown.dialog = this;
   Dropdown.ScrollDown.Action = function()
   {
      this.dialog.ScrollDropdownDown();
   };
   Dropdown_Top.ScrollUp.dialog = this;
   Dropdown_Top.ScrollUp.Action = function()
   {
      this.dialog.ScrollDropdownUp();
   };
   Dropdown_Top.ScrollDown.dialog = this;
   Dropdown_Top.ScrollDown.Action = function()
   {
      this.dialog.ScrollDropdownDown();
   };
   Dropdown.onMouseDown = function()
   {
      if(Dropdown._visible == true)
      {
         HideList();
      }
   };
   Dropdown_Top.onMouseDown = function()
   {
      if(Dropdown_Top._visible == true)
      {
         HideList();
      }
   };
   var _loc3_ = 0;
   while(_loc3_ < DROPDOWN_NUM_OPTIONS_BUTTONS)
   {
      var _loc4_ = Dropdown["Button" + _loc3_];
      var _loc5_ = Dropdown_Top["Button" + _loc3_];
      if(_loc3_ > m_aDropdownOptions.length - 1)
      {
         _loc4_._visible = false;
         _loc5_._visible = false;
      }
      else
      {
         var _loc7_ = m_nDropdownOffset + _loc3_;
         var _loc6_ = _global.GameInterface.Translate(m_aDropdownOptions[_loc7_]);
         _loc4_.index = _loc7_;
         _loc5_.index = _loc7_;
         _loc4_.label = _loc6_;
         trace("SetUpDropDownForOptions: objListButton.label = " + _loc4_.label + ", strEntryName = " + _loc6_ + ", aDropdownOptions[i] = " + aDropdownOptions[_loc3_]);
         _loc5_.label = _loc6_;
         SetUpDropdownListButtonForOptions(_loc4_);
         SetUpDropdownListButtonForOptions(_loc5_);
         if(nSelectedIndex == _loc7_)
         {
            SetDropDownSelectedText(_loc6_);
         }
         m_nNumVisibleButtons++;
      }
      _loc3_ = _loc3_ + 1;
   }
   Dropdown.Background._height = m_nNumVisibleButtons * Dropdown.Button1._height + 10;
   Dropdown_Top.Background._height = m_nNumVisibleButtons * Dropdown_Top.Button1._height + 9.5;
   UpdateDropdownArrows();
}
function setDisabled(bDisabled)
{
   m_bDisabled = bDisabled;
   if(bDisabled)
   {
      DisabledBar._visible = true;
   }
   else
   {
      DisabledBar._visible = false;
   }
}
function ScrollDropdownDown()
{
   trace("ScrollDropdownDown: m_aDropdownOptions.length = " + m_aDropdownOptions.length + ", m_nNumVisibleButtons = " + m_nNumVisibleButtons);
   if(m_aDropdownOptions.length < DROPDOWN_NUM_OPTIONS_BUTTONS || m_nNumVisibleButtons < DROPDOWN_NUM_OPTIONS_BUTTONS)
   {
      return undefined;
   }
   m_nDropdownOffset = m_nDropdownOffset + DROPDOWN_NUM_OPTIONS_BUTTONS;
   if(m_nDropdownOffset > m_aDropdownOptions.length - DROPDOWN_NUM_OPTIONS_BUTTONS)
   {
      m_nDropdownOffset = m_aDropdownOptions.length - DROPDOWN_NUM_OPTIONS_BUTTONS;
   }
   trace("ScrollDropdownDown: setting m_nDropdownOffset to : " + m_nDropdownOffset);
   SetUpDropDownForOptions(m_aDropdownOptions,"",m_nSelectedIndex);
   onShowDropDown();
}
function ScrollDropdownUp()
{
   m_nDropdownOffset = m_nDropdownOffset - DROPDOWN_NUM_OPTIONS_BUTTONS;
   if(m_nDropdownOffset < 0)
   {
      m_nDropdownOffset = 0;
   }
   SetUpDropDownForOptions(m_aDropdownOptions,"",m_nSelectedIndex);
   onShowDropDown();
}
function UpdateDropdownArrows()
{
   Dropdown.ScrollUp._visible = m_nDropdownOffset > 0;
   Dropdown.ScrollDown._visible = m_nDropdownOffset + DROPDOWN_NUM_OPTIONS_BUTTONS < m_aDropdownOptions.length;
   Dropdown_Top.ScrollUp._visible = m_nDropdownOffset > 0;
   Dropdown_Top.ScrollDown._visible = m_nDropdownOffset + DROPDOWN_NUM_OPTIONS_BUTTONS < m_aDropdownOptions.length;
}
function SetUpDropdownListButtonForOptions(objButton)
{
   objButton.dialog = this;
   objButton.SetText(objButton.label);
   objButton.Action = function()
   {
      this.dialog.onPressDropdownListEntryForOptions(this);
   };
   objButton._visible = true;
}
function GetSelectedIndex()
{
   return m_nSelectedIndex;
}
function CreateInit()
{
   trace("CreateInit: Override Me!");
}
function NotifyValueChange()
{
   trace("Override Me!");
}
function OnDropDownClose()
{
   Dropdown_Top._y = Dropdown_Top.defaultposY;
   DropDownCloseNotify();
}
function DropDownCloseNotify()
{
   trace("Override Me!");
}
function DropDownOpenNotify()
{
   trace("Override Me!");
}
function onPressDropdownListEntryForOptions(objButton)
{
   m_nSelectedIndex = objButton.index;
   NotifyValueChange();
   Dropdown._visible = false;
   Dropdown_Top._visible = false;
   OnDropDownClose();
   trace("onPressDropdownListEntryForOptions: m_nSelectedIndex = " + m_nSelectedIndex);
}
function onShowDropDown()
{
   trace("dropdown: HideList()");
   if(Dropdown._visible == true || Dropdown_Top._visible == true)
   {
      trace("onShowDropDown: setting Dropdown._visible == false");
      Dropdown._visible = false;
      Dropdown_Top._visible = false;
      OnDropDownClose();
   }
   else
   {
      if(!Dropdown_Top)
      {
         Dropdown._visible = true;
         return undefined;
      }
      DropDownOpenNotify();
      Dropdown_Top.defaultposY = -400;
      var _loc12_ = this._x;
      var _loc11_ = this._y;
      var _loc3_ = {x:_loc12_,y:_loc11_};
      this._parent.localToGlobal(_loc3_);
      trace("onShowDropDown: myPoint.y = " + _loc3_.y + ", Dropdown.Background._height = " + Dropdown.Background._height);
      var _loc7_ = 720 / Stage.height;
      _loc3_.y = _loc3_.y * _loc7_;
      var _loc5_ = Dropdown.Background._height;
      if(Dropdown_Top._visible == true)
      {
         _loc5_ = Dropdown_Top.Background._height;
      }
      var _loc8_ = Stage.height * _loc7_;
      if(_global.CheckOverBottomScreenBounds(_loc3_,_loc5_ + 130,Dropdown))
      {
         Dropdown_Top._visible = true;
         if(_loc5_ > _loc8_ / 2 || _global.CheckOverTopScreenBounds(_loc3_,Dropdown_Top.Background._height + 130,Dropdown_Top))
         {
            var _loc10_ = 0;
            var _loc9_ = Stage.height / 720;
            var _loc6_ = (_loc8_ / 2 - _loc5_ / 2.65) * _loc9_;
            var _loc4_ = {x:_loc10_,y:_loc6_};
            this.globalToLocal(_loc4_);
            trace("onShowDropDown: posY = " + _loc6_ + ", posPoint.y = " + _loc4_.y);
            Dropdown_Top._y = _loc4_.y;
            trace("onShowDropDown: setting Dropdown_Top._visible == true  (CENTERED), numScreenRatioY = " + _loc7_ + ", flResScale = " + _loc9_);
         }
         else
         {
            trace("onShowDropDown: setting Dropdown_Top._visible == true");
            Dropdown_Top._y = Dropdown_Top.defaultposY + 21.6 * (DROPDOWN_NUM_OPTIONS_BUTTONS - m_nNumVisibleButtons);
            trace("onShowDropDown: posY = " + _loc6_ + ", posPoint.y = " + _loc4_.y);
         }
      }
      else
      {
         trace("onShowDropDown: setting Dropdown._visible == true");
         Dropdown._visible = true;
      }
   }
}
function SetUpDropdownListButton(objButton, strDropdownOption, strNameString, funcToCallOnEntryPressed)
{
   var strEntryName = _global.GameInterface.Translate(strNameString + strDropdownOption);
   objButton.dialog = this;
   objButton.SetText(strEntryName);
   objButton.Action = function()
   {
      this.dialog.onPressDropdownListEntry(strDropdownOption,strEntryName,funcToCallOnEntryPressed,this);
   };
   objButton._visible = true;
}
function onPressDropdownListEntry(strDropdownOption, strEntryName, funcToCallOnEntryPressed, objButton)
{
   funcToCallOnEntryPressed(strDropdownOption);
   SetDropDownSelectedText(strEntryName);
   Dropdown._visible = false;
   Dropdown_Top._visible = false;
   OnDropDownClose();
}
function SetDropDownSelectedText(strDropdownOption)
{
   Catagory.SetText(strDropdownOption);
}
function HideList()
{
   if(this._parent._visible == false)
   {
      return undefined;
   }
   var _loc3_ = null;
   if(Dropdown._visible == true)
   {
      _loc3_ = Dropdown;
   }
   else if(Dropdown_Top._visible == true)
   {
      _loc3_ = Dropdown_Top;
   }
   else
   {
      return undefined;
   }
   if(_loc3_.hitTest(_root._xmouse,_root._ymouse,true) == false && Catagory.hitTest(_root._xmouse,_root._ymouse,true) == false)
   {
      trace("dropdown: HideList()");
      Dropdown._visible = false;
      Dropdown_Top._visible = false;
      OnDropDownClose();
   }
}
var m_nSelectedIndex = 0;
var m_bDisabled = false;
var m_nNumVisibleButtons = 0;
var m_nDropdownOffset = 0;
var m_aDropdownOptions = new Array();
var DROPDOWN_NUM_OPTIONS_BUTTONS = 20;
stop();
