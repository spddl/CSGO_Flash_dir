function SetUpScoreBoard(MatchId, Team, Xuid, TypeOfLister, bPlayShowAnims)
{
   if(MatchID == "" || MatchId == undefined || Xuid == "" || Xuid == undefined)
   {
      HideScoreboard();
      return undefined;
   }
   if(Team == 0)
   {
      m_objSelectedRow = null;
   }
   this._MatchId = MatchId;
   this._TypeOfLister = TypeOfLister;
   var _loc10_ = IsTournament(MatchId);
   var _loc11_ = _global.CScaleformComponent_MatchInfo.GetMatchTournamentTeamTag(MatchId,Team);
   _loc11_ = "econ/tournaments/teams/" + _loc11_ + ".png";
   var _loc12_ = this["TeamImageHolder" + Team.toString()];
   var _loc13_ = this["TeamIconDefault" + Team.toString()];
   if(_loc10_)
   {
      LoadImage(_loc11_,_loc12_,32,32,false);
      _loc12_._visible = true;
      _loc13_._visible = false;
   }
   else
   {
      _loc12_._visible = false;
      _loc13_._visible = true;
   }
   var _loc5_ = 0;
   while(_loc5_ <= 4)
   {
      if(Team == 0)
      {
         var _loc3_ = this["Ct" + _loc5_];
         ScoreCT.htmlText = _global.CScaleformComponent_MatchInfo.GetMatchRoundScoreForTeam(MatchId,Team);
         _loc3_.Selected._visible = false;
      }
      else
      {
         _loc3_ = this["T" + _loc5_];
         ScoreT.htmlText = _global.CScaleformComponent_MatchInfo.GetMatchRoundScoreForTeam(MatchId,Team);
         _loc3_.Selected._visible = false;
      }
      Xuid = _global.CScaleformComponent_MatchInfo.GetMatchPlayerXuidByIndexForTeam(MatchId,Team,_loc5_);
      var _loc7_ = "";
      if(_loc10_)
      {
         _loc7_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerStat(MatchId,Xuid,"name");
      }
      else
      {
         _loc7_ = _global.CScaleformComponent_FriendsList.GetFriendName(Xuid);
      }
      _loc3_.Name.htmlText = _loc7_;
      _loc3_.Kills.htmlText = _global.CScaleformComponent_MatchInfo.GetMatchPlayerStat(MatchId,Xuid,"kills");
      _loc3_.Assists.htmlText = _global.CScaleformComponent_MatchInfo.GetMatchPlayerStat(MatchId,Xuid,"assists");
      _loc3_.Mvps.htmlText = _global.CScaleformComponent_MatchInfo.GetMatchPlayerStat(MatchId,Xuid,"mvps");
      _loc3_.Score.htmlText = _global.CScaleformComponent_MatchInfo.GetMatchPlayerStat(MatchId,Xuid,"score");
      _loc3_.Deaths.htmlText = _global.CScaleformComponent_MatchInfo.GetMatchPlayerStat(MatchId,Xuid,"deaths");
      var _loc8_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerStat(MatchId,Xuid,"mvps");
      if(_loc8_ > 0)
      {
         _loc3_.Mvps.htmlText = _loc8_;
         _loc3_.Star._visible = true;
      }
      else
      {
         _loc3_.Mvps.htmlText = "";
         _loc3_.Star._visible = false;
      }
      _loc3_.Avatar.m_bShowFlair = false;
      _loc3_.Avatar._visible = true;
      if(_loc10_)
      {
         _loc3_.Avatar.ShowTeamInsteadLogoForAvatar(_loc11_);
         _loc3_.Avatar.SetFlairItem(0);
      }
      else
      {
         _loc3_.Avatar.SetFlairItem(Xuid);
         _loc3_.Avatar.ShowAvatar(3,Xuid,true,false);
      }
      var _loc9_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerXuidByIndexForTeam(MatchId,Team,_loc5_);
      if("friend" == _global.CScaleformComponent_FriendsList.GetFriendRelationship(_loc9_))
      {
         _loc3_.FriendIcon._visible = true;
      }
      else
      {
         _loc3_.FriendIcon._visible = false;
      }
      _loc3_.dialog = this;
      _loc3_._xuid = Xuid;
      _loc3_._team = Team;
      _loc3_._playername = _loc7_;
      _loc3_.Action = function()
      {
         this.dialog.SelectRow(this,MatchId,false);
      };
      if(Xuid == m_PlayerXuid)
      {
         m_objSelectedRow = _loc3_;
      }
      if(_loc5_ % 2)
      {
         _loc3_.Bg._alpha = 20;
      }
      else
      {
         _loc3_.Bg._alpha = 60;
      }
      _loc5_ = _loc5_ + 1;
   }
   ShowScoreboard(bPlayShowAnims);
   if((m_objSelectedRow == null || m_objSelectedRow == undefined) && Team == 1)
   {
      GetPlayerWithHighestScore(MatchId,bPlayShowAnims);
   }
   else
   {
      SelectRow(m_objSelectedRow,MatchId,bPlayShowAnims);
   }
}
function GetPlayerWithHighestScore(MatchId, bPlayShowAnims)
{
   var _loc5_ = this.Ct0;
   var _loc4_ = this.T0;
   var _loc7_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerStat(MatchId,_loc5_._xuid,"score");
   var _loc6_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerStat(MatchId,_loc4_._xuid,"score");
   if(_loc7_ >= _loc6_)
   {
      SelectRow(_loc5_,MatchId,bPlayShowAnims);
   }
   else
   {
      SelectRow(_loc4_,MatchId,bPlayShowAnims);
   }
}
function ShowScoreboard(bPlayShowAnims)
{
   this._visible = true;
   this._alpha = 100;
   if(!bPlayShowAnims)
   {
      return undefined;
   }
   var numLoop = 0;
   var _loc2_ = 0;
   while(_loc2_ < 2)
   {
      var _loc3_ = this["TeamImageHolder" + _loc2_];
      _loc3_._alpha = 0;
      _loc2_ = _loc2_ + 1;
   }
   _loc2_ = 0;
   while(_loc2_ <= 4)
   {
      var _loc4_ = this["Ct" + _loc2_];
      var _loc5_ = this["T" + _loc2_];
      _loc4_._alpha = 0;
      _loc5_._alpha = 0;
      _loc2_ = _loc2_ + 1;
   }
   new Lib.Tween(ScoreCT,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
   new Lib.Tween(ScoreT,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
   new Lib.Tween(this.TeamImageHolder0,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
   new Lib.Tween(this.TeamImageHolder1,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
   this.onEnterFrame = function()
   {
      var _loc2_ = this["Ct" + numLoop];
      var _loc3_ = this["T" + numLoop];
      new Lib.Tween(_loc2_,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
      new Lib.Tween(_loc2_,"_yscale",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
      new Lib.Tween(_loc3_,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
      new Lib.Tween(_loc3_,"_yscale",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
      if(numLoop == 4)
      {
         delete this.onEnterFrame;
      }
      numLoop++;
   };
}
function HideScoreboard()
{
   this._visible = false;
}
function DeleteAnim()
{
   new Lib.Tween(this,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,0.5,true);
}
function UpdateScoreBoardNames(Team)
{
   if(this._visible && this._MatchId != "" && _MatchId != null && _MatchId != undefined)
   {
      var _loc7_ = IsTournament(this._MatchId);
      var _loc3_ = 0;
      while(_loc3_ <= 4)
      {
         if(Team == 0)
         {
            var _loc5_ = this["Ct" + _loc3_];
         }
         else
         {
            _loc5_ = this["T" + _loc3_];
         }
         var _loc4_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerXuidByIndexForTeam(this._MatchId,Team,_loc3_);
         if(_loc7_)
         {
            _loc5_.Name.htmlText = _global.CScaleformComponent_MatchInfo.GetMatchPlayerStat(this._MatchId,_loc4_,"name");
         }
         else
         {
            _loc5_.Name.htmlText = _global.CScaleformComponent_FriendsList.GetFriendName(_loc4_);
         }
         _loc3_ = _loc3_ + 1;
      }
   }
}
function IsTournament(MatchId)
{
   var _loc2_ = _global.CScaleformComponent_MatchInfo.GetMatchTournamentName(MatchId);
   if(_loc2_ == "" || _loc2_ == null || _loc2_ == undefined)
   {
      return false;
   }
   return true;
}
function SelectRow(objTile, MatchId, bPlayShowAnims)
{
   if(m_objSelectedRow != objTile)
   {
      m_objSelectedRow.Selected._visible = false;
   }
   objTile.Selected._visible = true;
   m_objSelectedRow = objTile;
   var _loc3_ = false;
   if(objTile._xuid == m_PlayerXuid)
   {
      _loc3_ = true;
   }
   this._parent.Rounds.SetUpRoundData(MatchId,objTile._xuid,objTile._team,objTile._playername,bPlayShowAnims);
   this._parent.Rounds.GetSelectedPlayerActionBtns(MatchId,objTile._xuid,_loc3_);
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
stop();
var m_numPosPlayerRowX = 92.95;
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var m_objSelectedRow = null;
