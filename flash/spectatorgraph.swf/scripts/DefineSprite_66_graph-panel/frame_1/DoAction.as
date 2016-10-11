function GetGraphTypes()
{
   var _loc5_ = _global.CScaleformComponent_MatchStats.GetRangeCount();
   trace("-----------------------------numTypes" + _loc5_);
   aFilterTypes = [];
   var _loc3_ = 0;
   while(_loc3_ <= _loc5_ - 1)
   {
      var _loc4_ = _global.CScaleformComponent_MatchStats.GetRangeNameByIndex(_loc3_);
      aFilterTypes.push(_loc4_);
      trace("-----------------------------aFilterTypes" + aFilterTypes);
      _loc3_ = _loc3_ + 1;
   }
   Dropdown.SetUpDropDown(aFilterTypes,"#SFUI_Graph_title","#SFUI_Graph_type_",this.SetGraphDropdownType,m_strTypeDropdown);
   Dropdown.Catagory.navLayout = _global.SFMapOverview.overviewNav;
   Dropdown.Dropdown.Button0.navLayout = _global.SFMapOverview.overviewNav;
   Dropdown.Dropdown.Button1.navLayout = _global.SFMapOverview.overviewNav;
   Dropdown.Dropdown.Button2.navLayout = _global.SFMapOverview.overviewNav;
   Dropdown.Dropdown.Button3.navLayout = _global.SFMapOverview.overviewNav;
   Dropdown.Dropdown.Button4.navLayout = _global.SFMapOverview.overviewNav;
   Dropdown.Dropdown.Button5.navLayout = _global.SFMapOverview.overviewNav;
   Dropdown.Dropdown.Button6.navLayout = _global.SFMapOverview.overviewNav;
   Dropdown.Dropdown.Button7.navLayout = _global.SFMapOverview.overviewNav;
   Dropdown.Dropdown.Button8.navLayout = _global.SFMapOverview.overviewNav;
   Dropdown.Dropdown.Button9.navLayout = _global.SFMapOverview.overviewNav;
}
function onRefresh()
{
   m_strTypeDropdown = _global.CScaleformComponent_MatchStats.GetRangeNameByIndex(_global.CScaleformComponent_MatchStats.GetDesiredPage());
   GetGraphTypes();
   SetGraphDropdownType(m_strTypeDropdown);
}
function SetGraphDropdownType(strDropdownOption)
{
   ClearAllPreviouslyDrawnLines();
   m_strTypeDropdown = strDropdownOption;
   _global.CScaleformComponent_MatchStats.SetCurrentPage(m_strTypeDropdown);
   SetUpPlayerGraphs();
   DrawValueLines();
   DrawRoundLines();
   RedrawSelectedPlayersLines();
   SetUpAndDrawTeamButtons();
   FindBestPlayerOfType();
   if(m_bShowDefaultSelections)
   {
      TogglePlayerData(ct0);
      TogglePlayerData(t0);
      m_bShowDefaultSelections = false;
   }
}
function ClearAllPreviouslyDrawnLines()
{
   if(aSelectedPlayersCt.length > 0)
   {
      HidePlayerData(aSelectedPlayersCt[0]);
   }
   if(aSelectedPlayersT.length > 0)
   {
      HidePlayerData(aSelectedPlayersT[0]);
   }
}
function DrawValueLines()
{
   var _loc9_ = m_strTypeDropdown;
   trace("--------------------------range----------------------" + _loc9_);
   var _loc12_ = _global.CScaleformComponent_MatchStats.GetRangeMin(_loc9_);
   var _loc8_ = _global.CScaleformComponent_MatchStats.GetRangeMax(_loc9_);
   mcValue._visible = false;
   var _loc3_ = 0;
   while(_loc3_ <= 10)
   {
      if(this["mcValue" + _loc3_])
      {
         this["mcValue" + _loc3_].removeMovieClip();
      }
      _loc3_ = _loc3_ + 1;
   }
   if(_loc8_ == 0)
   {
      var _loc10_ = _global.GameInterface.Translate("#SFUI_Graph_NoData");
      var _loc11_ = _global.GameInterface.Translate("#SFUI_Graph_type_" + m_strTypeDropdown);
      _loc10_ = _global.ConstructString(_loc10_,_loc11_);
      NoData.Text.htmlText = _loc10_;
      NoData._visible = true;
      NoData.swapDepths(this.getNextHighestDepth());
      return undefined;
   }
   NoData._visible = false;
   if(_loc8_ < 10)
   {
      var _loc6_ = _loc8_;
      var _loc4_ = 1;
   }
   else
   {
      _loc6_ = 10;
      _loc4_ = _loc8_ / _loc6_;
   }
   var _loc7_ = GraphBounds._height / _loc6_;
   trace("--------------------------YSpacing----------------------" + _loc7_);
   _loc3_ = 0;
   while(_loc3_ <= _loc6_)
   {
      mcValue.duplicateMovieClip("mcValue" + _loc3_,80 + _loc3_);
      this["mcValue" + _loc3_]._x = GraphBounds._x;
      this["mcValue" + _loc3_]._y = GraphBounds._y + _loc7_ * -1 * _loc3_;
      if(IsMoney())
      {
         this["mcValue" + _loc3_].Value.htmlText = "$" + _loc3_ * _loc4_;
      }
      else if(m_strTypeDropdown == "livetime")
      {
         var _loc5_ = Math.round(_loc3_ * _loc4_ / 60);
         this["mcValue" + _loc3_].Value.htmlText = _loc5_ + "min";
      }
      else
      {
         this["mcValue" + _loc3_].Value.htmlText = _loc3_ * _loc4_;
      }
      if(_loc3_ * _loc4_ == 0)
      {
         this["mcValue" + _loc3_].Value.htmlText = "";
      }
      _loc3_ = _loc3_ + 1;
   }
}
function DrawRoundLines()
{
   mcRound._visible = false;
   var _loc9_ = m_strTypeDropdown;
   var _loc10_ = _global.CScaleformComponent_MatchStats.GetPlayerByIndex(0);
   var _loc8_ = _global.CScaleformComponent_MatchStats.GetDataSeriesPointCount(_loc9_,_loc10_);
   var _loc6_ = 0;
   if(_loc8_ <= 14)
   {
      _loc6_ = GraphBounds._width / 15;
      if(mcRound14._visible)
      {
         var _loc4_ = 0;
         while(_loc4_ < 30)
         {
            if(this["mcRound" + _loc4_])
            {
               this["mcRound" + _loc4_].removeMovieClip();
            }
            _loc4_ = _loc4_ + 1;
         }
      }
   }
   else
   {
      _loc6_ = GraphBounds._width / 30;
   }
   m_XSpacing = _loc6_;
   _loc4_ = 0;
   while(_loc4_ <= _loc8_ - 1)
   {
      var _loc3_ = mcRound.duplicateMovieClip("mcRound" + _loc4_,_loc4_);
      _loc3_.TeamGrey._visible = true;
      _loc3_.TeamGrey._width = _loc6_;
      _loc3_.Round._x = _loc6_ / 2;
      _loc3_.Line._x = _loc6_;
      _loc3_._x = GraphBounds._x + _loc6_ * _loc4_;
      _loc3_._y = GraphBounds._y;
      _loc3_.Round.Text.htmlText = _loc4_ + 1;
      if(_loc4_ == 14)
      {
         _loc3_.Line.transform.colorTransform = White;
      }
      _loc3_.Kill._visible = false;
      _loc3_.Bomb._visible = false;
      _loc3_.Hostage._visible = false;
      _loc3_.Defuse._visible = false;
      _loc3_.Time._visible = false;
      var _loc5_ = undefined;
      var WinType;
      var _loc7_ = _global.CScaleformComponent_MatchStats.GetRoundWinResult(_loc4_ + 1);
      switch(_loc7_)
      {
         case "ct_win_rescue":
            _loc5_ = "ct";
            WinType = "Hostage";
            break;
         case "ct_win_defuse":
            _loc5_ = "ct";
            WinType = "Defuse";
            break;
         case "ct_win_time":
            _loc5_ = "ct";
            WinType = "Time";
            break;
         case "ct_win_elimination":
            _loc5_ = "ct";
            WinType = "Kill";
            break;
         case "t_win_elimination":
            _loc5_ = "t";
            WinType = "Kill";
            break;
         case "t_win_bomb":
            _loc5_ = "t";
            WinType = "Bomb";
            break;
         case "t_win_time":
            _loc5_ = "t";
            WinType = "Time";
            break;
         default:
            _loc3_.TeamGrey._visible = false;
      }
      if(_loc8_ >= 15)
      {
         _loc3_[WinType]._height = 12;
         _loc3_[WinType]._width = 12;
      }
      else
      {
         _loc3_[WinType]._height = 15;
         _loc3_[WinType]._width = 15;
      }
      if(_loc5_ == "ct")
      {
         _loc3_.TeamGrey.transform.colorTransform = CT_ColorTransform0;
         _loc3_.Round.transform.colorTransform = CT_ColorTransform0;
         _loc3_[WinType].transform.colorTransform = CT_ColorTransform0;
      }
      else
      {
         _loc3_.TeamGrey.transform.colorTransform = T_ColorTransform0;
         _loc3_.Round.transform.colorTransform = T_ColorTransform0;
         _loc3_[WinType].transform.colorTransform = T_ColorTransform0;
      }
      _loc3_[WinType]._x = _loc3_.Round._x;
      _loc3_[WinType]._visible = true;
      _loc3_[WinType]._alpha = 52;
      _loc3_.TeamGrey._alpha = 40;
      _loc3_.dialog = this;
      _loc3_.onRollOver = function()
      {
         this.dialog.RoundRollOver(this,true,WinType);
      };
      _loc3_.onRollOut = function()
      {
         this.dialog.RoundRollOver(this,false,WinType);
      };
      _loc4_ = _loc4_ + 1;
   }
}
function RoundRollOver(RoundColumn, bShow, WinType)
{
   if(bShow)
   {
      RoundColumn.TeamGrey._alpha = 85;
      RoundColumn[WinType]._alpha = 100;
   }
   else
   {
      RoundColumn.TeamGrey._alpha = 40;
      RoundColumn[WinType]._alpha = 52;
   }
}
function SetUpPlayerGraphs()
{
   var _loc11_ = _global.CScaleformComponent_MatchStats.GetPlayerCount();
   var _loc6_ = 0;
   var _loc7_ = 0;
   var _loc3_ = 0;
   while(_loc3_ < _loc11_)
   {
      var _loc5_ = _global.CScaleformComponent_MatchStats.GetPlayerByIndex(_loc3_);
      var _loc9_ = _global.CScaleformComponent_MatchStats.GetPlayerXuid(_loc5_);
      var _loc10_ = _global.CScaleformComponent_MatchStats.GetPlayerTeam(_loc5_);
      nXPos = nXposOffset;
      if(_loc10_ == TEAMCT)
      {
         var _loc8_ = this.createEmptyMovieClip("graphct" + _loc6_,100 + _loc3_);
         var _loc4_ = this["ct" + _loc6_];
         _loc4_._GraphName = "graphct" + _loc6_;
         _loc4_._Team = TEAMCT;
         _loc6_ = _loc6_ + 1;
      }
      else
      {
         _loc8_ = this.createEmptyMovieClip("grapht" + _loc7_,200 + _loc3_);
         _loc4_ = this["t" + _loc7_];
         _loc4_._GraphName = "grapht" + _loc7_;
         _loc4_._Team = TEAMT;
         _loc7_ = _loc7_ + 1;
      }
      _loc8_._x = GraphBounds._x;
      _loc8_._y = GraphBounds._y;
      _loc4_._pIndex = _loc5_;
      _loc4_._Xuid = _loc9_;
      SetUpPlayerButtons(_loc4_);
      _loc3_ = _loc3_ + 1;
   }
}
function SetUpPlayerButtons(PlayerBtn)
{
   PlayerBtn._visible = true;
   PlayerBtn.dialog = this;
   PlayerBtn.navLayout = _global.SFMapOverview.overviewNav;
   PlayerBtn.SetText(_global.CScaleformComponent_FriendsList.GetFriendName(PlayerBtn._Xuid));
   PlayerBtn.ButtonTextSelected.Text.htmlText = _global.CScaleformComponent_FriendsList.GetFriendName(PlayerBtn._Xuid);
   PlayerBtn.Action = function()
   {
      this.dialog.TogglePlayerData(this);
   };
   PlayerBtn.RolledOver = function()
   {
      this.dialog.PlayerRollOver(this,true);
   };
   PlayerBtn.RolledOut = function()
   {
      this.dialog.PlayerRollOver(this,false);
   };
   PlayerBtn.Avatar.m_bShowFlair = false;
   PlayerBtn.Avatar._visible = true;
   PlayerBtn.Avatar.ShowAvatar(3,PlayerBtn._Xuid,true,false);
   PlayerBtn.Avatar.SetFlairItem(PlayerBtn._Xuid);
   if(PlayerBtn._Team == TEAMCT)
   {
      PlayerBtn.ButtonText.Text.textColor = parseInt(CTColor0);
   }
   else
   {
      PlayerBtn.ButtonText.Text.textColor = parseInt(TColor0);
   }
   CheckIfPlayerHasData(PlayerBtn);
}
function CheckIfPlayerHasData(PlayerBtn)
{
   var _loc3_ = _global.CScaleformComponent_MatchStats.GetDataSeriesPointCount(m_strTypeDropdown,PlayerBtn._pIndex);
   var _loc4_ = _global.CScaleformComponent_MatchStats.GetRangeMax(m_strTypeDropdown);
   if(_loc3_ == 0 || _loc4_ == 0)
   {
      PlayerBtn.setDisabled(true);
      PlayerBtn.ButtonTextSelected._visible = false;
      PlayerBtn.Selected._visible = false;
      PlayerBtn.Avatar._alpha = 50;
      return false;
   }
   PlayerBtn.setDisabled(false);
   PlayerBtn.Avatar._alpha = 100;
   return true;
}
function PlayerRollOver(PlayerBtn, bShow)
{
   if(PlayerBtn.Selected._visible)
   {
      return undefined;
   }
   if(bShow)
   {
      DrawLine(PlayerBtn,false,true);
      this[PlayerBtn._GraphName]._visible = true;
   }
   else
   {
      this[PlayerBtn._GraphName]._visible = false;
      this[PlayerBtn._GraphName].clear();
   }
}
function SetUpAndDrawTeamButtons()
{
   var _loc5_ = this.createEmptyMovieClip("teamgraphct",70);
   var _loc3_ = new Object();
   _loc3_._GraphName = "teamgraphct";
   _loc3_._Team = TEAMCT;
   _loc3_._pIndex = 0;
   _loc3_._Xuid = "";
   _loc5_._x = GraphBounds._x;
   _loc5_._y = GraphBounds._y;
   var _loc4_ = this.createEmptyMovieClip("teamgrapht",71);
   var _loc2_ = new Object();
   _loc2_._GraphName = "teamgrapht";
   _loc2_._Team = TEAMT;
   _loc2_._pIndex = 0;
   _loc2_._Xuid = "";
   _loc4_._x = GraphBounds._x;
   _loc4_._y = GraphBounds._y;
   DrawLine(_loc3_,true,false);
   DrawLine(_loc2_,true,false);
}
function RedrawSelectedPlayersLines()
{
   if(aSelectedPlayersCt.length > 0)
   {
      ShowPlayerData(aSelectedPlayersCt[0]);
   }
   if(aSelectedPlayersT.length > 0)
   {
      ShowPlayerData(aSelectedPlayersT[0]);
   }
}
function TogglePlayerData(PlayerBtn)
{
   if(PlayerBtn.Selected._visible == true)
   {
      if(PlayerBtn._Team == TEAMCT)
      {
         var _loc3_ = aSelectedPlayersCt;
      }
      else
      {
         _loc3_ = aSelectedPlayersT;
      }
      var _loc1_ = 0;
      while(_loc1_ <= _loc3_.length)
      {
         if(_loc3_[_loc1_] == PlayerBtn)
         {
            _loc3_.splice(_loc1_,1);
         }
         _loc1_ = _loc1_ + 1;
      }
      HidePlayerData(PlayerBtn);
   }
   else
   {
      if(PlayerBtn._Team == TEAMCT)
      {
         _loc3_ = aSelectedPlayersCt;
      }
      else
      {
         _loc3_ = aSelectedPlayersT;
      }
      _loc3_.unshift(PlayerBtn);
      if(_loc3_.length > 0)
      {
         HidePlayerData(_loc3_[1]);
         _loc3_.splice(1,1);
      }
      ShowPlayerData(PlayerBtn);
   }
}
function ShowPlayerData(PlayerBtn)
{
   if(!CheckIfPlayerHasData(PlayerBtn))
   {
      return undefined;
   }
   var _loc5_ = undefined;
   var _loc7_ = new flash.geom.ColorTransform();
   PlayerBtn.Selected._visible = true;
   PlayerBtn.ButtonTextSelected._visible = true;
   if(PlayerBtn._Team == TEAMCT)
   {
      var _loc4_ = aSelectedPlayersCt;
      var _loc3_ = [CTColor0,CTColor1];
   }
   else
   {
      _loc4_ = aSelectedPlayersT;
      _loc3_ = [TColor0,TColor1];
   }
   var _loc2_ = 0;
   while(_loc2_ <= _loc4_.length)
   {
      if(_loc4_[_loc2_]._Color == _loc3_[0] && _loc4_[_loc2_] != PlayerBtn)
      {
         _loc5_ = _loc3_[1];
         break;
      }
      _loc5_ = _loc3_[0];
      _loc2_ = _loc2_ + 1;
   }
   _loc7_.rgb = parseInt(_loc5_);
   PlayerBtn.Selected.transform.colorTransform = _loc7_;
   PlayerBtn._Color = _loc5_;
   this[PlayerBtn._GraphName]._visible = true;
   DrawLine(PlayerBtn,false,false);
}
function HidePlayerData(PlayerBtn)
{
   RemoveToolTipHitArea(PlayerBtn);
   this[PlayerBtn._GraphName]._visible = false;
   this[PlayerBtn._GraphName].clear();
   PlayerBtn.Selected._visible = false;
   PlayerBtn.ButtonTextSelected._visible = false;
}
function DrawLine(GraphToDisplayBtn, bIsTeam, bIsRollOver)
{
   var _loc19_ = _global.CScaleformComponent_MatchStats.GetRangeMax(m_strTypeDropdown);
   if(_loc19_ == 0)
   {
      return undefined;
   }
   var _loc16_ = this[GraphToDisplayBtn._GraphName];
   var _loc14_ = GraphToDisplayBtn._pIndex;
   var _loc13_ = GraphToDisplayBtn._Team;
   var _loc10_ = undefined;
   var _loc4_ = undefined;
   var _loc20_ = mcRound0._width / 2;
   var _loc23_ = mcValue0._height / 2;
   _loc10_ = _loc20_;
   var _loc9_ = m_strTypeDropdown;
   var _loc24_ = _global.CScaleformComponent_MatchStats.GetRangeMin(_loc9_);
   _loc19_ = _global.CScaleformComponent_MatchStats.GetRangeMax(_loc9_);
   var _loc17_ = GraphBounds._height / _loc19_;
   var _loc21_ = 2;
   var _loc22_ = 100;
   var _loc15_ = _global.CScaleformComponent_MatchStats.GetDataSeriesPointCount(_loc9_,_loc14_);
   SetLineStyle(GraphToDisplayBtn,_loc13_,bIsTeam,bIsRollOver);
   var _loc3_ = 0;
   while(_loc3_ < _loc15_)
   {
      if(bIsTeam)
      {
         _loc4_ = _global.CScaleformComponent_MatchStats.GetTeamDataSeriesPointByIndex(_loc9_,_loc13_,_loc3_ - 1);
      }
      else
      {
         _loc4_ = _global.CScaleformComponent_MatchStats.GetDataSeriesPointByIndex(_loc9_,_loc14_,_loc3_ - 1);
      }
      _loc4_ = _loc17_ * _loc4_ * -1;
      var _loc6_ = Math.round(_loc10_);
      var _loc8_ = _loc4_;
      if(bIsTeam)
      {
         _loc4_ = _global.CScaleformComponent_MatchStats.GetTeamDataSeriesPointByIndex(_loc9_,_loc13_,_loc3_);
      }
      else
      {
         _loc4_ = _global.CScaleformComponent_MatchStats.GetDataSeriesPointByIndex(_loc9_,_loc14_,_loc3_);
      }
      _loc4_ = _loc17_ * _loc4_ * -1;
      if(_loc3_ >= 1)
      {
         _loc10_ = _loc10_ + m_XSpacing;
      }
      var _loc7_ = Math.round(_loc10_);
      var _loc5_ = _loc4_;
      if(_loc3_ == 0 || _loc3_ == 15)
      {
         if(!bIsTeam && !bIsRollOver)
         {
            if(_loc3_ == 15)
            {
               AttachToolTipMovieForPoint(_loc6_ + m_XSpacing,_loc5_,_loc3_,GraphToDisplayBtn);
            }
            else
            {
               AttachToolTipMovieForPoint(_loc6_,_loc5_,_loc3_,GraphToDisplayBtn);
            }
         }
      }
      else if(_loc3_ >= 1 && _loc3_ <= 14 || _loc3_ >= 16)
      {
         if(_loc3_ == 15 && _loc15_ >= 15)
         {
            _loc7_ = _loc6_;
            _loc5_ = _loc8_;
         }
         _loc16_.moveTo(_loc6_,_loc8_);
         _loc16_.lineTo(_loc7_,_loc5_);
         if(!bIsTeam && !bIsRollOver)
         {
            AttachToolTipMovieForPoint(_loc7_,_loc5_,_loc3_,GraphToDisplayBtn);
         }
      }
      trace("matchstats------------------------plot- " + _loc3_ + ": " + _loc6_ + ", " + _loc8_ + " - " + _loc7_ + ", " + _loc5_);
      _loc3_ = _loc3_ + 1;
   }
}
function AttachToolTipMovieForPoint(dX, dY, Round, GraphToDisplayBtn)
{
   var _loc3_ = new flash.geom.ColorTransform();
   var _loc4_ = GraphToDisplayBtn._pIndex;
   var _loc2_ = this[GraphToDisplayBtn._GraphName];
   var ToolTipHitArea = RolloverHitArea.duplicateMovieClip("RolloverHitArea" + _loc4_ + Round,this.getNextHighestDepth());
   ToolTipHitArea._x = dX + _loc2_._x;
   ToolTipHitArea._y = dY + _loc2_._y;
   _loc3_.rgb = parseInt(GraphToDisplayBtn._Color);
   ToolTipHitArea.transform.colorTransform = _loc3_;
   ToolTipHitArea.onRollOver = function()
   {
      ShowToolTip(true,ToolTipHitArea._x,ToolTipHitArea._y,Round,GraphToDisplayBtn);
   };
   ToolTipHitArea.onRollOut = function()
   {
      ShowToolTip(false,ToolTipHitArea._x,ToolTipHitArea._y,Round,GraphToDisplayBtn);
   };
   RolloverHitArea._visible = false;
}
function ShowToolTip(bShow, locX, locY, Round, PlayerBtn)
{
   var _loc4_ = new flash.geom.ColorTransform();
   Tooltip.swapDepths(this.getNextHighestDepth());
   if(bShow)
   {
      Tooltip.Avatar.m_bShowFlair = false;
      Tooltip.Avatar._visible = true;
      Tooltip.Avatar.ShowAvatar(3,PlayerBtn._Xuid,true,false);
      Tooltip.Avatar.SetFlairItem(PlayerBtn._Xuid);
      Tooltip.Name.htmlText = _global.CScaleformComponent_FriendsList.GetFriendName(PlayerBtn._Xuid);
      if(IsMoney())
      {
         Tooltip.Value.htmlText = "$" + _global.CScaleformComponent_MatchStats.GetDataSeriesPointByIndex(m_strTypeDropdown,PlayerBtn._pIndex,Round);
      }
      else if(m_strTypeDropdown == "livetime")
      {
         var _loc6_ = Math.round(_global.CScaleformComponent_MatchStats.GetDataSeriesPointByIndex(m_strTypeDropdown,PlayerBtn._pIndex,Round) / 60);
         Tooltip.Value.htmlText = _loc6_ + "min";
      }
      else
      {
         Tooltip.Value.htmlText = _global.CScaleformComponent_MatchStats.GetDataSeriesPointByIndex(m_strTypeDropdown,PlayerBtn._pIndex,Round);
      }
      Tooltip.Value.autoSize = "left";
      Tooltip.Type.htmlText = "#SFUI_Graph_type_" + m_strTypeDropdown;
      _global.AutosizeTextDown(Tooltip.Type,6);
      Tooltip.Type._x = Tooltip.Value._x + Tooltip.Value._width;
      var _loc8_ = _global.GameInterface.Translate("#SFUI_Graph_Round");
      var _loc7_ = Round + 1;
      Tooltip.Round.htmlText = _loc8_ + " " + _loc7_;
      _loc4_.rgb = parseInt(PlayerBtn._Color);
      Tooltip.Bg.transform.colorTransform = _loc4_;
      Tooltip.Arrow.transform.colorTransform = _loc4_;
      Tooltip._x = locX;
      Tooltip._y = locY;
      Tooltip._visible = true;
   }
   else
   {
      Tooltip._visible = false;
   }
}
function IsMoney()
{
   if(m_strTypeDropdown == "worth" || m_strTypeDropdown == "saved" || m_strTypeDropdown == "killreward")
   {
      return true;
   }
   return false;
}
function FindBestPlayerOfType()
{
   if(m_strTypeDropdown != "damage" && m_strTypeDropdown != "kills")
   {
      TopPlayerCt._visible = false;
      TopPlayerT._visible = false;
      return undefined;
   }
   var _loc8_ = new Array();
   var _loc9_ = new Array();
   var _loc3_ = 0;
   while(_loc3_ < 5)
   {
      var _loc7_ = this["ct" + _loc3_];
      var _loc6_ = this["t" + _loc3_];
      var _loc4_ = _global.CScaleformComponent_MatchStats.GetDataSeriesPointCount(m_strTypeDropdown,_loc7_._pIndex);
      var _loc5_ = _global.CScaleformComponent_MatchStats.GetDataSeriesPointByIndex(m_strTypeDropdown,_loc7_._pIndex,_loc4_);
      _loc8_.push({Team:"ct",Data:_loc5_,Index:_loc3_});
      _loc4_ = _global.CScaleformComponent_MatchStats.GetDataSeriesPointCount(m_strTypeDropdown,_loc6_._pIndex);
      _loc5_ = _global.CScaleformComponent_MatchStats.GetDataSeriesPointByIndex(m_strTypeDropdown,_loc6_._pIndex,_loc4_);
      _loc9_.push({Team:"t",Data:_loc5_,Index:_loc3_});
      _loc3_ = _loc3_ + 1;
   }
   _loc8_.sortOn("Data",Array.DESCENDING | Array.NUMERIC);
   _loc9_.sortOn("Data",Array.DESCENDING | Array.NUMERIC);
   var _loc14_ = this[_loc8_[0].Team + _loc8_[0].Index];
   var _loc13_ = this[_loc9_[0].Team + _loc9_[0].Index];
   if(_loc8_[0].Data != 0 && _loc8_[0].Data > 2)
   {
      TopPlayerCt.transform.colorTransform = CT_ColorTransform0;
      TopPlayerCt._visible = true;
      TopPlayerCt._y = _loc14_._y + _loc14_._height / 2;
   }
   else
   {
      TopPlayerCt._visible = false;
   }
   if(_loc9_[0].Data != 0 && _loc9_[0].Data > 2)
   {
      TopPlayerT.transform.colorTransform = T_ColorTransform0;
      TopPlayerT._visible = true;
      TopPlayerT._y = _loc13_._y + _loc13_._height / 2;
   }
   else
   {
      TopPlayerT._visible = false;
   }
}
function RemoveToolTipHitArea(GraphToDisplayBtn)
{
   var _loc4_ = GraphToDisplayBtn._pIndex;
   var _loc5_ = _global.CScaleformComponent_MatchStats.GetDataSeriesPointCount(m_strTypeDropdown,_loc4_);
   trace("-----------------------NO-GraphToDisplayBtn._pIndex----------------------" + _loc4_);
   if(mcRound15._visible)
   {
      _loc5_ = 30;
   }
   var _loc3_ = 0;
   while(_loc3_ <= _loc5_)
   {
      this["RolloverHitArea" + _loc4_ + _loc3_].swapDepths(this.getNextHighestDepth());
      this["RolloverHitArea" + _loc4_ + _loc3_].removeMovieClip();
      _loc3_ = _loc3_ + 1;
   }
}
function SetLineStyle(GraphToDisplayBtn, Team, bIsTeam, bIsRollOver)
{
   var _loc2_ = this[GraphToDisplayBtn._GraphName];
   _loc2_.clear();
   if(bIsRollOver)
   {
      var _loc3_ = 45;
      if(Team == TEAMCT)
      {
         _loc2_.lineStyle(2,parseInt(CTColor0),_loc3_);
      }
      else if(Team == TEAMT)
      {
         _loc2_.lineStyle(2,parseInt(TColor0),_loc3_);
      }
      return undefined;
   }
   _loc3_ = 100;
   if(!bIsTeam)
   {
      _loc2_.lineStyle(2,parseInt(GraphToDisplayBtn._Color),_loc3_);
   }
   else if(Team == TEAMCT)
   {
      _loc2_.lineStyle(8,parseInt(CTteamColor0),_loc3_);
   }
   else if(Team == TEAMT)
   {
      _loc2_.lineStyle(8,parseInt(TteamColor0),_loc3_);
   }
}
function CheckShowCheckedPlayersGraph(objButton)
{
   if(objButton.Selected._visible == false)
   {
      this[objButton._GraphName]._visible = false;
   }
   else
   {
      this[objButton._GraphName]._visible = true;
   }
}
function RGBtoHEX(r, g, b)
{
   var _loc1_ = r << 16 | g << 8 | b;
   return _loc1_;
}
var TEAMT = 2;
var TEAMCT = 3;
var m_XSpacing;
var m_bShowDefaultSelections = true;
var aFilterTypes = [];
var aSelectedPlayersCt = [];
var aSelectedPlayersT = [];
var m_strTypeDropdown = _global.CScaleformComponent_MatchStats.GetRangeNameByIndex(0);
var CTColor0 = "0x54819E";
var CTColor1 = "0x5658A9";
var TColor0 = "0x947E28";
var TColor1 = "0x9D4839";
var CTteamColor0 = "0x243742";
var TteamColor0 = "0x443011";
var T_ColorTransform0 = new flash.geom.ColorTransform();
T_ColorTransform0.rgb = parseInt(TColor0);
var CT_ColorTransform0 = new flash.geom.ColorTransform();
CT_ColorTransform0.rgb = parseInt(CTColor0);
var White = new flash.geom.ColorTransform();
White.rgb = 13421772;
Tooltip._visible = false;
var i = 0;
while(i <= 4)
{
   this["ct" + i].Selected._visible = false;
   this["ct" + i].ButtonTextSelected._visible = false;
   this["t" + i].Selected._visible = false;
   this["t" + i].ButtonTextSelected._visible = false;
   i++;
}
stop();
