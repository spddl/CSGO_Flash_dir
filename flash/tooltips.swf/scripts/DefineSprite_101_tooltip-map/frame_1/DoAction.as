function TooltipItemShowHide(bShow)
{
   if(bShow)
   {
      this._visible = true;
   }
   else
   {
      this._visible = false;
   }
}
function TooltipMapInfo(strName, strDesc, strMissionDesc, StrikeMission)
{
   Content.Name.htmlText = strName;
   Content.Desc.htmlText = strDesc;
   Content.Name.autoSize = true;
   Content.Desc.autoSize = true;
   if(strMissionDesc != "")
   {
      if(StrikeMission != "")
      {
         strMissionDesc = strMissionDesc + "\n\n" + StrikeMission;
      }
      Content.Mission._visible = true;
      Content.Mission.Icon._visible = true;
      Content.Mission.Desc.htmlText = strMissionDesc;
      Content.Mission.Desc.autoSize = true;
      Content.Mission._y = Content.Name.textHeight + Content.Desc.textHeight + 20;
      Content.Background._height = Content.Name.textHeight + Content.Desc.textHeight + Content.Mission.Desc.textHeight + 30;
   }
   else if(StrikeMission != "")
   {
      Content.Mission._visible = true;
      Content.Mission.Icon._visible = false;
      Content.Mission.Desc.htmlText = StrikeMission;
      Content.Mission.Desc.autoSize = true;
      Content.Mission._y = Content.Name.textHeight + Content.Desc.textHeight + 20;
      Content.Background._height = Content.Name.textHeight + Content.Desc.textHeight + Content.Mission.Desc.textHeight + 50;
   }
   else
   {
      Content.Mission._visible = false;
      Content.Mission._y = 0;
      Content.Background._height = Content.Name.textHeight + Content.Desc.textHeight + 25;
   }
}
function TooltipMapLayout(PositionX, PositionY, TileWidth)
{
   this._x = PositionX;
   this._y = PositionY;
   var _loc5_ = {x:PositionX,y:PositionY};
   _root.localToGlobal(_loc5_);
   var _loc6_ = false;
   Arrows.RightArrow._y = 0;
   Arrows.LeftArrow._y = 0;
   this._x = PositionX;
   this._y = PositionY;
   if(_global.CheckOverRightScreenBounds(_loc5_,this))
   {
      this._x = this._x - 12 - (TileWidth + Content._width);
      _loc6_ = true;
   }
   else
   {
      this._x = this._x + 12;
   }
   var _loc4_ = Content.Background._height;
   if(Content.Scorecard._visible == true)
   {
      _loc4_ = _loc4_ + Content.Scorecard.Bg._height;
   }
   if(_global.CheckOverBottomScreenBounds(_loc5_,_loc4_,this))
   {
      this._y = this._y - (_loc5_.y + _loc4_ - 720);
      Arrows.LeftArrow._y = Arrows.LeftArrow._y + (_loc5_.y + _loc4_ - 720);
      Arrows.RightArrow._y = Arrows.LeftArrow._y;
   }
   Arrows.LeftArrow._visible = !_loc6_;
   Arrows.RightArrow._visible = _loc6_;
}
stop();
