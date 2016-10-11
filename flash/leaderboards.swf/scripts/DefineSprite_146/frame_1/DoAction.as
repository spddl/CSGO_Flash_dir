function UpdateQuery()
{
   var _loc2_ = LeaderBoardsData.LeaderboardTypes.order[CurrentActivePanel];
   CurrentRow = 0;
   TotalRows = 0;
   hideResultsRows();
   StatusMessage.SetText("#SFUI_LB_Status");
   StatusMessage._visible = true;
   var _loc7_ = LeaderBoardsData.BoardIDMap[_loc2_.statViewID];
   var _loc5_ = LeaderBoardsData.Modes[CurrentMode];
   var _loc6_ = _loc7_[_loc5_.mp];
   var _loc4_ = _loc6_[_loc5_.mtype];
   var _loc3_ = new Array();
   RecurseParamList(_loc2_.RowEntries,_loc3_);
   if(_global.IsXbox())
   {
      _global.LeaderBoardsAPI.SetQuery(CurrentFilter,AbsoluteRow,_loc2_.numRows,_loc4_.Xbox,_loc3_.length,_loc3_);
   }
   else
   {
      if(bDeviceRankedBoard)
      {
         CurrentELOBoardName = _loc4_.Steam + DeviceTypes[Device_Type].suffix;
      }
      _global.LeaderBoardsAPI.SetQuery(CurrentFilter,AbsoluteRow,_loc2_.numRows,!bDeviceRankedBoard?_loc4_.Steam:CurrentELOBoardName);
   }
}
function LookupParamId(ParamName)
{
   if(_global.IsXbox())
   {
      return LeaderBoardsData.StatIDMap[ParamName];
   }
   return LeaderBoardsData.SteamIDMap[ParamName];
}
function RecurseParamList(ObjList, ParamList)
{
   for(var _loc7_ in ObjList)
   {
      var _loc3_ = ObjList[_loc7_];
      if(_loc3_ != undefined)
      {
         if(typeof _loc3_ == "string")
         {
            var _loc2_ = LookupParamId(_loc3_);
            var _loc5_ = false;
            if(_loc2_ != undefined && _loc2_ >= 0)
            {
               var _loc1_ = 0;
               while(_loc1_ < ParamList.length)
               {
                  if(ParamList[_loc1_] == _loc2_)
                  {
                     _loc5_ = true;
                     break;
                  }
                  _loc1_ = _loc1_ + 1;
               }
               if(!_loc5_)
               {
                  ParamList[ParamList.length] = _loc2_;
               }
            }
         }
         else if(typeof _loc3_ == "object")
         {
            RecurseParamList(_loc3_,ParamList);
         }
      }
   }
}
function NotifyResults()
{
   var _loc6_ = _global.LeaderBoardsAPI.Query_NumResults();
   TotalRowResults = _loc6_ <= 0?0:_global.LeaderBoardsAPI.QueryRow_ColumnValue(0,-3);
   if(_global.LeaderBoardsAPI.QueryRow_ColumnValue(0,-4) == 0)
   {
      StatusMessage.SetText("#Menu_Dlg_Leaderboards_Lost_Connection");
      hideResultsRows();
      StatusMessage._visible = true;
   }
   else if(_loc6_ == 0)
   {
      StatusMessage.SetText("#SFUI_LB_NoResults");
      hideResultsRows();
      StatusMessage._visible = true;
   }
   else
   {
      StatusMessage._visible = false;
      var _loc5_ = LeaderBoardsData.LeaderboardTypes.order[CurrentActivePanel];
      var _loc4_ = this[_loc5_.panelName];
      if(_loc6_ > _loc5_.numRows)
      {
         TotalRows = _loc5_.numRows;
      }
      else
      {
         TotalRows = _loc6_;
      }
      if(CurrentFilter == Filter_Friends)
      {
         TotalRows = Math.min(_loc5_.numRows,_loc6_ - AbsoluteRow + 1);
         TotalRowResults = _loc6_;
      }
      if(CurrentFilter == Filter_Me)
      {
         AbsoluteRow = _global.LeaderBoardsAPI.QueryRow_ColumnValue(0,0);
      }
      CurrentRow = !bUpToPrevPage?0:_loc5_.numRows - 1;
      bUpToPrevPage = false;
      if(CurrentFilter == Filter_Me)
      {
         CurrentRow = _global.LeaderBoardsAPI.Query_GetCurrentPlayerRow();
      }
      UpdateRowSelection(CurrentRow);
      var _loc3_ = 0;
      while(_loc3_ < TotalRows)
      {
         RowName = _loc5_.rowPrefix + _loc3_;
         if(_loc3_ == CurrentRow)
         {
            _loc4_[RowName].gotoAndStop("Over");
         }
         else
         {
            _loc4_[RowName].gotoAndStop("Up");
         }
         PopulateRowData(_loc3_,_loc5_,_loc4_[RowName]);
         _loc3_ = _loc3_ + 1;
      }
   }
}
function PopulateRowData(RowIdx, LeaderboardConfig, Row)
{
   for(var _loc10_ in LeaderboardConfig.RowEntries)
   {
      var _loc2_ = LeaderboardConfig.RowEntries[_loc10_];
      if(_loc2_ && typeof _loc2_ == "string")
      {
         if(_loc2_ == "GAMERTAG")
         {
            var _loc8_ = _global.LeaderBoardsAPI.QueryRow_GamerTag(RowIdx);
            Row[_loc10_].htmlText = _loc8_;
         }
         else
         {
            var _loc3_ = LookupParamId(_loc2_);
            if(_loc3_ == undefined)
            {
               trace(" ERROR: Unknown columnId: " + _loc2_ + " for Flash column: " + _loc10_);
            }
            else if(_loc3_ < 0)
            {
               var _loc7_ = _global.LeaderBoardsAPI.QueryRow_ColumnValue(RowIdx,_loc3_);
               Row[_loc10_].htmlText = _loc7_;
            }
            else
            {
               var _loc9_ = _global.LeaderBoardsAPI.QueryRow_ColumnValue(RowIdx,_loc3_);
               Row[_loc10_].htmlText = _loc9_ + "";
            }
         }
      }
      else
      {
         ParseRowData(RowIdx,LeaderboardConfig,_loc2_,Row[_loc10_]);
      }
   }
   Row._visible = true;
}
function ParseRowData(RowIdx, LeaderboardConfig, RowFormat, RowItem)
{
   if(RowFormat.ratio != undefined)
   {
      var _loc7_ = LookupParamId(RowFormat.ratio.columnA);
      var _loc5_ = LookupParamId(RowFormat.ratio.columnB);
      var _loc13_ = "%3.3f";
      if(RowFormat.ratio.format != undefined)
      {
         _loc13_ = RowFormat.ratio.format;
      }
      var _loc17_ = RowFormat.ratio.bShowPercent == "1";
      var _loc15_ = RowFormat.ratio.bRatioSum == "1";
      if(_loc7_ == undefined)
      {
         trace(" ERROR: Unknown ratio argument in row " + RowIdx + " for columnIdA: " + RowFormat.ratio.columnA);
      }
      if(_loc5_ == undefined)
      {
         trace(" ERROR: Unknown ratio argument in row " + RowIdx + " for columnIdB: " + RowFormat.ratio.columnB);
      }
      if(_loc7_ != undefined && _loc5_ != undefined)
      {
         DataValue = _global.LeaderBoardsAPI.QueryRow_ColumnRatio(RowIdx,_loc7_,_loc5_,_loc13_,_loc17_,_loc15_);
         RowItem.htmlText = DataValue;
      }
   }
   if(RowFormat.scaled != undefined)
   {
      var _loc8_ = LookupParamId(RowFormat.scaled.column);
      if(_loc8_ == undefined)
      {
         trace(" ERROR: Unknown scaled argument in row " + RowIdx + " for column: " + RowFormat.scaled.column);
      }
      var _loc10_ = RowFormat.scaled.scale;
      if(_loc10_ == undefined)
      {
         trace(" ERROR: Unknown scaled argument in row " + RowIdx + " for scaleFactor: " + RowFormat.scaled.scale);
      }
      var _loc14_ = 3;
      if(RowFormat.scaled.precision != undefined)
      {
         _loc14_ = RowFormat.scaled.precision;
      }
      if(_loc8_ != undefined)
      {
         var DataValue = _global.LeaderBoardsAPI.QueryRow_ColumnValue(RowIdx,_loc8_);
         var _loc18_ = DataValue * _loc10_;
         RowItem.htmlText = "" + Math.floor(_loc18_);
      }
   }
   if(RowFormat.timeFormat != undefined)
   {
      _loc8_ = LookupParamId(RowFormat.timeFormat.column);
      if(_loc8_ == undefined)
      {
         trace(" ERROR: Unknown timeFormat argument in row " + RowIdx + " for column: " + RowFormat.timeFormat.column);
      }
      else
      {
         var DataValue = _global.LeaderBoardsAPI.QueryRow_ColumnValue(RowIdx,_loc8_);
         var _loc6_ = Math.floor(DataValue / 86400);
         if(_loc6_ > 0)
         {
            DataValue = DataValue % 86400;
         }
         var _loc12_ = Math.floor(DataValue / 3600);
         if(_loc12_ > 0)
         {
            DataValue = DataValue % 3600;
         }
         var _loc9_ = _loc12_.toString();
         var _loc16_ = Math.floor(DataValue / 60);
         var _loc11_ = _loc16_.toString();
         if(_loc6_ > 0)
         {
            RowItem.htmlText = _loc6_ + "d " + _loc9_ + "h " + _loc11_ + "m";
         }
         else
         {
            RowItem.htmlText = _loc9_ + "h " + _loc11_ + "m";
         }
      }
   }
   if(RowFormat.epoch != undefined)
   {
      _loc8_ = LookupParamId(RowFormat.epoch.column);
      if(_loc8_ == undefined)
      {
         trace(" ERROR: Unknown epoch argument in row " + RowIdx + " for column: " + RowFormat.epoch.column);
      }
      else
      {
         var DataValue = _global.LeaderBoardsAPI.QueryRow_ColumnValue(RowIdx,_loc8_);
         if(DataValue > 10000000)
         {
            RowItem.htmlText = Math.floor(DataValue / 1000000) + "M";
         }
         else if(DataValue > 10000)
         {
            RowItem.htmlText = Math.floor(DataValue / 1000) + "K";
         }
         else
         {
            RowItem.htmlText = DataValue + "";
         }
      }
   }
}
function hideResultsRows()
{
   var _loc6_ = LeaderBoardsData.LeaderboardTypes.order[CurrentActivePanel];
   var _loc7_ = this[_loc6_.panelName];
   Rank._visible = false;
   RankNumber._visible = false;
   var _loc3_ = 0;
   while(_loc3_ < _loc6_.numRows)
   {
      var _loc4_ = _loc6_.rowPrefix + _loc3_;
      _loc7_[_loc4_]._visible = false;
      var _loc5_ = _loc7_[_loc4_].MouseOverBar;
      _loc5_.rowIdx = _loc3_;
      _loc5_.onPress = function()
      {
         _global.LeaderBoardsMovie.onClickedRow(this);
      };
      _loc3_ = _loc3_ + 1;
   }
}
function DisplayCurrentRowUserInfo()
{
   _global.LeaderBoardsAPI.DisplayUserInfo(CurrentRow);
}
function onClickedRow(button)
{
   if(_global.LeaderBoardsMovie.isDoubleClickActive() && SelectedButton == button)
   {
      _global.LeaderBoardsMovie.stopDoubleClickTimer();
      _global.navManager.PlayNavSound("ButtonAction");
      _global.LeaderBoardsAPI.DisplayUserInfo(button.rowIdx);
      UnselectButton();
   }
   else
   {
      _global.LeaderBoardsMovie.startDoubleClickTimer();
      _global.LeaderBoardsMovie.LeaderBoards.Panel.UpdateRowSelection(button.rowIdx);
      UnselectButton();
      SelectedButton = button;
   }
}
function UnselectButton()
{
   if(SelectedButton != undefined)
   {
      SelectedButton = undefined;
   }
}
function onShow()
{
   _global.navManager.PushLayout(leaderBoardsNav,"leaderBoardsNav");
}
function onHide()
{
   _global.navManager.RemoveLayout(leaderBoardsNav);
   _global.GameInterface.SetConvar("player_last_leaderboards_panel",CurrentActivePanel);
   _global.GameInterface.SetConvar("player_last_leaderboards_mode",CurrentMode);
   _global.GameInterface.SetConvar("player_last_leaderboards_filter",CurrentFilter);
}
function cleanup()
{
   _global.navManager.RemoveLayout(leaderBoardsNav);
}
function PrevLeaderBoard()
{
   var _loc1_ = CurrentActivePanel - 1;
   if(_loc1_ < 0)
   {
      _loc1_ = LeaderBoardsData.LeaderboardTypes.order.length - 1;
   }
   switchPanel(_loc1_);
   UpdateQuery();
}
function NextLeaderBoard()
{
   var _loc1_ = CurrentActivePanel + 1;
   if(_loc1_ >= LeaderBoardsData.LeaderboardTypes.order.length)
   {
      _loc1_ = 0;
   }
   switchPanel(_loc1_);
   UpdateQuery();
}
function CycleFilter()
{
   if(_global.IsPS3() && CurrentFilter == Filter_Me)
   {
      CurrentFilter = 0;
   }
   else
   {
      CurrentFilter++;
      if(CurrentFilter >= LeaderBoardsData.Filters.length)
      {
         CurrentFilter = 0;
      }
   }
   FilterButton.SetText(LeaderBoardsData.Filters[CurrentFilter]);
   AbsoluteRow = 1;
   UpdateQuery();
}
function CycleInputDevice()
{
   if(!bDeviceRankedBoard)
   {
      return undefined;
   }
   Device_Type++;
   if(Device_Type >= DeviceTypes.length)
   {
      Device_Type = 0;
   }
   DeviceButton.SetText(DeviceTypes[Device_Type].label);
   AbsoluteRow = 1;
   UpdateQuery();
}
function PrevMode()
{
   CurrentMode--;
   if(CurrentMode < 0)
   {
      CurrentMode = LeaderBoardsData.Modes.length - 1;
   }
   ModeButton.SetText(LeaderBoardsData.Modes[CurrentMode].mtext);
   AbsoluteRow = 1;
   UpdateDeviceRankedBoard();
   UpdateQuery();
}
function NextMode()
{
   CurrentMode++;
   if(CurrentMode >= LeaderBoardsData.Modes.length)
   {
      CurrentMode = 0;
   }
   ModeButton.SetText(LeaderBoardsData.Modes[CurrentMode].mtext);
   AbsoluteRow = 1;
   UpdateDeviceRankedBoard();
   UpdateQuery();
}
function UpdateRowSelection(NewRow)
{
   var _loc3_ = LeaderBoardsData.LeaderboardTypes.order[CurrentActivePanel];
   var _loc4_ = this[_loc3_.panelName];
   var _loc5_ = _loc3_.rowPrefix + CurrentRow;
   _loc4_[_loc5_].gotoAndStop("Up");
   CurrentRow = NewRow;
   Rank._visible = true;
   RankNumber._visible = true;
   RankNumber.SetText(_global.LeaderBoardsAPI.QueryRow_ColumnValue(CurrentRow,-2));
   var _loc6_ = _loc3_.rowPrefix + CurrentRow;
   _loc4_[_loc6_].gotoAndStop("Over");
}
function UpPressed()
{
   if(TotalRows == 0)
   {
      return undefined;
   }
   var _loc2_ = LeaderBoardsData.LeaderboardTypes.order[CurrentActivePanel];
   var _loc1_ = CurrentRow - 1;
   if(_loc1_ < 0)
   {
      _loc1_ = 0;
      if(AbsoluteRow > 1 || CurrentFilter == Filter_Me)
      {
         if(AbsoluteRow > 1)
         {
            AbsoluteRow = AbsoluteRow - _loc2_.numRows;
            if(AbsoluteRow <= 1)
            {
               AbsoluteRow = 1;
            }
         }
         if(CurrentFilter == Filter_Me)
         {
            CurrentFilter = Filter_Overall;
            FilterButton.SetText(LeaderBoardsData.Filters[CurrentFilter]);
         }
         bUpToPrevPage = true;
         UpdateQuery();
      }
   }
   else
   {
      UpdateRowSelection(_loc1_);
   }
}
function DownPressed()
{
   if(TotalRows == 0)
   {
      return undefined;
   }
   var _loc2_ = LeaderBoardsData.LeaderboardTypes.order[CurrentActivePanel];
   var _loc1_ = CurrentRow + 1;
   if(_loc1_ >= TotalRows)
   {
      if(TotalRows == _loc2_.numRows && AbsoluteRow + _loc1_ <= TotalRowResults)
      {
         _loc1_ = 0;
         AbsoluteRow = AbsoluteRow + _loc2_.numRows;
         if(CurrentFilter == Filter_Me)
         {
            CurrentFilter = Filter_Overall;
            FilterButton.SetText(LeaderBoardsData.Filters[CurrentFilter]);
         }
         UpdateQuery();
      }
      else
      {
         _loc1_ = TotalRows - 1;
      }
   }
   else
   {
      UpdateRowSelection(_loc1_);
   }
}
function hideCurrentPanel()
{
   var _loc2_ = LeaderBoardsData.LeaderboardTypes.order[CurrentActivePanel];
   this[_loc2_.panelName]._visible = false;
}
function UpdateDeviceRankedBoard()
{
   var _loc2_ = LeaderBoardsData.LeaderboardTypes.order[CurrentActivePanel];
   bDeviceRankedBoard = _loc2_.hasDeviceSpecificRanking == "1";
   DeviceText._visible = bDeviceRankedBoard;
   DeviceGlyph._visible = _global.wantControllerShown && bDeviceRankedBoard;
   DeviceGlyph.wantsDeviceForBoard = bDeviceRankedBoard;
   DeviceButton._visible = bDeviceRankedBoard;
   if(bDeviceRankedBoard)
   {
      DeviceButton.SetText(DeviceTypes[Device_Type].label);
   }
}
function switchPanel(NewPanel)
{
   AbsoluteRow = 1;
   hideCurrentPanel();
   CurrentActivePanel = NewPanel;
   var _loc3_ = LeaderBoardsData.LeaderboardTypes.order[CurrentActivePanel];
   var _loc4_ = this[_loc3_.panelName];
   if(_loc4_ == undefined)
   {
      trace(" ERROR: Leaderboard Panel " + _loc3_.panelName + " isn\'t defined in the Flash file!");
      return undefined;
   }
   UpdateDeviceRankedBoard();
   CategoryName.SetText(_loc3_.nameID);
   for(var _loc5_ in _loc3_.ColumnHeadingLabels)
   {
      var _loc2_ = _loc3_.ColumnHeadingLabels[_loc5_];
      if(_loc2_ && typeof _loc2_ == "string")
      {
         _loc4_[_loc5_].SetText(_loc2_);
      }
   }
   hideResultsRows();
   _loc4_._visible = true;
}
function InitPanel()
{
   CurrentActivePanel = Math.floor(_global.GameInterface.GetConvarNumber("player_last_leaderboards_panel"));
   CurrentMode = Math.floor(_global.GameInterface.GetConvarNumber("player_last_leaderboards_mode"));
   CurrentFilter = Math.floor(_global.GameInterface.GetConvarNumber("player_last_leaderboards_filter"));
   UpButton.Action = function()
   {
      _global.LeaderBoardsMovie.UpPressed();
   };
   DownButton.Action = function()
   {
      _global.LeaderBoardsMovie.DownPressed();
   };
   ModeButton.Action = function()
   {
      _global.LeaderBoardsMovie.CycleMode();
   };
   FilterButton.Action = function()
   {
      _global.LeaderBoardsMovie.CycleFilter();
   };
   DeviceButton.Action = function()
   {
      _global.LeaderBoardsMovie.CycleInputDevice();
   };
   LeaderBoardsData = _global.GameInterface.LoadKVFile("LeaderboardsConfig.txt");
   CreateOrder(LeaderBoardsData.LeaderboardTypes);
   BSetDefaults = false;
   if(BSetDefaults == false)
   {
      CurrentFilter = 2;
      Device_Type = 0;
      BSetDefaults = true;
   }
   if(_global.IsPS3())
   {
      DeviceTypes = LeaderBoardsData.DeviceTypesPS3;
   }
   else if(!_global.IsXbox())
   {
      DeviceTypes = LeaderBoardsData.DeviceTypesPC;
   }
   if(CurrentActivePanel < 0)
   {
      CurrentActivePanel = 0;
   }
   var _loc5_ = LeaderBoardsData.LeaderboardTypes.order;
   var _loc6_ = _loc5_.length;
   if(CurrentActivePanel >= _loc6_)
   {
      CurrentActivePanel = _loc6_ - 1;
   }
   if(CurrentMode < 0)
   {
      CurrentMode = 0;
   }
   if(CurrentMode >= LeaderBoardsData.Modes.length)
   {
      CurrentMode = LeaderBoardsData.Modes.length - 1;
   }
   if(CurrentFilter < 0)
   {
      CurrentFilter = 0;
   }
   if(CurrentFilter >= LeaderBoardsData.Filters.length)
   {
      CurrentFilter = LeaderBoardsData.Filters.length - 1;
   }
   CategoryName.SetText(_loc5_[CurrentActivePanel].nameID);
   ModeButton.SetText(LeaderBoardsData.Modes[CurrentMode].mtext);
   FilterButton.SetText(LeaderBoardsData.Filters[CurrentFilter]);
   var _loc3_ = 0;
   while(_loc3_ < _loc6_)
   {
      var _loc4_ = _loc5_[_loc3_].panelName;
      this[_loc4_]._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   switchPanel(CurrentActivePanel);
   UpdateQuery();
}
function CreateOrder(o)
{
   if(typeof o == "object")
   {
      o.order = new Array();
      o.ordername = new Array();
      for(var _loc3_ in o)
      {
         var _loc2_ = o[_loc3_];
         if(_loc2_ && typeof _loc2_ == "object")
         {
            o.order[o[_loc3_].value] = _loc2_;
            o.ordername[o[_loc3_].value] = _loc3_;
         }
      }
   }
}
function IncFromOrder(o, order)
{
   o = o + 1;
   if(o >= order.length)
   {
      o = 0;
   }
   return o;
}
function DecFromOrder(o, order)
{
   o = o - 1;
   if(o < 0)
   {
      o = order.length - 1;
   }
   return o;
}
var CurrentActivePanel = 0;
var CurrentMode = 0;
var CurrentFilter = 0;
var CurrentRow = 0;
var Filter_Overall = 0;
var Filter_Me = 1;
var Filter_Friends = 2;
var bDeviceRankedBoard = false;
var Device_Type = 0;
var DeviceTypes;
var BSetDefaults = false;
var TotalRows = 0;
var AbsoluteRow = 1;
var TotalRowResults = 0;
var LeaderBoardsData;
var bUpToPrevPage = false;
var CurrentELOBoardName = undefined;
var SelectedButton = undefined;
var leaderBoardsNav = new Lib.NavLayout();
leaderBoardsNav.AddTabOrder([]);
leaderBoardsNav.ShowCursor(true);
leaderBoardsNav.AddRepeatKeys("DOWN","UP","HOME","END");
leaderBoardsNav.AddKeyHandlerTable({ACCEPT:{onDown:function(button, control, keycode)
{
   _global.navManager.PlayNavSound("ButtonAction");
   _global.LeaderBoardsAPI.DisplayUserInfo(CurrentRow);
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}},CANCEL:{onDown:function(button, control, keycode)
{
   _global.LeaderBoardsMovie.hidePanel();
}},UP:{onDown:function(button, control, keycode)
{
   _global.navManager.PlayNavSound("ButtonAction");
   UpButton.gotoAndPlay("StartOver");
   _global.LeaderBoardsMovie.UpPressed();
   return true;
},onUp:function(button, control, keycode)
{
   UpButton.gotoAndPlay("StartUp");
   return true;
}},DOWN:{onDown:function(button, control, keycode)
{
   _global.navManager.PlayNavSound("ButtonAction");
   DownButton.gotoAndPlay("StartOver");
   _global.LeaderBoardsMovie.DownPressed();
   return true;
},onUp:function(button, control, keycode)
{
   DownButton.gotoAndPlay("StartUp");
   return true;
}},KEY_XBUTTON_LEFT_SHOULDER:{onDown:function(button, control, keycode)
{
   _global.navManager.PlayNavSound("ButtonAction");
   _global.LeaderBoardsMovie.PrevCatButton.gotoAndPlay("StartOver");
   _global.LeaderBoardsMovie.PrevLeaderBoard();
   return true;
},onUp:function(button, control, keycode)
{
   _global.LeaderBoardsMovie.PrevCatButton.gotoAndPlay("StartUp");
   return true;
}},KEY_XBUTTON_RIGHT_SHOULDER:{onDown:function(button, control, keycode)
{
   _global.navManager.PlayNavSound("ButtonAction");
   _global.LeaderBoardsMovie.NextCatButton.gotoAndPlay("StartOver");
   _global.LeaderBoardsMovie.NextLeaderBoard();
   return true;
},onUp:function(button, control, keycode)
{
   _global.LeaderBoardsMovie.NextCatButton.gotoAndPlay("StartUp");
   return true;
}},KEY_XBUTTON_LTRIGGER:{onDown:function(button, control, keycode)
{
   if(!DeviceButton._visible)
   {
      return false;
   }
   _global.navManager.PlayNavSound("ButtonAction");
   DeviceButton.gotoAndPlay("StartOver");
   _global.LeaderBoardsMovie.CycleInputDevice();
   return true;
},onUp:function(button, control, keycode)
{
   DeviceButton.gotoAndPlay("StartUp");
   return true;
}},KEY_XBUTTON_X:{onDown:function(button, control, keycode)
{
   _global.navManager.PlayNavSound("ButtonAction");
   ModeButton.gotoAndPlay("StartOver");
   _global.LeaderBoardsMovie.CycleMode();
   return true;
},onUp:function(button, control, keycode)
{
   ModeButton.gotoAndPlay("StartUp");
   return true;
}},KEY_XBUTTON_Y:{onDown:function(button, control, keycode)
{
   _global.navManager.PlayNavSound("ButtonAction");
   FilterButton.gotoAndPlay("StartOver");
   _global.LeaderBoardsMovie.CycleFilter();
   return true;
},onUp:function(button, control, keycode)
{
   FilterButton.gotoAndPlay("StartUp");
   return true;
}}});
Lib.TintManager.StaticRegisterForTint(Rows,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(Block,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(ModeText,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(RankNumber,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(Rank,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(ACTable,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(GPTable,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(KDTable,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(WinsTable,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(MVPTable,Lib.TintManager.TintRegister_All);
Lib.TintManager.StaticRegisterForTint(FilterText,Lib.TintManager.TintRegister_All);
stop();
