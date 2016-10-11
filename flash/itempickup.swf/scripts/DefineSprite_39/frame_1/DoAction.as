function CheckOverRightScreenBounds(Pt)
{
   var _loc2_ = 1280 / Stage.width;
   var _loc4_ = 960 / Stage.width;
   var _loc3_ = 1152 / Stage.width;
   var _loc5_ = (Stage.width * _loc2_ - Stage.width * _loc4_) / 2 + Stage.width * _loc4_;
   var _loc6_ = (Stage.width * _loc2_ - Stage.width * _loc3_) / 2 + Stage.width * _loc3_;
   if(CheckNonWideAspectRatio() == "16x10")
   {
      if(_loc6_ < Pt.x + this._width)
      {
         return true;
      }
   }
   else if(CheckNonWideAspectRatio() == "4x3")
   {
      if(_loc5_ < Pt.x + this._width)
      {
         return true;
      }
   }
   else if(Stage.width * _loc2_ < Pt.x + this._width)
   {
      return true;
   }
   return false;
}
function CheckOverBottomScreenBounds(Pt)
{
   var _loc2_ = 720 / Stage.height;
   if(Stage.height * _loc2_ < Pt.y + this._height)
   {
      return true;
   }
   return false;
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
function TooltipItemShowHide(bShow)
{
   if(bShow)
   {
      this._visible = true;
      this.gotoAndPlay("StartShow");
   }
   else
   {
      this._visible = false;
   }
}
function TooltipItemGetInfo(PlayerXuid, strId)
{
   var _loc6_ = _global.CScaleformComponent_Inventory.GetItemName(PlayerXuid,strId);
   var _loc5_ = _global.CScaleformComponent_Inventory.GetItemType(PlayerXuid,strId);
   var _loc8_ = _global.CScaleformComponent_Inventory.GetItemDescription(PlayerXuid,strId);
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemTeam(PlayerXuid,strId);
   var _loc7_ = _global.CScaleformComponent_Inventory.GetWeaponCategory(PlayerXuid,strId);
   Content.econItemName.htmlText = _loc6_;
   Content.econItemType.htmlText = _loc5_;
   Content.econAttributes.htmlText = _loc8_;
   Content.econItemUsageBlock.econItemTeam.htmlText = _loc2_;
   Content.econItemUsageBlock.econItemCatagory.htmlText = _loc7_;
   Content.econItemUsageBlock.AnyPatch._visible = false;
   Content.econItemUsageBlock.CTPatch._visible = false;
   Content.econItemUsageBlock.TPatch._visible = false;
   if(_loc2_ == "#CSGO_Inventory_Team_Any")
   {
      Content.econItemUsageBlock.AnyPatch._visible = true;
   }
   if(_loc2_ == "#CSGO_Inventory_Team_CT")
   {
      Content.econItemUsageBlock.CTPatch._visible = true;
   }
   if(_loc2_ == "#CSGO_Inventory_Team_T")
   {
      Content.econItemUsageBlock.TPatch._visible = true;
   }
}
function TooltipItemLayout(PositionX, PositionY, TileWidth)
{
   var _loc3_ = {x:PositionX,y:PositionY};
   _root.localToGlobal(_loc3_);
   var _loc4_ = false;
   Arrows.RightArrow._y = 0;
   Arrows.LeftArrow._y = 0;
   this._x = PositionX;
   this._y = PositionY;
   Content.econItemName.autoSize = true;
   Content.econAttributes.autoSize = true;
   Content.Background._height = Content.econAttributes.textHeight + (Content.econAttributes._y - Content._y) + 20;
   if(CheckOverRightScreenBounds(_loc3_))
   {
      this._x = this._x - (TileWidth + Content._width);
      _loc4_ = true;
   }
   if(CheckOverBottomScreenBounds(_loc3_))
   {
      this._y = this._y - (_loc3_.y + Content.Background._height - 720);
      Arrows.LeftArrow._y = Arrows.LeftArrow._y + (_loc3_.y + Content.Background._height - 720);
      Arrows.RightArrow._y = Arrows.LeftArrow._y;
   }
   Arrows.LeftArrow._visible = !_loc4_;
   Arrows.RightArrow._visible = _loc4_;
}
this.stop();
