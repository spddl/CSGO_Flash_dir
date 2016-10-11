function TooltipScheduleShowHide(bShow)
{
   if(bShow)
   {
      this._visible = true;
      this.swapDepths(_root.getNextHighestDepth());
      new Lib.Tween(this,"_alpha",mx.transitions.easing.Strong.easeIn,0,100,0.25,true);
   }
   else
   {
      this._visible = false;
   }
}
function TooltipScheduleLayout(PosPoint)
{
   var _loc8_ = 0;
   var _loc9_ = 4;
   RemoveDays(_loc9_);
   var _loc6_ = 0;
   while(_loc6_ < _loc9_)
   {
      var _loc4_ = _global.CScaleformComponent_Inventory.GetQuestEventsByDay(_loc6_);
      trace("-------------------------QuestEventsInfo" + _loc4_);
      if(_loc4_ != undefined && _loc4_ != null && _loc4_ != "")
      {
         var _loc5_ = _loc4_.split(",");
         if(_loc5_.length > 1)
         {
            var _loc7_ = MakeNewDay(_loc6_,_loc5_[0]);
            _loc5_.shift();
            SetQuestsInfo(_loc7_,_loc5_);
         }
         else
         {
            _loc8_ = _loc8_ + 1;
         }
      }
      else
      {
         _loc8_ = _loc8_ + 1;
      }
      _loc6_ = _loc6_ + 1;
   }
   if(_loc8_ == _loc9_)
   {
      TooltipScheduleShowHide(false);
      return undefined;
   }
   this.Lister.Day._visible = false;
   this._x = PosPoint.x;
   this._y = PosPoint.y;
   Background._height = Lister._height + 35;
   Background._width = Lister._width;
   _root.localToGlobal(PosPoint);
   var _loc11_ = false;
   Arrows.LeftArrow._y = 0;
   if(_global.CheckOverBottomScreenBounds(PosPoint,Height,this))
   {
      this._y = this._y - (PosPoint.y + Height - 720);
      Arrows.LeftArrow._y = Arrows.LeftArrow._y + (PosPoint.y + Height - 720);
   }
}
function MakeNewDay(numDayIndex, strDate)
{
   var _loc3_ = this.Lister.Day;
   _loc3_._visible = false;
   var _loc2_ = _loc3_.duplicateMovieClip("mcDay" + numDayIndex,this.getNextHighestDepth() + numDayIndex);
   _loc2_.Date.Text.htmlText = strDate.toUpperCase();
   var _loc6_ = numDayIndex - 1;
   var _loc5_ = this.Lister["mcDay" + _loc6_];
   PlaceTile(_loc5_,_loc2_);
   return _loc2_;
}
function SetQuestsInfo(objDay, aQuests)
{
   var _loc15_ = 3;
   var _loc6_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc2_ = 0;
   while(_loc2_ < aQuests.length)
   {
      if(_loc2_ % _loc15_ == 0)
      {
         if(aQuests[_loc2_] != undefined && aQuests[_loc2_] != null && aQuests[_loc2_] != 0 && aQuests[_loc2_] != "")
         {
            var _loc5_ = _global.CScaleformComponent_Inventory.GetQuestItemIDFromQuestID(Number(aQuests[_loc2_]));
            var _loc8_ = _global.CScaleformComponent_Inventory.GetItemDescription(_loc6_,_loc5_,"default,-detailedinfo");
            var _loc11_ = _global.CScaleformComponent_Inventory.GetQuestGameMode(_loc6_,_loc5_);
            var _loc9_ = _global.CScaleformComponent_Inventory.GetQuestMapGroup(_loc6_,_loc5_);
            var _loc13_ = _global.CScaleformComponent_Inventory.GetQuestMap(_loc6_,_loc5_);
            var _loc7_ = objDay.Mission;
            var _loc3_ = _loc7_.duplicateMovieClip("mcMission" + _loc2_,objDay.getNextHighestDepth() + _loc2_,{_y:_loc7_._y});
            _loc7_._visible = false;
            _loc3_.Time.htmlText = aQuests[_loc2_ + 1] + "\n<font color=\'#666666\'>" + aQuests[_loc2_ + 2] + "</font>";
            _loc3_.Desc.htmlText = _loc8_;
            _loc3_.Desc.autoSize = "left";
            _loc3_.Time.autoSize = "left";
            VerticalCenterText(_loc3_.Time,_loc3_);
            VerticalCenterText(_loc3_.Desc,_loc3_);
            LoadMissionIcon(_loc6_,_loc5_,_loc11_,_loc13_,_loc9_,_loc3_.ModeIcon);
            var _loc14_ = _loc2_ - _loc15_;
            var _loc10_ = objDay["mcMission" + _loc14_];
            PlaceTile(_loc10_,_loc3_);
         }
      }
      _loc2_ = _loc2_ + 1;
   }
}
function PlaceTile(mcTilePrev, mcTileNew)
{
   var _loc2_ = mcTilePrev._y + mcTilePrev._height;
   if(mcTilePrev != null && mcTilePrev != undefined)
   {
      mcTileNew._y = _loc2_;
   }
}
function VerticalCenterText(objText, objBounds)
{
   objText.autoSize = "left";
   if(objText._height > objBounds._height)
   {
      objText._height = objBounds._height;
   }
   objText._y = (objBounds._height - objText._height) * 0.5;
}
function LoadMissionIcon(PlayerXuid, QuestItemID, GameMode, Map, MapGroup, objImageHolder)
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetQuestIcon(PlayerXuid,QuestItemID);
   if(_loc3_ == "" || _loc3_ == undefined)
   {
      if(GameMode == "casual" || GameMode == "competitive")
      {
         if(!HasMapSpecified(Map))
         {
            _loc3_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute(MapGroup,"icontag"));
         }
         else
         {
            _loc3_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + Map,"icontag"));
         }
      }
      else
      {
         _loc3_ = GameMode;
      }
   }
   objImageHolder.attachMovie("icon-" + _loc3_,"missionicon",1000000);
   var _loc4_ = 25;
   if(objImageHolder.missionicon._height > objImageHolder.missionicon._width)
   {
      var _loc6_ = objImageHolder.missionicon._height / objImageHolder.missionicon._width;
      objImageHolder.missionicon._width = _loc4_ / _loc6_;
      objImageHolder.missionicon._height = _loc4_;
   }
   else
   {
      _loc6_ = objImageHolder.missionicon._width / objImageHolder.missionicon._height;
      objImageHolder.missionicon._width = _loc4_;
      objImageHolder.missionicon._height = _loc4_ / _loc6_;
   }
   objImageHolder.missionicon._x = objImageHolder.missionicon._x - _loc4_ / 2;
   objImageHolder.missionicon._y = objImageHolder.missionicon._y - objImageHolder.missionicon._height / 2;
}
function HasMapSpecified(strMap)
{
   if(strMap == "" || strMap == undefined || strMap == null || strMap == " ")
   {
      return false;
   }
   return true;
}
function RemoveDays(numDaysToShow)
{
   var _loc2_ = 0;
   while(_loc2_ < numDaysToShow)
   {
      var _loc3_ = this.Lister["mcDay" + _loc2_];
      if(_loc3_)
      {
         _loc3_.removeMovieClip();
      }
      _loc2_ = _loc2_ + 1;
   }
}
stop();
