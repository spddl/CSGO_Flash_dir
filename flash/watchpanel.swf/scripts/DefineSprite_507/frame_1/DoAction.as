function MakeTopBarLayout(aTopBarMenuItems, numWidth, objParent)
{
   RemoveButtons(objParent);
   PlaceButtons(aTopBarMenuItems,numWidth,objParent);
   objParent.Bounds._visible = false;
}
function PlaceButtons(aTopBarMenuItems, numWidth, objParent)
{
   objParent.createEmptyMovieClip("TopMenuMaster",objParent.getNextHighestDepth());
   var _loc3_ = objParent.TopMenuMaster;
   var _loc1_ = 0;
   while(_loc1_ < aTopBarMenuItems.length)
   {
      AttachButton(aTopBarMenuItems[_loc1_],_loc3_,_loc1_);
      _loc1_ = _loc1_ + 1;
   }
   var _loc4_ = 0;
   _loc1_ = 0;
   while(_loc1_ < aTopBarMenuItems.length)
   {
      _loc4_ = _loc4_ + _loc3_["cat-button" + _loc1_].Mask._width;
      _loc1_ = _loc1_ + 1;
   }
   _loc3_._x = (numWidth - _loc4_) / 2;
}
function AttachButton(objBtnData, objMenuContaininer, numIndex)
{
   objMenuContaininer.attachMovie("top-bar-btn","cat-button" + numIndex,objMenuContaininer.getNextHighestDepth(),{_x:0,_y:posY});
   var _loc3_ = 15;
   var objBtn = objMenuContaininer["cat-button" + numIndex];
   var _loc2_ = null;
   objBtn.Selected._visible = false;
   objBtn._Type = objBtnData.type;
   objBtn.Action = function()
   {
      OnPressBtn(objBtn,objBtnData.action,objBtnData.type);
   };
   objBtn.ButtonText.Text.htmlText = _global.GameInterface.Translate(objBtnData.nametag);
   objBtn.ButtonText.Text.autoSize = "center";
   objBtn.ButtonText.Text._x = 0;
   objBtn.ButtonText._x = _loc3_;
   objBtn.Mask._width = objBtn.ButtonText.Text.textWidth + objBtn.ButtonText._x + _loc3_ + 2;
   trace("----------------------------------objBtnData.nametag: " + objBtnData.nametag);
   trace("----------------------------------objBtn: " + objBtn);
   if(numIndex > 0)
   {
      _loc2_ = objMenuContaininer["cat-button" + (numIndex - 1)];
      objBtn._x = objBtn._x + _loc2_.Mask._width + _loc2_._x;
   }
   else
   {
      objBtn._x = 0;
   }
}
function RemoveButtons(objParent)
{
   objParent.TopMenuMaster.removeMovieClip();
}
function OnPressBtn(objBtn, FunctionToCall, srtType)
{
   FunctionToCall(objBtn,srtType);
}
var m_aOpenMenus = new Array();
