function TooltipShowHide()
{
   this.Background.onMouseUp = function()
   {
      if(!this.Background.ClickDetect.hitTest(_root._xmouse,_root._ymouse,true))
      {
         this._parent._visible = false;
      }
   };
   this._visible = true;
}
function TooltipLayout(aMenuItems, aMenuItemNames, objTargetTile, FuncToCallWhenPressed)
{
   var _loc9_ = {x:_root._xmouse,y:_root._ymouse};
   this._parent.globalToLocal(_loc9_);
   this._x = _loc9_.x - 0;
   this._y = _loc9_.y - 0;
   var _loc5_ = 0;
   while(_loc5_ < NUM_BUTTONS)
   {
      var _loc4_ = this["Button" + _loc5_];
      if(_loc5_ <= aMenuItems.length - 1)
      {
         _loc4_._type = aMenuItems[_loc5_];
         _loc4_._visible = true;
         _loc4_.dialog = this;
         if(_loc4_._type == "seperator")
         {
            _loc4_.setDisabled(true);
            _loc4_.Seperator._alpha = 100;
            _loc4_.SetText("");
            _loc4_.ButtonText.Text.autoSize = true;
         }
         else
         {
            if(_loc4_._type == "disabled")
            {
               _loc4_.setDisabled(true);
               _loc4_.Seperator._alpha = 0;
               _loc4_.ButtonText._alpha = 40;
            }
            else
            {
               _loc4_.setDisabled(false);
               _loc4_.Seperator._alpha = 0;
               _loc4_.ButtonText._alpha = 100;
            }
            _loc4_.SetText(aMenuItemNames[_loc5_]);
            _loc4_.ButtonText.Text.autoSize = true;
            _loc4_.Action = function()
            {
               this.dialog.AssignAction(this,objTargetTile,FuncToCallWhenPressed);
            };
         }
      }
      else
      {
         _loc4_._visible = false;
         _loc4_.SetText("");
         _loc4_.ButtonText.Text.autoSize = true;
      }
      _loc5_ = _loc5_ + 1;
   }
   if(aMenuItems.length == 0)
   {
      this._visible = false;
   }
   else
   {
      Background._height = NUM_BUTTON_HEIGHT * aMenuItems.length + NUM_BUTTON_OFFSET;
      Background._width = GetMaxWidth(aMenuItems) + 15;
   }
   var _loc7_ = {x:this._x,y:this._y};
   _root.localToGlobal(_loc7_);
   if(_global.CheckOverRightScreenBounds(_loc7_,this))
   {
      this._x = this._x - 100;
   }
   var _loc10_ = NUM_BUTTON_HEIGHT * aMenuItems.length + NUM_BUTTON_OFFSET;
   if(_global.CheckOverBottomScreenBounds(_loc7_,_loc10_,this))
   {
      this._y = this._y - (_loc7_.y + Background._height - 720);
   }
}
function GetMaxWidth(aMenuItems)
{
   var _loc3_ = 90;
   var _loc2_ = 0;
   while(_loc2_ < NUM_BUTTONS)
   {
      if(_loc2_ <= aMenuItems.length - 1)
      {
         if(_loc3_ < this["Button" + _loc2_].ButtonText.Text._width && this["Button" + _loc2_].ButtonText.Text._width > 90)
         {
            _loc3_ = this["Button" + _loc2_].ButtonText.Text._width;
         }
      }
      _loc2_ = _loc2_ + 1;
   }
   return _loc3_ + 10;
}
function AssignAction(objButton, objTargetTile, FuncToCallWhenPressed)
{
   FuncToCallWhenPressed(objButton._type,objTargetTile);
}
var NUM_BUTTONS = 15;
var NUM_BUTTON_HEIGHT = 15.75;
var NUM_BUTTON_OFFSET = 14;
Background.onRollOver = function()
{
   "";
};
stop();
