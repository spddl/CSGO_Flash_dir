function SetUpDropDownForOptions(parentMovie)
{
   m_nNumVisibleButtons = 0;
   m_nSelectedIndex = nSelectedIndex;
   Dropdown._visible = false;
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
   Dropdown.onMouseDown = function()
   {
      if(Dropdown._visible == true)
      {
         HideList();
      }
   };
   Dropdown.Button_Camera.ButtonText.SetText("#CSGO_Scoreboard_CastButton_Camera");
   Dropdown.Button_Voice.ButtonText.SetText("#CSGO_Scoreboard_CastButton_Voice");
   Dropdown.Button_Xray.ButtonText.SetText("#CSGO_Scoreboard_CastButton_XRay");
   Dropdown.Button_UI.ButtonText.SetText("#CSGO_Scoreboard_CastButton_UI");
   Dropdown.Button_Camera.parentMovie = parentMovie;
   Dropdown.Button_Voice.parentMovie = parentMovie;
   Dropdown.Button_Xray.parentMovie = parentMovie;
   Dropdown.Button_UI.parentMovie = parentMovie;
   Dropdown.Button_Camera.Action = function()
   {
      _global.Scoreboard.onToggleSpecCamera(this);
   };
   Dropdown.Button_Voice.Action = function()
   {
      _global.Scoreboard.onToggleSpecVoice(this);
   };
   Dropdown.Button_Xray.Action = function()
   {
      _global.Scoreboard.onToggleSpecXray(this);
   };
   Dropdown.Button_UI.Action = function()
   {
      _global.Scoreboard.onToggleSpecUI(this);
   };
}
function onScoreboardHide()
{
   Dropdown._visible = false;
   OnDropDownClose();
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
function CreateInit()
{
   trace("CreateInit: Override Me!");
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
function onShowDropDown()
{
   trace("dropdown: HideList()");
   if(Dropdown._visible == true)
   {
      trace("onShowDropDown: setting Dropdown._visible == false");
      Dropdown._visible = false;
      OnDropDownClose();
   }
   else
   {
      trace("onShowDropDown: setting Dropdown._visible == true");
      Dropdown._visible = true;
      Dropdown.Button_Camera.Disabled_Icon._visible = !_global.ScoreboardAPI.GetCasterIsCameraman();
      Dropdown.Button_Voice.Disabled_Icon._visible = !_global.ScoreboardAPI.GetCasterIsHeard();
      Dropdown.Button_Xray.Disabled_Icon._visible = !_global.ScoreboardAPI.GetCasterControlsXray();
      Dropdown.Button_UI.Disabled_Icon._visible = !_global.ScoreboardAPI.GetCasterControlsUI();
      var _loc2_ = _global.ScoreboardAPI.GetCasterControlIsDisabled();
      Dropdown.Button_Xray.setDisabled(_loc2_);
      Dropdown.Button_UI.setDisabled(_loc2_);
      _global.navManager.PlayNavSound("ButtonAction");
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
function HideList()
{
   if(this._parent._visible == false)
   {
      return undefined;
   }
   var _loc3_ = Dropdown;
   if(_loc3_.hitTest(_root._xmouse,_root._ymouse,true) == false && Catagory.hitTest(_root._xmouse,_root._ymouse,true) == false)
   {
      trace("dropdown: HideList()");
      Dropdown._visible = false;
      OnDropDownClose();
   }
}
var m_nSelectedIndex = 0;
var m_bDisabled = false;
var m_nNumVisibleButtons = 0;
var m_nDropdownOffset = 0;
var DROPDOWN_NUM_OPTIONS_BUTTONS = 20;
stop();
