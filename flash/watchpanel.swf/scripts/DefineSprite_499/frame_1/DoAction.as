function SetUpTournamentInfo(PlayerXuid, strEventId, bIsPlayerPickEm, bIsFantasyGame)
{
   var _loc3_ = 0;
   Old._visible = false;
   Btn0._visible = false;
   Btn1._visible = false;
   Btn2._visible = false;
   PickStatusPanel._visible = false;
   Leaderboard._visible = false;
   if(strEventId.indexOf("tournament:") != -1)
   {
      var _loc8_ = strEventId.split(":");
   }
   _loc3_ = _loc8_[1];
   m_numTournamentID = _loc3_;
   UnBlurTournamentPanel(_loc3_);
   var _loc5_ = _global.CScaleformComponent_Predictions.GetEventSectionsCount(strEventId);
   var _loc7_ = _global.CScaleformComponent_Predictions.GetMyPredictionsLoaded(strEventId);
   _global.CScaleformComponent_Fantasy.GetMyFantasyTeamsCount(strEventId);
   if(_loc5_ == 0 || _loc5_ == undefined || _loc5_ == null || !_loc7_)
   {
      this._visible = false;
      return undefined;
   }
   HideTournamentBrackets();
   SetInfo(_loc3_,bIsPlayerPickEm,bIsFantasyGame);
   SetUpInfoButtons(_loc3_,strEventId,bIsPlayerPickEm,bIsFantasyGame);
   ShowTournamentInfo();
   if(bIsFantasyGame)
   {
      this.FantasyTeam._visible = true;
      SetUpFantasyGame(PlayerXuid,strEventId,_loc3_);
      SetFantasyScore(strEventId,_loc3_,PlayerXuid);
   }
   else
   {
      m_bCanHideGroupTooltip = true;
      SetUpStages(_loc3_,_loc5_,strEventId,PlayerXuid,bIsPlayerPickEm);
      SetScore(strEventId,_loc3_);
   }
}
function ShowTournamentInfo()
{
   this._visible = true;
   new Lib.Tween(this,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,2,true);
}
function SetScore(strEventId, numTournamentID)
{
   var _loc2_ = _global.CScaleformComponent_Predictions.GetMyPredictionsTotalPoints(strEventId);
   var _loc9_ = _global.CScaleformComponent_Predictions.GetRequiredPredictionsPointsBronze(strEventId);
   var _loc7_ = _global.CScaleformComponent_Predictions.GetRequiredPredictionsPointsSilver(strEventId);
   var _loc6_ = _global.CScaleformComponent_Predictions.GetRequiredPredictionsPointsGold(strEventId);
   var _loc8_ = undefined;
   var _loc3_ = _global.GameInterface.Translate("#CSGO_PickEm_Trophy_Status");
   Info.TrophyTitle.htmlText = "#CSGO_PickEm_Trophy_Title";
   if(numTournamentID == 7)
   {
      var _loc4_ = _global.GameInterface.Translate("#CSGO_PickEm_Trophy_Combined_Score");
   }
   else
   {
      _loc4_ = _global.GameInterface.Translate("#CSGO_PickEm_Trophy_Your_Score");
   }
   if(_loc2_ == 0 || _loc2_ == undefined)
   {
      _loc4_ = _global.ConstructString(_loc4_,"-");
   }
   else
   {
      _loc4_ = _global.ConstructString(_loc4_,_loc2_);
   }
   Info.Points.htmlText = _loc4_;
   _global.AutosizeTextDown(Points,8);
   if(_loc2_ < _loc9_)
   {
      _loc3_ = _global.ConstructString(_loc3_,_loc9_ - _loc2_,_global.GameInterface.Translate("#CSGO_PickEm_Trophy_level_Bronze"));
      Info.PointsNeeded.htmlText = _loc3_;
      Trophy._visible = false;
      NoPicks._visible = true;
      return undefined;
   }
   if(_loc2_ >= _loc9_ && _loc2_ < _loc7_)
   {
      _loc3_ = _global.ConstructString(_loc3_,_loc7_ - _loc2_,_global.GameInterface.Translate("#CSGO_PickEm_Trophy_level_Silver"));
      _loc8_ = GetTrophyIconPath(strEventId) + "bronze.png";
   }
   else if(_loc2_ >= _loc7_ && _loc2_ < _loc6_)
   {
      _loc3_ = _global.ConstructString(_loc3_,_loc6_ - _loc2_,_global.GameInterface.Translate("#CSGO_PickEm_Trophy_level_Gold"));
      _loc8_ = GetTrophyIconPath(strEventId) + "silver.png";
   }
   else if(_loc2_ >= _loc6_)
   {
      _loc8_ = GetTrophyIconPath(strEventId) + "gold.png";
   }
   if(_loc2_ >= _loc6_)
   {
      Info.PointsNeeded.htmlText = "#CSGO_PickEm_Trophy_Status_Gold";
   }
   else
   {
      Info.PointsNeeded.htmlText = _loc3_;
   }
   LoadImage(_loc8_,Trophy,64,48,false);
   Trophy._visible = true;
   NoPicks._visible = false;
   Info.Points._visible = true;
   Info.PointsNeeded._visible = true;
}
function GetTrophyIconPath(strEventId)
{
   if(strEventId == "tournament:4")
   {
      return "econ/status_icons/cologne_prediction_";
   }
   if(strEventId == "tournament:5")
   {
      return "econ/status_icons/dhw14_prediction_";
   }
   if(strEventId == "tournament:6")
   {
      return "econ/status_icons/kat_2015_prediction_";
   }
   if(strEventId == "tournament:7")
   {
      return "econ/status_icons/col_2015_prediction_";
   }
   if(strEventId == "tournament:8")
   {
      return "econ/status_icons/cluj_2015_prediction_";
   }
   if(strEventId == "tournament:9")
   {
      return "econ/status_icons/mlg_2016_pickem_";
   }
   if(strEventId == "tournament:10")
   {
      return "econ/status_icons/cologne_pickem_2016_";
   }
}
function SetInfo(numTournament, bIsPlayerPickEm, bIsFantasyGame)
{
   if(bIsPlayerPickEm)
   {
      var _loc2_ = "Player_";
   }
   else if(bIsFantasyGame)
   {
      _loc2_ = "Fantasy_";
   }
   else
   {
      _loc2_ = "";
   }
   Info.Title.htmlText = "#CSGO_Team_PickEm_Title_" + _loc2_ + numTournament;
   Info.Desc.htmlText = "#CSGO_PickEm_Desc_Tournament_" + _loc2_ + numTournament;
   _global.AutosizeTextDown(Desc,7);
   _global.AutosizeTextDown(MoneyDesc,8);
   var _loc4_ = "econ/tournaments/team_stickers_banner_" + numTournament + ".png";
   LoadImage(_loc4_,BgImage,768,512,false);
   BgImage._alpha = 60;
}
function SetUpInfoButtons(numTournamentID, strEventId, bIsPlayerPickEm, bIsFantasyGame)
{
   LeaderboardsBtn.dialog = this;
   LeaderboardsBtn._EventID = strEventId;
   if(bIsFantasyGame)
   {
      LeaderboardsBtn.SetText("#CSGO_Watch_Fantasy_Leaderboards");
   }
   else
   {
      LeaderboardsBtn.SetText("#CSGO_Watch_PickEm_Leaderboards");
   }
   LeaderboardsBtn.Action = function()
   {
      this.dialog.ShowLeaderboard(this._EventID,bIsFantasyGame);
   };
   Store.dialog = this;
   Store.SetText("#CSGO_PickEm_Buy");
   if(IsCurrentTournament(numTournamentID) && GetTournamentWinner(strEventId) == "")
   {
      var _loc4_ = "images/ui_icons/";
      Store.Action = function()
      {
         this.dialog.ShowStore();
      };
      Store.setDisabled(false);
      Old._visible = false;
      _global.AutosizeTextDown(MoneyDesc,6);
      SetTopInfoBtns(24,numTournamentID,bIsFantasyGame,true);
   }
   else
   {
      Store.setDisabled(true);
      Old._visible = true;
      SetTopInfoBtns(24,numTournamentID,bIsFantasyGame,false);
   }
   BtnBack.dialog = this;
   BtnBack._visible = false;
   BtnBack.Action = function()
   {
      this.dialog.ScrollBracket(false,numTournamentID);
   };
   BtnNext.dialog = this;
   BtnNext._visible = false;
   BtnNext.Action = function()
   {
      this.dialog.ScrollBracket(true,numTournamentID);
   };
   if(numTournamentID >= 8 && !bIsFantasyGame && !bIsPlayerPickEm)
   {
      BtnNext._visible = true;
   }
}
function ScrollBracket(bNext, numTournamentID)
{
   var _loc2_ = this["Bracket" + numTournamentID];
   if(bNext)
   {
      BtnNext._visible = false;
      var _loc3_ = new Lib.Tween(_loc2_,"_x",mx.transitions.easing.Strong.easeOut,0,-216,0.5,true);
      _loc3_.onMotionFinished = function()
      {
         if(m_numTournamentID >= 8)
         {
            BtnBack._visible = true;
         }
      };
   }
   else
   {
      BtnBack._visible = false;
      _loc3_ = new Lib.Tween(_loc2_,"_x",mx.transitions.easing.Strong.easeOut,-216,0,0.5,true);
      _loc3_.onMotionFinished = function()
      {
         if(m_numTournamentID >= 8)
         {
            BtnNext._visible = true;
         }
      };
   }
}
function ResetBracketTween(numTournamentID)
{
   var _loc2_ = this["Bracket" + numTournamentID];
   this.stop();
   this[Lib.Tween].stop();
   this.gotoAndStop(0);
   this.Tween.stop();
   this.Move.stop();
}
function ShowStore()
{
   _global.MainMenuMovie.Panel.StoreListerPanel.ShowPanel(false);
}
function SetTopInfoBtns(numLeftOffset, numTournamentID, bIsFantasyGame, bShow)
{
   var _loc4_ = new Array();
   var _loc7_ = "images/ui_icons/";
   if(bShow)
   {
      _loc4_.push("info");
      _loc4_.push("external_link");
   }
   var _loc3_ = 0;
   while(_loc3_ < 3)
   {
      var _loc2_ = this["Btn" + _loc3_];
      if(_loc3_ >= _loc4_.length)
      {
         _loc2_._visible = false;
      }
      else
      {
         _loc2_.dialog = this;
         _loc2_._visible = true;
         _loc2_._alpha = 100;
         _loc2_.SetText("#CSGO_Watch_Tournament_Info_" + _loc4_[_loc3_]);
         _loc2_._Type = _loc4_[_loc3_];
         _loc2_.ButtonText.Text.autoSize = "left";
         _loc2_.ButtonText.Text._x = 20;
         _loc2_.Action = function()
         {
            this.dialog.onPressActionButton(this,bIsFantasyGame);
         };
         LoadImage(_loc7_ + _loc4_[_loc3_] + ".png",_loc2_.ImageHolder,28,28,false);
         if(_loc3_ == 0)
         {
            _loc2_._x = 760 - (numLeftOffset + _loc2_._width);
         }
         else
         {
            var _loc5_ = this["Btn" + (_loc3_ - 1)];
            _loc2_._x = _loc5_._x - (_loc2_._width + numLeftOffset);
         }
      }
      _loc3_ = _loc3_ + 1;
   }
}
function onPressActionButton(objBtn, bIsFantasyGame)
{
   switch(objBtn._Type)
   {
      case "info":
         if(bIsFantasyGame)
         {
            _global.CScaleformComponent_SteamOverlay.OpenURL("http://www.counter-strike.net/pickem/cologne2016#player_instructions");
         }
         else
         {
            _global.CScaleformComponent_SteamOverlay.OpenURL("http://www.counter-strike.net/pickem/cologne2016#team_instructions");
         }
         break;
      case "external_link":
         _global.CScaleformComponent_SteamOverlay.OpenURL("http://en.esl-one.com/csgo/cologne-2016/");
   }
}
function HideTournamentBrackets()
{
   var _loc3_ = this._parent.GetEventIdFromListerType(this._parent.DEFAULT_TOURNAMENT_ID);
   var _loc2_ = 1;
   while(_loc2_ <= _loc3_)
   {
      var _loc4_ = this["Bracket" + _loc2_];
      _loc4_._visible = false;
      _loc2_ = _loc2_ + 1;
   }
   _loc2_ = 1;
   while(_loc2_ <= _loc3_)
   {
      _loc4_ = this["PlayerBracket" + _loc2_];
      _loc4_._visible = false;
      _loc2_ = _loc2_ + 1;
   }
   _loc4_ = this.FantasyTeam;
   if(_loc4_)
   {
      _loc4_._visible = false;
   }
}
function SetUpStages(numTournamentID, numSections, strEventId, PlayerXuid, bIsPlayerPickEm)
{
   if(bIsPlayerPickEm)
   {
      var _loc5_ = this["PlayerBracket" + numTournamentID];
   }
   else
   {
      _loc5_ = this["Bracket" + numTournamentID];
   }
   _loc5_._visible = true;
   var _loc3_ = 0;
   while(_loc3_ < numSections)
   {
      var _loc7_ = _global.CScaleformComponent_Predictions.GetEventSectionIDByIndex(strEventId,_loc3_);
      var _loc15_ = _global.CScaleformComponent_Predictions.GetSectionIsActive(strEventId,_loc7_);
      var _loc14_ = _loc5_["TitleDay" + _loc3_];
      var _loc10_ = _loc5_["PointsDay" + _loc3_];
      _loc14_.htmlText = _global.CScaleformComponent_Predictions.GetSectionName(strEventId,_loc7_);
      if(bIsPlayerPickEm)
      {
         var _loc18_ = "images/ui_icons/";
         var _loc11_ = _loc5_["StatDay" + _loc3_];
         _loc11_.htmlText = "<font color= \'#89B2D2\'>" + _global.GameInterface.Translate("#CSGO_PickEm_Stat_Tournament_" + numTournamentID + "_" + _loc3_) + "</font>";
      }
      else
      {
         var _loc12_ = _loc5_["DateDay" + _loc3_];
         if(numTournamentID == 9 && _loc3_ > 2)
         {
            var _loc13_ = _global.GameInterface.Translate("#CSGO_Tournament_Month_" + numTournamentID + "_1");
            _loc13_ = _global.ConstructString(_loc13_,_global.CScaleformComponent_Predictions.GetSectionDesc(strEventId,_loc7_));
         }
         else if(numTournamentID == 8 && _loc3_ == 4)
         {
            _loc13_ = _global.GameInterface.Translate("#CSGO_Tournament_Final_Date_" + numTournamentID);
         }
         else
         {
            _loc13_ = _global.GameInterface.Translate("#CSGO_Tournament_Month_" + numTournamentID);
            _loc13_ = _global.ConstructString(_loc13_,_global.CScaleformComponent_Predictions.GetSectionDesc(strEventId,_loc7_));
         }
         _loc12_.htmlText = _loc13_;
      }
      SetUpGroups(_loc5_,numTournamentID,strEventId,_loc7_,_loc3_,PlayerXuid,bIsPlayerPickEm);
      var _loc16_ = UpdatePointsForGroup(strEventId,_loc7_);
      var _loc8_ = _global.GameInterface.Translate("#CSGO_PickEm_Points_Earn");
      _loc8_ = _global.ConstructString(_loc8_,_loc16_);
      if(_loc15_ && IsCurrentTournament(numTournamentID) && GetTournamentWinner(strEventId) == "")
      {
         var _loc9_ = "<font color= \'#FFFFFF\'><b>" + _global.GameInterface.Translate("#CSGO_PickEm_Active") + "</b></font>";
         _loc9_ = _global.ConstructString(_loc9_,_loc8_);
         _loc5_["SelectedDay" + _loc3_]._visible = true;
         _loc10_._alpha = 100;
         _loc12_._alpha = 100;
         _loc11_._alpha = 100;
         _loc14_._alpha = 100;
      }
      else
      {
         _loc9_ = _loc8_;
         _loc5_["SelectedDay" + _loc3_]._visible = false;
         _loc10_._alpha = 40;
         _loc12_._alpha = 40;
         _loc11_._alpha = 40;
         _loc14_._alpha = 40;
      }
      if(_loc15_ && _loc3_ > 1 && numTournamentID >= 8 && _loc5_._x >= -100)
      {
         ScrollBracket(true,numTournamentID);
      }
      else if(numTournamentID >= 8)
      {
         _loc5_._x = 0;
         ResetBracketTween(numTournamentID);
      }
      _loc10_.htmlText = _loc9_;
      _global.AutosizeTextDown(_loc10_,8);
      _loc3_ = _loc3_ + 1;
   }
   LoadImage(GetChampionTrophyIconPath(strEventId),_loc5_.Trophy,32,32,false);
   SetOldWinnelPanel(_loc5_,strEventId);
}
function UpdatePointsForGroup(strEventId, numDayID)
{
   var _loc3_ = _global.CScaleformComponent_Predictions.GetSectionGroupIDByIndex(strEventId,numDayID,0);
   var _loc2_ = _global.CScaleformComponent_Predictions.GetGroupPickWorth(strEventId,_loc3_);
   return _loc2_;
}
function SetUpGroups(objBracket, numTournamentID, strEventId, numDayID, numIndex, PlayerXuid, bIsPlayerPickEm)
{
   var _loc23_ = _global.CScaleformComponent_Predictions.GetSectionGroupsCount(strEventId,numDayID);
   trace("----------------------------numDayID-----------------------------" + numDayID);
   trace("----------------------------numIndex-----------------------------" + numIndex);
   var _loc6_ = 0;
   while(_loc6_ < _loc23_)
   {
      var _loc16_ = _global.CScaleformComponent_Predictions.GetEventSectionsCount(strEventId);
      var _loc5_ = _global.CScaleformComponent_Predictions.GetSectionGroupIDByIndex(strEventId,numDayID,_loc6_);
      var _loc18_ = _global.CScaleformComponent_Predictions.GetGroupPicksCount(strEventId,_loc5_);
      var _loc10_ = _global.CScaleformComponent_Predictions.GetGroupTeamsCount(strEventId,_loc5_);
      var _loc15_ = false;
      var _loc24_ = _global.CScaleformComponent_Predictions.GetGroupMatchesLiveCount(strEventId,_loc5_);
      var _loc8_ = _loc24_.split(",");
      if(_loc6_ == _loc23_ - 1 && numIndex == _loc16_ - 1)
      {
         _loc15_ = true;
         if(_loc10_ > 2)
         {
            var _loc3_ = objBracket["Day" + numIndex + "_" + _loc6_ + "_Alt"];
            var _loc21_ = objBracket["Day" + numIndex + "_" + _loc6_];
         }
         else
         {
            _loc3_ = objBracket["Day" + numIndex + "_" + _loc6_];
            _loc21_ = objBracket["Day" + numIndex + "_" + _loc6_ + "_Alt"];
         }
      }
      else
      {
         _loc3_ = objBracket["Day" + numIndex + "_" + _loc6_];
      }
      if(m_bCanHideGroupTooltip)
      {
         _loc3_.ToolTip._visible = false;
      }
      _loc21_._visible = false;
      _loc3_._visible = true;
      if(_loc8_[0] != "" && _loc8_[0] != undefined && _loc8_[0] != "0")
      {
         _loc3_.Live.dialog = this;
         _loc3_.Live._MatchId = _loc8_[0];
         _loc3_.Live.Action = function()
         {
            this.dialog.OnWatch(this._MatchId);
         };
         _loc3_.Live._visible = true;
      }
      else
      {
         _loc3_.Live._visible = false;
      }
      if(_loc18_ > 0)
      {
         var _loc25_ = _global.CScaleformComponent_Predictions.GetGroupPickWorth(strEventId,_loc5_);
         var _loc13_ = _global.CScaleformComponent_Predictions.GetGroupName(strEventId,_loc5_);
         var _loc11_ = _global.CScaleformComponent_Predictions.GetGroupCanPick(strEventId,_loc5_);
         var _loc20_ = _global.CScaleformComponent_Predictions.GetGroupTeamsPickableCount(strEventId,_loc5_);
         _loc3_._PickableCount = _loc20_;
         _loc3_._ID = _loc5_;
         _loc3_._DayIndex = numIndex;
         _loc3_._GroupIndex = _loc6_;
         _loc3_._NumTeams = _loc10_;
         _loc3_._IsLastGroupOfLastBay = _loc15_;
         if(numIndex > 0 || strEventId == "tournament:4" || numTournamentID >= 8)
         {
            _loc3_.GroupName._visible = false;
         }
         else
         {
            _loc3_.GroupName.htmlText = "#CSGO_MatchInfo_Stage_" + _loc13_;
            _loc3_.GroupName._visible = true;
         }
         if(numIndex <= 1 && strEventId == "tournament:7")
         {
            _loc3_.GroupName.htmlText = "#CSGO_MatchInfo_Stage_" + _loc13_;
            _loc3_.GroupName._visible = true;
         }
         if(bIsPlayerPickEm)
         {
            SetPlayerPredictionStatus(_loc3_,numTournamentID,numDayID,numIndex,strEventId,_loc5_,_loc11_);
         }
         else
         {
            SetTeamPredictionStatus(_loc3_,strEventId,_loc5_,PlayerXuid);
         }
         var _loc17_ = SetUpTeams(_loc3_,numTournamentID,strEventId,numDayID,_loc5_,_loc11_,PlayerXuid,bIsPlayerPickEm);
         if(_loc11_ && _loc17_ < _loc10_)
         {
            _loc3_.Selected._alpha = 70;
         }
         else
         {
            _loc3_.Selected._alpha = 20;
         }
      }
      else
      {
         _loc24_ = _global.CScaleformComponent_Predictions.GetGroupMatchesLiveCount(strEventId,_loc5_);
         _loc3_.GroupName._visible = false;
         _loc3_.Pick0._visible = false;
         _loc3_.PickBg._visible = false;
         _loc3_.Selected.Pick._visible = false;
         _loc3_.Selected._alpha = 20;
         SetUpTeams(_loc3_,numTournamentID,strEventId,numDayID,_loc5_,false,PlayerXuid,bIsPlayerPickEm);
      }
      _loc6_ = _loc6_ + 1;
   }
}
function SetUpTeams(objGroup, numTournamentID, strEventId, numDayID, numGroupId, bCanPick, PlayerXuid, bIsPlayerPickEm)
{
   var _loc15_ = _global.CScaleformComponent_Predictions.GetGroupTeamsCount(strEventId,numGroupId);
   var _loc14_ = 0;
   var objPlayPickPanel = objGroup._parent.PlayerPick;
   onHidePlayerPickPanel(objPlayPickPanel);
   var _loc5_ = 0;
   while(_loc5_ < _loc15_)
   {
      var _loc11_ = "econ/tournaments/teams/";
      var _loc3_ = objGroup["Team" + _loc5_];
      var _loc7_ = _global.CScaleformComponent_Predictions.GetGroupTeamIDByIndex(strEventId,numGroupId,_loc5_);
      var _loc10_ = _global.CScaleformComponent_Predictions.GetGroupTeamIsCorrectPickByIndex(strEventId,numGroupId,_loc5_);
      var _loc4_ = _global.CScaleformComponent_Predictions.GetTeamName(_loc7_);
      var _loc6_ = _global.CScaleformComponent_Predictions.GetTeamTag(_loc7_);
      trace("-------------------------------------srtTeamTag--------------------------------" + _loc6_);
      trace("-------------------------------------strTeamName--------------------------------" + _loc4_);
      _loc3_.dialog = this;
      if(_loc4_ == "" || _loc4_ == undefined || _loc4_ == null)
      {
         _loc3_.TeamIcon._visible = false;
         _loc3_.Add._visible = false;
         _loc3_.AddSticker._visible = false;
         _loc3_.Remove._visible = false;
         _loc3_.SetText("#CSGO_PickEm_Team_TBD");
         _loc3_.setDisabled(true);
         _loc3_._parent.Hint._visible = false;
         _loc14_ = _loc14_ + 1;
      }
      else
      {
         _loc6_ = _loc6_.toLowerCase();
         LoadImage(_loc11_ + _loc6_ + ".png",_loc3_.TeamIcon,32,32,false);
         _loc3_.TeamIcon._visible = true;
         _loc3_._TeamID = _loc7_;
         _loc3_._GroupID = numGroupId;
         _loc3_._EventID = strEventId;
         _loc3_._TournamentID = numTournamentID;
         _loc3_._TeamName = _loc4_;
         _loc3_._TeamTag = _loc6_;
         _loc3_._DayID = numDayID;
         if(!bIsPlayerPickEm)
         {
            _loc3_.SetText(_loc4_);
            _global.AutosizeTextDown(_loc3_.ButtonText.Text,7);
            _loc3_._parent.Hint._visible = false;
            SetUpGroupToolTip(_loc3_,strEventId,numGroupId,"team",bCanPick);
            SetTeamWinnerState(_loc3_,_loc10_);
            SetTeamPrediction(objGroup,_loc3_,strEventId,numGroupId,_loc7_,PlayerXuid,_loc10_,bCanPick);
         }
         else if(!bCanPick)
         {
            _loc3_.setDisabled(true);
         }
         else
         {
            _loc3_.Action = function()
            {
               this.dialog.SetUpPlayerPickPanel(this,objPlayPickPanel);
            };
            if(GetEmptyPredictionSlotForGroup(_loc3_,"player") == null)
            {
               _loc3_.setDisabled(true);
            }
            else
            {
               _loc3_.setDisabled(false);
            }
         }
      }
      _loc5_ = _loc5_ + 1;
   }
   return _loc14_;
}
function SetUpGroupToolTip(objSelection, strEventId, numGroupId, SlotType, bCanPick)
{
   if(bCanPick && GetEmptyPredictionSlotForGroup(objSelection,SlotType) != null)
   {
      var _loc5_ = GetNextStageName(strEventId,objSelection._parent._DayIndex);
      if(SlotType == "team")
      {
         var strHeader = _global.GameInterface.Translate("#CSGO_PickEm_Rules_Tooltip");
         var _loc4_ = _global.GameInterface.Translate("#CSGO_PickEm_Rules_ThisMatch");
      }
      else
      {
         var strHeader = _global.GameInterface.Translate("#CSGO_PickEm_Rules_Player_Tooltip");
         _loc4_ = _global.GameInterface.Translate("#CSGO_PickEm_Stat_Tournament_" + objSelection._TournamentID + "_" + objSelection._parent._DayIndex);
      }
      strHeader = _global.ConstructString(strHeader,_loc4_);
      objSelection.RolledOver = function()
      {
         ShowHideGroupToolTip(this._parent,true,strHeader);
      };
      objSelection.RolledOut = function()
      {
         ShowHideGroupToolTip(this._parent,false,strHeader);
      };
   }
   else
   {
      objSelection.RolledOver = function()
      {
      };
      objSelection.RolledOut = function()
      {
      };
   }
}
function SetTeamWinnerState(objTeam, bIsWinner)
{
   if(bIsWinner)
   {
      objTeam.ButtonText._alpha = 100;
      objTeam.TeamIcon._alpha = 100;
   }
}
function SetTeamPrediction(objGroup, objTeam, strEventId, numGroupId, numTeamId, PlayerXuid, bIsWinner, bCanPick)
{
   var _loc4_ = IsSelectionAlreadyAPrediction(strEventId,numGroupId,numTeamId,"team");
   if(!bCanPick)
   {
      objTeam.setDisabled(true);
      objTeam.Add._visible = false;
      objTeam.AddSticker._visible = false;
      objTeam.Remove._visible = false;
      return undefined;
   }
   objTeam.setDisabled(false);
   if(GetEmptyPredictionSlotForGroup(objTeam,"team") != null)
   {
      if(_loc4_)
      {
         objTeam.Action = function()
         {
            this.dialog.onMakePick(this,true,"");
         };
      }
      else
      {
         objTeam.Action = function()
         {
            this.dialog.onMakePick(this,false,"");
         };
      }
      objTeam.AddSticker._visible = false;
      objTeam.Remove._visible = _loc4_;
      objTeam.Add._visible = !_loc4_;
      var _loc5_ = _global.CScaleformComponent_Predictions.GetMyPredictionItemIDForTeamID(strEventId,numTeamId);
      if(_loc5_ != "" && _loc5_ != undefined && _loc5_ != 0 && _loc5_ != "0")
      {
         objTeam.AddSticker._visible = !_loc4_;
      }
   }
   else
   {
      if(_loc4_)
      {
         objTeam.Action = function()
         {
            this.dialog.onMakePick(this,true,"");
         };
      }
      else
      {
         objTeam.setDisabled(true);
      }
      objTeam.Remove._visible = _loc4_;
      objTeam.Add._visible = false;
      objTeam.AddSticker._visible = false;
   }
}
function SetTeamPredictionStatus(objGroup, strEventId, numGroupId, PlayerXuid)
{
   var _loc12_ = _global.CScaleformComponent_Predictions.GetGroupPicksCount(strEventId,numGroupId);
   var _loc5_ = 0;
   while(_loc5_ < _loc12_)
   {
      var _loc2_ = objGroup["Pick" + _loc5_];
      _loc2_._visible = false;
      if(TournamentOverrideForTypeOfPickSlot(strEventId,numGroupId,_loc5_) == "team")
      {
         var _loc3_ = _global.CScaleformComponent_Predictions.GetMyPredictionTeamID(strEventId,numGroupId,_loc5_);
         if(_loc3_ != "" && _loc3_ != undefined && _loc3_ != null && _loc3_ != 0)
         {
            var _loc8_ = _global.CScaleformComponent_Predictions.GetFakeItemIDToRepresentTeamID(strEventId,_loc3_);
            var _loc9_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(PlayerXuid,_loc8_) + ".png";
            LoadImage(_loc9_,_loc2_.Icon,24,18,false);
            _loc2_._visible = true;
            var _loc4_ = _global.CScaleformComponent_Predictions.GetGroupCorrectPicksByIndex(strEventId,numGroupId,0);
            if(_loc4_ != "" && _loc4_ != undefined && _loc4_ != null && _loc4_ != 0)
            {
               var _loc11_ = _loc4_.split(",");
               var _loc10_ = IsTeamPredictionCorrect(_loc11_,_loc3_.toString());
               _loc2_.Correct._visible = _loc10_;
            }
            else
            {
               _loc2_.Correct._visible = false;
            }
         }
         _loc2_._xscale = 100;
         _loc2_._yscale = 100;
      }
      _loc5_ = _loc5_ + 1;
   }
}
function SetPlayerPredictionStatus(objGroup, numTournamentID, numDayID, numIndex, strEventId, numGroupId, bCanPick)
{
   var _loc25_ = _global.CScaleformComponent_Predictions.GetGroupPicksCount(strEventId,numGroupId);
   var _loc9_ = "econ/tournaments/players/";
   var _loc8_ = false;
   var _loc24_ = false;
   objGroup.Winners.ToolTip._visible = false;
   var _loc5_ = 0;
   while(_loc5_ < _loc25_)
   {
      var _loc3_ = objGroup.PlayerBtn;
      if(TournamentOverrideForTypeOfPickSlot(strEventId,numGroupId,_loc5_) == "player")
      {
         var _loc6_ = _global.CScaleformComponent_Predictions.GetMyPredictionTeamID(strEventId,numGroupId,_loc5_);
         var _loc19_ = false;
         var _loc10_ = _global.CScaleformComponent_Predictions.GetGroupCorrectPicksByIndex(strEventId,numGroupId,1);
         if(_loc10_ != "" && _loc10_ != undefined && _loc10_ != null && _loc10_ != 0)
         {
            _loc19_ = true;
         }
         _loc3_.dialog = this;
         _loc3_._EventID = strEventId;
         _loc3_._GroupID = numGroupId;
         _loc3_._TournamentID = Number(numTournamentID);
         _loc3_._DayID = numDayID;
         if(_loc6_ != "" && _loc6_ != undefined && _loc6_ != null && _loc6_ != 0)
         {
            _loc8_ = true;
            var _loc14_ = _global.CScaleformComponent_Predictions.GetProPlayerCode(_loc6_);
            var _loc16_ = _global.CScaleformComponent_Predictions.GetProPlayerNick(_loc6_);
            var _loc11_ = _global.CScaleformComponent_Predictions.GetProPlayerTeamIDForEventID(_loc6_,Number(numTournamentID));
            trace("--------------------------------------------strPlayerCode----------------------------" + _loc14_);
            trace("--------------------------------------------PredictedSteamId----------------------------" + _loc6_);
            var _loc23_ = _global.CScaleformComponent_Predictions.GetFakeItemIDToRepresentPlayerID(strEventId,_loc6_);
            var _loc21_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(m_PlayerXuid,_loc23_) + ".png";
            LoadImage(_loc21_,_loc3_.Sticker.Icon,32,23,false);
            LoadImage(_loc9_ + _loc14_ + ".png",_loc3_.PickIcon.Icon,32,32,false);
            _loc3_._SteamID = _loc6_;
            _loc3_._TeamID = _loc11_;
            _loc3_.SetText(_loc16_);
            _loc3_.Action = function()
            {
               this.dialog.onMakePick(this,true,this._SteamID);
            };
            if(_loc19_)
            {
               var _loc7_ = _loc10_.split(",");
               _loc24_ = IsTeamPredictionCorrect(_loc7_,_loc6_);
            }
         }
         if(_loc19_)
         {
            objGroup.Winner._visible = true;
            _loc7_ = _loc10_.split(",");
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               var _loc4_ = objGroup.Winners["Winner" + _loc5_];
               if(_loc5_ > _loc7_.length)
               {
                  _loc4_._visible = false;
               }
               else
               {
                  _loc14_ = _global.CScaleformComponent_Predictions.GetProPlayerCode(_loc7_[_loc5_]);
                  _loc9_ = "econ/tournaments/players/" + _loc14_ + ".png";
                  _loc16_ = _global.CScaleformComponent_Predictions.GetProPlayerNick(_loc7_[_loc5_]);
                  _loc11_ = _global.CScaleformComponent_Predictions.GetProPlayerTeamIDForEventID(_loc7_[_loc5_],Number(numTournamentID));
                  var _loc17_ = _global.CScaleformComponent_Predictions.GetTeamTag(Number(_loc11_));
                  var _loc13_ = "econ/tournaments/teams/" + _loc17_ + ".png";
                  var _loc15_ = _global.CScaleformComponent_Predictions.GetTeamName(Number(_loc11_));
                  _loc4_.dialog = this;
                  _loc4_._PlayerName = _loc16_;
                  _loc4_._ImagePath = _loc9_;
                  _loc4_._TeamImage = _loc13_;
                  _loc4_._TeamName = _loc15_;
                  _loc4_.onRollOver = function()
                  {
                     this.dialog.SetWinnerToolTip(objGroup.Winners.ToolTip,this);
                     objGroup.Winners.ToolTip._visible = true;
                  };
                  _loc4_.onRollOut = function()
                  {
                     objGroup.Winners.ToolTip._visible = false;
                  };
                  LoadImage(_loc9_,_loc4_,32,32,false);
                  _loc4_._visible = true;
               }
               _loc5_ = _loc5_ + 1;
            }
            if(_loc7_.length > 1)
            {
               objGroup.Winners.WinnerText.htmlText = "#CSGO_PickEm_Stat_Player_Winners";
            }
            else
            {
               objGroup.Winners.WinnerText.htmlText = "#CSGO_PickEm_Stat_Player_Winner";
            }
            _global.AutosizeTextDown(objGroup.Winners.WinnerText,7);
            objGroup.Winners._visible = true;
         }
         else
         {
            objGroup.Winners._visible = false;
         }
         _loc3_.Remove._visible = _loc8_ && bCanPick;
         _loc3_.Sticker._visible = _loc8_;
         _loc3_.PickIcon._visible = _loc8_;
         _loc3_.ButtonText._visible = _loc8_;
         _loc3_.PickIcon.Correct._visible = _loc24_;
         _loc3_.Bg._visible = _loc8_;
         _loc3_.Sticker._xscale = 140;
         _loc3_.Sticker._yscale = 140;
         _loc3_.Sticker.Correct._visible = false;
         SetUpGroupToolTip(_loc3_,strEventId,numGroupId,"player",bCanPick);
      }
      _loc3_.NoPick._visible = !_loc8_;
      _loc3_.Highlight._visible = _loc8_;
      objGroup.PlayerBtn.setDisabled(!bCanPick || !_loc8_);
      _loc5_ = _loc5_ + 1;
   }
}
function SetWinnerToolTip(objToolTip, objWinner)
{
   LoadImage(objWinner._ImagePath,objToolTip.Image,32,32,false);
   LoadImage(objWinner._TeamImage,objToolTip.Team,32,32,false);
   objToolTip.Name.htmlText = objWinner._PlayerName;
   _global.AutosizeTextDown(objToolTip.Name,8);
}
function HasTeamsInGroup(strEventId, numGroupId)
{
   var _loc6_ = _global.CScaleformComponent_Predictions.GetGroupTeamsCount(strEventId,numGroupId);
   var _loc5_ = 0;
   trace("---------------numTeams--------------------" + _loc6_);
   var _loc2_ = 0;
   while(_loc2_ < _loc6_)
   {
      var _loc4_ = _global.CScaleformComponent_Predictions.GetGroupTeamIDByIndex(strEventId,numGroupId,_loc2_);
      var _loc3_ = _global.CScaleformComponent_Predictions.GetTeamName(_loc4_);
      if(_loc3_ != "" && _loc3_ != undefined && _loc3_ != null)
      {
         _loc5_ = _loc5_ + 1;
      }
      _loc2_ = _loc2_ + 1;
   }
   if(_loc5_ != 0)
   {
      return true;
   }
   return false;
}
function IsTeamPredictionCorrect(aWinningTeamIds, PredictedId)
{
   var _loc1_ = 0;
   while(_loc1_ < aWinningTeamIds.length)
   {
      if(aWinningTeamIds[_loc1_] == PredictedId)
      {
         return true;
      }
      _loc1_ = _loc1_ + 1;
   }
   return false;
}
function GetSlotPrediction(strEventId, numGroupId, SelectionId, SlotType)
{
   var _loc6_ = _global.CScaleformComponent_Predictions.GetGroupPicksCount(strEventId,numGroupId);
   var _loc2_ = 0;
   while(_loc2_ < _loc6_)
   {
      if(TournamentOverrideForTypeOfPickSlot(strEventId,numGroupId,_loc2_) == SlotType)
      {
         var _loc5_ = _global.CScaleformComponent_Predictions.GetMyPredictionTeamID(strEventId,numGroupId,_loc2_);
      }
      _loc2_ = _loc2_ + 1;
   }
}
function IsSelectionAlreadyAPrediction(strEventId, numGroupId, SelectionId, SlotType)
{
   var _loc6_ = _global.CScaleformComponent_Predictions.GetGroupPicksCount(strEventId,numGroupId);
   var _loc2_ = 0;
   while(_loc2_ < _loc6_)
   {
      if(TournamentOverrideForTypeOfPickSlot(strEventId,numGroupId,_loc2_) == SlotType)
      {
         var _loc3_ = _global.CScaleformComponent_Predictions.GetMyPredictionTeamID(strEventId,numGroupId,_loc2_);
         if(SelectionId == _loc3_)
         {
            return true;
         }
      }
      _loc2_ = _loc2_ + 1;
   }
   return false;
}
function GetEmptyPredictionSlotForGroup(objSelection, SlotType)
{
   var _loc5_ = _global.CScaleformComponent_Predictions.GetGroupPicksCount(objSelection._EventID,objSelection._GroupID);
   var _loc2_ = 0;
   while(_loc2_ < _loc5_)
   {
      if(TournamentOverrideForTypeOfPickSlot(objSelection._EventID,objSelection._GroupID,_loc2_) == SlotType)
      {
         var _loc3_ = _global.CScaleformComponent_Predictions.GetMyPredictionTeamID(objSelection._EventID,objSelection._GroupID,_loc2_);
         if(_loc3_ <= 0 || _loc3_ == null || _loc3_ == undefined || _loc3_ == "")
         {
            return _loc2_;
         }
      }
      _loc2_ = _loc2_ + 1;
   }
   return null;
}
function GetTeamsPredictionSlot(objSelection, SlotType)
{
   var _loc7_ = _global.CScaleformComponent_Predictions.GetGroupPicksCount(objSelection._EventID,objSelection._GroupID);
   var _loc2_ = 0;
   while(_loc2_ < _loc7_)
   {
      if(TournamentOverrideForTypeOfPickSlot(objSelection._EventID,objSelection._GroupID,_loc2_) == SlotType)
      {
         if(SlotType == "player")
         {
            var _loc5_ = _global.CScaleformComponent_Predictions.GetMyPredictionTeamID(objSelection._EventID,objSelection._GroupID,_loc2_);
            if(_loc5_ == objSelection._SteamID)
            {
               return _loc2_;
            }
         }
         else
         {
            var _loc4_ = _global.CScaleformComponent_Predictions.GetMyPredictionTeamID(objSelection._EventID,objSelection._GroupID,_loc2_);
            if(_loc4_ == objSelection._TeamID)
            {
               return _loc2_;
            }
         }
      }
      _loc2_ = _loc2_ + 1;
   }
   return null;
}
function TournamentOverrideForTypeOfPickSlot(EventID, GroupID, numIndex)
{
   return _global.CScaleformComponent_Predictions.GetGroupPickTypeByIndex(EventID,GroupID,numIndex);
}
function LoadImage(imagePath, objImage, numWidth, numHeight, bCenterImage)
{
   var _loc1_ = new Object();
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
   };
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc4_ = imagePath;
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc4_,objImage.Image);
   if(bCenterImage)
   {
      objImage._x = (objImage._parent._width - numWidth) * 0.5;
   }
}
function ShowHideGroupToolTip(objGroup, bShow, strText)
{
   objGroup.ToolTip.Desc.Text.htmlText = strText;
   objGroup.ToolTip.Desc.Text.autoSize = "center";
   _global.AutosizeTextDown(objPlayPickPanel.Desc,7);
   objGroup.ToolTip.Desc._y = (objGroup.ToolTip.Background._height - objGroup.ToolTip.Desc.Text._height) / 2 - objGroup.ToolTip.Background._height / 2;
   objGroup.ToolTip._visible = bShow;
   if(bShow)
   {
      new Lib.Tween(objGroup.objTooltip,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
   }
}
function OnWatch(strMatchId)
{
   _global.CScaleformComponent_MatchInfo.Watch(strMatchId);
}
function SetUpPlayerPickPanel(objSelection, objPlayPickPanel)
{
   var _loc10_ = "econ/tournaments/players/";
   var _loc12_ = "econ/tournaments/teams/";
   var _loc11_ = Number(objSelection._TournamentID);
   var _loc14_ = Number(objSelection._TeamID);
   var _loc13_ = _global.CScaleformComponent_Predictions.GetProPlayersForEventIDTeamID(_loc11_,_loc14_);
   var _loc7_ = _loc13_.split(",");
   objPlayPickPanel.TeamName.htmlText = objSelection._TeamName;
   LoadImage(_loc12_ + objSelection._TeamTag + ".png",objPlayPickPanel.TeamIcon,32,32,false);
   objPlayPickPanel.Desc.htmlText = "#CSGO_PickEm_Stat_TournamentDesc_" + _loc11_ + "_" + objSelection._parent._DayIndex;
   objPlayPickPanel.Desc.autoSize = "left";
   _global.AutosizeTextDown(objPlayPickPanel.Desc,7);
   var _loc5_ = 0;
   while(_loc5_ < _loc7_.length)
   {
      var _loc4_ = objPlayPickPanel["Player" + _loc5_];
      var _loc8_ = _global.CScaleformComponent_Predictions.GetProPlayerCode(_loc7_[_loc5_]).toLowerCase();
      var _loc9_ = _global.CScaleformComponent_Predictions.GetProPlayerNick(_loc7_[_loc5_]);
      LoadImage(_loc10_ + _loc8_ + ".png",_loc4_.PlayerImage,32,32,false);
      _loc4_.dialog = this;
      _loc4_._PlayerCode = _loc8_;
      _loc4_._SteamID = _loc7_[_loc5_];
      _loc4_.SetText(_loc9_);
      _loc4_.Action = function()
      {
         this.dialog.onMakePick(objSelection,false,this._SteamID);
         onHidePlayerPickPanel(objPlayPickPanel);
      };
      var _loc6_ = _global.CScaleformComponent_Predictions.GetMyPredictionItemIDForTeamID(objSelection._EventID,objSelection._TeamID,_loc7_[_loc5_]);
      if(_loc6_ != "" && _loc6_ != undefined && _loc6_ != 0 && _loc6_ != "0")
      {
         _loc4_.HaveSticker.htmlText = "#CSGO_PickEm_Has_Stricker";
         _loc4_.HaveSticker._visible = true;
      }
      else
      {
         _loc4_.HaveSticker._visible = false;
      }
      _loc5_ = _loc5_ + 1;
   }
   objPlayPickPanel.Close.dialog = this;
   objPlayPickPanel.Close.Action = function()
   {
      this.dialog.onHidePlayerPickPanel(objPlayPickPanel);
   };
   PlacePlayerPickPanel(objSelection._parent,objPlayPickPanel);
   onShowPlayerPickPanel(objPlayPickPanel);
   objPlayPickPanel.Bg.onMouseUp = function()
   {
      if(!objPlayPickPanel.Bg.hitTest(_root._xmouse,_root._ymouse,true) && !objSelection._parent.hitTest(_root._xmouse,_root._ymouse,true))
      {
         onHidePlayerPickPanel(objPlayPickPanel);
      }
   };
}
function onShowPlayerPickPanel(objPlayPickPanel)
{
   objPlayPickPanel._visible = true;
   new Lib.Tween(objPlayPickPanel,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
}
function onHidePlayerPickPanel(objPlayPickPanel)
{
   var _loc1_ = new Lib.Tween(objPlayPickPanel,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,0.5,true);
   _loc1_.onMotionFinished = function()
   {
      objPlayPickPanel._visible = false;
   };
}
function PlacePlayerPickPanel(objGroup, objPlayPickPanel)
{
   var _loc3_ = 440;
   var _loc5_ = 740;
   var _loc4_ = 5;
   objPlayPickPanel._y = objGroup._y - objGroup.Selected._height / 2;
   objPlayPickPanel.Arrow._y = objPlayPickPanel._height / 2;
   objPlayPickPanel.Arrow._visible = true;
   if(objPlayPickPanel._y + objPlayPickPanel._height >= _loc3_)
   {
      objPlayPickPanel._y = objPlayPickPanel._y - (objPlayPickPanel._y + objPlayPickPanel._height - _loc3_);
      objPlayPickPanel.Arrow._y = objPlayPickPanel._height / 4 * 3;
   }
   objPlayPickPanel._x = objGroup._x + objGroup._width + _loc4_;
   if(objPlayPickPanel._x + objPlayPickPanel.Bg._width >= _loc5_)
   {
      objPlayPickPanel._x = objPlayPickPanel._x - (objGroup._x - (objPlayPickPanel.Bg._width + _loc4_));
      objPlayPickPanel.Arrow._x = objPlayPickPanel._x + objPlayPickPanel.Bg._width;
      objPlayPickPanel.Arrow._visible = false;
   }
}
function onMakePick(objSelection, bRemovePick, SteamId, bIsFantasyTeamPick)
{
   ShowPickStatusPanel(objSelection._TournamentID);
   SetUpPickStatusPanel(objSelection,bRemovePick,SteamId,bIsFantasyTeamPick);
}
function ShowPickStatusPanel(numTournamentID)
{
   PickStatusPanel._visible = true;
   new Lib.Tween(PickStatusPanel,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
   BlurTournamentPanel(numTournamentID);
}
function HidePickStatusPanel(numTournamentID)
{
   UnBlurTournamentPanel(numTournamentID);
   var _loc1_ = new Lib.Tween(PickStatusPanel,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,0.5,true);
   _loc1_.onMotionFinished = function()
   {
      PickStatusPanel._visible = false;
   };
}
function SetUpPickStatusPanel(objSelection, bRemovePick, SteamId, bIsFantasyTeamPick)
{
   ResetStatusPickStatusPanel(objSelection._TournamentID);
   if(bIsFantasyTeamPick)
   {
      var _loc5_ = "";
   }
   else
   {
      _loc5_ = _global.CScaleformComponent_Predictions.GetGroupName(objSelection._EventID,objSelection._GroupID);
   }
   if(!bRemovePick)
   {
      if(SteamId != "")
      {
         var _loc4_ = _global.CScaleformComponent_Predictions.GetMyPredictionItemIDForTeamID(objSelection._EventID,Number(objSelection._TeamID),SteamId);
      }
      else
      {
         _loc4_ = _global.CScaleformComponent_Predictions.GetMyPredictionItemIDForTeamID(objSelection._EventID,objSelection._TeamID);
      }
      if(_loc4_ == "" || _loc4_ == undefined || _loc4_ == null || _loc4_ == "0")
      {
         var _loc6_ = GetStoreIdForTeamsInActiveTournament(objSelection._TeamTag,objSelection._TournamentID);
         if((_loc6_ == 0 || _loc6_ == null) && !bIsFantasyTeamPick)
         {
            SetUpHasNoStickerStatusPanel(objSelection._TeamName);
         }
         else
         {
            SetUpBuyStickerStatusPanel(objSelection,_loc6_,_loc5_,SteamId);
         }
      }
      else
      {
         SetUpSetPredictionStatusPanel(objSelection,_loc4_,_loc5_,SteamId);
      }
   }
   else
   {
      if(SteamId != "")
      {
         _loc4_ = _global.CScaleformComponent_Predictions.GetMyPredictionItemIDForTeamID(objSelection._EventID,objSelection._TeamID,SteamId);
      }
      else
      {
         _loc4_ = _global.CScaleformComponent_Predictions.GetMyPredictionItemIDForTeamID(objSelection._EventID,objSelection._TeamID);
      }
      if(_loc4_ != "" && _loc4_ != undefined && _loc4_ != null && _loc4_ != "0")
      {
         SetUpRemovePredictionStatusPanel(objSelection,_loc4_,_loc5_,SteamId);
      }
   }
   UpdateSpacingForTextAndButtons();
}
function ResetStatusPickStatusPanel(TournamentID)
{
   PickStatusPanel.Timeout._visible = false;
   PickStatusPanel.Status._visible = false;
   PickStatusPanel.StickerImage._visible = false;
   PickStatusPanel.Accept._visible = false;
   PickStatusPanel.Cancel._visible = false;
   PickStatusPanel.Bg.onRollOver = function()
   {
   };
   PickStatusPanel.Team._visible = false;
   PickStatusPanel.Cancel._visible = true;
   PickStatusPanel.Cancel.dialog = this;
   PickStatusPanel.Cancel.SetText("#SFUI_Crafting_Cancel");
   PickStatusPanel.Cancel.Action = function()
   {
      this.dialog.HidePickStatusPanel(TournamentID);
   };
   PickStatusPanel.Cancel.setDisabled(false);
}
function UpdateSpacingForTextAndButtons()
{
   var _loc1_ = 10;
   PickStatusPanel.Text.autoSize = "center";
   PickStatusPanel.Warning.autoSize = "center";
   PickStatusPanel.Warning._y = PickStatusPanel.Text._height + PickStatusPanel.Text._y;
   PickStatusPanel.Cancel._y = PickStatusPanel.Warning._height + PickStatusPanel.Warning._y + _loc1_;
   PickStatusPanel.Accept._y = PickStatusPanel.Cancel._y;
   PickStatusPanel.Timeout._y = PickStatusPanel.Accept._height + PickStatusPanel.Accept._y + _loc1_;
   PickStatusPanel.Status._y = PickStatusPanel.Timeout._y;
}
function SetUpHasNoStickerStatusPanel(TeamName)
{
   var _loc2_ = _global.GameInterface.Translate("#CSGO_PickEm_NA_Title");
   _loc2_ = _global.ConstructString(_loc2_,TeamName);
   LoadImage("econ/tournaments/nosticker.png",PickStatusPanel.StickerImage,43,32,false);
   PickStatusPanel.StickerImage._visible = true;
   PickStatusPanel.Warning.htmlText = "#CSGO_PickEm_NA_Warning";
   PickStatusPanel.Accept._visible = true;
   PickStatusPanel.Accept.SetText("#CSGO_PickEm_Make_Pick");
   PickStatusPanel.Accept.setDisabled(true);
   PickStatusPanel.Text.htmlText = _loc2_;
}
function SetUpBuyStickerStatusPanel(objSelection, StoreItemID, strGroupName, SteamId)
{
   var _loc5_ = "";
   if(SteamId != "")
   {
      var FakeId = _global.CScaleformComponent_Predictions.GetFakeItemIDToRepresentPlayerID(objSelection._EventID,SteamId);
      _loc5_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(m_PlayerXuid,FakeId) + ".png";
      var _loc8_ = _global.CScaleformComponent_Predictions.GetProPlayerNick(SteamId);
      var PlayerCode = _global.CScaleformComponent_Predictions.GetProPlayerCode(SteamId);
      var _loc7_ = _global.GameInterface.Translate(objSelection._Role);
      var _loc4_ = _global.GameInterface.Translate("#CSGO_PickEm_Buy_Player_Title");
      _loc4_ = _global.ConstructString(_loc4_,_loc8_,_loc7_);
      PickStatusPanel.Warning.htmlText = "#CSGO_PickEm_Player_Market_Warning_" + objSelection._TournamentID;
      PickStatusPanel.Accept.dialog = this;
      PickStatusPanel.Accept.SetText("#CSGO_PickEm_Marketplace");
      PickStatusPanel.Accept.Action = function()
      {
         this.dialog.BuyStickerMarket(objSelection._TournamentID,PlayerCode);
      };
      PickStatusPanel.Accept.setDisabled(false);
      PickStatusPanel.Accept._visible = true;
   }
   else
   {
      var FakeId = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(StoreItemID,0);
      _loc5_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(m_PlayerXuid,FakeId) + "_large.png";
      var _loc3_ = _global.CScaleformComponent_Store.GetStoreItemSalePrice(FakeId,1);
      if(_loc3_ == "" || _loc3_ == undefined)
      {
         _loc3_ = "Error StoreEntryMissing";
      }
      _loc4_ = _global.GameInterface.Translate("#CSGO_PickEm_Buy_Title");
      _loc4_ = _global.ConstructString(_loc4_,objSelection._TeamName);
      PickStatusPanel.Warning.htmlText = "#CSGO_PickEm_Buy_Warning_" + objSelection._TournamentID;
      PickStatusPanel.Accept.dialog = this;
      PickStatusPanel.Accept.SetText(_loc3_);
      PickStatusPanel.Accept.Action = function()
      {
         this.dialog.BuySticker(FakeId,objSelection._TournamentID);
      };
      PickStatusPanel.Accept.setDisabled(false);
      PickStatusPanel.Accept._visible = true;
   }
   LoadImage(_loc5_,PickStatusPanel.StickerImage,43,32,false);
   PickStatusPanel.StickerImage._visible = true;
   PickStatusPanel.Text.htmlText = _loc4_;
}
function SetUpSetPredictionStatusPanel(objSelection, StickerID, strGroupName, SteamId)
{
   var SlotType = "";
   if(SteamId != "")
   {
      var _loc6_ = _global.CScaleformComponent_Predictions.GetProPlayerNick(SteamId);
      var _loc7_ = _global.CScaleformComponent_Predictions.GetProPlayerCode(SteamId);
      var _loc4_ = _global.GameInterface.Translate(objSelection._Role);
      var _loc3_ = _global.GameInterface.Translate("#CSGO_PickEm_Apply_Player_Title");
      _loc3_ = _global.ConstructString(_loc3_,_loc6_,_loc4_);
      SlotType = "player";
   }
   else
   {
      _loc3_ = _global.GameInterface.Translate("#CSGO_PickEm_Apply_Title");
      _loc3_ = _global.ConstructString(_loc3_,objSelection._TeamName);
      SlotType = "team";
   }
   var _loc5_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(m_PlayerXuid,StickerID) + ".png";
   LoadImage(_loc5_,PickStatusPanel.StickerImage,43,32,false);
   PickStatusPanel.StickerImage._visible = true;
   PickStatusPanel.Accept.dialog = this;
   PickStatusPanel.Accept.SetText("#CSGO_PickEm_Make_Pick");
   PickStatusPanel.Accept.Action = function()
   {
      this.dialog.SetMyPrediction(objSelection,StickerID,SlotType,SteamId);
   };
   PickStatusPanel.Accept.setDisabled(false);
   PickStatusPanel.Accept._visible = true;
   PickStatusPanel.Warning.htmlText = "#CSGO_PickEm_Apply_Warning";
   PickStatusPanel.Text.htmlText = _loc3_;
}
function GetNextStageName(EventId, numCurrentDay)
{
   var _loc6_ = _global.CScaleformComponent_Predictions.GetEventSectionsCount(EventId);
   var _loc7_ = 0;
   var _loc2_ = 0;
   while(_loc2_ < _loc6_)
   {
      var _loc3_ = _global.CScaleformComponent_Predictions.GetEventSectionIDByIndex(EventId,_loc2_);
      if(_global.CScaleformComponent_Predictions.GetSectionIsActive(EventId,_loc3_))
      {
         if(numCurrentDay == 0 || numCurrentDay == 1)
         {
            return _loc2_;
         }
      }
      _loc2_ = _loc2_ + 1;
   }
   return null;
}
function SetUpRemovePredictionStatusPanel(objSelection, StickerID, strGroupName, SteamId)
{
   var SlotType = "";
   if(SteamId != "")
   {
      SlotType = "player";
      var _loc6_ = _global.CScaleformComponent_Predictions.GetProPlayerNick(SteamId);
      var _loc3_ = _global.GameInterface.Translate("#CSGO_PickEm_Remove_Title");
      var _loc4_ = _global.GameInterface.Translate("#CSGO_MatchInfo_Stage_" + strGroupName);
      _loc3_ = _global.ConstructString(_loc3_,_loc6_,_loc4_);
   }
   else
   {
      SlotType = "team";
      _loc3_ = _global.GameInterface.Translate("#CSGO_PickEm_Remove_Title");
      _loc4_ = _global.GameInterface.Translate("#CSGO_MatchInfo_Stage_" + strGroupName);
      _loc3_ = _global.ConstructString(_loc3_,objSelection._TeamName,_loc4_);
   }
   var _loc5_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(m_PlayerXuid,StickerID) + ".png";
   LoadImage(_loc5_,PickStatusPanel.StickerImage,43,32,false);
   PickStatusPanel.StickerImage._visible = true;
   PickStatusPanel.Accept.dialog = this;
   PickStatusPanel.Accept.SetText("#CSGO_PickEm_Remove_Pick");
   PickStatusPanel.Accept.Action = function()
   {
      this.dialog.RemoveMyPrediction(objSelection,StickerID,SlotType,numSlot);
   };
   PickStatusPanel.Accept.setDisabled(false);
   PickStatusPanel.Accept._visible = true;
   PickStatusPanel.Warning.htmlText = "#CSGO_PickEm_Remove_Warning";
   PickStatusPanel.Text.htmlText = _loc3_;
}
function BuySticker(strItemId, TournamentID)
{
   _global.CScaleformComponent_Store.StoreItemPurchase(strItemId);
   HidePickStatusPanel(TournamentID);
}
function BuyStickerMarket(TournamentID, PlayerCode)
{
   trace("------------------------------BuyStickerMarket--------------------------");
   var _loc2_ = _global.CScaleformComponent_SteamOverlay.GetAppID();
   var _loc3_ = _global.CScaleformComponent_SteamOverlay.GetSteamCommunityURL();
   _loc3_ = _loc3_ + ("/market/search?q=&appid=" + _loc2_ + "&lock_appid=" + _loc2_ + "&category_" + _loc2_ + "_Type%5B0%5D=tag_CSGO_Tool_Sticker&category_" + _loc2_ + "_Tournament%5B0%5D=tag_Tournament" + TournamentID + "&category_" + _loc2_ + "_ProPlayer%5B0%5D=tag_" + PlayerCode);
   _global.CScaleformComponent_SteamOverlay.OpenURL(_loc3_);
   HidePickStatusPanel(TournamentID);
}
function SetMyPrediction(objSelection, StickerID, SlotType, SteamId)
{
   var _loc2_ = GetEmptyPredictionSlotForGroup(objSelection,SlotType);
   var _loc3_ = false;
   if(SlotType == "player")
   {
      _loc3_ = true;
   }
   if(_loc2_ != null)
   {
      m_PredictionCallbackConfirmedGroupID = null;
      m_PredictionCallbackConfirmedTeamID = null;
      _global.CScaleformComponent_Predictions.SetMyPredictionUsingItemID(objSelection._EventID,objSelection._GroupID,_loc2_,StickerID);
      PickStatusPanel.Accept.setDisabled(true);
      PickStatusPanel.Cancel.setDisabled(true);
      PickStatusPanel.Status.Text.htmlText = "#CSGO_PickEm_Pick_Submitting";
      PickStatusPanel.Status._visible = true;
      TimeOutForPredictions(objSelection,_loc3_,SteamId,_loc2_);
   }
}
function RemoveMyPrediction(objSelection, StickerID, SlotType, numSlot)
{
   numSlot = GetTeamsPredictionSlot(objSelection,SlotType);
   var _loc3_ = false;
   if(SlotType == "player")
   {
      _loc3_ = true;
   }
   if(numSlot != null)
   {
      m_PredictionCallbackConfirmedGroupID = null;
      m_PredictionCallbackConfirmedTeamID = null;
      _global.CScaleformComponent_Predictions.SetMyPredictionUsingItemID(objSelection._EventID,objSelection._GroupID,numSlot,"0");
      PickStatusPanel.Accept.setDisabled(true);
      PickStatusPanel.Cancel.setDisabled(true);
      PickStatusPanel.Status.Text.htmlText = "#CSGO_PickEm_Pick_Removing";
      PickStatusPanel.Status._visible = true;
      TimeOutForRemove(objSelection,_loc3_,numSlot);
   }
}
function TimeOutForPredictions(objSelection, bIsPlayerPickEm, SteamId, numSlot)
{
   var numLoop = 0;
   PickStatusPanel.onEnterFrame = function()
   {
      if(m_PredictionCallbackConfirmedGroupID == objSelection._GroupID && (m_PredictionCallbackConfirmedTeamID == objSelection._TeamID || m_PredictionCallbackConfirmedTeamID == SteamId))
      {
         trace("------------------------------------------m_PredictionCallbackConfirmedGroupID" + m_PredictionCallbackConfirmedGroupID);
         trace("------------------------------------------m_PredictionCallbackConfirmedTeamID" + m_PredictionCallbackConfirmedTeamID);
         PickStatusPanel.Cancel.setDisabled(true);
         HidePickStatusPanel(objSelection._TournamentID);
         PlayPredictionAnim(objSelection,bIsPlayerPickEm,numSlot);
         delete PickStatusPanel.onEnterFrame;
      }
      if(numLoop > 150)
      {
         PredictionTimeOut();
         delete PickStatusPanel.onEnterFrame;
      }
      numLoop++;
   };
}
function TimeOutForRemove(objSelection, bIsPlayerPickEm, numSlot)
{
   var numLoop = 0;
   PickStatusPanel.onEnterFrame = function()
   {
      if(m_PredictionCallbackConfirmedGroupID == objSelection._GroupID && (m_PredictionCallbackConfirmedTeamID == 0 || m_PredictionCallbackConfirmedTeamID == ""))
      {
         trace("------------------------------------------m_PredictionCallbackConfirmedTeamID" + m_PredictionCallbackConfirmedTeamID);
         PickStatusPanel.Cancel.setDisabled(true);
         HidePickStatusPanel(objSelection._TournamentID);
         PlayRemoveAnim(objSelection,bIsPlayerPickEm,numSlot);
         delete PickStatusPanel.onEnterFrame;
      }
      if(numLoop > 150)
      {
         PredictionTimeOut();
         delete PickStatusPanel.onEnterFrame;
      }
      numLoop++;
   };
}
function PredictionTimeOut()
{
   PickStatusPanel.Status._visible = false;
   PickStatusPanel.Timeout.Text.htmlText = "#CSGO_PickEm_Pick_TimeOut";
   PickStatusPanel.Timeout._visible = true;
   PickStatusPanel.Cancel.setDisabled(false);
}
function PlayPredictionAnim(objSelection, bIsPlayerPickEm, numSlot)
{
   var _loc12_ = _global.CScaleformComponent_Predictions.GetGroupCanPick(objSelection._EventID,objSelection._GroupID);
   var _loc9_ = _global.CScaleformComponent_Predictions.GetEventSectionsCount(objSelection._EventID);
   var _loc10_ = _global.CScaleformComponent_Predictions.GetSectionGroupsCount(objSelection._EventID,objSelection._DayID);
   if(bIsPlayerPickEm)
   {
      SetUpGroups(objSelection._parent._parent,objSelection._TournamentID,objSelection._EventID,objSelection._DayID,objSelection._parent._DayIndex,m_PlayerXuid,bIsPlayerPickEm);
      var _loc3_ = objSelection._parent._parent;
      if(objSelection._parent._NumTeams > 3 && _loc3_._IsLastGroupOfLastBay)
      {
         var _loc4_ = _loc3_["Day" + objSelection._parent._DayIndex + "_" + objSelection._parent._GroupIndex + "_Alt"];
      }
      else
      {
         _loc4_ = _loc3_["Day" + objSelection._parent._DayIndex + "_" + objSelection._parent._GroupIndex];
      }
      new Lib.Tween(_loc4_.PlayerBtn.Sticker,"_xscale",mx.transitions.easing.Bounce.easeOut,400,140,1,true);
      new Lib.Tween(_loc4_.PlayerBtn.Sticker,"_yscale",mx.transitions.easing.Bounce.easeOut,400,140,1,true);
      new Lib.Tween(_loc4_.PlayerBtn.Sticker,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
      new Lib.Tween(_loc4_.PlayerBtn.PickIcon,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
   }
   else
   {
      _loc3_ = objSelection._parent;
      var _loc5_ = _loc3_["Pick" + numSlot];
      var _loc8_ = _global.CScaleformComponent_Predictions.GetSectionDesc(objSelection._EventID,objSelection._DayID);
      var _loc6_ = _global.GameInterface.Translate("#CSGO_PickEm_Confirmed_Tooltip");
      _loc6_ = _global.ConstructString(_loc6_,_loc8_);
      SetUpGroups(objSelection._parent._parent,objSelection._TournamentID,objSelection._EventID,objSelection._DayID,objSelection._parent._DayIndex,m_PlayerXuid,bIsPlayerPickEm);
      new Lib.Tween(_loc5_,"_yscale",mx.transitions.easing.Bounce.easeOut,500,100,1,true);
      new Lib.Tween(_loc5_,"_xscale",mx.transitions.easing.Bounce.easeOut,500,100,1,true);
      var _loc11_ = new Lib.Tween(_loc5_,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
      ShowHideGroupToolTip(_loc3_,true,_loc6_);
      new Lib.Tween(_loc3_.ToolTip,"_xscale",mx.transitions.easing.Bounce.easeOut,90,100,0.25,true);
      new Lib.Tween(_loc3_.ToolTip,"_yscale",mx.transitions.easing.Bounce.easeOut,90,100,0.25,true);
      setTimeout(TimeOutHideTooltip,m_numTimerDelay,_loc3_);
      m_bCanHideGroupTooltip = false;
      _loc3_.ToolTip.gotoAndPlay("StartAnim");
   }
}
function TimeOutHideTooltip(objGroup)
{
   ShowHideGroupToolTip(objGroup,false,"");
   m_bCanHideGroupTooltip = true;
}
function PlayRemoveAnim(objSelection, bIsPlayerPickEm, numSlot)
{
   var _loc6_ = _global.CScaleformComponent_Predictions.GetGroupCanPick(objSelection._EventID,objSelection._GroupID);
   var _loc3_ = null;
   if(bIsPlayerPickEm)
   {
      new Lib.Tween(objSelection.Sticker,"_xscale",mx.transitions.easing.Strong.easeOut,140,400,1,true);
      new Lib.Tween(objSelection.Sticker,"_yscale",mx.transitions.easing.Strong.easeOut,140,400,1,true);
      new Lib.Tween(objSelection.Sticker,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,1,true);
      _loc3_ = objSelection.PickIcon;
   }
   else
   {
      var _loc4_ = objSelection._parent;
      var _loc2_ = _loc4_["Pick" + numSlot];
      _loc3_ = _loc2_;
      new Lib.Tween(_loc2_,"_xscale",mx.transitions.easing.Strong.easeOut,100,400,1,true);
      new Lib.Tween(_loc2_,"_yscale",mx.transitions.easing.Strong.easeOut,100,400,1,true);
   }
   var _loc5_ = new Lib.Tween(_loc3_,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,1,true);
   _loc5_.onMotionFinished = function()
   {
      SetUpGroups(objSelection._parent._parent,objSelection._TournamentID,objSelection._EventID,objSelection._DayID,objSelection._parent._DayIndex,m_PlayerXuid,bIsPlayerPickEm);
   };
}
function GetChampionTrophyIconPath(strEventId)
{
   if(strEventId == "tournament:4")
   {
      return "econ/status_icons/cologne_trophy_champion_large.png";
   }
   if(strEventId == "tournament:5")
   {
      return "econ/status_icons/dhw_2014_champion_large.png";
   }
   if(strEventId == "tournament:6")
   {
      return "econ/status_icons/kat_2015_champion_large.png";
   }
   if(strEventId == "tournament:7")
   {
      return "econ/status_icons/col_2015_champion_large.png";
   }
   if(strEventId == "tournament:8")
   {
      return "econ/status_icons/clug_2015_champion_large.png";
   }
   if(strEventId == "tournament:9")
   {
      return "econ/status_icons/columbus_2016_champion_large.png";
   }
   if(strEventId == "tournament:10")
   {
      return "econ/status_icons/cologne_2016_champion_large.png";
   }
}
function SetOldWinnelPanel(objBracket, strEventId)
{
   if(GetTournamentWinner(strEventId) != "")
   {
      var _loc2_ = "econ/tournaments/teams/";
      var _loc1_ = GetTournamentWinner(strEventId).toLowerCase();
      LoadImage(_loc2_ + _loc1_ + ".png",objBracket.Winner,32,32);
   }
}
function ShowLeaderboard(strEventId, bIsFantasyGame)
{
   Leaderboard.SetUpPickEmLeaderboard(strEventId,bIsFantasyGame);
   Leaderboard.Close.dialog = this;
   Leaderboard.Close.Action = function()
   {
      CloseLeaderboard();
   };
   Leaderboard.Bg.onRollOver = function()
   {
   };
   Leaderboard._visible = true;
   new Lib.Tween(Leaderboard,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
}
function CloseLeaderboard()
{
   var _loc1_ = new Lib.Tween(Leaderboard,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,1,true);
   _loc1_.onMotionFinished = function()
   {
      Leaderboard._visible = false;
   };
}
function PredictionUploaded(teamID, groupID)
{
   m_PredictionCallbackConfirmedGroupID = groupID;
   m_PredictionCallbackConfirmedTeamID = teamID;
}
function BlurTournamentPanel(numTournamentID)
{
   if(this.FantasyTeam._visible)
   {
      this.FantasyTeam.filters = [filterBlur];
   }
   else
   {
      this["Bracket" + numTournamentID].filters = [filterBlur];
   }
}
function UnBlurTournamentPanel(numTournamentID)
{
   if(this.FantasyTeam._visible)
   {
      this.FantasyTeam.filters = [filterUnBlur];
   }
   else
   {
      this["Bracket" + numTournamentID].filters = [filterUnBlur];
   }
}
function IsCurrentTournament(numTournamentID)
{
   if(_global.CScaleformComponent_News.GetActiveTournamentEventID() == numTournamentID)
   {
      return true;
   }
   return false;
}
function GetTournamentWinner(strEventId)
{
   var _loc5_ = _global.CScaleformComponent_Predictions.GetEventSectionsCount(strEventId);
   var _loc4_ = _global.CScaleformComponent_Predictions.GetEventSectionIDByIndex(strEventId,_loc5_ - 1);
   var _loc7_ = _global.CScaleformComponent_Predictions.GetSectionGroupsCount(strEventId,_loc4_);
   var _loc6_ = _global.CScaleformComponent_Predictions.GetSectionGroupIDByIndex(strEventId,_loc4_,_loc7_ - 1);
   var _loc8_ = _global.CScaleformComponent_Predictions.GetGroupCorrectPicksByIndex(strEventId,_loc6_,0);
   var _loc2_ = _global.CScaleformComponent_Predictions.GetTeamTag(Number(_loc8_));
   if(_loc2_ != undefined && _loc2_ != "" && _loc2_ != null)
   {
      return _loc2_;
   }
   return "";
}
function SetUpFantasyGame(PlayerXuid, strEventId, numTournamentID)
{
   m_numTournamentID = numTournamentID;
   m_strEventId = strEventId;
   m_bShowCurrentTournamentStats = false;
   ShowHideFantasyTooltip(false,null);
   var _loc3_ = this.FantasyTeam;
   SetUpTableButtons(numTournamentID);
   SetUpTableButtonsStatic(numTournamentID);
   SetUpPagingButtons();
   SetUpPicksButtons(numTournamentID);
   SetUpDays();
   onSelectFantasyDay(m_ObjDaySelected);
   m_ObjSelectedRole = _loc3_.StatTable.BtnStat0;
   onSelectFantasyStat(m_ObjSelectedRole);
   SetUpLiveButton(m_strEventId,m_numTournamentID);
}
function SetFantasyScore(type)
{
   var _loc9_ = type;
   Trophy._visible = false;
   NoPicks._visible = true;
   if(type == "tournament:8")
   {
      type = "official_leaderboard_pickem_cluj2015_fantasy";
   }
   else if(type == "tournament:9")
   {
      type = "official_leaderboard_pickem_columbus2016_fantasy";
   }
   else if(type == "tournament:10")
   {
      type = "official_leaderboard_pickem_cologne2016_fantasy";
   }
   var _loc8_ = _global.CScaleformComponent_Leaderboards.GetState(type);
   Info.TrophyTitle.htmlText = "#CSGO_Fantasy_Trophy_Title";
   if(_loc8_ != "ready")
   {
      Info.Points._visible = false;
      Info.PointsNeeded._visible = false;
      _global.CScaleformComponent_Leaderboards.Refresh(type);
      return undefined;
   }
   if(FantasyTeam._visible == false)
   {
      Info.Points._visible = false;
      Info.PointsNeeded._visible = false;
   }
   var _loc6_ = _global.GameInterface.Translate("#CSGO_Fantasy_Trophy_Score");
   var _loc2_ = _global.CScaleformComponent_Leaderboards.GetEntryScoreByXuid(type,m_PlayerXuid);
   if(_loc2_ == undefined)
   {
      _loc2_ = "-";
   }
   _loc6_ = _global.ConstructString(_loc6_,_loc2_);
   Info.Points.htmlText = _loc6_;
   var _loc5_ = _global.GameInterface.Translate("#CSGO_Fantasy_Trophy_Status");
   _loc2_ = _global.CScaleformComponent_Leaderboards.GetEntryGlobalPctByXuid(type,m_PlayerXuid);
   if(_loc2_ == undefined)
   {
      _loc2_ = "-";
   }
   else
   {
      _loc2_ = _loc2_ + "%";
   }
   _loc5_ = _global.ConstructString(_loc5_,_loc2_);
   Info.PointsNeeded.htmlText = _loc5_;
   Info.Points._visible = true;
   Info.PointsNeeded._visible = true;
   var _loc4_ = _global.CScaleformComponent_Fantasy.GetMyFantasyTeamTrophyItemID(m_strEventId);
   if(_loc4_ != "" && _loc4_ != undefined && _loc4_ != 0 && _loc4_ != null)
   {
      Trophy._visible = true;
      NoPicks._visible = false;
      var _loc7_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(m_PlayerXuid,_loc4_) + ".png";
      LoadImage(_loc7_,Trophy,64,48,false);
   }
   _global.AutosizeTextDown(Points,8);
   _global.AutosizeTextDown(PointsNeeded,8);
}
function SetUpLiveButton()
{
   FantasyTeam.Live._visible = false;
   var _loc5_ = _global.CScaleformComponent_News.GetActiveTournamentEventID();
   var _loc4_ = "tournament:" + _loc5_;
   var _loc3_ = "";
   if(GetMatchList("live") != "")
   {
      _loc3_ = GetMatchList("live");
   }
   else if(GetMatchList(_loc4_) != "")
   {
      _loc3_ = GetMatchList(_loc4_);
   }
   if(_loc3_ != "")
   {
      FantasyTeam.Live.dialog = this;
      FantasyTeam.Live._MatchId = _loc3_;
      FantasyTeam.Live.Action = function()
      {
         this.dialog.OnWatch(this._MatchId);
      };
      FantasyTeam.Live._visible = true;
   }
}
function GetMatchList(strListerType)
{
   if(_global.CScaleformComponent_MatchList.GetCount(strListerType) != undefined)
   {
      var _loc6_ = _global.CScaleformComponent_MatchList.GetCount(strListerType);
      if(_loc6_ > 0)
      {
         var _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            var _loc2_ = _global.CScaleformComponent_MatchList.GetMatchByIndex(strListerType,_loc4_);
            var _loc3_ = _global.CScaleformComponent_MatchInfo.GetMatchTournamentName(_loc2_);
            var _loc5_ = _global.CScaleformComponent_MatchInfo.GetMatchState(_loc2_);
            if(_loc3_ != "" && _loc3_ != null && _loc3_ != undefined && _loc5_ == "live")
            {
               return _loc2_;
            }
            _loc4_ = _loc4_ + 1;
         }
      }
      return "";
   }
   return "";
}
function SetUpTableButtons(numTournamentID)
{
   var _loc4_ = 0;
   while(_loc4_ < 5)
   {
      var _loc3_ = this.FantasyTeam.StatTable["BtnStat" + _loc4_];
      _loc3_.dialog = this;
      _loc3_.ButtonText.Text.htmlText = "#CSGO_Fantasy_Team_Stat_" + _loc4_;
      _loc3_._Stat = this["STR_STAT" + _loc4_];
      _loc3_._Index = _loc4_;
      _loc3_.Selected._visible = false;
      _loc3_.SelectedRole._visible = false;
      _loc3_.Action = function()
      {
         onSelectFantasyStat(this);
      };
      _global.AutosizeTextDown(_loc3_.ButtonText.Text,7);
      _loc4_ = _loc4_ + 1;
   }
}
function SetUpTableButtonsStatic(numTournamentID)
{
   var _loc4_ = this.FantasyTeam.StatTable.BtnTeam;
   _loc4_.dialog = this;
   _loc4_.SetText("#CSGO_Fantasy_Team_Stat_Team");
   _loc4_._Stat = "team";
   _loc4_._Index = "Team";
   _loc4_.Selected._visible = false;
   _loc4_.Action = function()
   {
      onSelectFantasyStat(this);
   };
   _global.AutosizeTextDown(_loc4_.ButtonText.Text,7);
   _loc4_ = this.FantasyTeam.StatTable.BtnPlayer;
   _loc4_.dialog = this;
   _loc4_.SetText("#CSGO_Fantasy_Team_Stat_Player");
   _loc4_._Stat = "name";
   _loc4_._Index = "Player";
   _loc4_.Selected._visible = false;
   _loc4_.SelectedRole._visible = false;
   _loc4_.Action = function()
   {
      onSelectFantasyStat(this);
   };
   _global.AutosizeTextDown(_loc4_.ButtonText.Text,7);
   _loc4_ = this.FantasyTeam.StatTable.BtnMatches;
   _loc4_.dialog = this;
   _loc4_.SetText("#CSGO_Fantasy_Team_Stat_Matches");
   _loc4_._Stat = "matches_played";
   _loc4_._Index = "Matches";
   _loc4_.Selected._visible = false;
   _loc4_.SelectedRole._visible = false;
   _loc4_.Action = function()
   {
      onSelectFantasyStat(this);
   };
   _global.AutosizeTextDown(_loc4_.ButtonText.Text,7);
   var _loc3_ = this.FantasyTeam.StatTable;
   _loc3_.Add.htmlText = "#CSGO_Fantasy_Team_Stat_Add";
   _loc3_.Sticker.htmlText = "#CSGO_Fantasy_Team_Stat_Sticker";
   _global.AutosizeTextDown(_loc3_.Name,7);
   _global.AutosizeTextDown(_loc3_.Add,7);
   _global.AutosizeTextDown(_loc3_.Sticker,7);
   _loc3_.StickerFilter.dialog = this;
   _loc3_.StickerFilter.SetText("#CSGO_Fantasy_Team_StickerFilter");
   _loc3_.StickerFilter.Selected._visible = false;
   _loc3_.StickerFilter.Action = function()
   {
      onFilterStickers();
   };
   m_bFilterStickers = false;
   _loc3_.StickerHint._visible = false;
   _global.AutosizeTextDown(_loc3_.StickerHint.Text,7);
   _global.AutosizeTextDown(_loc3_.StickerFilter.ButtonText.Text,7);
   var _loc5_ = _global.GameInterface.Translate("#CSGO_Fantasy_Team_PlayerStats_Desc");
   _loc5_ = _global.ConstructString(_loc5_,_global.GameInterface.Translate("#CSGO_Watch_Cat_Tournament_" + (numTournamentID - 1)));
   _loc3_.Desc.htmlText = _loc5_;
   _loc5_ = _global.GameInterface.Translate("#CSGO_Fantasy_NoSTickers_In_Table");
   _loc5_ = _global.ConstructString(_loc5_,_global.GameInterface.Translate("#CSGO_Watch_Cat_Tournament_" + numTournamentID));
   _loc3_.NoStickersMessage.htmlText = _loc5_;
   _loc3_.NoStickersMessage._visible = false;
   var _loc6_ = [];
   _loc6_.push(numTournamentID - 1);
   _loc6_.push(numTournamentID);
   _loc3_.TournamentSelectDropdown.SetUpDropDown(_loc6_,"","#CSGO_Watch_Cat_Tournament_",this.SetTournamentSelectDropdown,numTournamentID - 1);
}
function SetTournamentSelectDropdown(strDropdownOption)
{
   m_bShowCurrentTournamentStats = Number(strDropdownOption) != m_numTournamentID?false:true;
   if(m_strLockedPlayerID != "")
   {
      numPageOfLockedPlayer = GetPageOfLockedPlayer(m_strLockedPlayerID);
      m_numPage = numPageOfLockedPlayer;
   }
   else
   {
      m_numPage = 0;
   }
   UpdateRows();
   EnableDisableButtons();
}
function SetUpPagingButtons()
{
   var _loc2_ = this.FantasyTeam.StatTable.BtnPrev;
   _loc2_.dialog = this;
   _loc2_.Action = function()
   {
      onScrollPress(this,false);
   };
   var _loc3_ = this.FantasyTeam.StatTable.BtnNext;
   _loc3_.dialog = this;
   _loc3_.Action = function()
   {
      onScrollPress(this,true);
   };
}
function SetUpPicksButtons(numTournamentID)
{
   var _loc3_ = 0;
   while(_loc3_ < 5)
   {
      var _loc2_ = this.FantasyTeam["Pick" + _loc3_];
      _loc2_.RoleName.htmlText = "#CSGO_Fantasy_Team_Cat_" + _loc3_;
      _loc2_.BtnPick.dialog = this;
      _loc2_.BtnPick._Stat = this["STR_STAT" + _loc3_];
      _loc2_.BtnPick._Index = _loc3_;
      _loc2_.BtnPick.Selected._visible = false;
      _loc2_.Remove.dialog = this;
      _loc2_.Remove._Index = _loc3_;
      _loc3_ = _loc3_ + 1;
   }
   var _loc4_ = this.FantasyTeam.BtnSubmitTeam;
   _loc4_.dialog = this;
   _loc4_.ButtonText.Text.htmlText = "#CSGO_Fantasy_Save_Team";
   _loc4_.Action = function()
   {
      SetUpSetPredictionStatusPanelFantasyTeam(numTournamentID,m_ObjDaySelected._DayID,m_strEventId,m_aNotSubmittedTeam);
   };
}
function SetUpDays()
{
   var _loc10_ = 7;
   var _loc9_ = _global.CScaleformComponent_Predictions.GetEventSectionsCount(m_strEventId);
   var _loc11_ = null;
   var _loc4_ = 0;
   while(_loc4_ < _loc10_)
   {
      if(_loc4_ == 5 && m_numTournamentID == 9 || _loc4_ >= _loc9_)
      {
         var _loc3_ = this.FantasyTeam["Day" + _loc4_];
         _loc3_._visible = false;
      }
      else
      {
         var _loc5_ = _global.CScaleformComponent_Predictions.GetEventSectionIDByIndex(m_strEventId,_loc4_);
         var _loc7_ = _global.CScaleformComponent_Predictions.GetSectionIsActive(m_strEventId,_loc5_);
         _loc3_ = this.FantasyTeam["Day" + _loc4_];
         _loc3_._visible = true;
         _loc3_.Selected._visible = false;
         if(_loc4_ > 2 && m_numTournamentID == 9)
         {
            _loc3_.Text.Month.htmlText = _global.GameInterface.Translate("#CSGO_Tournament_Month_Short_" + m_numTournamentID + "_1");
         }
         else if(_loc4_ == _loc9_ - 1 && m_numTournamentID == 8)
         {
            _loc3_.Text.Month.htmlText = _global.GameInterface.Translate("#CSGO_Tournament_Month_Final_Short_" + m_numTournamentID);
         }
         else
         {
            _loc3_.Text.Month.htmlText = _global.GameInterface.Translate("#CSGO_Tournament_Month_Short_" + m_numTournamentID);
         }
         _loc3_.Text.Date.htmlText = _global.CScaleformComponent_Predictions.GetSectionDesc(m_strEventId,_loc5_);
         _loc3_.setDisabled(false);
         _loc3_.dialog = this;
         _loc3_._DayID = _loc5_;
         _loc3_._DayIndex = _loc4_;
         _loc3_.Action = function()
         {
            onSelectFantasyDay(this);
         };
         if(HasDaysMatchesStarted(_loc5_))
         {
            if(_loc7_ && GetTournamentWinner(m_strEventId) == "")
            {
               _loc3_.Status.htmlText = "#CSGO_Fantasy_Team_Locked";
               m_ObjDaySelected = _loc3_;
            }
            else
            {
               GetDaysScore(_loc4_,_loc5_);
               _loc3_.Status.htmlText = GetDaysScore(_loc4_,_loc5_);
               _global.AutosizeTextDown(_loc3_.Status,7);
               _loc3_.Text.Month._alpha = 30;
               _loc3_.Text.Date._alpha = 30;
               if(GetTournamentWinner(m_strEventId) != "")
               {
                  m_ObjDaySelected = _loc3_;
               }
            }
         }
         else if(_loc7_)
         {
            _loc3_.Status.htmlText = "<b>" + _global.GameInterface.Translate("#CSGO_Fantasy_Team_Active") + "</b>";
            _loc3_.Status._alpha = 100;
            m_ObjDaySelected = _loc3_;
         }
         else
         {
            var _loc6_ = 0;
            var _loc8_ = this.FantasyTeam["Day" + (_loc4_ - 1)];
            if(_loc8_._visible == false)
            {
               _loc6_ = _global.CScaleformComponent_Predictions.GetEventSectionIDByIndex(m_strEventId,_loc4_ - 2);
            }
            else
            {
               _loc6_ = _global.CScaleformComponent_Predictions.GetEventSectionIDByIndex(m_strEventId,_loc4_ - 1);
            }
            if(HasDaysMatchesStarted(_loc6_))
            {
               _loc3_.setDisabled(false);
               _loc3_.Status.htmlText = "#CSGO_Fantasy_Team_Update_Team";
               _loc3_.Text.Month._alpha = 30;
               _loc3_.Text.Date._alpha = 30;
            }
            else
            {
               _loc3_.setDisabled(true);
               _loc3_.Status.htmlText = "";
            }
         }
      }
      _loc4_ = _loc4_ + 1;
   }
   PlaceDays(_loc10_);
}
function PlaceDays(numDaysTiles)
{
   var _loc5_ = 0;
   var _loc6_ = 762;
   var _loc3_ = [];
   var _loc2_ = 0;
   while(_loc2_ < numDaysTiles)
   {
      var _loc4_ = this.FantasyTeam["Day" + _loc2_];
      if(_loc4_._visible)
      {
         _loc5_ = _loc5_ + _loc4_._width;
         _loc3_.push(_loc4_);
      }
      _loc2_ = _loc2_ + 1;
   }
   _loc2_ = 0;
   while(_loc2_ < _loc3_.length)
   {
      if(_loc2_ == 0)
      {
         _loc3_[_loc2_]._x = _loc6_ / 2 - _loc5_ / 2;
      }
      else
      {
         _loc3_[_loc2_]._x = _loc3_[_loc2_ - 1]._width + _loc3_[_loc2_ - 1]._x;
      }
      _loc2_ = _loc2_ + 1;
   }
}
function GetDaysScore(numDayIndex, numDayID)
{
   var _loc8_ = _global.CScaleformComponent_Fantasy.GetMyFantasyTeamIndexForSectionID(m_strEventId,numDayID);
   var _loc7_ = _global.CScaleformComponent_Fantasy.GetMyFantasyTeamAtIndexPicks(m_strEventId,Number(_loc8_));
   var _loc4_ = _loc7_.split(",");
   var _loc3_ = 0;
   var _loc2_ = 0;
   while(_loc2_ < 5)
   {
      _loc3_ = _loc3_ + _global.CScaleformComponent_Fantasy.ComputeProPlayerMatchFantasyScore(m_strEventId,_loc4_[_loc2_],m_numTournamentID + "/stage" + numDayIndex,_loc2_);
      _loc2_ = _loc2_ + 1;
   }
   if(_loc3_ > 0 && _loc3_ != undefined)
   {
      var _loc6_ = "+" + _loc3_ + "pts";
      return _loc6_;
   }
   return "";
}
function onSelectFantasyDay(objBtn)
{
   var _loc1_ = HasDaysMatchesStarted(objBtn._DayID);
   m_ObjDaySelected.Selected._visible = false;
   m_ObjDaySelected = objBtn;
   objBtn.Selected._visible = true;
   GetAlreadySubmittedFantasyTeamIds(objBtn._DayID);
   LoadFantasyTeamData(_loc1_,null,true);
   EnableDisableCommitButton(_loc1_);
   m_ObjSelectedPick = null;
   onSelectFantasyPick(null);
   UpdateRows();
}
function GetAlreadySubmittedFantasyTeamIds(numDayID)
{
   var _loc4_ = _global.CScaleformComponent_Fantasy.GetMyFantasyTeamIndexForSectionID(m_strEventId,numDayID);
   var _loc2_ = _global.CScaleformComponent_Fantasy.GetMyFantasyTeamAtIndexPicks(m_strEventId,Number(_loc4_));
   var _loc3_ = new Array();
   if(HasDaysMatchesStarted(numDayID))
   {
      _loc3_ = _loc2_.split(",");
      m_aNotSubmittedTeam = _loc3_;
   }
   else if(_global.MainMenuMovie.Panel.m_aNotSavedFantasyTeam.length <= 0)
   {
      if(_loc2_ == undefined || _loc2_ == null || _loc2_ == "" || _loc2_ == 0)
      {
         _loc2_ = ",,,,";
         _loc3_ = _loc2_.split(",");
         m_aNotSubmittedTeam = _loc3_;
      }
      else
      {
         _loc3_ = _loc2_.split(",");
         m_aNotSubmittedTeam = _loc3_;
      }
   }
   else
   {
      m_aNotSubmittedTeam = _global.MainMenuMovie.Panel.m_aNotSavedFantasyTeam;
   }
   m_strSubmittedTeam = _loc2_;
   trace("------------------------------m_strSubmittedTeam----------------------" + m_strSubmittedTeam);
   trace("------------------------------m_aNotSubmittedTeam----------------------" + m_aNotSubmittedTeam);
   m_ObjSelectedPick = null;
}
function LoadFantasyTeamData(bLockPick, numPickIndex, bDayChange)
{
   var _loc4_ = 0;
   while(_loc4_ < 5)
   {
      var _loc3_ = this.FantasyTeam["Pick" + _loc4_].BtnPick;
      var _loc6_ = this.FantasyTeam["Pick" + _loc4_].Remove;
      var _loc5_ = "";
      _loc3_.Add._visible = false;
      _loc3_.StickerImage._visible = false;
      _loc3_.PointsEarned._visible = false;
      _loc3_.PlayerImage._y = -49.25;
      _loc3_.PlayerImage._alpha = 100;
      _loc6_._visible = false;
      if(m_aNotSubmittedTeam[_loc4_] != "" && m_aNotSubmittedTeam[_loc4_] != undefined && m_aNotSubmittedTeam[_loc4_] != null && m_aNotSubmittedTeam[_loc4_] != 0)
      {
         _loc5_ = m_aNotSubmittedTeam[_loc4_];
      }
      else
      {
         _loc5_ = "";
         if(m_ObjSelectedPick._Index != _loc4_ && !bLockPick)
         {
            _loc3_.Add._visible = true;
         }
         if(bLockPick)
         {
            _loc3_._parent.PlayerName.htmlText = "";
         }
         else
         {
            _loc3_._parent.PlayerName.htmlText = "#CSGO_Fantasy_Team_Action";
         }
         _loc3_._parent.PointsEarned._visible = false;
         _loc3_.PlayerImage._visible = false;
      }
      if(_loc5_ != "")
      {
         var _loc13_ = _global.CScaleformComponent_Predictions.GetProPlayerCode(_loc5_);
         var _loc12_ = "econ/tournaments/players/" + _loc13_ + ".png";
         LoadImage(_loc12_,_loc3_.PlayerImage,32,32,false);
         _loc3_.PlayerImage._visible = true;
         var _loc9_ = _global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(_loc5_,Number(m_numTournamentID),"team");
         GetAndLoadPlayerStickerBasedOnID(m_strEventId,_loc9_,_loc5_,_loc3_.StickerImage);
         _loc3_._parent.PlayerName.htmlText = _global.CScaleformComponent_Predictions.GetProPlayerNick(_loc5_);
         var _loc8_ = _global.CScaleformComponent_Predictions.GetSectionTeamStatus(m_strEventId,m_ObjDaySelected._DayID,Number(_loc9_),_loc5_);
         if(_loc8_ == "eliminated" || _loc8_ == "byeday")
         {
            _loc3_._parent.PointsEarned.htmlText = "#CSGO_Fantasy_Player_Status_" + _loc8_;
            _loc3_._parent.PointsEarned._alpha = 80;
         }
         else
         {
            var _loc11_ = _global.CScaleformComponent_Fantasy.ComputeProPlayerMatchFantasyScore(m_strEventId,_loc5_,"" + m_numTournamentID + "/stage" + m_ObjDaySelected._DayIndex,_loc4_);
            if(_loc11_ == undefined)
            {
               _loc3_._parent.PointsEarned.htmlText = "#CSGO_Fantasy_Team_PointsNone";
               _loc3_._parent.PointsEarned._alpha = 30;
            }
            else
            {
               var _loc7_ = _global.GameInterface.Translate("#CSGO_Fantasy_Team_PointsEarned");
               _loc7_ = _global.ConstructString(_loc7_,_loc11_);
               _loc3_._parent.PointsEarned.htmlText = _loc7_;
               _loc3_._parent.PointsEarned._alpha = 100;
            }
         }
         _loc3_._parent.PointsEarned._visible = true;
         if(numPickIndex == _loc4_)
         {
            AddFantasyPlayerAnim(_loc3_);
         }
         if(!bLockPick)
         {
            _loc6_._visible = true;
         }
         _loc6_.Action = function()
         {
            onRemoveFantasyPick(this);
         };
      }
      _loc3_._PlayerID = _loc5_;
      if(bLockPick)
      {
         _loc3_.Action = function()
         {
         };
      }
      else
      {
         _loc3_.Action = function()
         {
            onSelectFantasyPick(this);
         };
      }
      _loc3_.RolledOver = function()
      {
         ShowHideFantasyTooltip(true,this);
      };
      _loc3_.RolledOut = function()
      {
         ShowHideFantasyTooltip(false,this);
      };
      if(bDayChange)
      {
         AnimFantasyPlayerPicks(_loc3_);
      }
      _loc4_ = _loc4_ + 1;
   }
}
function AnimFantasyPlayerPicks(objPick)
{
   new Lib.Tween(objPick,"_xscale",mx.transitions.easing.Bounce.easeOut,110,100,0.75,true);
   new Lib.Tween(objPick,"_yscale",mx.transitions.easing.Bounce.easeOut,110,100,0.75,true);
   new Lib.Tween(objPick.White,"_alpha",mx.transitions.easing.Strong.easeOut,80,0,0.75,true);
}
function AddFantasyPlayerAnim(objPick)
{
   new Lib.Tween(objPick.PlayerImage,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.75,true);
   new Lib.Tween(objPick.PlayerImage,"_y",mx.transitions.easing.Strong.easeOut,100,-49.25,0.75,true);
   new Lib.Tween(objPick.StickerImage,"_xscale",mx.transitions.easing.Bounce.easeOut,300,140,1,true);
   new Lib.Tween(objPick.StickerImage,"_yscale",mx.transitions.easing.Bounce.easeOut,300,140,1,true);
}
function HasDaysMatchesStarted(numDayID)
{
   var _loc2_ = _global.CScaleformComponent_Predictions.GetSectionGroupsLockedCount(m_strEventId,numDayID);
   if(_loc2_ > 0)
   {
      return true;
   }
   return false;
}
function onSelectFantasyPick(objPick, bRemove)
{
   var _loc2_ = 0;
   while(_loc2_ < 5)
   {
      var _loc3_ = this.FantasyTeam["Pick" + _loc2_].BtnPick;
      _loc3_.Selected._visible = false;
      _loc2_ = _loc2_ + 1;
   }
   if(objPick == null)
   {
      return undefined;
   }
   m_ObjSelectedPick = objPick;
   objPick.Selected._visible = true;
   if(objPick._PlayerID != "" && !bRemove)
   {
      m_strLockedPlayerID = objPick._PlayerID;
      onSelectFantasyStat(m_ObjSelectedRole,true);
   }
   else
   {
      UpdateRows();
   }
   var _loc5_ = this.FantasyTeam.StatTable["BtnStat" + objPick._Index];
   HighlightSelectedStatInTable(_loc5_);
   LoadFantasyTeamData(HasDaysMatchesStarted(m_ObjDaySelected._DayID),-1);
   new Lib.Tween(objPick.Selected,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
}
function onRemoveFantasyPick(objPick)
{
   UpdateNotSubmittedTeam(true,objPick);
   trace("-------------------------------objPick._Index--------------------" + objPick._Index);
}
function UpdateNotSubmittedTeam(bRemove, objPick, strPickID)
{
   if(bRemove)
   {
      m_aNotSubmittedTeam.splice(objPick._Index,1,"");
      objPick._parent.BtnPick.PlayerImage._visible = false;
      onSelectFantasyPick(objPick._parent.BtnPick,true);
   }
   else
   {
      m_aNotSubmittedTeam.splice(m_ObjSelectedPick._Index,1,strPickID);
      PickStatusPanel.Cancel.setDisabled(true);
      HidePickStatusPanel(m_numTournamentID);
      LoadFantasyTeamData(HasDaysMatchesStarted(m_ObjDaySelected._DayID),m_ObjSelectedPick._Index);
      HighlightSelectedStatInTable(null);
   }
   _global.MainMenuMovie.Panel.m_aNotSavedFantasyTeam = [];
   _global.MainMenuMovie.Panel.m_aNotSavedFantasyTeam = m_aNotSubmittedTeam;
   EnableDisableCommitButton();
   UpdateRows();
   trace("-------------------------------m_aNotSubmittedTeam--------------------" + m_aNotSubmittedTeam);
}
function EnableDisableCommitButton(bHasDaysMatchesStarted)
{
   var _loc4_ = this.FantasyTeam;
   var _loc5_ = 0;
   if(bHasDaysMatchesStarted)
   {
      _loc4_.BtnSubmitTeam.setDisabled(true);
      _loc4_.BtnSubmitTeam.Anim._visible = false;
      _loc4_.NumberOfPicks.htmlText = "";
      _loc4_.NotSubmittedWarning.htmlText = "";
      return undefined;
   }
   trace("-------------------------------m_strSubmittedTeam--------------------" + m_strSubmittedTeam);
   trace("-------------------------------m_strSubmittedTeam--------------------" + _global.MainMenuMovie.Panel.m_aNotSavedFantasyTeam.join(","));
   if(m_strSubmittedTeam == m_aNotSubmittedTeam.join(",") && m_strSubmittedTeam != ",,,," && m_strSubmittedTeam != undefined)
   {
      _loc4_.BtnSubmitTeam.setDisabled(true);
      _loc4_.BtnSubmitTeam.Anim._visible = false;
      _loc4_.NotSubmittedWarning.htmlText = "#CSGO_Fantasy_Team_Submitted";
      _loc4_.NotSubmittedWarning.textColor = 6656299;
      _loc4_.NumberOfPicks.htmlText = "";
      return undefined;
   }
   var _loc3_ = 0;
   while(_loc3_ < m_aNotSubmittedTeam.length)
   {
      if(m_aNotSubmittedTeam[_loc3_] != "" && m_aNotSubmittedTeam[_loc3_] != null && m_aNotSubmittedTeam[_loc3_] != undefined)
      {
         _loc5_ = _loc5_ + 1;
      }
      _loc3_ = _loc3_ + 1;
   }
   if(_loc5_ == 5)
   {
      _loc4_.BtnSubmitTeam.setDisabled(false);
      new Lib.Tween(_loc4_.BtnSubmitTeam,"_alpha",mx.transitions.easing.Bounce.easeOut,0,100,1,true);
      new Lib.Tween(_loc4_.BtnSubmitTeam,"_xscale",mx.transitions.easing.Bounce.easeOut,150,100,1,true);
      new Lib.Tween(_loc4_.BtnSubmitTeam,"_yscale",mx.transitions.easing.Bounce.easeOut,150,100,1,true);
      _loc4_.BtnSubmitTeam.Anim._visible = true;
   }
   else
   {
      _loc4_.BtnSubmitTeam.setDisabled(true);
      _loc4_.BtnSubmitTeam.Anim._visible = false;
   }
   var _loc6_ = _global.GameInterface.Translate("#CSGO_Fantasy_Number_Picks");
   _loc6_ = _global.ConstructString(_loc6_,_loc5_);
   _loc4_.NumberOfPicks.htmlText = _loc6_;
   _loc4_.NotSubmittedWarning.htmlText = "#CSGO_Fantasy_Team_NotSubmitted";
   if(_loc5_ < 5)
   {
      _loc4_.NumberOfPicks.textColor = 16750848;
      _loc4_.NotSubmittedWarning.textColor = 16750848;
   }
   else
   {
      _loc4_.NumberOfPicks.textColor = 6656299;
   }
}
function UpdateRows()
{
   var _loc2_ = m_numPage * NUM_TABLE_ROWS;
   var _loc1_ = 0;
   while(_loc1_ < NUM_TABLE_ROWS)
   {
      GetTableData(m_ObjSelectedRole._Stat,m_strEventId,m_numTournamentID,m_numPage,_loc1_,_loc2_);
      _loc2_ = _loc2_ + 1;
      _loc1_ = _loc1_ + 1;
   }
}
function onFilterStickers()
{
   m_bFilterStickers = !m_bFilterStickers;
   DeselectLockedPlayer();
   var _loc2_ = this.FantasyTeam.StatTable.StickerFilter;
   _loc2_.Selected._visible = m_bFilterStickers;
   _loc2_._parent.StickerHint._visible = m_bFilterStickers;
   FantasyTeam.StatTable.NoStickersMessage._visible = false;
   if(!m_bFilterStickers)
   {
      AnimTableRows();
      EnableDisableButtons();
      return undefined;
   }
   FilterOwnedPlayerStickers();
   if(m_bFilterStickers && (m_aPlayersWithStickers.length <= 0 || m_aPlayersWithStickers == undefined))
   {
      FantasyTeam.StatTable.NoStickersMessage._visible = true;
   }
   m_numPage = 0;
   AnimTableRows(true);
   EnableDisableButtons();
}
function FilterOwnedPlayerStickers()
{
   var _loc7_ = GetDataTournamentId(m_numTournamentID);
   var _loc6_ = _global.CScaleformComponent_Predictions.GetProPlayersSortedStatsListerCount(m_strEventId,Number(m_numTournamentID),m_ObjSelectedRole._Stat);
   m_aPlayersWithStickers = [];
   var _loc3_ = 0;
   while(_loc3_ < _loc6_)
   {
      var _loc4_ = _global.CScaleformComponent_Predictions.GetProPlayersSortedStatsListerAccount(m_strEventId,Number(_loc7_),m_ObjSelectedRole._Stat,_loc3_,"desc");
      var _loc5_ = _global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(_loc4_,Number(m_numTournamentID),"team");
      var _loc2_ = _global.CScaleformComponent_Predictions.GetMyPredictionItemIDForTeamID(m_strEventId,Number(_loc5_),_loc4_);
      if(_loc2_ != "" && _loc2_ != undefined && _loc2_ != 0 && _loc2_ != "0")
      {
         m_aPlayersWithStickers.push(_loc4_);
      }
      _loc3_ = _loc3_ + 1;
   }
}
function GetTableData(strSelectedRole, strEventId, numTournamentID, numPage, numIndex, numStartRowIndex, bHighlightPickInTableClearLockedPlayerId)
{
   if(m_bFilterStickers)
   {
      numPlayers = m_aPlayersWithStickers.length;
   }
   else
   {
      var numPlayers = _global.CScaleformComponent_Predictions.GetProPlayersSortedStatsListerCount(strEventId,Number(numTournamentID),strSelectedRole);
   }
   var _loc4_ = this.FantasyTeam.StatTable["Row" + numIndex];
   var _loc7_ = GetDataTournamentId(numTournamentID);
   var _loc9_ = "desc";
   _loc4_.TablePos.htmlText = numStartRowIndex + 1;
   if(strSelectedRole == "team")
   {
      _loc9_ = "asc";
      _loc7_ = numTournamentID;
   }
   else if(strSelectedRole == "name")
   {
      _loc7_ = numTournamentID;
   }
   if(numStartRowIndex < numPlayers)
   {
      if(m_bFilterStickers)
      {
         var _loc3_ = m_aPlayersWithStickers[numStartRowIndex];
      }
      else
      {
         _loc3_ = _global.CScaleformComponent_Predictions.GetProPlayersSortedStatsListerAccount(strEventId,Number(_loc7_),strSelectedRole,Number(numStartRowIndex),_loc9_);
      }
   }
   else
   {
      _loc3_ = undefined;
   }
   if(_loc3_ == undefined || _loc3_ == null || _loc3_ == "" || _loc3_ == 0)
   {
      _loc4_._visible = false;
   }
   else
   {
      _loc4_._visible = true;
      FillOutTableRow(_loc3_,numTournamentID,strEventId,_loc4_,strSelectedRole,bHighlightPickInTableClearLockedPlayerId);
      trace("-------------------------------------------strPlayerId-------------------------------------" + _loc3_);
      if(numIndex % 2)
      {
         _loc4_.Bg._alpha = 20;
      }
      else
      {
         _loc4_.Bg._alpha = 50;
      }
   }
   if(m_strLockedPlayerID == _loc3_)
   {
      return true;
   }
   return false;
}
function FillOutTableRow(strPlayerId, numTournamentID, strEventId, objRow, strSelectedRole, bHighlightPickInTableClearLockedPlayerId)
{
   objRow.Highlight0._alpha = 0;
   objRow.Highlight1._alpha = 0;
   objRow.Highlight2._alpha = 0;
   objRow.Highlight3._alpha = 0;
   objRow.Highlight4._alpha = 0;
   objRow.HighlightTeam._alpha = 0;
   objRow.HighlightPlayer._alpha = 0;
   objRow.HighlightMatches._alpha = 0;
   var _loc10_ = "econ/tournaments/teams/";
   var _loc5_ = GetDataTournamentId(numTournamentID);
   var _loc6_ = _global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(strPlayerId,Number(numTournamentID),"team");
   var _loc7_ = _global.CScaleformComponent_Predictions.GetTeamTag(Number(_loc6_));
   _loc7_ = _loc7_.toLowerCase();
   LoadImage(_loc10_ + _loc7_ + ".png",objRow.TeamImage,32,32,false);
   var _loc13_ = _global.CScaleformComponent_Predictions.GetProPlayerCode(strPlayerId);
   var _loc11_ = "econ/tournaments/players/" + _loc13_ + ".png";
   LoadImage(_loc11_,objRow.PlayerImage,32,32,false);
   objRow.Name.htmlText = _global.CScaleformComponent_Predictions.GetProPlayerNick(strPlayerId);
   var _loc8_ = _global.CScaleformComponent_Predictions.GetSectionTeamStatus(strEventId,m_ObjDaySelected._DayID,Number(_loc6_),strPlayerId);
   if(_loc8_ == "eliminated" || _loc8_ == "byeday")
   {
      objRow.Status.htmlText = "#CSGO_Fantasy_Player_Status_" + _loc8_;
      objRow.Status._visible = true;
   }
   else
   {
      objRow.Status._visible = false;
   }
   objRow.Matches.htmlText = CheckIfRowDataIsValid(_global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(strPlayerId,Number(_loc5_),"matches_played"));
   var _loc15_ = CheckIfRowDataIsValid(_global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(strPlayerId,Number(_loc5_),"enemy_kills"));
   var _loc16_ = CheckIfRowDataIsValid(_global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(strPlayerId,Number(_loc5_),"deaths"));
   objRow.cat0.htmlText = _loc15_ + " / " + _loc16_;
   objRow.cat1.htmlText = CheckIfRowDataIsValid(_global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(strPlayerId,Number(_loc5_),STR_STAT1));
   objRow.cat2.htmlText = CheckIfRowDataIsValid(_global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(strPlayerId,Number(_loc5_),STR_STAT2));
   objRow.cat3.htmlText = CheckIfRowDataIsValid(_global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(strPlayerId,Number(_loc5_),STR_STAT3));
   objRow.cat4.htmlText = CheckIfRowDataIsValid(_global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(strPlayerId,Number(_loc5_),STR_STAT4));
   objRow.BtnAdd._visible = true;
   objRow.BtnAdd.dialog = this;
   objRow.BtnAdd._TeamTag = _loc7_;
   objRow.BtnAdd._TournamentID = numTournamentID;
   objRow.BtnAdd._EventID = strEventId;
   objRow.BtnAdd._TeamID = _loc6_;
   objRow.BtnAdd._PlayerID = strPlayerId;
   objRow.BtnAdd._RoleIndex = m_ObjSelectedPick._Index;
   objRow.BtnAdd._Role = "#CSGO_Fantasy_Team_Cat_" + m_ObjSelectedPick._Index;
   if(GetAndLoadPlayerStickerBasedOnID(strEventId,_loc6_,strPlayerId,objRow.StickerImage))
   {
      objRow.BtnAdd.Action = function()
      {
         this.dialog.UpdateNotSubmittedTeam(false,this._RoleIndex,this._PlayerID);
      };
   }
   else
   {
      objRow.BtnAdd.Action = function()
      {
         this.dialog.onMakePick(this,false,this._PlayerID,true);
      };
   }
   objRow.BtnPlayerSelect.dialog = this;
   if(m_strLockedPlayerID == strPlayerId && bHighlightPickInTableClearLockedPlayerId)
   {
      objRow.BtnPlayerSelect.Selected._visible = false;
      objRow.BtnPlayerSelect.Pin._visible = false;
      objRow.Name.textColor = "0xFFFFFF";
      objRow.Matches.textColor = "0xFFFFFF";
      objRow.cat0.textColor = "0xFFFFFF";
      objRow.cat1.textColor = "0xFFFFFF";
      objRow.cat2.textColor = "0xFFFFFF";
      objRow.cat3.textColor = "0xFFFFFF";
      objRow.cat4.textColor = "0xFFFFFF";
      trace("-------------------------------------------HIDE ME-------------------------------------" + bHighlightPickInTableClearLockedPlayerId);
      DeselectLockedPlayer();
   }
   else if(m_strLockedPlayerID == strPlayerId)
   {
      objRow.BtnPlayerSelect.Selected._visible = true;
      objRow.BtnPlayerSelect.Pin._visible = true;
      trace("-------------------------------------------SHOW ME-------------------------------------" + bHighlightPickInTableClearLockedPlayerId);
   }
   else
   {
      objRow.BtnPlayerSelect.Selected._visible = false;
      objRow.BtnPlayerSelect.Pin._visible = false;
   }
   objRow.BtnPlayerSelect._TeamTag = _loc7_;
   objRow.BtnPlayerSelect._TeamID = _loc6_;
   objRow.BtnPlayerSelect._PlayerID = strPlayerId;
   objRow.BtnPlayerSelect.Action = function()
   {
      this.dialog.onLockPlayerInTable(this);
   };
   if(m_ObjSelectedPick == null || IsAldeadyPicked(strPlayerId))
   {
      objRow.BtnAdd.setDisabled(true);
   }
   else
   {
      objRow.BtnAdd.setDisabled(false);
   }
   objRow["BtnStat" + m_ObjSelectedRole._Index].textColor = 16777215;
   objRow["Highlight" + m_ObjSelectedRole._Index]._alpha = 10;
   GetAndLoadPlayerStickerBasedOnID(strEventId,_loc6_,strPlayerId,objRow.StickerImage);
}
function GetDataTournamentId(numTournamentID)
{
   if(m_bShowCurrentTournamentStats)
   {
      return numTournamentID;
   }
   return numTournamentID - 1;
}
function IsAldeadyPicked(strPlayerId)
{
   var _loc1_ = 0;
   while(_loc1_ < m_aNotSubmittedTeam.length)
   {
      if(strPlayerId == m_aNotSubmittedTeam[_loc1_])
      {
         return true;
      }
      _loc1_ = _loc1_ + 1;
   }
   return false;
}
function GetAndLoadPlayerStickerBasedOnID(strEventId, numTeamId, strPlayerId, objImage)
{
   var _loc2_ = _global.CScaleformComponent_Predictions.GetMyPredictionItemIDForTeamID(strEventId,Number(numTeamId),strPlayerId);
   unloadMovie(objImage.StickerImagePath);
   if(_loc2_ != "" && _loc2_ != undefined && _loc2_ != 0 && _loc2_ != "0")
   {
      var _loc4_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(m_PlayerXuid,_loc2_) + ".png";
      LoadImage(_loc4_,objImage,48,32,false);
      objImage._visible = true;
      return true;
   }
   objImage._visible = false;
   return false;
}
function CheckIfRowDataIsValid(numData)
{
   if(numData != -1 && numData != null && numData != undefined && numData != "")
   {
      return numData;
   }
   return "N/A";
}
function HighlightSelectedStatInTable(BtnSelected)
{
   var _loc2_ = 0;
   while(_loc2_ < 5)
   {
      var _loc3_ = this.FantasyTeam.StatTable["BtnStat" + _loc2_];
      _loc3_.SelectedRole._visible = false;
      _loc2_ = _loc2_ + 1;
   }
   if(BtnSelected != null)
   {
      BtnSelected.SelectedRole._visible = true;
   }
}
function onSelectFantasyStat(BtnSelected, bHighlightPickInTableClearLockedPlayerId)
{
   var _loc4_ = false;
   var _loc2_ = 0;
   if(m_ObjSelectedRole == BtnSelected && m_numPage == 0 && !bHighlightPickInTableClearLockedPlayerId)
   {
      UpdateRows();
      EnableDisableButtons();
      trace("------------------------------------StartRows------------------");
      return undefined;
   }
   m_ObjSelectedRole.ButtonText.Text.htmlText = _global.GameInterface.Translate("#CSGO_Fantasy_Team_Stat_" + m_ObjSelectedRole._Index);
   BtnSelected.ButtonText.Text.htmlText = _global.GameInterface.Translate("#CSGO_Fantasy_Team_Stat_" + BtnSelected._Index) + " " + "▼";
   m_ObjSelectedRole.Selected._visible = false;
   m_ObjSelectedRole = BtnSelected;
   BtnSelected.Selected._visible = true;
   if(m_bFilterStickers)
   {
      FilterOwnedPlayerStickers();
   }
   if(m_strLockedPlayerID != "")
   {
      _loc2_ = GetPageOfLockedPlayer(m_strLockedPlayerID);
      if(m_numPage == _loc2_)
      {
         _loc4_ = true;
      }
      m_numPage = _loc2_;
   }
   else
   {
      m_numPage = 0;
   }
   AnimTableRows(true,bHighlightPickInTableClearLockedPlayerId,_loc4_);
   EnableDisableButtons();
}
function GetPageOfLockedPlayer(strPlayerIdToFind)
{
   var _loc5_ = GetDataTournamentId(m_numTournamentID);
   if(m_bFilterStickers)
   {
      var _loc6_ = m_aPlayersWithStickers.length;
   }
   else
   {
      _loc6_ = _global.CScaleformComponent_Predictions.GetProPlayersSortedStatsListerCount(m_strEventId,Number(_loc5_),m_ObjSelectedRole._Stat);
   }
   var _loc4_ = -1;
   var _loc2_ = 0;
   while(_loc2_ < _loc6_)
   {
      if(m_bFilterStickers)
      {
         var _loc3_ = m_aPlayersWithStickers[_loc2_];
      }
      else if(m_ObjSelectedRole._Stat == "team")
      {
         _loc3_ = _global.CScaleformComponent_Predictions.GetProPlayersSortedStatsListerAccount(m_strEventId,Number(m_numTournamentID),m_ObjSelectedRole._Stat,_loc2_,"asc");
      }
      else
      {
         _loc3_ = _global.CScaleformComponent_Predictions.GetProPlayersSortedStatsListerAccount(m_strEventId,Number(_loc5_),m_ObjSelectedRole._Stat,_loc2_,"desc");
      }
      if(strPlayerIdToFind == _loc3_)
      {
         _loc4_ = _loc2_;
      }
      _loc2_ = _loc2_ + 1;
   }
   if(_loc4_ != -1)
   {
      trace("---------------------------------------GetPageOfLockedPlayerPAGE-------------------------" + Math.ceil(_loc4_ / NUM_TABLE_ROWS));
      var _loc8_ = Math.ceil((_loc4_ + 1) / NUM_TABLE_ROWS) - 1;
      if(_loc8_ < 0)
      {
         _loc8_ = 0;
      }
      return _loc8_;
   }
}
function HighlightTable(strPrevSelectedStat, strSelectedStat)
{
   var _loc2_ = 0;
   while(_loc2_ < NUM_TABLE_ROWS)
   {
      var _loc3_ = this.FantasyTeam.StatTable["Row" + _loc2_];
      _loc3_[strSelectedStat].textColor = 16777215;
      if(strPrevSelectedStat != "" || strPrevSelectedStat != undefined)
      {
         _loc3_[strPrevSelectedStat].textColor = 6710886;
      }
      _loc2_ = _loc2_ + 1;
   }
}
function onLockPlayerInTable(ObjPlayerRow)
{
   if(m_strLockedPlayerID == ObjPlayerRow._PlayerID)
   {
      DeselectLockedPlayer(ObjPlayerRow);
      return undefined;
   }
   var _loc2_ = 0;
   while(_loc2_ < NUM_TABLE_ROWS)
   {
      var _loc3_ = this.FantasyTeam.StatTable["Row" + _loc2_];
      _loc3_.BtnPlayerSelect.Selected._visible = false;
      _loc3_.BtnPlayerSelect.Pin._visible = false;
      _loc2_ = _loc2_ + 1;
   }
   m_ObjLockedPlayer = ObjPlayerRow;
   m_strLockedPlayerID = ObjPlayerRow._PlayerID;
   ObjPlayerRow.Selected._visible = true;
   ObjPlayerRow.Pin._visible = true;
   new Lib.Tween(ObjPlayerRow.Selected,"_alpha",mx.transitions.easing.Strong.easeOut,0,20,0.5,true);
   new Lib.Tween(ObjPlayerRow.Selected,"_yscale",mx.transitions.easing.Strong.easeOut,100,50,0.5,true);
   new Lib.Tween(ObjPlayerRow.Selected,"_y",mx.transitions.easing.Strong.easeOut,0,6,0.5,true);
}
function DeselectLockedPlayer(ObjPlayerRow)
{
   ObjPlayerRow.Selected._visible = false;
   ObjPlayerRow.Pin._visible = false;
   m_ObjLockedPlayer = null;
   m_strLockedPlayerID = "";
}
function onScrollPress(btnScroll, bNext)
{
   if(bNext && m_numPage < GetMaxPages())
   {
      m_numPage = m_numPage + 1;
   }
   else if(m_numPage >= 1)
   {
      m_numPage = m_numPage - 1;
   }
   AnimTableRows(bNext);
   EnableDisableButtons();
}
function EnableDisableButtons()
{
   var _loc2_ = this.FantasyTeam.StatTable.BtnPrev;
   var _loc3_ = this.FantasyTeam.StatTable.BtnNext;
   trace("-----------------------------m_numPage--------------------------" + m_numPage);
   if(m_numPage <= 0)
   {
      _loc2_.setDisabled(true);
   }
   else
   {
      _loc2_.setDisabled(false);
   }
   if(m_numPage >= GetMaxPages() - 1)
   {
      _loc3_.setDisabled(true);
   }
   else
   {
      _loc3_.setDisabled(false);
   }
}
function GetMaxPages()
{
   var _loc1_ = NUM_MAX_PAGES;
   if(m_bFilterStickers)
   {
      _loc1_ = Math.ceil(m_aPlayersWithStickers.length / 5);
   }
   return _loc1_;
}
function AnimTableRows(bNext, bHighlightPickInTableClearLockedPlayerId, bSkipPlayAnims)
{
   var numStartRowIndex = m_numPage * NUM_TABLE_ROWS;
   if(bNext)
   {
      var numLoop = 0;
      this.onEnterFrame = function()
      {
         var _loc3_ = GetTableData(m_ObjSelectedRole._Stat,m_strEventId,m_numTournamentID,m_numPage,numLoop,numStartRowIndex,bHighlightPickInTableClearLockedPlayerId);
         numStartRowIndex = numStartRowIndex + 1;
         trace("-------------------------------------------AnimTableRows------------------------------------" + bHighlightPickInTableClearLockedPlayerId);
         var _loc2_ = this.FantasyTeam.StatTable["Row" + numLoop];
         if(!_loc3_ && !bSkipPlayAnims)
         {
            new Lib.Tween(_loc2_,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
            new Lib.Tween(_loc2_,"_yscale",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
         }
         if(numLoop >= NUM_TABLE_ROWS)
         {
            delete this.onEnterFrame;
         }
         numLoop++;
      };
   }
   else
   {
      var numLoop = NUM_TABLE_ROWS - 1;
      numStartRowIndex = numStartRowIndex + NUM_TABLE_ROWS;
      this.onEnterFrame = function()
      {
         numStartRowIndex = numStartRowIndex - 1;
         var _loc3_ = GetTableData(m_ObjSelectedRole._Stat,m_strEventId,m_numTournamentID,m_numPage,numLoop,numStartRowIndex);
         if(!_loc3_)
         {
            var _loc2_ = this.FantasyTeam.StatTable["Row" + numLoop];
            new Lib.Tween(_loc2_,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
            new Lib.Tween(_loc2_,"_yscale",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
         }
         if(numLoop == 0)
         {
            delete this.onEnterFrame;
         }
         numLoop--;
      };
   }
}
function ShowHideFantasyTooltip(bShow, objPick)
{
   var _loc3_ = this.FantasyTeam.Tooltip;
   var _loc5_ = 10;
   _loc3_.Stats._visible = false;
   _loc3_.Points._visible = false;
   if(!bShow)
   {
      _loc3_._visible = false;
   }
   else
   {
      _loc3_.Desc.htmlText = "#CSGO_Fantasy_Team_Cat_" + objPick._Index + "_Tooltip";
      _loc3_.Desc.autoSize = "left";
      _global.AutosizeTextDown(_loc3_.Stats,7);
      if(objPick._PlayerID != "" && GetFantasyPointsForTooltip(objPick._Index,objPick._PlayerID))
      {
         _loc3_.Stats._y = _loc5_ + _loc3_.Desc._y + _loc3_.Desc._height;
         _loc3_.Points._y = _loc3_.Stats._y;
         _loc3_.Bg._height = _loc3_.Desc._height + _loc3_.Stats._height + _loc5_ * 2;
         _loc3_.Stats._visible = true;
         _loc3_.Points._visible = true;
      }
      else
      {
         _loc3_.Bg._height = _loc3_.Desc._height + _loc5_;
      }
      _loc3_._visible = true;
      _loc3_._x = objPick._parent._x + objPick._width;
      new Lib.Tween(_loc3_,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
   }
}
function GetFantasyPointsForTooltip(numIndex, PlayerId)
{
   var _loc7_ = this.FantasyTeam.Tooltip;
   var _loc3_ = this["STR_STAT" + numIndex];
   var _loc6_ = "stage" + m_ObjDaySelected._DayIndex;
   var _loc4_ = _global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(PlayerId,Number(m_numTournamentID),_loc6_ + "/" + "enemy_kills");
   var _loc5_ = _global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(PlayerId,Number(m_numTournamentID),_loc6_ + "/" + "deaths");
   var _loc8_ = _global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(PlayerId,Number(m_numTournamentID),_loc6_ + "/" + _loc3_);
   if(_loc4_ == undefined || _loc5_ == undefined || _loc8_ == undefined)
   {
      return false;
   }
   if(numIndex == 0)
   {
      var _loc9_ = _loc4_ + "\n" + _loc5_;
      var _loc10_ = _global.GameInterface.Translate("#CSGO_Fantasy_Tooltip_Stats_Kills") + "\n" + _global.GameInterface.Translate("#CSGO_Fantasy_Tooltip_Stats_Deaths") + "\n";
   }
   else
   {
      _loc3_ = _global.GameInterface.Translate("#CSGO_Fantasy_Tooltip_Stat_" + numIndex);
      _loc9_ = _loc4_ + "\n" + _loc5_ + "\n" + _loc8_;
      _loc10_ = _global.GameInterface.Translate("#CSGO_Fantasy_Tooltip_Stats_Kills") + "\n" + _global.GameInterface.Translate("#CSGO_Fantasy_Tooltip_Stats_Deaths") + "\n" + _loc3_;
   }
   _loc7_.Points.htmlText = _loc9_;
   _loc7_.Stats.htmlText = _loc10_;
   _global.AutosizeTextDown(_loc7_.Stats,7);
   return true;
}
function SetUpSetPredictionStatusPanelFantasyTeam(numTournamentID, numDayID, strEventId, aSteamIds)
{
   ShowPickStatusPanel(numTournamentID);
   ResetStatusPickStatusPanel(numTournamentID);
   PickStatusPanel.Team._visible = true;
   var _loc11_ = new Array();
   var _loc3_ = 0;
   while(_loc3_ < 5)
   {
      var _loc5_ = PickStatusPanel.Team["Pick" + _loc3_];
      var _loc9_ = _global.CScaleformComponent_Predictions.GetProPlayerCode(aSteamIds[_loc3_]);
      var _loc8_ = "econ/tournaments/players/" + _loc9_ + ".png";
      var _loc7_ = _global.CScaleformComponent_Predictions.GetProPlayerStatForEventID(aSteamIds[_loc3_],Number(numTournamentID),"team");
      _loc5_.Name.htmlText = _global.CScaleformComponent_Predictions.GetProPlayerNick(aSteamIds[_loc3_]);
      LoadImage(_loc8_,_loc5_.PlayerImage,32,32,false);
      var _loc4_ = _global.CScaleformComponent_Predictions.GetMyPredictionItemIDForTeamID(strEventId,Number(_loc7_),aSteamIds[_loc3_]);
      if(_loc4_ != "" && _loc4_ != undefined && _loc4_ != 0 && _loc4_ != "0")
      {
         _loc11_.push(_loc4_);
         var _loc10_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(m_PlayerXuid,_loc4_) + ".png";
         LoadImage(_loc10_,_loc5_.StickerImage,48,32,false);
         _loc5_.StickerImage._visible = true;
      }
      else
      {
         objImage._visible = false;
      }
      _loc3_ = _loc3_ + 1;
   }
   PickStatusPanel.Text.htmlText = "#CSGO_Fantasy_Apply_Player_Title";
   PickStatusPanel.Warning.htmlText = "#CSGO_Fantasy_Apply_Warning";
   PickStatusPanel.Accept.dialog = this;
   PickStatusPanel.Accept.SetText("#CSGO_Fantasy_Make_Pick");
   if(_loc11_.length == 5)
   {
      var strStickers = _loc11_.join(",");
      PickStatusPanel.Accept.Action = function()
      {
         this.dialog.SetMyFantasyTeamPicksForSectionID(strEventId,numDayID,strStickers);
      };
      PickStatusPanel.Accept.setDisabled(false);
   }
   else
   {
      PickStatusPanel.Accept.setDisabled(true);
      PickStatusPanel.Timeout._visible = true;
      PickStatusPanel.Timeout.Text.htmlText = "#CSGO_PickEm_Roster_TimeOut";
   }
   PickStatusPanel.Accept.setDisabled(false);
   PickStatusPanel.Accept._visible = true;
   UpdateSpacingForTextAndButtons();
}
function SetMyFantasyTeamPicksForSectionID(strEventId, numDayID, strStickers)
{
   trace("-----------------------------strEventId------------------------------" + strEventId);
   trace("-----------------------------numDayID------------------------------" + numDayID);
   trace("-----------------------------strStickers------------------------------" + strStickers);
   _global.CScaleformComponent_Fantasy.SetMyFantasyTeamPicksForSectionID(strEventId,numDayID,strStickers);
   PickStatusPanel.Accept.setDisabled(true);
   PickStatusPanel.Cancel.setDisabled(true);
   PickStatusPanel.Status.Text.htmlText = "#CSGO_PickEm_Pick_Submitting";
   PickStatusPanel.Status._visible = true;
   TimeOutForFantasyPredictions();
}
function TimeOutForFantasyPredictions()
{
   var numLoop = 0;
   PickStatusPanel.onEnterFrame = function()
   {
      if(numLoop > 150)
      {
         PredictionTimeOut();
         delete PickStatusPanel.onEnterFrame;
      }
      numLoop++;
   };
}
function FantasyTeamPredictionUploaded(Type, sectionID)
{
   if(Type = m_strEventId && sectionID == m_ObjDaySelected._DayID)
   {
      delete PickStatusPanel.onEnterFrame;
      HidePickStatusPanel(m_numTournamentID);
      onSelectFantasyDay(m_ObjDaySelected);
      FantasySubmittedAnim();
   }
}
function FantasySubmittedAnim()
{
   var numLoop = 0;
   this.onEnterFrame = function()
   {
      var _loc2_ = this.FantasyTeam["Pick" + numLoop].BtnPick;
      new Lib.Tween(_loc2_.Check,"_alpha",mx.transitions.easing.Strong.easeIn,80,0,1,true);
      if(numLoop >= 5)
      {
         delete this.onEnterFrame;
      }
      numLoop++;
   };
}
function GetStoreIdForTeamsInActiveTournament(strTeamTag, numTournamentId)
{
   if(numTournamentId == _global.CScaleformComponent_News.GetActiveTournamentEventID())
   {
      var _loc2_ = 0;
      while(_loc2_ < m_aTeamIdItems.length)
      {
         if(m_aTeamIdItems[_loc2_].teamid == strTeamTag)
         {
            return m_aTeamIdItems[_loc2_].itemid;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   return null;
}
function GetTeamItems()
{
   return m_aTeamIdItems;
}
function GetPlayerItems()
{
   return m_aTeamIdPlayers;
}
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var m_PredictionCallbackConfirmed = false;
var m_PredictionCallbackConfirmedGroupID = groupID;
var m_PredictionCallbackConfirmedTeamID = teamID;
var m_numTimerDelay = 4000;
var m_bCanHideGroupTooltip = true;
var filterBlur = new flash.filters.BlurFilter(10,10,1);
var filterUnBlur = new flash.filters.BlurFilter(1,1,1);
var m_numTournamentID = 0;
var m_numPage = 0;
var NUM_TABLE_ROWS = 5;
var NUM_MAX_PAGES = 16;
var m_numTournamentID = 0;
var m_strEventId = "";
var m_ObjSelectedRole = null;
var m_ObjSelectedPick = null;
var m_ObjLockedPlayer = null;
var m_ObjDaySelected = null;
var m_bFilterStickers = false;
var m_strLockedPlayerID = "";
var m_bShowCurrentTournamentStats = false;
var STR_STAT0 = "KDR";
var STR_STAT1 = "clutch_kills";
var STR_STAT2 = "pistol_kills";
var STR_STAT3 = "opening_kills";
var STR_STAT4 = "sniper_kills";
var STR_CATAGORY0 = "estimated_avg_match_points_fantasy_slot_0";
var STR_CATAGORY1 = "estimated_avg_match_points_fantasy_slot_1";
var STR_CATAGORY2 = "estimated_avg_match_points_fantasy_slot_2";
var STR_CATAGORY3 = "estimated_avg_match_points_fantasy_slot_3";
var STR_CATAGORY4 = "estimated_avg_match_points_fantasy_slot_4";
var m_strSubmittedTeam = "";
var m_aNotSubmittedTeam = new Array();
var m_aPlayersWithStickers = new Array();
var m_aTeamIdItems = new Array({itemid:4253,teamid:"esl"},{itemid:4254,teamid:"legends"},{itemid:4255,teamid:"challengers"},{itemid:-1,teamid:""},{itemid:4246,teamid:"sk"},{itemid:4244,teamid:"navi"},{itemid:4242,teamid:"liq"},{itemid:4249,teamid:"astr"},{itemid:4245,teamid:"vp"},{itemid:4239,teamid:"clg"},{itemid:4251,teamid:"fntc"},{itemid:4237,teamid:"nip"},{itemid:4250,teamid:"nv"},{itemid:4241,teamid:"flip"},{itemid:4238,teamid:"optc"},{itemid:4243,teamid:"mss"},{itemid:4248,teamid:"faze"},{itemid:4252,teamid:"dig"},{itemid:4240,teamid:"gamb"},{itemid:4247,teamid:"g2"});
var m_aTeamIdPlayers = new Array({itemid:-1,teamid:""},{itemid:4257,teamid:"group2"},{itemid:4256,teamid:"group1"},{itemid:-1,teamid:""},{itemid:4267,teamid:""},{itemid:4265,teamid:""},{itemid:4263,teamid:""},{itemid:4270,teamid:""},{itemid:4266,teamid:""},{itemid:4260,teamid:""},{itemid:4272,teamid:""},{itemid:4258,teamid:""},{itemid:4271,teamid:""},{itemid:4262,teamid:""},{itemid:4259,teamid:""},{itemid:4264,teamid:""},{itemid:4269,teamid:""},{itemid:4273,teamid:""},{itemid:4261,teamid:""},{itemid:4268,teamid:""});
stop();
