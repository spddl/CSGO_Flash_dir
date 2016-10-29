function GetMissionItemId(numActiveQuestID)
{
   trace("----------------------------------------GetMissionItemId-------------------------------" + numActiveQuestID);
   var _loc2_ = _global.CScaleformComponent_Inventory.GetQuestItemIDFromQuestID(numActiveQuestID);
   trace("----------------------------------------ItemID-------------------------------" + _loc2_);
   return _loc2_;
}
function ClearVoteNextMapPanel()
{
   if(timerRandomMapSelect)
   {
      clearInterval(timerRandomMapSelect);
      delete timerRandomMapSelect;
   }
   i = 0;
   while(i < NUM_MAPVOTE_PANELS)
   {
      var _loc8_ = "Target" + i;
      var _loc2_ = ScoreBoard.InnerScoreBoard.MapVotePanel[_loc8_];
      if(_loc2_)
      {
         var _loc7_ = "[" + (i + 1) + "]";
         if(i == 9)
         {
            _loc7_ = "[0]";
         }
         _loc2_.KeyBind.Text.htmlText = _loc7_;
         _loc2_.KeyBind._visible = true;
         j = 1;
         while(j <= NUM_MAPVOTE_CHECKS)
         {
            var _loc6_ = "YesImage" + j;
            var _loc4_ = _loc2_[_loc6_];
            if(_loc4_)
            {
               _loc4_._visible = false;
            }
            var _loc5_ = "Box" + j;
            var _loc3_ = _loc2_[_loc5_];
            if(_loc3_)
            {
               _loc3_._visible = false;
            }
            j++;
         }
         _loc2_._visible = false;
         _loc2_.WinnerHighlight._visible = false;
         _loc2_.SelectedHighlight._visible = false;
         _loc2_.ArrowSelected._visible = false;
         _loc2_.ArrowSelected.gotoAndPlay("stopAnim");
         _loc2_.dialog = this;
         _loc2_._MapIndex = i;
         _loc2_.Action = function()
         {
            VoteForMap(this);
         };
         _loc2_.setDisabled(false);
      }
      i++;
   }
}
function VoteForMap(VoteButton)
{
   _global.GameInterface.ConsoleCommand("endmatch_votenextmap " + VoteButton._MapIndex);
}
function GetNumPlayers()
{
   var _loc3_ = _global.CScaleformComponent_FriendsList.GetPlayerCount("ct");
   var _loc2_ = _global.CScaleformComponent_FriendsList.GetPlayerCount("t");
   var _loc4_ = gameAPI.GetGameMode();
   var _loc5_ = gameAPI.GetGameType();
   if(_loc5_ == 4 && (_loc4_ == 1 || _loc4_ == 0))
   {
      return "TwoPlayerCoop";
   }
   if(_loc3_ > 8 || _loc2_ > 8)
   {
      return "";
   }
   if(_loc3_ < 9 && _loc3_ > 5 || _loc2_ < 9 && _loc2_ > 5)
   {
      return "SixteenPlayer";
   }
   if(_loc3_ < 6 && _loc2_ < 6)
   {
      return "TenPlayer";
   }
   return "";
}
function ShowOvertimeVersion()
{
   ScoreBoard.InnerScoreBoard.gotoAndStop("Overtime" + GetNumPlayers());
}
function ShowFirstHalfVersion()
{
   ScoreBoard.InnerScoreBoard.gotoAndStop("FirstHalf" + GetNumPlayers());
}
function ShowSecondHalfVersion()
{
   ScoreBoard.InnerScoreBoard.gotoAndStop("SecondHalf" + GetNumPlayers());
}
function ShowStandardVersion()
{
   ScoreBoard.InnerScoreBoard.gotoAndStop("Standard" + GetNumPlayers());
}
function SelectPlayerRow(row, xuid)
{
   row.gotoAndStop("Over");
   m_selectedPlayerXuid = xuid;
}
function DeselectPlayerRow(row, xuid)
{
   row.gotoAndStop("Up");
   m_selectedPlayerXuid = xuid;
}
function SetPlayerNormal(nameMovie)
{
   nameMovie.gotoAndStop("Normal");
}
function SetPlayerDead(nameMovie)
{
   nameMovie.gotoAndStop("Dead");
}
function SetPlayerLocal(nameMovie)
{
   nameMovie.gotoAndStop("Local");
   strLocalPlayerName = nameMovie.Player_Name.text;
}
function SetPlayerDeadLocal(nameMovie)
{
   nameMovie.gotoAndStop("DeadLocal");
   strLocalPlayerName = nameMovie.Player_Name.text;
}
function resizeClanTag(row)
{
   _global.AutosizeTextDown(row.Clan_Name.Clan_Name,8);
}
function SetShouldShowPlayerColor(row, bShouldShow, nPlayerIndex)
{
   row.DynamicAvatar.AvatarContainer.SetShouldShowPlayerColor(bShouldShow,nPlayerIndex);
}
function SetTeamLogo(nTeamID, logoString)
{
   var _loc8_ = 3;
   var _loc6_ = 2;
   var _loc2_ = ScoreBoard.InnerScoreBoard.bg_scoreboard.TeamLogos.CTLogo;
   var _loc4_ = ScoreBoard.InnerScoreBoard.bg_scoreboard.TeamLogos.DefaultIconCT;
   if(nTeamID == _loc6_)
   {
      _loc2_ = ScoreBoard.InnerScoreBoard.bg_scoreboard.TeamLogos.TLogo;
      _loc4_ = ScoreBoard.InnerScoreBoard.bg_scoreboard.TeamLogos.DefaultIconT;
   }
   _loc2_._visible = false;
   _loc4_._visible = true;
   if(logoString == undefined || logoString == "")
   {
      return undefined;
   }
   trace("(scoreboard) SetTeamLogo to: " + logoString);
   _loc2_._visible = true;
   _loc4_._visible = false;
   if(nTeamID == _loc8_ && m_teamLogo_CT == logoString)
   {
      return undefined;
   }
   m_teamLogo_CT = logoString;
   if(nTeamID == _loc6_ && m_teamLogo_T == logoString)
   {
      return undefined;
   }
   m_teamLogo_T = logoString;
   logoString = "econ/tournaments/teams/" + logoString;
   if(_loc2_ != undefined)
   {
      _loc2_.unloadMovie();
   }
   var _loc3_ = new Object();
   _loc3_.onLoadInit = function(target_mc)
   {
      target_mc._width = m_nTeamLogoSize;
      target_mc._height = m_nTeamLogoSize;
   };
   _loc3_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc5_ = new MovieClipLoader();
   _loc5_.addListener(_loc3_);
   _loc5_.loadClip(logoString,_loc2_);
}
function ShowAvatar(row, nTeam, xuid, accountID, playerNameText, forceRefresh)
{
   row.DynamicAvatar._visible = true;
   row.DynamicAvatar.AvatarContainer.SetShowFlairItem(false);
   if(forceRefresh || row.xuid != xuid || row.playerNameText == undefined || row.playerNameText != playerNameText)
   {
      row.DynamicAvatar.AvatarContainer.ShowAvatar(nTeam,xuid,false,false);
      forceRefresh = true;
   }
   row.xuid = xuid;
   row.playerNameText = playerNameText;
   row.accountID = accountID;
   if(nTeam == 1 && row.DynamicAvatar._visible == true)
   {
      ScoreBoard.InnerScoreBoard.Spectator_Scoretable._visible = true;
      if(ScoreBoard.InnerScoreBoard.Spectator_Scoretable.Spectator_ScoreRow_0 == row)
      {
         var _loc2_ = gameAPI.IsLocalPlayerHLTV();
         ScoreBoard.InnerScoreBoard.Spectator_Scoretable.Caster_Settings_0._visible = _loc2_;
      }
   }
}
function HideAvatar(row)
{
   row.DynamicAvatar._visible = false;
   var _loc3_ = "CoinIcon";
   var _loc2_ = row[_loc3_];
   if(_loc2_)
   {
      _loc2_._visible = false;
      _loc2_.flLastFlairUpdate = 0;
   }
   var _loc8_ = "MusicIcon";
   var _loc9_ = row[_loc8_];
   _loc9_._visible = false;
   var _loc5_ = "XpIcon_00";
   var _loc4_ = row[_loc5_];
   _loc4_._visible = false;
   var _loc7_ = "RankIcon_00";
   var _loc6_ = row[_loc7_];
   _loc6_._visible = false;
   row.tIcon._visible = false;
   row.lIcon._visible = false;
   row.fIcon._visible = false;
   if(ScoreBoard.InnerScoreBoard.Spectator_Scoretable.Spectator_ScoreRow_0 == row)
   {
      ScoreBoard.InnerScoreBoard.Spectator_Scoretable.Caster_Settings_0._visible = false;
   }
}
function fillOutWinHistory()
{
   var _loc26_ = _global.ScoreboardAPI.AreTeamsPlayingSwitchedSides();
   var _loc16_ = int(_global.ScoreboardAPI.GetCurrentRound());
   if(m_nCurrentRound == _loc16_ && m_bPlayersSwitchedSides == _loc26_)
   {
      return undefined;
   }
   m_nCurrentRound = _loc16_;
   m_bPlayersSwitchedSides = _loc26_;
   ScoreBoard.InnerScoreBoard.GraphBounds1.clear();
   ScoreBoard.InnerScoreBoard.GraphBounds2.clear();
   m_nLastHistLine_Y = 0;
   m_nLastHistLine_X = 0;
   ScoreBoard.InnerScoreBoard.WinHistory_T.BG._visible = false;
   ScoreBoard.InnerScoreBoard.WinHistory_CT.BG._visible = false;
   if(_global.ScoreboardAPI.HasRoundDataToShow() == false)
   {
      ScoreBoard.InnerScoreBoard.WinHistory_T._visible = false;
      ScoreBoard.InnerScoreBoard.WinHistory_CT._visible = false;
      return undefined;
   }
   ScoreBoard.InnerScoreBoard.WinHistory_T._visible = true;
   ScoreBoard.InnerScoreBoard.WinHistory_CT._visible = true;
   var _loc8_ = 1;
   while(_loc8_ <= 30)
   {
      var _loc12_ = undefined;
      if(_loc8_ > 9)
      {
         _loc12_ = "Icon_" + _loc8_;
      }
      else
      {
         _loc12_ = "Icon_0" + _loc8_;
      }
      var _loc6_ = ScoreBoard.InnerScoreBoard.WinHistory_CT[_loc12_];
      _loc6_.Kill._visible = false;
      _loc6_.Bomb._visible = false;
      _loc6_.Hostage._visible = false;
      _loc6_.Defuse._visible = false;
      _loc6_.Time._visible = false;
      _loc6_.CurrentRound._visible = false;
      _loc6_.LostRound._visible = false;
      _loc6_.WinFade_B._visible = false;
      _loc6_.WinFade_T._visible = false;
      var _loc5_ = ScoreBoard.InnerScoreBoard.WinHistory_T[_loc12_];
      _loc5_.Kill._visible = false;
      _loc5_.Bomb._visible = false;
      _loc5_.Hostage._visible = false;
      _loc5_.Defuse._visible = false;
      _loc5_.Time._visible = false;
      _loc5_.CurrentRound._visible = false;
      _loc5_.LostRound._visible = false;
      _loc5_.WinFade_B._visible = false;
      _loc5_.WinFade_T._visible = false;
      ScoreBoard.InnerScoreBoard.WinHistory_T.Halftime._visible = false;
      ScoreBoard.InnerScoreBoard.WinHistory_CT.Halftime._visible = false;
      _loc8_ = _loc8_ + 1;
   }
   trace("fillOutWinHistory:   nRound = " + _loc16_);
   if(_loc16_ > 15)
   {
      ScoreBoard.InnerScoreBoard.WinHistory_CT.Halftime._visible = true;
   }
   var _loc28_ = ScoreBoard.InnerScoreBoard.GraphBounds1._height;
   var _loc27_ = ScoreBoard.InnerScoreBoard.GraphBounds1._width;
   _loc8_ = 1;
   while(_loc8_ <= _loc16_)
   {
      var _loc4_ = _loc16_ > 15 && _loc8_ <= 15 && _loc26_;
      if(_loc8_ > 9)
      {
         _loc12_ = "Icon_" + _loc8_;
      }
      else
      {
         _loc12_ = "Icon_0" + _loc8_;
      }
      trace("fillOutWinHistory:   iconName = " + _loc12_);
      _loc6_ = ScoreBoard.InnerScoreBoard.WinHistory_CT[_loc12_];
      _loc5_ = ScoreBoard.InnerScoreBoard.WinHistory_T[_loc12_];
      if(_loc8_ == _loc16_)
      {
         _loc5_.BG._visible = false;
         return undefined;
      }
      var _loc10_ = undefined;
      var _loc9_ = undefined;
      var _loc15_ = _global.CScaleformComponent_MatchStats.GetRoundWinResult(_loc8_);
      trace("fillOutWinHistory:   Result = " + _loc15_);
      var _loc3_ = undefined;
      var _loc11_ = undefined;
      var _loc7_ = undefined;
      switch(_loc15_)
      {
         case "ct_win_rescue":
            _loc10_ = "ct";
            _loc3_ = !_loc4_?_loc6_:_loc5_;
            _loc7_ = !_loc4_?"WinFade_B":"WinFade_T";
            _loc11_ = !_loc4_?_loc5_:_loc6_;
            _loc9_ = "Hostage";
            break;
         case "ct_win_defuse":
            _loc10_ = "ct";
            _loc3_ = !_loc4_?_loc6_:_loc5_;
            _loc7_ = !_loc4_?"WinFade_B":"WinFade_T";
            _loc11_ = !_loc4_?_loc5_:_loc6_;
            _loc9_ = "Defuse";
            break;
         case "ct_win_time":
            _loc10_ = "ct";
            _loc3_ = !_loc4_?_loc6_:_loc5_;
            _loc7_ = !_loc4_?"WinFade_B":"WinFade_T";
            _loc11_ = !_loc4_?_loc5_:_loc6_;
            _loc9_ = "Time";
            break;
         case "ct_win_elimination":
            _loc10_ = "ct";
            _loc3_ = !_loc4_?_loc6_:_loc5_;
            _loc7_ = !_loc4_?"WinFade_B":"WinFade_T";
            _loc11_ = !_loc4_?_loc5_:_loc6_;
            _loc9_ = "Kill";
            break;
         case "t_win_elimination":
            _loc10_ = "t";
            _loc3_ = !_loc4_?_loc5_:_loc6_;
            _loc7_ = !_loc4_?"WinFade_T":"WinFade_B";
            _loc11_ = !_loc4_?_loc6_:_loc5_;
            _loc9_ = "Kill";
            break;
         case "t_win_bomb":
            _loc10_ = "t";
            _loc3_ = !_loc4_?_loc5_:_loc6_;
            _loc7_ = !_loc4_?"WinFade_T":"WinFade_B";
            _loc11_ = !_loc4_?_loc6_:_loc5_;
            _loc9_ = "Bomb";
            break;
         case "t_win_time":
            _loc10_ = "t";
            _loc3_ = !_loc4_?_loc5_:_loc6_;
            _loc7_ = !_loc4_?"WinFade_T":"WinFade_B";
            _loc11_ = !_loc4_?_loc6_:_loc5_;
            _loc9_ = "Time";
            break;
         default:
            RoundColumn.TeamGrey._visible = false;
      }
      var _loc21_ = ScoreBoard.InnerScoreBoard.GraphBounds1;
      var _loc17_ = 0;
      var _loc13_ = {x:_loc3_._x + _loc3_._width / 2,y:_loc3_._y};
      _loc3_.localToGlobal(_loc13_);
      _loc21_.globalToLocal(_loc13_);
      var _loc23_ = _loc13_.x;
      var _loc14_ = (_loc8_ - 1) % 15;
      if(_loc14_ < 0)
      {
         _loc14_ = 0;
      }
      var _loc18_ = _loc14_ * (_loc27_ / 15);
      var _loc20_ = parseInt(TColor1);
      if(_loc10_ == "ct")
      {
         _loc3_.transform.colorTransform = CT_ColorTransform0;
         _loc7_.transform.colorTransform = CT_ColorTransform0;
         _loc11_.transform.colorTransform = T_ColorTransform0;
         _loc20_ = parseInt(CTColor1);
      }
      else
      {
         _loc3_.transform.colorTransform = T_ColorTransform0;
         _loc7_.transform.colorTransform = T_ColorTransform0;
         _loc11_.transform.colorTransform = CT_ColorTransform0;
         _loc17_ = _loc28_;
      }
      m_nLastHistLine_X = _loc18_;
      m_nLastHistLine_Y = _loc17_;
      _loc3_[_loc9_]._visible = true;
      _loc3_[_loc9_]._alpha = 55;
      _loc3_[_loc7_]._visible = true;
      _loc3_[_loc7_]._alpha = 16;
      var _loc19_ = _loc3_.Kill._x + _loc3_.Kill._width / 2;
      var _loc22_ = _loc3_.Kill._y;
      _loc13_ = {x:_loc19_,y:_loc22_};
      _loc3_.Kill.localToGlobal(_loc13_);
      this.globalToLocal(_loc13_);
      _loc3_.globalX = _loc13_.x;
      _loc3_.globalY = _loc13_.y;
      _loc3_.round = _loc8_;
      _loc3_.teamwon = _loc10_;
      _loc3_.wintype = _loc9_;
      _loc3_.onRollOver = function()
      {
         ShowToolTip(true,this.globalX,this.globalY,this.round,this.teamwon,this.wintype);
      };
      _loc3_.onRollOut = function()
      {
         ShowToolTip(false,this.globalX,this.globalY,this.round,this.teamwon,this.wintype);
      };
      _loc8_ = _loc8_ + 1;
   }
}
function UpdateTeamNameColor()
{
   var _loc4_ = gameAPI.GetGameMode();
   var _loc6_ = gameAPI.GetGameType();
   var _loc2_ = false;
   if(_loc6_ == 4 && (_loc4_ == 1 || _loc4_ == 0))
   {
      _loc2_ = true;
   }
   if(m_TeamName_T == "")
   {
      m_TeamName_T = _global.GameInterface.Translate("#SFUI_T_Label");
   }
   if(m_TeamName_CT == "")
   {
      m_TeamName_CT = _global.GameInterface.Translate("#SFUI_CT_Label");
   }
   teamNameLabel_CT = ScoreBoard.InnerScoreBoard.CT_TeamName.CT_TeamNameText.htmlText;
   if(m_TeamName_CT != teamNameLabel_CT)
   {
      var _loc3_ = _global.GameInterface.Translate("#SFUI_CT_Label");
      if(teamNameLabel_CT == _loc3_)
      {
         ScoreBoard.InnerScoreBoard.CT_TeamName.transform.colorTransform = CT_ColorTransform0;
         if(_loc2_ == false)
         {
            ScoreBoard.InnerScoreBoard.CT_TeamName._alpha = 50;
         }
      }
      else
      {
         ScoreBoard.InnerScoreBoard.CT_TeamName.transform.colorTransform = TeamNameColor_CT;
         if(_loc2_ == false)
         {
            ScoreBoard.InnerScoreBoard.CT_TeamName._alpha = 100;
         }
      }
      m_TeamName_CT = teamNameLabel_CT;
   }
   teamNameLabel_T = ScoreBoard.InnerScoreBoard.T_TeamName.T_TeamNameText.htmlText;
   if(m_TeamName_T != teamNameLabel_T)
   {
      var _loc5_ = _global.GameInterface.Translate("#SFUI_T_Label");
      if(teamNameLabel_T == _loc5_)
      {
         ScoreBoard.InnerScoreBoard.T_TeamName.transform.colorTransform = T_ColorTransform0;
         if(_loc2_ == false)
         {
            ScoreBoard.InnerScoreBoard.T_TeamName._alpha = 50;
         }
      }
      else
      {
         ScoreBoard.InnerScoreBoard.T_TeamName.transform.colorTransform = TeamNameColor_T;
         if(_loc2_ == false)
         {
            ScoreBoard.InnerScoreBoard.T_TeamName._alpha = 100;
         }
      }
      m_TeamName_T = teamNameLabel_T;
   }
   trace("T_TeamName: " + ScoreBoard.InnerScoreBoard.T_TeamName.T_TeamNameText.htmlText);
   trace("strTeamName_T: " + _loc5_);
   trace("CT_TeamName: " + ScoreBoard.InnerScoreBoard.CT_TeamName.CT_TeamNameText.htmlText);
   trace("strTeamName_CT: " + _loc3_);
}
function onLoadInit(movieClip)
{
   movieClip._width = avatarWidth;
   movieClip._height = avatarHeight;
   ScoreBoard.gotoAndStop("StartShow");
}
function onToggleSpecCamera(button)
{
   var _loc2_ = false;
   var _loc4_ = !gameAPI.GetCasterIsCameraman();
   if(_loc4_ != 0)
   {
      _loc2_ = true;
   }
   button.Disabled_Icon._visible = !_loc2_;
   var _loc3_ = ScoreBoard.InnerScoreBoard.Spectator_Scoretable.Spectator_ScoreRow_0.accountID;
   if(!_loc2_)
   {
      _loc3_ = 0;
   }
   gameAPI.SetCasterIsCameraman(_loc3_);
   _global.navManager.PlayNavSound("ButtonAction");
}
function onToggleSpecVoice(button)
{
   var _loc2_ = false;
   var _loc4_ = !gameAPI.GetCasterIsHeard();
   if(_loc4_ != 0)
   {
      _loc2_ = true;
   }
   button.Disabled_Icon._visible = !_loc2_;
   var _loc3_ = ScoreBoard.InnerScoreBoard.Spectator_Scoretable.Spectator_ScoreRow_0.accountID;
   if(!_loc2_)
   {
      _loc3_ = 0;
   }
   gameAPI.SetCasterIsHeard(_loc3_);
   _global.navManager.PlayNavSound("ButtonAction");
}
function onToggleSpecXray(button)
{
   var _loc2_ = false;
   var _loc4_ = !gameAPI.GetCasterControlsXray();
   if(_loc4_ != 0)
   {
      _loc2_ = true;
   }
   button.Disabled_Icon._visible = !_loc2_;
   var _loc3_ = ScoreBoard.InnerScoreBoard.Spectator_Scoretable.Spectator_ScoreRow_0.accountID;
   if(!_loc2_)
   {
      _loc3_ = 0;
   }
   gameAPI.SetCasterControlsXray(_loc3_);
   _global.navManager.PlayNavSound("ButtonAction");
}
function onToggleSpecUI(button)
{
   var _loc2_ = false;
   var _loc4_ = !gameAPI.GetCasterControlsUI();
   if(_loc4_ != 0)
   {
      _loc2_ = true;
   }
   button.Disabled_Icon._visible = !_loc2_;
   var _loc3_ = ScoreBoard.InnerScoreBoard.Spectator_Scoretable.Spectator_ScoreRow_0.accountID;
   if(!_loc2_)
   {
      _loc3_ = 0;
   }
   gameAPI.SetCasterControlsUI(_loc3_);
   _global.navManager.PlayNavSound("ButtonAction");
}
function SetScrollingText(newText)
{
   TickerTextField.text = newText;
   return TickerTextField.textWidth;
}
function GetTickerWidth()
{
   return ScoreBoard.InnerScoreBoard.Ticker.InnerTicker._width;
}
function GetProjectedTextWidth(newText)
{
   var _loc2_ = TickerTextField.text;
   TickerTextField.text = newText;
   var _loc1_ = TickerTextField.textWidth;
   TickerTextField.text = _loc2_;
   return _loc1_;
}
function SetScrollingX(newX)
{
   TickerTextField._x = newX;
}
function onLoaded()
{
   _global.Scoreboard = this;
   _global.ScoreboardAPI = gameAPI;
   gameAPI.OnReady();
   trace("Scoreboard: onLoaded!");
   var _loc3_ = ScoreBoard.InnerScoreBoard.Spectator_Scoretable;
   _loc3_._visible = !_global.ScoreboardAPI.IsQueuedMatchmaking();
   _loc3_.Caster_Settings_0.SetUpDropDownForOptions(gameAPI);
   var _loc4_ = gameAPI.IsLocalPlayerHLTV();
   _loc3_.Caster_Settings_0.setDisabled(!_loc4_);
   GetPrevCoopData();
}
function onUnload(mc)
{
   delete _global.Scoreboard;
   delete _global.ScoreboardAPI;
   _global.resizeManager.RemoveListener(this);
   hidePanel();
   return true;
}
function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(ScoreBoard,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
}
function OnGameEvent(strEvent)
{
   if(strEvent == "begin_new_match")
   {
      m_aTotalXp = [];
      ScoreBoard.InnerScoreBoard.XpPanel._bHasXp = false;
   }
   trace("---------------------------OnGameEvent------------------" + strEvent);
}
function GetGamePhase()
{
   trace("---------------------------GetGamePhase------------------" + gameAPI.GetGamePhase());
   return gameAPI.GetGamePhase();
}
function showPanel()
{
   trace("Scoreboard: Calling showPanel!");
   if(!scoreboardVisible)
   {
      m_numSelectedRowIndex = 0;
      if(GetGamePhase() == 4 || GetGamePhase() == 5)
      {
         _global.navManager.PushLayout(scoreboardCursorNav,"scoreboardCursorNav");
         ScoreBoard.InnerScoreBoard.CursorHint.Hint.CursorHintText.htmlText = "#SFUI_Scoreboard_Navigation_Cursor_Choose";
      }
      else
      {
         _global.navManager.PushLayout(scoreboardNav,"scoreboardNav");
         var _loc3_ = _global.GameInterface.Translate(gameAPI.GetMouseEnableBindingName());
         var _loc2_ = _global.GameInterface.Translate("#SFUI_Scoreboard_Navigation_Cursor_Hint");
         _loc2_ = _global.ConstructString(_loc2_,_loc3_);
         ScoreBoard.InnerScoreBoard.CursorHint.Hint.CursorHintText.htmlText = _loc2_;
      }
      ScoreBoard.InnerScoreBoard.CursorHint.gotoAndPlay("StartAnim");
      TickerTextField.autoSize = true;
      ScoreBoard.gotoAndStop("StartShow");
      ScoreBoard._visible = true;
      scoreboardVisible = true;
      ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel._visible = false;
      ScoreBoard.InnerScoreBoard.ItemDropPanelIndividual._visible = false;
      UpdateTextSettings();
      DisplayMusicKit();
      UpdateTeamNameColor();
      if(GetGamePhase() != 5)
      {
         ScoreBoard.InnerScoreBoard.XpPanel._visible = false;
         ScoreBoard.InnerScoreBoard.EloPanel._visible = false;
         QuestPanelShow();
      }
      else
      {
         ScoreBoard.InnerScoreBoard.QuestPanel._visible = false;
      }
      if(GetNumPlayers() != "TenPlayer")
      {
         _global.WinPanelRoot._alpha = 0;
      }
      trace("Scoreboard: is now being shown!");
      var _loc4_ = gameAPI.IsLocalPlayerHLTV();
      if(_loc4_)
      {
         OnRightClick("");
      }
      fillOutWinHistory();
      m_teamLogo_CT = "";
      m_teamLogo_T = "";
      FillCoopScoreDataStart();
   }
}
function UpdateTextSettings()
{
   ScoreBoard.InnerScoreBoard.GameType.GameType.autoSize = "left";
   ScoreBoard.InnerScoreBoard.GameTime.GameTimeLeft.autoSize = "center";
   ScoreBoard.InnerScoreBoard.GameType.GameType.autoSize = "left";
   ScoreBoard.InnerScoreBoard.MapName.MapName.autoSize = "left";
   ScoreBoard.InnerScoreBoard.Dash.autoSize = "left";
   var _loc1_ = gameAPI.GetGameType();
   var _loc2_ = false;
   if(GetGamePhase() != 5 && _loc1_ != 4)
   {
      ScoreBoard.InnerScoreBoard.TimerIcon._alpha = 100;
   }
   ScoreBoard.InnerScoreBoard.TimerIcon._x = ScoreBoard.InnerScoreBoard.GameTime.GameTimeLeft._x + ScoreBoard.InnerScoreBoard.GameTime._x - (ScoreBoard.InnerScoreBoard.TimerIcon._width + 2);
   ScoreBoard.InnerScoreBoard.Dash._x = ScoreBoard.InnerScoreBoard.MapName._x + ScoreBoard.InnerScoreBoard.MapName._width;
   ScoreBoard.InnerScoreBoard.GameType._x = ScoreBoard.InnerScoreBoard.Dash._x + ScoreBoard.InnerScoreBoard.Dash._width;
   ScoreBoard.InnerScoreBoard.GameType._y = ScoreBoard.InnerScoreBoard.MapName._y;
   ScoreBoard.InnerScoreBoard.TimerIcon._y = ScoreBoard.InnerScoreBoard.MapName._y - 20.35;
}
function hidePanel()
{
   trace("Scoreboard: Calling hidePanel!");
   ScoreBoard.InnerScoreBoard.GameTime._visible = true;
   HideContextMenu();
   m_bEnableCursor = false;
   Tooltip._visible = false;
   ScoreBoard._visible = false;
   _global.navManager.RemoveLayout(scoreboardCursorNav);
   _global.navManager.RemoveLayout(scoreboardNav);
   ScoreBoard.BannerWin._visible = false;
   ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel._visible = false;
   ScoreBoard.InnerScoreBoard.ItemDropPanelIndividual._visible = false;
   ScoreBoard.InnerScoreBoard.TWinBanner._visible = false;
   ScoreBoard.InnerScoreBoard.CTWinBanner._visible = false;
   ScoreBoard.InnerScoreBoard.GungameWinBanner._visible = false;
   ScoreBoard.InnerScoreBoard.bg_endmatch._visible = false;
   clearInterval(GameTimeInterval);
   ScoreBoard.InnerScoreBoard.GameTime.GameTimeLeft.textColor = 16777215;
   scoreboardVisible = false;
   ScoreBoard.InnerScoreBoard.MapVotePanel._visible = false;
   m_bSelectingRandomMap = false;
   ClearVoteNextMapPanel();
   ScoreBoard.InnerScoreBoard;
   var _loc5_ = ScoreBoard.InnerScoreBoard.Spectator_Scoretable;
   _loc5_.Caster_Settings_0.onScoreboardHide();
   _global.WinPanelRoot._alpha = 100;
   i = 0;
   while(i < 12)
   {
      var _loc4_ = "CT_ScoreRow_" + i;
      row = ScoreBoard.InnerScoreBoard.CT_Scoretable[_loc4_];
      if(row)
      {
         var _loc3_ = "CoinIcon";
         var _loc2_ = row[_loc3_];
         if(_loc2_)
         {
            _loc2_._visible = false;
         }
      }
      i++;
   }
   i = 0;
   while(i < 12)
   {
      _loc4_ = "T_ScoreRow_" + i;
      row = ScoreBoard.InnerScoreBoard.T_Scoretable[_loc4_];
      if(row)
      {
         _loc3_ = "CoinIcon";
         _loc2_ = row[_loc3_];
         if(_loc2_)
         {
            _loc2_._visible = false;
         }
      }
      i++;
   }
   if(timerRandomMapSelect)
   {
      clearInterval(timerRandomMapSelect);
      delete timerRandomMapSelect;
   }
}
function setNumServerSlotsTen(bIsTen)
{
   m_bIsMaxTenPlayers = bIsTen;
}
function SetAllRowElements(IconsData)
{
   DisplayFlairIcon(IconsData.owner,IconsData.flairImage);
   PositionIcons(row,SetCompetitiveSkillGroupIcon(IconsData.owner,IconsData.competitiveSkillGroup),SetPublicProfileRank(IconsData.owner,IconsData.profileRank),DisplayMusicIcon(IconsData.owner,IconsData.musicKitID),SetPublicProfileCommends(IconsData.owner,IconsData.commendTop));
}
function DisplayFlairIcon(row, NewMovieName)
{
   var _loc3_ = row.CoinIcon;
   if(NewMovieName != undefined && NewMovieName != "")
   {
      NewMovieName = NewMovieName + "_small.png";
      var _loc2_ = new Object();
      _loc2_.onLoadInit = function(target_mc)
      {
         target_mc._width = 24;
         target_mc._height = 18;
         target_mc._x = 370;
         target_mc._y = 0;
         target_mc.smoothing = true;
         if(target_mc._parent._parent._visible == false)
         {
            target_mc._visible = false;
         }
      };
      _loc2_.onLoadError = function(target_mc, errorCode, status)
      {
         trace("Error loading image: " + errorCode + " [" + status + "] ----- You probably forgot to author a small version of your flair item (needs to end with _small).");
      };
      var _loc4_ = new MovieClipLoader();
      _loc4_.addListener(_loc2_);
      _loc4_.loadClip(NewMovieName,_loc3_);
      _loc3_._visible = true;
   }
   else
   {
      _loc3_._visible = false;
   }
}
function SetCompetitiveSkillGroupIcon(row, nRankMedal)
{
   var _loc1_ = row.RankIcon_00;
   if(nRankMedal >= 1)
   {
      LoadEloIcon(42,17,"econ/status_icons/skillgroup" + nRankMedal + ".png",_loc1_.MedalPicture);
      return _loc1_;
   }
   _loc1_._visible = false;
   return null;
}
function SetPublicProfileRank(row, nRankMedal)
{
   var _loc1_ = row.XpIcon_00;
   if(nRankMedal >= 1)
   {
      LoadEloIcon(17,17,"econ/status_icons/level" + nRankMedal + ".png",_loc1_.MedalPicture);
      return _loc1_;
   }
   _loc1_._visible = false;
   return null;
}
function DisplayMusicIcon(row, strMusicKitId)
{
   var _loc2_ = row.MusicIcon;
   if(strMusicKitId != null && strMusicKitId != undefined && strMusicKitId != 0 && strMusicKitId != 1)
   {
      return _loc2_;
   }
   _loc2_._visible = false;
   return null;
}
function SetPublicProfileCommends(row, strType)
{
   row.tIcon._visible = false;
   row.lIcon._visible = false;
   row.fIcon._visible = false;
   if(strType == "t" || strType == "l" || strType == "f")
   {
      var _loc3_ = row[strType + "Icon"];
      return _loc3_;
   }
   return null;
}
function PositionIcons(row, objSkillGroupIcon, objProfileRankIcon, objMusicIcon, objCommendsIcon)
{
   var _loc4_ = 372;
   var _loc3_ = 0;
   var _loc2_ = new Array();
   if(objSkillGroupIcon != null)
   {
      _loc2_.push(objSkillGroupIcon);
   }
   if(objProfileRankIcon != null)
   {
      _loc2_.push(objProfileRankIcon);
   }
   if(objMusicIcon != null)
   {
      _loc2_.push(objMusicIcon);
   }
   if(objCommendsIcon != null)
   {
      _loc2_.push(objCommendsIcon);
   }
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.length)
   {
      _loc2_[_loc1_]._x = _loc4_ - (_loc2_[_loc1_]._width + _loc3_);
      _loc3_ = _loc3_ + _loc2_[_loc1_]._width;
      _loc2_[_loc1_]._visible = true;
      _loc1_ = _loc1_ + 1;
   }
}
function initRow(row, nIndex, nTeam)
{
   row.onRollOver = function()
   {
      RolloverRow(this);
   };
   row.onRelease = function()
   {
      SelectRow(this);
   };
   row.nIndex = nIndex;
   row.nTeam = nTeam;
}
function SelectRow(row)
{
   if(row.bg_bar._visible == false)
   {
      return false;
   }
   _global.ScoreboardAPI.SelectPlayerRow(row.nIndex,row.nTeam);
   m_numSelectedRowIndex = row.nIndex;
   OpenContextMenu(row);
   return true;
}
function RolloverRow(row)
{
   if(row.bg_bar._visible == false)
   {
      return false;
   }
   _global.ScoreboardAPI.SelectPlayerRow(row.nIndex,row.nTeam);
   if(m_numSelectedRowIndex != row.nIndex)
   {
      HideContextMenu();
   }
   return true;
}
function RowIsSpectator(row)
{
   if(row == ScoreBoard.InnerScoreBoard.Spectator_Scoretable.Spectator_ScoreRow_0 || row == ScoreBoard.InnerScoreBoard.Spectator_Scoretable.Spectator_ScoreRow_1)
   {
      return true;
   }
   return false;
}
function DisplayCurrentRowUserInfo()
{
   _global.LeaderBoardsAPI.DisplayUserInfo(CurrentRow);
}
function BlinkGameTime()
{
   UpdateTextSettings();
   ScoreBoard.InnerScoreBoard.GameTime.GameTimeLeft.textColor = 13608492;
   updateAfterEvent();
}
function SetWinBanner(bSurrendered, bIsGunGame, sText, numTeam, nVotesToSucceed)
{
   ScoreBoard.InnerScoreBoard.bg_endmatch._visible = true;
   if(!_global.ScoreboardAPI.IsQueuedMatchmaking())
   {
      GameTimeInterval = setInterval(BlinkGameTime,250);
      ScoreBoard.InnerScoreBoard.TimerIcon._alpha = 0;
      BlinkGameTime();
   }
   SetVotePanel(nVotesToSucceed > 0,nVotesToSucceed);
   if(ScoreBoard.InnerScoreBoard.EloPanel._bRankedUp == true)
   {
      SkillGroupRankUpAnim();
   }
   var _loc3_ = ScoreBoard.InnerScoreBoard.XpPanel;
   if(_loc3_._bHasXp == true)
   {
      HideQuestPanel();
      XpBarShow(m_aTotalXp);
   }
   if(bIsGunGame)
   {
      ScoreBoard.InnerScoreBoard.GungameWinBanner._visible = true;
      ScoreBoard.InnerScoreBoard.GungameWinBanner.gotoAndPlay("startAnim");
      ScoreBoard.InnerScoreBoard.GungameWinBanner.WinText.Text.htmlText = sText;
      return undefined;
   }
   if(numTeam == 3)
   {
      ScoreBoard.InnerScoreBoard.CTWinBanner.WinText.Text.htmlText = sText;
      ShowWinBannerCT();
      if(bSurrendered)
      {
         ScoreBoard.InnerScoreBoard.TWinBanner.WinText.Text.htmlText = "#SFUI_Scoreboard_Final_Surrendered";
         ShowWinBannerT();
      }
      return undefined;
   }
   if(numTeam == 2)
   {
      ScoreBoard.InnerScoreBoard.TWinBanner.WinText.Text.htmlText = sText;
      ShowWinBannerT();
      if(bSurrendered)
      {
         ScoreBoard.InnerScoreBoard.CTWinBanner.WinText.Text.htmlText = "#SFUI_Scoreboard_Final_Surrendered";
         ShowWinBannerCT();
      }
      return undefined;
   }
   ScoreBoard.InnerScoreBoard.TWinBanner.WinText.Text.htmlText = sText;
   ScoreBoard.InnerScoreBoard.CTWinBanner.WinText.Text.htmlText = sText;
   ShowWinBannerT();
   ShowWinBannerCT();
   ScoreBoard.InnerScoreBoard.ItemPanelParent._visible = false;
   ScoreBoard.InnerScoreBoard.ItemDropPanelIndividual._visible = false;
}
function SetVotePanel(bShow, nVotesToSucceed)
{
   trace("nVotesToSucceed = " + nVotesToSucceed);
   if(bShow && nVotesToSucceed > 0)
   {
      ClearVoteNextMapPanel();
      ScoreBoard.InnerScoreBoard.MapVotePanel._visible = true;
      if(!gameAPI.NextMapAlreadySelected())
      {
         var _loc7_ = gameAPI.GetNumMapsInMapgroup();
         if(_loc7_ > NUM_MAPVOTE_PANELS)
         {
            _loc7_ = NUM_MAPVOTE_PANELS;
         }
         i = 0;
         while(i < _loc7_)
         {
            var _loc3_ = gameAPI.GetMapNameInMapgroup(i);
            if(_loc3_ != null && _loc3_ != undefined && _loc3_ != "")
            {
               var _loc6_ = "Target" + i;
               var _loc2_ = ScoreBoard.InnerScoreBoard.MapVotePanel[_loc6_];
               if(_loc2_)
               {
                  trace(_loc3_);
                  _loc2_.MapName.Text.htmlText = _loc3_;
                  _loc2_._visible = true;
                  trace("SetWinBanner : nVotesToSucceed = " + nVotesToSucceed);
                  j = 1;
                  while(j <= nVotesToSucceed)
                  {
                     var _loc4_ = "Box" + j;
                     var _loc1_ = _loc2_[_loc4_];
                     if(_loc1_)
                     {
                        _loc1_._visible = true;
                     }
                     j++;
                  }
               }
            }
            i++;
         }
      }
   }
   else
   {
      ScoreBoard.InnerScoreBoard.MapVotePanel._visible = false;
   }
}
function ShowWinBannerCT()
{
   ScoreBoard.InnerScoreBoard.CTWinBanner._visible = true;
   ScoreBoard.InnerScoreBoard.CTWinBanner.gotoAndPlay("startAnim");
}
function ShowWinBannerT()
{
   ScoreBoard.InnerScoreBoard.TWinBanner._visible = true;
   ScoreBoard.InnerScoreBoard.TWinBanner.gotoAndPlay("startAnim");
}
function SetEndMatchMapVoteSlot(nSlot, nVotes, bWinning, nPlayerVoteSlot, bVotingHasEnded)
{
   if(!bWinning && m_bSelectingRandomMap)
   {
      return undefined;
   }
   var _loc7_ = "Target" + nSlot;
   var _loc2_ = ScoreBoard.InnerScoreBoard.MapVotePanel[_loc7_];
   if(_loc2_ && _loc2_._visible)
   {
      j = 1;
      while(j <= NUM_MAPVOTE_CHECKS)
      {
         var _loc3_ = "YesImage" + j;
         var _loc1_ = _loc2_[_loc3_];
         if(_loc1_)
         {
            if(j <= nVotes)
            {
               _loc1_._visible = true;
            }
            else
            {
               _loc1_._visible = false;
            }
         }
         j++;
      }
      _loc2_.ArrowSelected._visible = bVotingHasEnded && bWinning;
      if(_loc2_.ArrowSelected._visible)
      {
         _loc2_.ArrowSelected.gotoAndPlay("startAnim");
      }
      if(bVotingHasEnded || nPlayerVoteSlot > -1)
      {
         _loc2_.KeyBind._visible = false;
         _loc2_.setDisabled(true);
      }
      else
      {
         _loc2_.KeyBind._visible = true;
         _loc2_.setDisabled(false);
      }
      _loc2_.SelectedHighlight._visible = nPlayerVoteSlot == nSlot;
      if(bWinning)
      {
         m_bSelectingRandomMap = false;
         trace("!!!!! SetEndMatchMapVoteSlot : bWinning");
         if(timerRandomMapSelect)
         {
            clearInterval(timerRandomMapSelect);
            delete timerRandomMapSelect;
         }
      }
      _loc2_.WinnerHighlight._visible = bWinning;
   }
   ScoreBoard.InnerScoreBoard.MapVotePanel.MapVoteDesc.SetText("#SFUI_Scoreboard_VoteNow");
   ScoreBoard.InnerScoreBoard.MapVotePanel.MapVoteDesc._visible = !bVotingHasEnded;
}
function StartSelectRandomMap(nCount, nSlot1, nSlot2, nSlot3, nSlot4, nSlot5, nSlot6, nSlot7, nSlot8, nSlot9, nSlot10)
{
   m_bSelectingRandomMap = true;
   trace("StartSelectRandomMap : nCount = " + nCount);
   ScoreBoard.InnerScoreBoard.MapVotePanel.MapVoteDesc.SetText("#SFUI_Scoreboard_SelectingRandomMap");
   nWinningMapsCount = nCount;
   aWinningMaps[0] = nSlot1;
   aWinningMaps[1] = nSlot2;
   aWinningMaps[2] = nSlot3;
   aWinningMaps[3] = nSlot4;
   aWinningMaps[4] = nSlot5;
   aWinningMaps[5] = nSlot6;
   aWinningMaps[6] = nSlot7;
   aWinningMaps[7] = nSlot8;
   aWinningMaps[8] = nSlot9;
   aWinningMaps[9] = nSlot10;
   if(timerRandomMapSelect)
   {
      clearInterval(timerRandomMapSelect);
      delete timerRandomMapSelect;
   }
   timerRandomMapSelect = setInterval(SelectRandomMap,125,null);
}
function SelectRandomMap()
{
   var _loc4_ = Math.floor(Math.random() * nWinningMapsCount);
   if(nLastWinningMapSlot == aWinningMaps[_loc4_])
   {
      _loc4_ = _loc4_ + 1;
      if(_loc4_ >= nWinningMapsCount)
      {
         _loc4_ = 0;
      }
   }
   i = 0;
   while(i < NUM_MAPVOTE_PANELS)
   {
      var _loc3_ = "Target" + i;
      var _loc2_ = ScoreBoard.InnerScoreBoard.MapVotePanel[_loc3_];
      if(_loc2_)
      {
         if(aWinningMaps[_loc4_] == i)
         {
            _loc2_.WinnerHighlight._visible = true;
         }
         else
         {
            _loc2_.WinnerHighlight._visible = false;
         }
         _loc2_.KeyBind._visible = false;
      }
      i++;
   }
   trace("SelectRandomMap : intRandomSlot = " + _loc4_);
   _global.navManager.PlayNavSound("ButtonRollover");
   nLastWinningMapSlot = aWinningMaps[_loc4_];
}
function InitItemDropPanel()
{
   m_nItemDropCurIndex = 0;
   m_nItemDropErrorOffset = 0;
   itemDropArray = [];
}
function ShowItemPanelStart()
{
   ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel._visible = true;
   ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel.HideAllItems();
}
function AddItemDropToList(item)
{
   itemDropArray.push(item);
   trace("---<(scoreboard.as)>----  AddItemDropToList: itemID = " + item.itemID + ", fauxItemID = " + item.fauxItemID + ", ownerXuid = " + item.ownerXuid);
}
function RevealNextItem()
{
   if(m_nItemDropCurIndex >= itemDropArray.length)
   {
      trace("---ERROR---  scoreboard_scaleforme.cpp is asking to reveal and item at index " + m_nItemDropCurIndex + ", but we have have " + itemDropArray.length + " items stored!!!");
      return undefined;
   }
   var _loc4_ = _global.CScaleformComponent_Inventory.IsItemInfoValid(String(itemDropArray[m_nItemDropCurIndex].ownerXuid),String(itemDropArray[m_nItemDropCurIndex].itemID));
   if(!_loc4_ && itemDropArray[m_nItemDropCurIndex].fauxItemID > 0)
   {
      _loc4_ = true;
   }
   if(!_loc4_)
   {
      m_nItemDropCurIndex++;
      m_nItemDropErrorOffset++;
      trace("SCOREBOARD: RevealNextItem: Item isn\'t valid!, itemDropArray[m_nItemDropCurIndex].fauxItemID = " + itemDropArray[m_nItemDropCurIndex].fauxItemID);
      return undefined;
   }
   if(ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel._visible == false || m_nItemDropCurIndex - m_nItemDropErrorOffset == 0)
   {
      ShowItemPanelStart();
   }
   var _loc3_ = MAX_ITEM_DROP_PANELS_CASUAL;
   if(m_bIsMaxTenPlayers)
   {
      _loc3_ = MAX_ITEM_DROP_PANELS;
   }
   ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel.SetMaxLocalItemTiles(MAX_LOCAL_PLAYER_ITEMS);
   ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel.SetMaxVisibleItemTiles(_loc3_);
   ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel.SetExtraTileSlot(_loc3_);
   var _loc5_ = _global.CScaleformComponent_Inventory.IsInventoryImageCachable(itemDropArray[m_nItemDropCurIndex].itemID,itemDropArray[m_nItemDropCurIndex].ownerXuid);
   if(_loc5_)
   {
      _global.CScaleformComponent_ImageCache.EnsureInventoryImageCached(itemDropArray[m_nItemDropCurIndex].itemID);
   }
   if(itemDropArray[m_nItemDropCurIndex].IsLocal && itemDropArray[m_nItemDropCurIndex].rarity < 3)
   {
      _global.ScoreboardAPI.PlayItemDropSoundLocal();
   }
   else
   {
      _global.ScoreboardAPI.PlayItemDropSound(itemDropArray[m_nItemDropCurIndex].rarity);
   }
   if(m_nItemDropCurIndex - m_nItemDropErrorOffset >= _loc3_)
   {
      ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel.gotoAndPlay("ShowNext");
   }
   else
   {
      ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel.gotoAndStop("Start");
   }
   ScoreBoard.InnerScoreBoard.ItemPanelParent._visible = true;
   ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel.ShowItem(m_nItemDropCurIndex,m_nItemDropErrorOffset,true,itemDropArray.length - m_nItemDropErrorOffset,itemDropArray[m_nItemDropCurIndex].itemID,itemDropArray[m_nItemDropCurIndex].fauxItemID,itemDropArray[m_nItemDropCurIndex].ownerXuid,itemDropArray[m_nItemDropCurIndex].IsLocal,itemDropArray[m_nItemDropCurIndex].team,itemDropArray[m_nItemDropCurIndex].dropReason);
   trace("Scoreboard.ItemPanelParent.ItemPanel.ShowItem : m_nItemDropCurIndex = " + m_nItemDropCurIndex + ", ownerXuid = " + itemDropArray[m_nItemDropCurIndex].ownerXuid + ", PlayerName = " + PlayerName);
   var _loc2_ = undefined;
   if(itemDropArray[m_nItemDropCurIndex].team == 3)
   {
      var _loc6_ = "CT_ScoreRow_" + itemDropArray[m_nItemDropCurIndex].rowIndex;
      _loc2_ = ScoreBoard.InnerScoreBoard.CT_Scoretable[_loc6_];
   }
   else if(itemDropArray[m_nItemDropCurIndex].team == 2)
   {
      _loc6_ = "T_ScoreRow_" + itemDropArray[m_nItemDropCurIndex].rowIndex;
      _loc2_ = ScoreBoard.InnerScoreBoard.T_Scoretable[_loc6_];
   }
   _loc2_.Sheen._visible = true;
   _loc2_.Sheen.gotoAndPlay("Sheen");
   m_nItemDropCurIndex++;
}
function QuestPanelShow()
{
   trace("SCOREBOARD: QuestPanelShow");
   var _loc2_ = ScoreBoard.InnerScoreBoard.QuestPanel;
   var _loc3_ = gameAPI.GetQuestProgressReason();
   if(_loc3_ != "ok" && _loc3_ != "not_enough_players" && _loc3_ != "wrong_map" && _loc3_ != "wrong_mode" && _loc3_ != "warmup" && _loc3_ != "not_synced_with_server")
   {
      HideQuestPanel();
      return undefined;
   }
   if(_loc3_ == "wrong_mode" && _global.CScaleformComponent_MatchStats.GetGameMode() == "competitive")
   {
      HideQuestPanel();
      return undefined;
   }
   var _loc6_ = gameAPI.GetQuestID();
   if(questId == 0)
   {
      HideQuestPanel();
      return undefined;
   }
   trace("SCOREBOARD: questID = " + _loc6_);
   var _loc4_ = GetMissionItemId(_loc6_);
   if(!_loc4_ || _loc4_ == "")
   {
      HideQuestPanel();
      return undefined;
   }
   trace("SCOREBOARD: questItemID = " + _loc4_);
   var _loc7_ = _global.CScaleformComponent_Inventory.GetQuestGameMode(null,_loc4_);
   if(_loc7_ == "cooperative" || _loc7_ == "coopmission")
   {
      HideQuestPanel();
      return undefined;
   }
   var _loc8_ = _global.CScaleformComponent_Inventory.GetItemName(null,_loc4_);
   var _loc10_ = _global.CScaleformComponent_Inventory.DoesQuestTeamMatchPlayer(null,_loc4_);
   _loc2_._visible = true;
   _loc2_.Title._visible = false;
   _loc2_.InActive._visible = false;
   trace("SCOREBOARD: quest reason = " + _loc3_);
   if(_loc3_ == "wrong_map" || _loc3_ == "wrong_mode")
   {
      _loc2_.InActive._visible = true;
      _loc2_.InActive.Text.htmlText = "#SFUI_Missions_Not_In_Map";
   }
   else if(_loc3_ == "not_enough_players")
   {
      _loc2_.InActive._visible = true;
      _loc2_.InActive.Text.htmlText = "#SFUI_Missions_In_MorePlayers";
   }
   else if(_loc3_ == "warmup")
   {
      _loc2_.InActive._visible = true;
      _loc2_.InActive.Text.htmlText = "#SFUI_Missions_In_WarmUp";
   }
   else if(_loc3_ == "not_synced_with_server")
   {
      _loc2_.InActive._visible = true;
      _loc2_.InActive.Text.htmlText = "#SFUI_Missions_Server_Desync";
   }
   else if(_loc10_ == false)
   {
      _loc2_.InActive._visible = true;
      _loc2_.InActive.Text.htmlText = "#SFUI_Missions_Wrong_Team";
   }
   else
   {
      _loc2_.Title._visible = true;
      var _loc5_ = _global.GameInterface.Translate("#SFUI_Missions_Title");
      _loc5_ = _global.ConstructString(_loc5_,_loc8_);
      _loc2_.Title.Text.htmlText = _loc5_;
      _global.AutosizeTextDown(_loc2_.Title.Text,8);
      _loc2_.Title.Text.autoSize = "left";
   }
   _global.AutosizeTextDown(_loc2_.InActive.Text,8);
   var _loc11_ = _global.CScaleformComponent_Inventory.GetItemDescription(null,_loc4_,"default,-detailedinfo");
   var _loc9_ = _global.CScaleformComponent_Inventory.GetItemDescription(null,_loc4_,"detailedinfo");
   _loc2_.Desc.Desc.htmlText = _loc11_;
   _loc2_.DescCurrent.DescCurrent.htmlText = strDecriptionCurrent;
   _loc2_.DescDetails.DescDetails.htmlText = _loc9_;
   _global.AutosizeTextDown(_loc2_.Desc.Desc,7);
   _global.AutosizeTextDown(_loc2_.DescDetails.DescDetails,7);
   _loc2_.Desc.Desc.autoSize = "left";
   _loc2_.DescDetails.DescDetails.autoSize = "left";
   _loc2_.DescCurrent.Warning.autoSize = "left";
   var _loc12_ = 5;
   var _loc13_ = 0;
   _loc2_.Desc._y = (_loc2_.Bg._height - _loc2_.Desc._height) / 2 + 8;
   _loc2_.DescDetails._y = (_loc2_.Bg._height - _loc2_.DescDetails._height) / 2 + 8;
}
function HideQuestPanel()
{
   ScoreBoard.InnerScoreBoard.QuestPanel._visible = false;
}
function SeperateName(strName)
{
   if(strName.indexOf("|  ") != -1)
   {
      var _loc2_ = strName.split("|  ",2);
   }
   else if(strName.indexOf("| ") != -1)
   {
      _loc2_ = strName.split("| ",2);
   }
   else
   {
      _loc2_ = new Array(strName);
   }
   if(_loc2_.length == 1)
   {
      return _loc2_[0];
   }
   return _loc2_[1];
}
function ShowScoreboard()
{
   trace("------------------------------------SHOWSCORECCARD--------------------------");
   var _loc19_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc7_ = _global.CScaleformComponent_Inventory.GetActiveSeasonCoinItemId(_loc19_);
   var _loc18_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(null,_loc7_,"season access");
   var _loc5_ = ScoreBoard.InnerScoreBoard.EloPanel.Scorecard;
   var _loc9_ = 7;
   var _loc11_ = _global.CScaleformComponent_MatchStats.GetSeasonMapCategory();
   var _loc13_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
   if(_loc7_ == "" || _loc7_ == undefined || _loc7_ == null || _loc13_ == -1 || _loc13_ == undefined)
   {
      _loc5_._visible = false;
      return undefined;
   }
   var _loc16_ = _global.CScaleformComponent_Inventory.ItemHasScorecardValues(null,_loc7_,_loc11_);
   if(_loc16_ < 1)
   {
      _loc5_._visible = false;
      return undefined;
   }
   var _loc4_ = [];
   var _loc17_ = _global.CScaleformComponent_Inventory.GetScorecardAttributes(null,_loc7_,_loc11_);
   _loc4_ = _loc17_.split(",");
   var _loc8_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(null,_loc7_,_loc4_[0]);
   var _loc15_ = math.floor(_loc8_ / 60);
   var _loc10_ = _global.GameInterface.Translate("#CSGO_competitive_Time_Played");
   if(isNaN(_loc8_))
   {
      _loc5_._visible = false;
      return undefined;
   }
   if(_loc8_ > 60)
   {
      _loc15_ = Math.floor(_loc8_ / 60);
      _loc8_ = Math.ceil(_loc8_ - _loc15_ * 60);
      _loc10_ = _global.ConstructString(_loc10_,_loc15_,_loc8_);
   }
   else
   {
      _loc10_ = _global.ConstructString(_loc10_,"0",_loc8_);
   }
   if(_loc5_.OperationLogo != undefined)
   {
      _loc5_.OperationLogo.unloadMovie();
   }
   if(_loc11_ == "competitive")
   {
      _loc5_.IconComp._visible = true;
      _loc5_.OperationLogo._visible = false;
      _loc5_.Title.htmlText = "#CSGO_Scorecard_Title_Active";
      _loc5_.Desc.htmlText = "#CSGO_Operation_Scorecard_Desc_Tournament";
   }
   else
   {
      var _loc20_ = "econ/season_icons/season_" + _loc18_ + ".png";
      _loc5_.IconComp._visible = false;
      _loc5_.OperationLogo._visible = true;
      var _loc14_ = new Object();
      _loc14_.onLoadInit = function(target_mc)
      {
         target_mc._width = 27.5;
         target_mc._height = 20;
         target_mc.forceSmoothing = true;
      };
      var _loc12_ = new MovieClipLoader();
      _loc12_.addListener(_loc14_);
      _loc12_.loadClip(_loc20_,_loc5_.OperationLogo);
      _loc5_.Title.htmlText = "#CSGO_Scorecard_Title_Operation";
      _loc5_.Desc.htmlText = "#CSGO_Operation_Scorecard_Desc_Operation";
   }
   _loc5_.Time.Time.htmlText = _loc10_;
   var _loc2_ = 1;
   while(_loc2_ <= _loc9_)
   {
      var _loc3_ = _loc5_.Rows["Row" + _loc2_];
      if(_loc2_ >= _loc4_.length)
      {
         _loc3_._visible = false;
      }
      else
      {
         var _loc6_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(null,_loc7_,_loc4_[_loc2_]);
         _loc3_.Attribute.htmlText = "#CSGO_" + _loc4_[_loc2_];
         if(_loc4_[_loc2_] == "competitive_hsp" || _loc4_[_loc2_] == "operation_hsp")
         {
            _loc3_.Value.htmlText = Math.floor(_loc6_) + "%";
         }
         else
         {
            _loc3_.Value.htmlText = Math.floor(_loc6_);
         }
         _loc3_._visible = true;
      }
      _loc2_ = _loc2_ + 1;
   }
   _loc5_._visible = true;
}
function GetPrevCoopData()
{
   var _loc2_ = _global.CScaleformComponent_MatchStats.GetCoopQuestID();
   trace("----------------------------------------CurrentCoopQuestID-------------------------------" + _loc2_);
   if(_loc2_ == null || _loc2_ == "" || _loc2_ == undefined || _loc2_ == 0)
   {
      return "";
   }
   styTypeOfLeaderboard = "official_leaderboard_quest_" + _loc2_;
   return UpdatePrevCoopScore(styTypeOfLeaderboard);
}
function UpdatePrevCoopScore(styTypeOfLeaderboard)
{
   var _loc3_ = _global.CScaleformComponent_Leaderboards.GetState(styTypeOfLeaderboard);
   trace("----------------------------------------styTypeOfLeaderboard-------------------------------" + styTypeOfLeaderboard);
   if("none" == _loc3_)
   {
      _global.CScaleformComponent_Leaderboards.Refresh(styTypeOfLeaderboard);
      return "";
   }
   if("ready" == _loc3_)
   {
      if(3 <= _global.CScaleformComponent_Leaderboards.HowManyMinutesAgoCached(styTypeOfLeaderboard))
      {
         _global.CScaleformComponent_Leaderboards.Refresh(styTypeOfLeaderboard);
      }
      return styTypeOfLeaderboard;
   }
   return "";
}
function FillCoopScoreDataStart()
{
   var _loc2_ = gameAPI.GetGameMode();
   var _loc4_ = gameAPI.GetGameType();
   var _loc3_ = false;
   if(_loc4_ == 4 && (_loc2_ == 1 || _loc2_ == 0))
   {
      _loc3_ = true;
   }
   if(_loc3_ == false)
   {
      return undefined;
   }
   var _loc5_ = gameAPI.IsCoopMissionCompleted();
   if(_loc5_ == true)
   {
      m_fStartFillCoopData = getTimer();
      if(timerFillCoopData)
      {
         clearInterval(timerFillCoopData);
         delete timerFillCoopData;
      }
      timerFillCoopData = setInterval(this,"FillCoopScoreData",41);
   }
   else
   {
      FillCoopScoreData();
   }
}
function FillCoopScoreData()
{
   var _loc26_ = gameAPI.GetGameType();
   var _loc10_ = gameAPI.GetGameMode();
   var _loc19_ = false;
   if(_loc26_ == 4 && (_loc10_ == 1 || _loc10_ == 0))
   {
      _loc19_ = true;
   }
   if(_loc19_ == false)
   {
      return undefined;
   }
   var _loc6_ = gameAPI.GetCoopMatchScoreboardDetailsHandle();
   var _loc3_ = _global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatsCount(_loc6_,"score");
   var _loc7_ = _global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatsCount(_loc6_,"bonus");
   var _loc22_ = gameAPI.IsCoopMissionCompleted();
   var _loc4_ = ScoreBoard.InnerScoreBoard.CoopStatsPanel;
   var _loc23_ = _global.CScaleformComponent_MyPersona.GetXuid();
   _loc4_.IconCoopMission._visible = _loc10_ != 1?false:true;
   _loc4_.IconCooperative._visible = _loc10_ != 0?false:true;
   var _loc21_ = _global.CScaleformComponent_MatchStats.GetCoopQuestID();
   var _loc20_ = _loc21_ == 0?"":GetMissionItemId(_loc21_);
   var _loc18_ = _loc20_ == ""?"":_global.CScaleformComponent_Inventory.GetItemName(_loc23_,_loc20_);
   _loc4_.MissionName.Text.htmlText = _loc18_ == ""?"":_loc18_;
   if(_loc22_ == false)
   {
      trace("----- bCompleted = " + _loc22_);
      if(_loc4_)
      {
         var _loc24_ = GetPrevCoopData();
         if(_loc24_ != "")
         {
            var _loc8_ = _global.CScaleformComponent_Leaderboards.GetEntryDetailsHandleByXuid(_loc24_,_loc23_);
         }
         trace("----------------------------------------hPrevDetails-------------------------------" + _loc8_);
         if(_loc8_ == undefined || _loc8_ == null)
         {
            var _loc5_ = 1;
            while(_loc5_ <= 5)
            {
               var _loc12_ = _loc5_ > _loc3_?"":_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatNameByIndex(_loc6_,"score",_loc5_ - 1);
               _loc4_["Row" + _loc5_].Desc.SetText(_loc12_);
               _loc4_["Row" + _loc5_].Dat.Text.htmlText = _loc12_ != ""?"-":"";
               _loc4_["Row" + _loc5_].Score.Text.htmlText = _loc12_ != ""?"-":"";
               _loc12_ = _loc5_ > _loc7_?"":_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatNameByIndex(_loc6_,"bonus",_loc5_ - 1);
               _loc4_["BRow" + _loc5_].Desc.Text.htmlText = _loc12_;
               _loc4_["BRow" + _loc5_].Score.Text.htmlText = _loc12_ != ""?"-":"";
               _loc5_ = _loc5_ + 1;
            }
            _loc4_.RatingTotal.Score.SetText("-");
            _loc4_.BonusTotal.Score.SetText("-");
            _loc4_.TotalScore.Inner.SetText("-");
            _loc4_.PrevAnim._visible = false;
         }
         else
         {
            _loc5_ = 1;
            while(_loc5_ <= 5)
            {
               _loc12_ = _loc5_ > _loc3_?"":_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatNameByIndex(_loc8_,"score",_loc5_ - 1);
               _loc4_["Row" + _loc5_].Desc.SetText(_loc12_);
               if(_loc12_ == "")
               {
                  _loc4_["Row" + _loc5_].Dat.Text.htmlText = "";
                  _loc4_["Row" + _loc5_].Score.Text.htmlText = "";
               }
               else
               {
                  var _loc2_ = _loc5_ > _loc3_?0:_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatValueByIndex(_loc8_,"score",_loc5_ - 1);
                  trace("----- data(" + _loc5_ + ") = " + _loc2_);
                  if(_loc5_ == 1)
                  {
                     if(_loc10_ == 0)
                     {
                        _loc2_ = int(_loc2_ / 100) + "." + (_loc2_ % 100 >= 10?"":"0") + _loc2_ % 100;
                        _loc2_ = _loc2_ + "%";
                     }
                     if(_loc10_ == 1)
                     {
                        var _loc14_ = int(_loc2_ / 60);
                        var _loc13_ = int(_loc2_ % 60);
                        _loc2_ = _loc14_ + ":" + (_loc13_ >= 10?"":"0") + _loc13_;
                     }
                     _loc4_["Row" + _loc5_].Dat.Text.htmlText = _loc5_ > _loc3_?"-":_loc2_;
                  }
                  else if(_loc5_ == 2 || _loc5_ == 3)
                  {
                     _loc2_ = int(_loc2_ / 100) + "." + (_loc2_ % 100 >= 10?"":"0") + _loc2_ % 100;
                     _loc2_ = _loc2_ + "%";
                     _loc4_["Row" + _loc5_].Dat.Text.htmlText = _loc5_ > _loc3_?"-":_loc2_;
                  }
                  else
                  {
                     _loc4_["Row" + _loc5_].Dat.Text.htmlText = _loc5_ > _loc3_?"-":_global.FormatNumberToString(_loc2_);
                  }
                  var _loc11_ = _loc5_ > _loc3_?0:_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatScoreByIndex(_loc8_,"score",_loc5_ - 1);
                  _loc4_["Row" + _loc5_].Score.Text.htmlText = _loc5_ > _loc3_?"-":_global.FormatNumberToString(_loc11_);
               }
               _loc12_ = _loc5_ > _loc7_?"":_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatNameByIndex(_loc8_,"bonus",_loc5_ - 1);
               _loc4_["BRow" + _loc5_].Desc.Text.htmlText = _loc12_;
               if(_loc12_ == "")
               {
                  _loc4_["BRow" + _loc5_].Score.Text.htmlText = "";
               }
               else
               {
                  _loc11_ = _loc5_ > _loc7_?0:_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatScoreByIndex(_loc8_,"bonus",_loc5_ - 1);
                  _loc4_["BRow" + _loc5_].Score.Text.htmlText = _loc5_ > _loc7_?"-":_global.FormatNumberToString(_loc11_);
               }
               _loc5_ = _loc5_ + 1;
            }
            _loc4_.RatingTotal.Score.SetText(_global.FormatNumberToString(_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatScoreTotal(_loc8_,"score")));
            _loc4_.BonusTotal.Score.SetText(_global.FormatNumberToString(_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatScoreTotal(_loc8_,"bonus")));
            var _loc17_ = _global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatScoreTotal(_loc8_,"all");
            trace("----------------------------------------PrevScore-------------------------------" + _loc17_);
            _loc4_.TotalScore.Inner.SetText(_global.FormatNumberToString(_loc17_));
            _loc4_.PrevAnim._PrevScore = _loc17_;
            _loc4_.PrevAnim._visible = false;
         }
      }
      _loc4_.TitleTextRating.htmlText = "#SFUI_CoopSB_Rating_Prev";
      _loc4_.TitleTextBonus.htmlText = "#SFUI_CoopSB_Bonus_Prev";
      _loc4_.CoopTotalTitle.TitleText.htmlText = "#SFUI_CoopSB_FinalScore_Prev";
      return undefined;
   }
   var _loc9_ = (getTimer() - m_fStartFillCoopData) / COOP_ANIM_REVEAL_TIME;
   trace("----- flFrac = " + _loc9_);
   trace("----- m_fStartFillCoopData = " + m_fStartFillCoopData);
   trace("----- getTimer() = " + getTimer());
   if(m_fStartFillCoopData + COOP_ANIM_REVEAL_TIME <= getTimer())
   {
      if(timerFillCoopData)
      {
         clearInterval(timerFillCoopData);
         delete timerFillCoopData;
      }
      _loc9_ = 1;
      trace("----- FRAC END!@");
      _global.navManager.PlayNavSound("OpenCrate");
   }
   else
   {
      _global.navManager.PlayNavSound("XPRemaining");
   }
   _loc4_ = ScoreBoard.InnerScoreBoard.CoopStatsPanel;
   if(_loc4_)
   {
      _loc4_.PrevAnim._visible = false;
      _loc4_.TitleTextRating.htmlText = "#SFUI_CoopSB_Rating";
      _loc4_.TitleTextBonus.htmlText = "#SFUI_CoopSB_Bonus";
      _loc4_.CoopTotalTitle.TitleText.htmlText = "#SFUI_CoopSB_FinalScore";
      _loc5_ = 1;
      while(_loc5_ <= 5)
      {
         _loc12_ = _loc5_ > _loc3_?"":_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatNameByIndex(_loc6_,"score",_loc5_ - 1);
         _loc4_["Row" + _loc5_].Desc.SetText(_loc12_);
         if(_loc12_ == "")
         {
            _loc4_["Row" + _loc5_].Dat.Text.htmlText = "";
            _loc4_["Row" + _loc5_].Score.Text.htmlText = "";
         }
         else
         {
            _loc2_ = _loc5_ > _loc3_?0:_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatValueByIndex(_loc6_,"score",_loc5_ - 1);
            _loc2_ = _loc2_ * _loc9_;
            if(_loc9_ < 1)
            {
               _loc2_ = int(_loc2_);
            }
            trace("----- data(" + _loc5_ + ") = " + _loc2_);
            if(_loc5_ == 1)
            {
               if(_loc10_ == 0)
               {
                  _loc2_ = int(_loc2_ / 100) + "." + (_loc2_ % 100 >= 10?"":"0") + _loc2_ % 100;
                  _loc2_ = _loc2_ + "%";
               }
               if(_loc10_ == 1)
               {
                  _loc14_ = int(_loc2_ / 60);
                  _loc13_ = int(_loc2_ % 60);
                  _loc2_ = _loc14_ + ":" + (_loc13_ >= 10?"":"0") + _loc13_;
               }
               _loc4_["Row" + _loc5_].Dat.Text.htmlText = _loc5_ > _loc3_?"-":_loc2_;
            }
            else if(_loc5_ == 2 || _loc5_ == 3)
            {
               _loc2_ = int(_loc2_ / 100) + "." + (_loc2_ % 100 >= 10?"":"0") + _loc2_ % 100;
               _loc2_ = _loc2_ + "%";
               _loc4_["Row" + _loc5_].Dat.Text.htmlText = _loc5_ > _loc3_?"-":_loc2_;
            }
            else
            {
               _loc4_["Row" + _loc5_].Dat.Text.htmlText = _loc5_ > _loc3_?"-":_global.FormatNumberToString(_loc2_);
            }
            _loc11_ = _loc5_ > _loc3_?0:_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatScoreByIndex(_loc6_,"score",_loc5_ - 1);
            _loc11_ = int(_loc11_ * _loc9_);
            _loc4_["Row" + _loc5_].Score.Text.htmlText = _loc5_ > _loc3_?"-":_global.FormatNumberToString(_loc11_);
         }
         _loc5_ = _loc5_ + 1;
      }
      _loc5_ = 1;
      while(_loc5_ <= 5)
      {
         _loc12_ = _loc5_ > _loc7_?"":_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatNameByIndex(_loc6_,"bonus",_loc5_ - 1);
         _loc4_["BRow" + _loc5_].Desc.Text.htmlText = _loc12_;
         _loc11_ = _loc5_ > _loc7_?0:_global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatScoreByIndex(_loc6_,"bonus",_loc5_ - 1);
         _loc11_ = int(_loc11_ * _loc9_);
         if(_loc12_ == "")
         {
            _loc4_["BRow" + _loc5_].Score.Text.htmlText = "";
         }
         else
         {
            _loc4_["BRow" + _loc5_].Score.Text.htmlText = _loc5_ > _loc7_?"-":_global.FormatNumberToString(_loc11_);
         }
         _loc5_ = _loc5_ + 1;
      }
      var _loc28_ = _global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatScoreTotal(_loc6_,"score");
      var _loc27_ = _global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatScoreTotal(_loc6_,"bonus");
      _loc4_.RatingTotal.Score.SetText(_global.FormatNumberToString(int(_loc28_ * _loc9_)));
      _loc4_.BonusTotal.Score.SetText(_global.FormatNumberToString(int(_loc27_ * _loc9_)));
      if(_loc9_ < 1)
      {
         _loc4_.TotalScore.Inner.SetText("-");
      }
      else
      {
         var _loc15_ = _global.CScaleformComponent_Leaderboards.GetDetailsMatchScoreboardStatScoreTotal(_loc6_,"all");
         _loc4_.TotalScore.Inner.SetText(_global.FormatNumberToString(_loc15_));
         _loc4_.TotalScore.Anim.Text.htmlText = _global.FormatNumberToString(_loc15_);
         _loc4_.TotalScore.gotoAndPlay("StartAnim");
         if(Number(_loc4_.PrevAnim._PrevScore) < Number(_loc15_))
         {
            var _loc16_ = _global.GameInterface.Translate("#CSGO_Coop_Scoreboard_Better");
            var _loc25_ = _global.FormatNumberToString(_loc4_.PrevAnim._PrevScore);
            var _loc29_ = _global.FormatNumberToString(_loc15_ - _loc4_.PrevAnim._PrevScore);
            _loc16_ = _global.ConstructString(_loc16_,_loc25_,_loc29_);
            _loc4_.PrevAnim.PrevEnd.Text.htmlText = _loc16_;
            _loc4_.PrevAnim._visible = true;
            _loc4_.PrevAnim.gotoAndPlay("StartAnim");
            _loc4_.PrevAnim.NewHigh._visible = true;
         }
         else if(Number(_loc4_.PrevAnim._PrevScore) >= Number(_loc15_) && Number(_loc4_.PrevAnim._PrevScore > 0))
         {
            _loc16_ = _global.GameInterface.Translate("#CSGO_Coop_Scoreboard_Worse");
            _loc25_ = _global.FormatNumberToString(_loc4_.PrevAnim._PrevScore);
            _loc16_ = _global.ConstructString(_loc16_,_loc25_);
            _loc4_.PrevAnim.PrevEnd.Text.htmlText = _loc16_;
            _loc4_.PrevAnim._visible = true;
            _loc4_.PrevAnim.gotoAndPlay("StartAnim");
            _loc4_.PrevAnim.NewHigh._visible = false;
         }
         else
         {
            _loc4_.PrevAnim._visible = false;
         }
      }
   }
}
function MyRankUpdate(rankOld, rankNew, numWins, rankChange)
{
   var _loc2_ = ScoreBoard.InnerScoreBoard.EloPanel;
   var _loc3_ = 0;
   _loc2_._bRankedUp = false;
   _loc2_.LevelUpAnim._visible = false;
   if(rankOld == null || rankOld == undefined)
   {
      _loc2_._visible = false;
      return undefined;
   }
   _loc2_._visible = true;
   _loc2_.Flare._visible = false;
   _loc2_.EloIcon._visible = false;
   _loc2_.TextExpired._visible = false;
   _loc2_.Text._visible = false;
   SetEloPanelPos();
   if(rankOld < rankNew)
   {
      _loc3_ = rankNew;
      _loc2_._bRankedUp = true;
   }
   else
   {
      _loc3_ = rankOld;
   }
   if(_loc3_ < 1 && numWins >= 10)
   {
      _loc2_.TextExpired._visible = true;
      _loc2_.TextExpired.htmlText = "<font color= \'#466571\'>" + _global.GameInterface.Translate("#SFUI_Scoreboard_CompWins_Skill_Group_Expired") + "</font>";
      _global.AutosizeTextDown(_loc2_.Text,9);
      _loc2_.CompWins._visible = true;
   }
   else if(_loc3_ < 1)
   {
      var _loc8_ = 10;
      var _loc9_ = _loc8_ - numWins;
      var _loc5_ = _global.GameInterface.Translate("#SFUI_Scoreboard_CompWins_No_Skill_Group");
      _loc2_.Text._visible = true;
      _loc5_ = _global.ConstructString(_loc5_,_loc9_);
      _loc2_.Text.htmlText = _loc5_;
      _global.AutosizeTextDown(_loc2_.Text,9);
      _loc2_.Text.autoSize = "left";
      if(numWins > 0)
      {
         _loc2_.CompWins._visible = true;
      }
      else
      {
         _loc2_.CompWins._visible = false;
      }
      LoadEloIcon(82.5,33,"econ/status_icons/skillgroup_none.png",_loc2_.EloIcon.XpIcon);
      _loc2_.EloIcon._visible = true;
   }
   else if(_loc3_ >= 1)
   {
      var _loc4_ = "";
      _loc4_ = _global.GameInterface.Translate(aRankNames[_loc3_]);
      if(_loc2_._bRankedUp)
      {
         _loc2_.LevelUpAnim._visible = true;
         LoadEloIcon(82.5,33,"econ/status_icons/skillgroup" + _loc3_ + ".png",_loc2_.LevelUpAnim.XpIcon.XpIcon);
         _loc2_.EloIcon._visible = true;
         _loc2_.LevelUpAnim.TextR.Text.htmlText = "#SFUI_WinPanel_elo_up_string";
         _loc2_.LevelUpAnim.Text.Text.htmlText = _loc4_;
         _global.AutosizeTextDown(_loc2_.LevelUpAnim.TextR.Text,9);
         _global.AutosizeTextDown(_loc2_.LevelUpAnim.Text.Text,9);
      }
      _loc4_ = "<b>" + _loc4_ + "</b>" + " <font color= \'#466571\'>" + _global.GameInterface.Translate("#SFUI_WinPanel_elo_current_string") + "</font>";
      _loc2_.Text._visible = true;
      _loc2_.Text.htmlText = _loc4_;
      _global.AutosizeTextDown(_loc2_.Text,9);
      _loc2_.CompWins._visible = true;
      LoadEloIcon(82.5,33,"econ/status_icons/skillgroup" + _loc3_ + ".png",_loc2_.EloIcon.XpIcon);
      _loc2_.EloIcon._visible = true;
   }
   if(_loc2_.CompWins._visible)
   {
      _loc2_.CompWins.Text.htmlText = "<font color= \'#8DB2D8\'><b>" + numWins + "</b></font>" + " <font color= \'#466571\'>" + _global.GameInterface.Translate("#SFUI_Scoreboard_CompWins") + "</font>";
      _global.AutosizeTextDown(_loc2_.CompWins.Text,10);
   }
   ShowScoreboard();
}
function SkillGroupRankUpAnim()
{
   var _loc2_ = ScoreBoard.InnerScoreBoard.EloPanel;
   _loc2_.LevelUpAnim.gotoAndPlay("StartAnim");
   _global.navManager.PlayNavSound("XPLevelUp");
}
function OnMatchXpReceived(strPoints, strReason, nOldLevel, nOldXp)
{
   var _loc3_ = strPoints.split(",");
   var _loc7_ = strReason.split(",");
   var _loc6_ = new Array();
   trace("---------------------------OnMatchXpReceived------------------" + strPoints);
   trace("---------------------------OnMatchXpReceived------------------" + strReason);
   var _loc10_ = null;
   var _loc9_ = null;
   var _loc1_ = 0;
   while(_loc1_ < _loc3_.length)
   {
      var _loc2_ = Number(_loc3_[_loc1_]);
      _loc6_.push({reason:_loc7_[_loc1_],xp:_loc2_});
      _loc1_ = _loc1_ + 1;
   }
   ShowXpPanel(_loc6_,nOldLevel,nOldXp);
}
function ShowXpPanel(aTotalXp, nOldLevel, nOldXp)
{
   var _loc5_ = ScoreBoard.InnerScoreBoard.XpPanel;
   var _loc7_ = nOldLevel;
   var _loc6_ = nOldXp;
   var _loc11_ = _global.CScaleformComponent_MyPersona.GetXpPerLevel();
   var _loc10_ = _loc5_.XpBar._width;
   _loc5_._bHasXp = false;
   if(_loc6_ == undefined || _loc6_ == null || _loc7_ == undefined)
   {
      _loc5_._visible = false;
      return undefined;
   }
   if(_loc6_ > 0)
   {
      aTotalXp.unshift({reason:"Old",xp:_loc6_});
   }
   _loc5_._numLevelOld = _loc7_;
   var _loc4_ = 0;
   var _loc2_ = 0;
   while(_loc2_ < aTotalXp.length)
   {
      _loc4_ = _loc4_ + aTotalXp[_loc2_].xp;
      _loc2_ = _loc2_ + 1;
   }
   if(_loc4_ > 0)
   {
      _loc5_._bHasXp = true;
      m_aTotalXp = [];
      m_aTotalXp = aTotalXp;
      SetXpPanelData(_loc7_);
   }
   return undefined;
}
function SetXpPanelData(numLevelOld)
{
   var _loc2_ = ScoreBoard.InnerScoreBoard.XpPanel;
   var _loc3_ = _global.GameInterface.Translate("#SFUI_XP_RankName_Display");
   _loc3_ = _global.ConstructString(_loc3_,numLevelOld,_global.GameInterface.Translate("#SFUI_XP_RankName_" + numLevelOld));
   _loc2_.XpIconAnim.Text.htmlText = _loc3_;
   LoadEloIcon(38,38,"econ/status_icons/level" + numLevelOld + ".png",_loc2_.XpIconAnim.XpIcon.XpIcon);
   _loc2_.XpIconAnim._visible = true;
   _loc2_.XpIconAnim._alpha = 100;
}
function DebugPrintXpEntires(aTotalXp, strDesc)
{
   var _loc3_ = 0;
   var _loc1_ = 0;
   while(_loc1_ < aTotalXp.length)
   {
      trace("--------------------XP:" + strDesc + "Index: " + _loc1_ + " numXp: " + aTotalXp[_loc1_].xp + " Reason: " + aTotalXp[_loc1_].reason);
      _loc3_ = _loc3_ + aTotalXp[_loc1_].xp;
      _loc1_ = _loc1_ + 1;
   }
   trace("--------------------numTotalXp:" + strDesc + _loc3_);
}
function XpBarShow(aTotalXp)
{
   var _loc8_ = _global.CScaleformComponent_MyPersona.GetXpPerLevel();
   var _loc13_ = 0;
   var _loc6_ = 0;
   var _loc5_ = new Array();
   var _loc14_ = 0;
   var _loc2_ = 0;
   while(_loc2_ < aTotalXp.length)
   {
      _loc6_ = _loc6_ + aTotalXp[_loc2_].xp;
      _loc13_ = _loc13_ + aTotalXp[_loc2_].xp;
      if(_loc6_ >= _loc8_)
      {
         var _loc4_ = _loc6_ - _loc8_;
         var _loc7_ = aTotalXp[_loc2_].xp - _loc4_;
         trace("--------------------numLeftOverXp: " + _loc4_);
         trace("--------------------numRemainingXp: " + _loc7_);
         if(_loc4_ > 0)
         {
            _loc5_.push({reason:aTotalXp[_loc2_].reason,xp:_loc7_,levelup:true,displayxp:aTotalXp[_loc2_].xp});
            _loc5_.push({reason:aTotalXp[_loc2_].reason,xp:_loc4_,levelup:false,displayxp:0});
         }
         else
         {
            _loc5_.push({reason:aTotalXp[_loc2_].reason,xp:aTotalXp[_loc2_].xp,levelup:true,displayxp:aTotalXp[_loc2_].xp});
         }
         _loc6_ = 0;
         _loc14_ = _loc14_ + 1;
      }
      else
      {
         _loc5_.push({reason:aTotalXp[_loc2_].reason,xp:aTotalXp[_loc2_].xp,levelup:false,displayxp:aTotalXp[_loc2_].xp});
      }
      _loc2_ = _loc2_ + 1;
   }
   DebugPrintXpEntires(_loc5_,"aBarSegments");
   ScoreBoard.InnerScoreBoard.XpPanel._visible = true;
   ClearBars(10);
   ClearLabels(10);
   SetRemainingXp(_loc14_,_loc13_,_loc8_);
   PlaceXpBars(_loc5_,_loc8_);
   PlaceXpLabels(_loc5_);
   SetEloPanelPos();
}
function PlaceXpBars(aBarSegments, numXpNeededForNextLevel)
{
   ScoreBoard.InnerScoreBoard.XpPanel.XpBar.Bar._visible = false;
   ScoreBoard.InnerScoreBoard.XpPanel.XpBar.Seperator._visible = false;
   ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim._visible = false;
   ScoreBoard.InnerScoreBoard.XpPanel.RemainingXp._visible = false;
   var _loc2_ = ScoreBoard.InnerScoreBoard.XpPanel.XpBar;
   var _loc6_ = ScoreBoard.InnerScoreBoard.XpPanel.XpBar;
   var _loc4_ = 0;
   var _loc1_ = 0;
   while(_loc1_ < aBarSegments.length)
   {
      _loc4_ = _loc4_ + aBarSegments[_loc1_].xp;
      trace("--------------------numXpTotal: " + _loc4_);
      _loc2_.Bar.duplicateMovieClip("Bar" + _loc1_,10 + _loc1_);
      _loc2_["Bar" + _loc1_]._xscale = aBarSegments[_loc1_].xp / numXpNeededForNextLevel * 100;
      _loc2_["Bar" + _loc1_]._visible = false;
      _loc2_["Bar" + _loc1_].SolidBar.transform.colorTransform = GetBarTint(aBarSegments[_loc1_].reason.toString());
      if(_loc1_ == 0 || aBarSegments[_loc1_ - 1].levelup == true)
      {
         _loc2_["Bar" + _loc1_]._x = 0;
      }
      else
      {
         _loc2_["Bar" + _loc1_]._x = _loc2_["Bar" + (_loc1_ - 1)]._x + _loc2_["Bar" + (_loc1_ - 1)]._width;
      }
      _loc2_.Seperator.duplicateMovieClip("Seperator" + _loc1_,50 + _loc1_);
      _loc2_["Seperator" + _loc1_]._x = _loc2_["Bar" + _loc1_]._x;
      _loc2_["Seperator" + _loc1_]._visible = false;
      _loc1_ = _loc1_ + 1;
   }
   RevealXpBars(aBarSegments);
}
function PlaceXpLabels(aBarSegments)
{
   ScoreBoard.InnerScoreBoard.XpPanel.Label._visible = false;
   var _loc3_ = ScoreBoard.InnerScoreBoard.XpPanel;
   var _loc5_ = "";
   var _loc6_ = null;
   var _loc12_ = 0;
   var _loc2_ = 0;
   while(_loc2_ < aBarSegments.length)
   {
      if(_loc12_ > 1)
      {
         return undefined;
      }
      _loc3_.Label.duplicateMovieClip("Label" + _loc2_,100 + _loc2_);
      _loc3_["Label" + _loc2_].LabelAnim.Bg.transform.colorTransform = GetBarTint(aBarSegments[_loc2_].reason.toString());
      if(aBarSegments[_loc2_].displayxp == 0)
      {
         _loc5_ = _global.GameInterface.Translate("#SFUI_XP_RankName_NewLevel");
         _loc3_["Label" + _loc2_].LabelAnim.Bg.transform.colorTransform = GetBarTint("levelup");
      }
      else if(aBarSegments[_loc2_].reason == "Old")
      {
         _loc5_ = _global.GameInterface.Translate("#SFUI_XP_Bonus_RankUp_" + aBarSegments[_loc2_].reason);
         _loc5_ = _global.ConstructString(_loc5_,_global.FormatNumberToString(aBarSegments[_loc2_].displayxp));
      }
      else
      {
         var _loc7_ = _global.CScaleformComponent_MatchStats.GetGameMode();
         _loc7_ = _global.GameInterface.Translate(_global.GameInterface.Translate("#SFUI_GameMode_" + _loc7_));
         _loc5_ = _global.GameInterface.Translate("#SFUI_XP_Bonus_RankUp_" + aBarSegments[_loc2_].reason);
         _loc5_ = _global.ConstructString(_loc5_,_global.FormatNumberToString(aBarSegments[_loc2_].displayxp),_loc7_);
      }
      _loc3_["Label" + _loc2_].LabelAnim.Text.Text.htmlText = _loc5_;
      _loc3_["Label" + _loc2_].LabelAnim.Text.Text.autoSize = "left";
      var _loc9_ = _loc3_["Label" + _loc2_].LabelAnim.Text.Text._x;
      var _loc10_ = _loc3_["Label" + _loc2_].LabelAnim.Text.Text._width;
      _loc3_["Label" + _loc2_].LabelAnim.Bg._width = _loc9_ + _loc10_ + 3;
      _loc3_["Label" + _loc2_].LabelAnim.Bg._alpha = 30;
      if(_loc2_ == 0)
      {
         _loc3_["Label" + _loc2_]._x = _loc3_.XpBar._x;
         _loc3_["Label" + _loc2_]._y = ScoreBoard.InnerScoreBoard.XpPanel.Label._y;
      }
      else
      {
         var _loc8_ = _loc6_._x + _loc6_._width + 3;
         var _loc11_ = _loc8_ + _loc3_["Label" + _loc2_]._width;
         if(_loc11_ > _loc3_.XpBar._width + _loc3_.XpBar._x)
         {
            _loc12_ = _loc12_ + 1;
            _loc3_["Label" + _loc2_]._x = _loc3_.XpBar._x;
            _loc3_["Label" + _loc2_]._y = _loc3_.Label._y + _loc3_.Label.LabelAnim.Bg._height + 1;
         }
         else
         {
            _loc3_["Label" + _loc2_]._x = _loc8_;
            _loc3_["Label" + _loc2_]._y = _loc6_._y;
         }
      }
      _loc3_["Label" + _loc2_]._visible = false;
      _loc6_ = _loc3_["Label" + _loc2_];
      _loc6_._levelup = aBarSegments[_loc2_].levelup;
      _loc2_ = _loc2_ + 1;
   }
}
function GetBarTint(strReason)
{
   if(strReason == "Old")
   {
      return BlueBar;
   }
   if(strReason == "levelup")
   {
      return PurpleBar;
   }
   if(strReason == "6" || strReason == "7")
   {
      return YellowBar;
   }
   return GreenBar;
}
function RevealXpBars(aBarSegments)
{
   var objBar = ScoreBoard.InnerScoreBoard.XpPanel.XpBar;
   var numBar = 0;
   var numDrawLoop = 0;
   var _loc2_ = false;
   var numPauseTimer = 30;
   var numAnimTarget = 0;
   var numPauseTime = 12;
   var numNewLevelsEarned = 0;
   var numSound = 1;
   ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim._bIsPlaying = false;
   ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim._bClearBars = false;
   ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim.swapDepths(500);
   ScoreBoard.InnerScoreBoard.XpPanel.onEnterFrame = function()
   {
      if(ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim._bClearBars == true)
      {
         ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim._bClearBars = false;
         ClearBars(numBar - 1);
      }
      if(ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim._bIsPlaying == false)
      {
         if(numPauseTimer <= numPauseTime)
         {
            if(aBarSegments[numBar - 1].levelup == true && numPauseTimer == numPauseTime)
            {
               numNewLevelsEarned++;
               PlayLevelUpAnim(numNewLevelsEarned);
            }
            numPauseTimer++;
            trace("--------------------numPauseTimer: " + numPauseTimer);
         }
         else if(numDrawLoop == 0)
         {
            numAnimTarget = objBar["Bar" + numBar]._xscale;
            objBar["Seperator" + numBar]._visible = true;
            objBar["Bar" + numBar]._visible = true;
            ScoreBoard.InnerScoreBoard.XpPanel["Label" + numBar]._visible = true;
            if(numBar > 0)
            {
               if(ScoreBoard.InnerScoreBoard.XpPanel["Label" + numBar])
               {
                  ScoreBoard.InnerScoreBoard.XpPanel["Label" + numBar].gotoAndPlay("StartAnim");
                  if(aBarSegments[numBar].reason == "6" || aBarSegments[numBar].reason == "7")
                  {
                     _global.navManager.PlayNavSound("XPBarSound5");
                  }
                  else if(numSound < 5)
                  {
                     _global.navManager.PlayNavSound("XPBarSound" + numSound);
                     numSound++;
                  }
               }
            }
            else
            {
               ScoreBoard.InnerScoreBoard.XpPanel["Label" + numBar].gotoAndPlay("StopAnim");
            }
            if(numBar > 0)
            {
               objBar["Bar" + numBar]._xscale = 0;
               objBar["Bar" + numBar].Glow.gotoAndPlay("StartAnim");
            }
            numDrawLoop++;
         }
         else
         {
            trace("--------------------bar scale: " + objBar["Bar" + numBar]._xscale);
            trace("----------------numAnimTarget: " + numAnimTarget);
            if(objBar["Bar" + numBar]._xscale >= numAnimTarget - 0.25)
            {
               trace("--------------------bar is finished : " + numBar);
               objBar["Bar" + numBar]._xscale = numAnimTarget;
               if(aBarSegments.length == numBar)
               {
                  if(numNewLevelsEarned == 0)
                  {
                     ShowRemainingXp();
                     _global.navManager.PlayNavSound("XPRemaining");
                  }
                  delete ScoreBoard.InnerScoreBoard.XpPanel.onEnterFrame;
               }
               numBar++;
               numDrawLoop = 0;
               numPauseTimer = 0;
            }
            else
            {
               objBar["Bar" + numBar]._xscale = objBar["Bar" + numBar]._xscale + (numAnimTarget - objBar["Bar" + numBar]._xscale) * 0.2;
               if(numDrawLoop % 6)
               {
                  _global.navManager.PlayNavSound("XPRemaining");
               }
            }
         }
      }
   };
}
function ClearBars(numBars)
{
   var _loc2_ = ScoreBoard.InnerScoreBoard.XpPanel.XpBar;
   var _loc1_ = 0;
   while(_loc1_ <= numBars)
   {
      if(_loc2_["Seperator" + _loc1_])
      {
         _loc2_["Seperator" + _loc1_].removeMovieClip();
      }
      if(_loc2_["Bar" + _loc1_])
      {
         _loc2_["Bar" + _loc1_].removeMovieClip();
      }
      _loc1_ = _loc1_ + 1;
   }
}
function ClearLabels(numBars)
{
   var _loc2_ = ScoreBoard.InnerScoreBoard.XpPanel;
   var _loc1_ = 0;
   while(_loc1_ <= numBars)
   {
      if(_loc2_["Label" + _loc1_])
      {
         _loc2_["Label" + _loc1_].removeMovieClip();
      }
      _loc1_ = _loc1_ + 1;
   }
}
function PlayLevelUpAnim(numNewLevelsEarned)
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetMaxLevel();
   var _loc6_ = _global.CScaleformComponent_FriendsList.GetFriendLevel(_global.CScaleformComponent_MyPersona.GetXuid());
   if(_loc6_ >= _loc3_)
   {
      var _loc2_ = _loc3_;
      var _loc5_ = _global.GameInterface.Translate("#SFUI_XP_RankName_" + _loc3_);
      ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim.TextR.Text.htmlText = "#SFUI_XP_RankName_EarnedMax";
   }
   else
   {
      _loc2_ = ScoreBoard.InnerScoreBoard.XpPanel._numLevelOld + numNewLevelsEarned;
      _loc5_ = _global.GameInterface.Translate("#SFUI_XP_RankName_" + _loc2_);
      ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim.TextR.Text.htmlText = "#SFUI_XP_RankName_EarnedNewLevel";
   }
   var _loc4_ = _global.GameInterface.Translate("#SFUI_XP_RankName_Display");
   _loc4_ = _global.ConstructString(_loc4_,_loc2_,_loc5_);
   ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim.Text.Text.htmlText = _loc4_;
   LoadEloIcon(28,28,"econ/status_icons/level" + _loc2_ + ".png",ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim.XpIcon.XpIcon);
   ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim._visible = true;
   ScoreBoard.InnerScoreBoard.XpPanel.LevelUpAnim.gotoAndPlay("StartAnim");
   _global.navManager.PlayNavSound("XPLevelUp2");
   SetXpPanelData(_loc2_);
}
function ShowRemainingXp(numNewLevelsEarned)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetMaxLevel();
   var _loc3_ = _global.CScaleformComponent_FriendsList.GetFriendLevel(_global.CScaleformComponent_MyPersona.GetXuid());
   if(_loc3_ >= _loc2_)
   {
      return undefined;
   }
   ScoreBoard.InnerScoreBoard.XpPanel.RemainingXp._visible = true;
   ScoreBoard.InnerScoreBoard.XpPanel.RemainingXp.gotoAndPlay("StartAnim");
}
function SetRemainingXp(numNewLevelsEarned, numTotalXp, numXpNeededForNextLevel)
{
   var _loc11_ = ScoreBoard.InnerScoreBoard.XpPanel.RemainingXp;
   var _loc9_ = _global.CScaleformComponent_MyPersona.GetActiveXpBonuses();
   var _loc3_ = _loc9_.split(",");
   var _loc4_ = false;
   var _loc6_ = undefined;
   var _loc7_ = ScoreBoard.InnerScoreBoard.XpPanel._numLevelOld + numNewLevelsEarned + 1;
   if(numNewLevelsEarned > 0)
   {
      numXpNeededForNextLevel = numXpNeededForNextLevel * numNewLevelsEarned;
   }
   var _loc10_ = numXpNeededForNextLevel - numTotalXp;
   trace("---------------------------strActiveBonuses----------------" + _loc9_);
   var _loc5_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
   _loc5_ = _loc5_ + 1;
   var _loc12_ = _global.CScaleformComponent_MyPersona.GetMyMedalRankByType(_loc5_ + "Operation$OperationCoin");
   if(_loc12_ <= 1)
   {
      _loc5_ = 0;
   }
   var _loc2_ = 0;
   while(_loc2_ < _loc3_.length)
   {
      if(_loc3_[_loc2_] == 2)
      {
         _loc4_ = true;
      }
      _loc2_ = _loc2_ + 1;
   }
   if(!_loc4_)
   {
      _loc6_ = _global.GameInterface.Translate("#SFUI_XP_Bonus_RankUp_Remain");
      _loc6_ = _global.ConstructString(_loc6_,_loc10_,_loc7_,_global.GameInterface.Translate("#SFUI_XP_RankName_" + _loc7_));
   }
   else
   {
      _loc6_ = _global.GameInterface.Translate("#SFUI_XP_Bonus_RankUp_Remain_Drop");
      var _loc8_ = "";
      if(_loc5_ > 0)
      {
         _loc8_ = " " + _global.GameInterface.Translate("#SFUI_mapgroup_op_op0" + _loc5_ + "_Short");
      }
      _loc6_ = _global.ConstructString(_loc6_,_global.FormatNumberToString(_loc10_),_loc7_,_loc8_);
   }
   _loc11_.Remainder.Text.htmlText = _loc6_;
}
function LoadEloIcon(numWidth, numHeight, MovieName, objIcon)
{
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
      target_mc.forceSmoothing = true;
   };
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(MovieName,objIcon);
}
function SetEloPanelPos()
{
   var _loc2_ = ScoreBoard.InnerScoreBoard.XpPanel;
   var _loc1_ = ScoreBoard.InnerScoreBoard.EloPanel;
   var _loc3_ = 56;
   if(_loc2_._visible)
   {
      _loc1_._y = _loc3_ + _loc2_._y - 1;
   }
   else
   {
      _loc1_._y = 507.75;
   }
}
function OpenContextMenu(objRow)
{
   if(!scoreboardVisible)
   {
      return undefined;
   }
   objRow._SelectedXuid = gameAPI.GetSelectedPlayerXuid();
   objRow._SelectedIndex = gameAPI.GetSelectedPlayerIndex();
   var _loc13_ = ScoreBoard.PlayerContextMenu;
   var _loc3_ = [];
   var _loc4_ = [];
   var _loc14_ = _global.CScaleformComponent_FriendsList.IsLocalPlayerPlayingMatch();
   var _loc8_ = false;
   var _loc6_ = _global.CScaleformComponent_Inventory.GetMusicIDForPlayer(objRow._SelectedXuid);
   var _loc12_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc11_ = _global.CScaleformComponent_MyPersona.GetLauncherType() != "perfectworld"?false:true;
   if(objRow._SelectedXuid == "" || objRow._SelectedXuid == null || objRow._SelectedXuid == undefined)
   {
      return undefined;
   }
   if(objRow._SelectedXuid == _loc12_)
   {
      _loc8_ = true;
   }
   _loc3_.push("goprofile");
   _loc4_.push("#SFUI_Lobby_ShowCSGOProfile");
   if(!_loc11_)
   {
      _loc3_.push("steamprofile");
      _loc4_.push("#SFUI_Lobby_ShowGamercard");
   }
   if(!_loc8_ && !_loc11_)
   {
      _loc3_.push("message");
      _loc4_.push("#SFUI_PlayerDetails_Trade");
   }
   if(!_loc8_)
   {
      if(_loc6_ != null && _loc6_ != undefined && _loc6_ != 0 && _loc6_ != 1)
      {
         var _loc15_ = _global.CScaleformComponent_Inventory.GetMusicNameFromMusicID(_loc6_);
         var _loc7_ = _global.GameInterface.GetConvarNumber("cl_borrow_music_from_player_index");
         var _loc10_ = false;
         if(m_MusicKitBorrowedId != _loc6_)
         {
            var _loc9_ = _global.GameInterface.Translate("#SFUI_PlayerDetails_MusicKit");
            _loc9_ = _global.ConstructString(_loc9_,_global.GameInterface.Translate(_loc15_));
            _loc3_.push("seperator");
            _loc4_.push("");
            _loc10_ = true;
            _loc3_.push("equipmusickit");
            _loc4_.push(_loc9_);
         }
         if(_loc7_ != "" && _loc7_ != undefined && _loc7_ != null && _loc7_ != 0)
         {
            if(_loc10_ == false)
            {
               _loc3_.push("seperator");
               _loc4_.push("");
            }
            _loc3_.push("restmusickit");
            _loc4_.push("#SFUI_PlayerDetails_Revert_MusicKit");
         }
      }
   }
   else if(m_MusicKitBorrowedId != null && m_MusicKitBorrowedId != undefined && m_MusicKitBorrowedId != 0 && m_MusicKitBorrowedId != 1)
   {
      var _loc16_ = _global.CScaleformComponent_Inventory.GetMusicIDForPlayer(_loc12_);
      if(m_MusicKitBorrowedId != _loc16_)
      {
         _loc3_.push("seperator");
         _loc4_.push("");
         _loc3_.push("restmusickit");
         _loc4_.push("#SFUI_PlayerDetails_Revert_MusicKit");
      }
   }
   if(!_loc8_ && _loc14_)
   {
      _loc3_.push("seperator");
      _loc4_.push("");
      if(_global.CScaleformComponent_FriendsList.IsSelectedPlayerMuted(objRow._SelectedXuid))
      {
         _loc3_.push("Mute");
         _loc4_.push("#SFUI_PlayerDetails_Unmute");
         _loc3_.push("seperator");
         _loc4_.push("");
      }
      else if(objRow.nTeam == 2 || objRow.nTeam == 3)
      {
         _loc3_.push("Mute");
         _loc4_.push("#SFUI_PlayerDetails_Mute");
      }
      if(!_global.CScaleformComponent_MyPersona.IsVacBanned())
      {
         _loc3_.push("seperator");
         _loc4_.push("");
         _loc3_.push("Commend");
         _loc4_.push("#SFUI_PlayerDetails_Commend");
         _loc3_.push("Report");
         _loc4_.push("#SFUI_PlayerDetails_Report");
         if("none" == _global.CScaleformComponent_FriendsList.GetFriendRelationship(objRow._SelectedXuid))
         {
            _loc3_.push("addfriend");
            _loc4_.push("#SFUI_Friend_Add");
         }
      }
   }
   _loc13_.TooltipShowHide();
   _loc13_.TooltipLayout(_loc3_,_loc4_,objRow,this.AssignContextMenuAction);
}
function GetMusicKitName(xuid)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetMusicIDForPlayer(xuid);
   var _loc3_ = "";
   if(_loc2_ == null || _loc2_ == undefined || _loc2_ == "" || _loc2_ == 0 || _loc2_ == 1)
   {
      return _loc3_;
   }
   _loc3_ = _global.CScaleformComponent_Inventory.GetMusicNameFromMusicID(_loc2_);
   if(_loc3_ == null || _loc3_ == undefined || _loc3_ == "")
   {
      return _loc3_;
   }
}
function ToggleMute()
{
   _global.CScaleformComponent_FriendsList.ToggleMute(gameAPI.GetSelectedPlayerXuid());
}
function HideContextMenu()
{
   ScoreBoard.PlayerContextMenu._visible = false;
}
function onSteamProfile()
{
   _global.CScaleformComponent_SteamOverlay.ShowUserProfilePage(gameAPI.GetSelectedPlayerXuid());
}
function onMessage()
{
   _global.CScaleformComponent_SteamOverlay.StartTradeWithUser(gameAPI.GetSelectedPlayerXuid());
}
function ShowPlayerDetails(PanelToOpen)
{
   var _loc4_ = gameAPI.GetSelectedPlayerXuid();
   _global.ScoreboardAPI.OpenPlayerDetailsPanel(_loc4_,PanelToOpen);
   var _loc2_ = _global.PlayerDetailsMovie;
   if(_loc2_ != undefined && _loc2_ != null)
   {
      var _loc3_ = gameAPI.GetSelectedPlayerIndex();
      _loc4_ = gameAPI.GetSelectedPlayerXuid();
      _loc2_.ShowPlayerDetails(_loc4_,_loc3_);
      trace("ShowPlayerDetails");
   }
   else
   {
      trace("Didnt find PlayerDetailsMovie!!!!!!!");
   }
}
function HideEloBracketInfo()
{
   ScoreBoard.InnerScoreBoard.EloRankText.EloText._visible = false;
   ScoreBoard.InnerScoreBoard.eloBracket._visible = false;
}
function AssignContextMenuAction(strMenuItem, objTargetTile)
{
   switch(strMenuItem)
   {
      case "goprofile":
         ShowPlayerDetails("ProfileBasic");
         break;
      case "steamprofile":
         onSteamProfile();
         if(ScoreBoard.InnerScoreBoard.bg_endmatch._visible == false)
         {
            hidePanel();
         }
         break;
      case "message":
         onMessage();
         if(ScoreBoard.InnerScoreBoard.bg_endmatch._visible == false)
         {
            hidePanel();
         }
         break;
      case "Commend":
         ShowPlayerDetails("ProfileCommend");
         break;
      case "Report":
         ShowPlayerDetails("ProfileReport");
         break;
      case "Mute":
         ToggleMute();
         break;
      case "addfriend":
         _global.CScaleformComponent_SteamOverlay.InteractWithUser(objTargetTile._SelectedXuid,"friendadd");
         break;
      case "equipmusickit":
         EquipSelectedMusicKit(objTargetTile);
         break;
      case "restmusickit":
         ResetMusicKit(objTargetTile);
   }
}
function EquipSelectedMusicKit(objTargetTile)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetMusicIDForPlayer(objTargetTile._SelectedXuid);
   var _loc3_ = _global.CScaleformComponent_Inventory.GetMusicIDForPlayer(_global.CScaleformComponent_MyPersona.GetXuid());
   if(_loc2_ == _loc3_)
   {
      return undefined;
   }
   if(_loc2_ != null && _loc2_ != undefined && _loc2_ != 0 && _loc2_ != 1)
   {
      _global.GameInterface.SetConvar("cl_borrow_music_from_player_index",objTargetTile._SelectedIndex);
      m_MusicKitBorrowedId = _loc2_;
      strMusicKitName = _global.CScaleformComponent_Inventory.GetMusicNameFromMusicID(_loc2_);
      var _loc4_ = _global.CScaleformComponent_FriendsList.GetFriendName(objTargetTile._SelectedXuid);
      DisplayMusicKit();
      trace("-------------------------EquipSelectedMusicKit-Borrowing-Kit------>" + _loc2_ + ":" + "strMusicKitName");
      trace("-------------------------EquipSelectedMusicKit-Borrowing-From------>" + _loc4_);
   }
}
function ResetMusicKit(objTargetTile)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetMusicIDForPlayer(_global.CScaleformComponent_MyPersona.GetXuid());
   _global.GameInterface.SetConvar("cl_borrow_music_from_player_index","");
   m_MusicKitBorrowedId = _loc2_;
   DisplayMusicKit();
   var _loc4_ = _global.CScaleformComponent_Inventory.GetMusicNameFromMusicID(_loc2_);
   var _loc3_ = _global.CScaleformComponent_FriendsList.GetFriendName(objTargetTile._SelectedXuid);
   trace("-------------------------ResetMusicKit-Returning-Kit------>" + _loc2_ + ":" + "strMusicKitName");
   trace("-------------------------ResetMusicKit-Returning-To------>" + _global.CScaleformComponent_MyPersona.GetXuid());
}
function DisplayMusicKit()
{
   var _loc10_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc2_ = _global.CScaleformComponent_Inventory.GetMusicIDForPlayer(_loc10_);
   var _loc4_ = _global.GameInterface.GetConvarNumber("cl_borrow_music_from_player_index");
   var _loc5_ = false;
   if(_loc4_ != "" && _loc4_ != undefined && _loc4_ != null && _loc4_ != 0)
   {
      _loc5_ = true;
   }
   if(_loc5_)
   {
      _loc2_ = m_MusicKitBorrowedId;
      _loc5_ = true;
   }
   if(_loc2_ == null || _loc2_ == undefined || _loc2_ == 0 || _loc2_ == 1)
   {
      ScoreBoard.InnerScoreBoard.MusicKitPanel._visible = false;
      return undefined;
   }
   var _loc3_ = _global.GameInterface.Translate(_global.CScaleformComponent_Inventory.GetMusicNameFromMusicID(_loc2_));
   if(_loc3_ == null || _loc3_ == undefined || _loc3_ == "")
   {
      ScoreBoard.InnerScoreBoard.MusicKitPanel._visible = false;
      return undefined;
   }
   var _loc9_ = _global.CScaleformComponent_Inventory.GetItemInventoryImageFromMusicID(_loc2_) + ".png";
   if(ScoreBoard.InnerScoreBoard.MusicKitPanel.MusicImage.DynamicItemImage.Image != undefined)
   {
      ScoreBoard.InnerScoreBoard.MusicKitPanel.MusicImage.DynamicItemImage.Image.unloadMovie();
   }
   var _loc7_ = new Object();
   _loc7_.onLoadInit = function(target_mc)
   {
      target_mc._width = 31;
      target_mc._height = 25.5;
   };
   _loc7_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc11_ = _loc9_;
   var _loc8_ = new MovieClipLoader();
   _loc8_.addListener(_loc7_);
   _loc8_.loadClip(_loc11_,ScoreBoard.InnerScoreBoard.MusicKitPanel.MusicImage.DynamicItemImage.Image);
   if(_loc5_)
   {
      var _loc6_ = _global.GameInterface.Translate("#SFUI_PlayerDetails_Borrow_MusicKit");
      _loc6_ = _global.ConstructString(_loc6_,_global.GameInterface.Translate(_loc3_));
      ScoreBoard.InnerScoreBoard.MusicKitPanel.MusicText.Text.htmlText = _loc6_;
   }
   else
   {
      ScoreBoard.InnerScoreBoard.MusicKitPanel.MusicText.Text.htmlText = _loc3_;
   }
   ScoreBoard.InnerScoreBoard.MusicKitPanel._visible = true;
}
function ShowToolTip(bShow, locX, locY, Round, TeamWon, WinType)
{
   var _loc10_ = int(_global.ScoreboardAPI.GetCurrentRound());
   trace("ShowToolTip: bShow = " + bShow + ", Round = " + Round + ", nCurrentRound = " + _loc10_);
   if(Round >= _loc10_)
   {
      trace("ShowToolTip [RETURNING]: Round+1 = " + Round + ", nCurrentRound = " + _loc10_);
      return undefined;
   }
   var _loc13_ = new flash.geom.ColorTransform();
   Tooltip.swapDepths(this.getNextHighestDepth());
   if(bShow)
   {
      var _loc6_ = _global.CScaleformComponent_MatchStats.GetRoundPlayersAlive_CT(Round);
      var _loc5_ = _global.CScaleformComponent_MatchStats.GetRoundPlayersAlive_T(Round);
      Tooltip.Icons.Kill._visible = false;
      Tooltip.Icons.Bomb._visible = false;
      Tooltip.Icons.Hostage._visible = false;
      Tooltip.Icons.Defuse._visible = false;
      Tooltip.Icons.Time._visible = false;
      Tooltip.Icons[WinType]._visible = true;
      Tooltip.Icons[WinType]._alpha = 100;
      var _loc7_ = "";
      switch(WinType)
      {
         case "Hostage":
            _loc7_ = _global.GameInterface.Translate("#SFUI_RoundWin_Hostage");
            break;
         case "Defuse":
            _loc7_ = _global.GameInterface.Translate("#SFUI_RoundWin_Defused");
            break;
         case "Time":
            _loc7_ = _global.GameInterface.Translate("#SFUI_RoundWin_Time");
            break;
         case "Kill":
            _loc7_ = _global.GameInterface.Translate("#SFUI_RoundWin_Kill");
            break;
         case "Bomb":
            _loc7_ = _global.GameInterface.Translate("#SFUI_RoundWin_Bomb");
            break;
         default:
            _loc7_ = "";
      }
      Tooltip.Name.htmlText = _loc7_;
      Tooltip.Type._x = Tooltip.Value._x + Tooltip.Value._width;
      var _loc12_ = _global.GameInterface.Translate("#SFUI_Graph_Round");
      var _loc11_ = Round;
      Tooltip.Round.htmlText = _loc12_ + " " + _loc11_;
      if(TeamWon == "ct")
      {
         Tooltip.Bg.transform.colorTransform = CT_ColorTransform0;
         Tooltip.Arrow.transform.colorTransform = CT_ColorTransform0;
         Tooltip.Icons[WinType].transform.colorTransform = CT_ColorTransform0;
      }
      else
      {
         Tooltip.Bg.transform.colorTransform = T_ColorTransform0;
         Tooltip.Arrow.transform.colorTransform = T_ColorTransform0;
         Tooltip.Icons[WinType].transform.colorTransform = T_ColorTransform0;
      }
      i = 1;
      while(i <= 5)
      {
         var _loc3_ = "CT_" + i;
         if(_loc6_ == -1)
         {
            Tooltip[_loc3_]._alpha = 0;
         }
         else if(i <= _loc6_)
         {
            Tooltip[_loc3_].transform.colorTransform = CT_ColorTransform0;
            Tooltip[_loc3_]._alpha = 100;
         }
         else
         {
            Tooltip[_loc3_].transform.colorTransform = Grey;
            Tooltip[_loc3_]._alpha = 40;
         }
         var _loc4_ = "T_" + i;
         if(_loc5_ == -1)
         {
            Tooltip[_loc4_]._alpha = 0;
         }
         else if(i <= _loc5_)
         {
            Tooltip[_loc4_].transform.colorTransform = T_ColorTransform0;
            Tooltip[_loc4_]._alpha = 100;
         }
         else
         {
            Tooltip[_loc4_].transform.colorTransform = Grey;
            Tooltip[_loc4_]._alpha = 40;
         }
         i++;
      }
      Tooltip._x = locX;
      Tooltip._y = locY;
      Tooltip._visible = true;
   }
   else
   {
      Tooltip._visible = false;
   }
}
function OnRightClick(KeyBind)
{
   if(scoreboardVisible)
   {
      if(!m_bEnableCursor)
      {
         m_bEnableCursor = true;
         _global.navManager.RemoveLayout(scoreboardNav);
         _global.navManager.PushLayout(scoreboardCursorNav,"scoreboardCursorNav");
         ScoreBoard.InnerScoreBoard.CursorHint.Hint.CursorHintText.htmlText = "#SFUI_Scoreboard_Navigation_Cursor_Choose";
         ScoreBoard.InnerScoreBoard.CursorHint.gotoAndPlay("StartAnim");
         trace("-------------------------------------------------------Pressing OnRightClick---------TRUE----------------------------------------");
         return undefined;
      }
      if(GetGamePhase() < 4 && m_bEnableCursor)
      {
         m_bEnableCursor = false;
         _global.navManager.RemoveLayout(scoreboardCursorNav);
         _global.navManager.PushLayout(scoreboardNav,"scoreboardNav");
         ScoreBoard.InnerScoreBoard.CursorHint.Hint.CursorHintText.htmlText = "#SFUI_Scoreboard_Navigation_Cursor_Hint";
         trace("-------------------------------------------------------Pressing OnRightClick---------FALSE----------------------------------------");
      }
   }
}
var NUM_MAPVOTE_PANELS = 10;
var NUM_MAPVOTE_CHECKS = 10;
var MAX_LOCAL_PLAYER_ITEMS = 3;
var MAX_ITEM_DROP_PANELS = 5;
var MAX_ITEM_DROP_PANELS_CASUAL = 6;
var EXTRA_ITEM_DROP_PANEL = MAX_ITEM_DROP_PANELS;
var scoreboardNav = new Lib.NavLayout();
var scoreboardCursorNav = new Lib.NavLayout();
var TickerTextField = ScoreBoard.InnerScoreBoard.Ticker.InnerTicker.TickerText;
var scoreboardVisible = false;
var avatarWidth = 24;
var avatarHeight = 24;
var m_bIsMaxTenPlayers = true;
var intOffsetValue = 135;
var bTenPlayerOffset = false;
var srtTenPlayer = TenPlayer;
var itemDropArray = new Array();
var m_nItemDropCurIndex = 0;
var m_nItemDropErrorOffset = 0;
var m_bEnableCursor = false;
var m_numSelectedRowIndex = 0;
var m_MusicKitBorrowedFromPIndex = -1;
var m_MusicKitBorrowedId = 0;
var m_nCurrentRound = 0;
var m_bPlayersSwitchedSides = false;
Tooltip._visible = false;
var strLocalPlayerName = undefined;
var m_selectedPlayerXuid = "";
var localPlayerRow = undefined;
ScoreBoard.BannerWin._visible = false;
ScoreBoard.InnerScoreBoard.EloPanel._visible = false;
ScoreBoard.InnerScoreBoard.EloPanel.Scorecard._visible = false;
ScoreBoard.InnerScoreBoard.XpPanel._visible = false;
ScoreBoard.InnerScoreBoard.QuestPanel._visible = false;
ScoreBoard.InnerScoreBoard.ItemPanelParent.ItemPanel._visible = false;
ScoreBoard.InnerScoreBoard.ItemDropPanelIndividual._visible = false;
ScoreBoard.InnerScoreBoard.CTWinBanner._visible = false;
ScoreBoard.InnerScoreBoard.TWinBanner._visible = false;
ScoreBoard.InnerScoreBoard.GungameWinBanner._visible = false;
ScoreBoard.InnerScoreBoard.bg_endmatch._visible = false;
ScoreBoard.InnerScoreBoard.MusicKitPanel._visible = false;
var m_nTeamLogoSize = ScoreBoard.InnerScoreBoard.bg_scoreboard.TeamLogos.TLogo._width;
var m_teamLogo_CT = "";
var m_teamLogo_T = "";
var CTColor0 = "0x5aa0ce";
var CTColor1 = "0x1a8bd4";
var TColor0 = "0xd3ad59";
var TColor1 = "0xce971c";
var CTteamColor0 = "0x243742";
var TteamColor0 = "0x443011";
var m_TeamName_T = "";
var m_TeamName_CT = "";
var T_ColorTransform0 = new flash.geom.ColorTransform();
T_ColorTransform0.rgb = parseInt(TColor0);
var CT_ColorTransform0 = new flash.geom.ColorTransform();
CT_ColorTransform0.rgb = parseInt(CTColor0);
var White = new flash.geom.ColorTransform();
White.rgb = 13421772;
var Grey = new flash.geom.ColorTransform();
Grey.rgb = 5855577;
var TeamNameColor_CT = new flash.geom.ColorTransform();
TeamNameColor_CT.rgb = 6857178;
var TeamNameColor_T = new flash.geom.ColorTransform();
TeamNameColor_T.rgb = 14926433;
var BlueBar = new flash.geom.ColorTransform();
BlueBar.rgb = parseInt("0x2E4E68");
var GreenBar = new flash.geom.ColorTransform();
GreenBar.rgb = parseInt("0x31A831");
var YellowBar = new flash.geom.ColorTransform();
YellowBar.rgb = parseInt("0x91AF1C");
var PurpleBar = new flash.geom.ColorTransform();
PurpleBar.rgb = parseInt("0x9966CC");
var m_nLastHistLine_X = 0;
var m_nLastHistLine_Y = 0;
ScoreBoard.PlayerContextMenu._visible = false;
var aRankNames = new Array();
i = 1;
while(i <= 18)
{
   aRankNames[i] = "#SFUI_ELO_RankName_" + i;
   i++;
}
var nWinningMapsCount = 0;
var nLastWinningMapSlot = -1;
var aWinningMaps = new Array();
var timerRandomMapSelect;
var m_bSelectingRandomMap = false;
var m_aTotalXp = new Array();
var timerFillCoopData;
var m_fStartFillCoopData = -1;
var COOP_ANIM_REVEAL_TIME = 2200;
ScoreBoard.InnerScoreBoard.MapVotePanel._visible = false;
ClearVoteNextMapPanel();
scoreboardNav.DisableAnalogStickNavigation(true);
scoreboardCursorNav.DisableAnalogStickNavigation(true);
scoreboardCursorNav.ShowCursor(true);
scoreboardCursorNav.DenyInputToGame(false);
scoreboardNav.AddRepeatKeys("DOWN","UP","LEFT","RIGHT");
scoreboardNav.AddKeyHandlerTable({KEY_XBUTTON_START:{onDown:function(button, control, keycode)
{
}},KEY_XBUTTON_Y:{onDown:function(button, control, keycode)
{
   if(!_global.IsPC() && _global.Scoreboard != undefined && _global.Scoreboard != null && _global.Scoreboard.scoreboardVisible)
   {
      trace("Pressing ENTER");
      ShowPlayerDetails();
      return true;
   }
   return false;
}},KEY_XBUTTON_A:{onDown:function(button, control, keycode)
{
}},KEY_F1:{onDown:function(button, control, keycode)
{
   if(!_global.wantControllerShown)
   {
      _global.VotePanelAPI.VoteYes();
   }
   return true;
}},KEY_F2:{onDown:function(button, control, keycode)
{
   if(!_global.wantControllerShown)
   {
      _global.VotePanelAPI.VoteNo();
   }
   return true;
}}});
scoreboardNav.AddRepeatKeys("DOWN","UP","LEFT","RIGHT");
scoreboardCursorNav.AddKeyHandlerTable({KEY_XBUTTON_START:{onDown:function(button, control, keycode)
{
}},KEY_XBUTTON_Y:{onDown:function(button, control, keycode)
{
   if(!_global.IsPC() && _global.Scoreboard != undefined && _global.Scoreboard != null && _global.Scoreboard.scoreboardVisible)
   {
      trace("Pressing ENTER");
      ShowPlayerDetails();
      return true;
   }
   return false;
}},KEY_XBUTTON_A:{onDown:function(button, control, keycode)
{
}},KEY_F1:{onDown:function(button, control, keycode)
{
   if(!_global.wantControllerShown)
   {
      _global.VotePanelAPI.VoteYes();
   }
   return true;
}},KEY_F2:{onDown:function(button, control, keycode)
{
   if(!_global.wantControllerShown)
   {
      _global.VotePanelAPI.VoteNo();
   }
   return true;
}}});
scoreboardCursorNav.AddRepeatKeys("DOWN","UP","LEFT","RIGHT");
_global.resizeManager.AddListener(this);
stop();
