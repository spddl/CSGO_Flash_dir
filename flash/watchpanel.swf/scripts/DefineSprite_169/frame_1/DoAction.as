function SetUpRoundData(MatchId, Xuid, Team, strPlayerName, bPlayShowAnims)
{
   if(MatchId == undefined || MatchId == "" || MatchId == null)
   {
      HideRounds();
      return undefined;
   }
   ErrorPanel._visible = false;
   WatchRoundProxy._visible = false;
   _global.AutosizeTextDown(WatchRoundProxy.Text,8);
   this._alpha = 100;
   var _loc22_ = 30;
   var _loc5_ = new Array();
   var _loc12_ = GetMaxRounds(MatchId);
   var _loc16_ = _global.CScaleformComponent_MatchInfo.CanWatchHighlights(MatchId,Xuid);
   var _loc13_ = "";
   _loc13_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerRoundStats(MatchId,Xuid,"enemy_kills");
   var _loc20_ = _loc13_.split(",");
   _loc5_.push({kills:_loc20_});
   _loc13_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerRoundStats(MatchId,Xuid,"enemy_headshots");
   _loc20_ = _loc13_.split(",");
   _loc5_.push({headshots:_loc20_});
   _loc13_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerRoundStats(MatchId,Xuid,"mvps");
   _loc20_ = _loc13_.split(",");
   _loc5_.push({mvp:_loc20_});
   _loc13_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerRoundStats(MatchId,Xuid,"deaths");
   _loc20_ = _loc13_.split(",");
   _loc5_.push({deaths:_loc20_});
   var _loc18_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerRoundStats(MatchId,Xuid,"round_wins");
   var _loc14_ = false;
   if(_loc18_ == undefined || _loc18_ == "")
   {
      _loc14_ = true;
   }
   _loc20_ = _loc18_.split(",");
   _loc5_.push({wins:_loc20_});
   _loc13_ = _global.GameInterface.Translate("#CSGO_Watch_RoundData_Name");
   _loc13_ = _global.ConstructString(_loc13_,strPlayerName);
   if(strPlayerName != "" && strPlayerName != undefined && !_loc14_)
   {
      Name.htmlText = _loc13_;
   }
   else
   {
      Name.htmlText = "";
   }
   var _loc19_ = _global.CScaleformComponent_MatchInfo.GetTeamsAreSwitchedFromStart(MatchId);
   if(_loc19_)
   {
      if(Team == 0)
      {
         Team = 1;
      }
      else if(Team == 1)
      {
         Team = 0;
      }
   }
   var _loc4_ = 0;
   while(_loc4_ < 30)
   {
      var _loc3_ = this["Round" + _loc4_];
      _loc3_.dialog = this;
      _loc3_.swapDepths(_loc4_);
      if(_loc16_)
      {
         if(_loc4_ < _loc12_)
         {
            _loc3_.setDisabled(false);
         }
         else
         {
            _loc3_.setDisabled(true);
         }
         _loc3_.RolledOver = function()
         {
            this.dialog.MoveToTop(this);
            WatchRoundProxy._visible = false;
         };
         _loc3_.RolledOut = function()
         {
         };
         _global.AutosizeTextDown(_loc3_.WatchRoundBtn.Text,8);
         if(_loc4_ == 0)
         {
            WatchRoundProxy._visible = true;
         }
      }
      else
      {
         _loc3_.setDisabled(true);
      }
      _loc3_._RoundIndex = _loc4_ + 1;
      _loc3_.Action = function()
      {
         this.dialog.OnWatchRound(MatchId,this._RoundIndex);
      };
      _loc3_._visible = true;
      var _loc10_ = int(_loc5_[0].kills[_loc4_]);
      var _loc11_ = int(_loc5_[1].headshots[_loc4_]);
      TintKillsBasedOnRound(_loc3_,Team,_loc4_);
      ShowKillsAndHeadshots(_loc3_,_loc10_,_loc11_);
      var _loc6_ = int(_loc5_[4].wins[_loc4_]);
      if(_loc4_ >= _loc12_)
      {
         var _loc7_ = true;
      }
      else
      {
         _loc7_ = false;
      }
      ShowRoundWins(_loc3_,_loc6_,_loc7_,_loc14_);
      var _loc8_ = int(_loc5_[3].deaths[_loc4_]);
      ShowDeaths(_loc3_,_loc8_);
      var _loc9_ = int(_loc5_[2].mvp[_loc4_]);
      ShowMvp(_loc3_,_loc9_);
      _loc4_ = _loc4_ + 1;
   }
   SetTeamLines(Team,_loc12_,_loc14_);
   if(!_loc14_)
   {
      ShowRounds(bPlayShowAnims);
   }
   else
   {
      ShowNoData(MatchId);
   }
   Hint._visible = !_loc14_ && _global.CScaleformComponent_MatchInfo.CanDownload(MatchId);
}
function ShowRounds(bPlayShowAnims)
{
   this._visible = true;
   if(!bPlayShowAnims)
   {
      return undefined;
   }
   var numLoop = 0;
   delete this.onEnterFrame;
   var _loc2_ = 0;
   while(_loc2_ < 30)
   {
      var _loc3_ = this["Round" + _loc2_];
      _loc3_._alpha = 0;
      _loc2_ = _loc2_ + 1;
   }
   new Lib.Tween(LineTeamFirstHalf,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,3,true);
   new Lib.Tween(LineTeamSecHalf,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,3,true);
   this.onEnterFrame = function()
   {
      var _loc2_ = this["Round" + numLoop];
      new Lib.Tween(_loc2_,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
      new Lib.Tween(_loc2_,"_xscale",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
      if(numLoop >= 29)
      {
         delete this.onEnterFrame;
      }
      numLoop++;
   };
}
function MoveToTop(objRound)
{
   objRound.swapDepths(_root.getNextHighestDepth());
}
function HideRounds()
{
   this._visible = false;
}
function DeleteAnim()
{
   new Lib.Tween(this,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,0.5,true);
}
function SetTeamLines(Team, numMaxRoundsPlayed, bHasNoRoundData)
{
   var _loc1_ = 20.8;
   LineTeamSecHalf._visible = false;
   LineTeamFirstHalf._visible = false;
   if(bHasNoRoundData)
   {
      return undefined;
   }
   if(Team == 0)
   {
      LineTeamFirstHalf.transform.colorTransform = CT_ColorTransform;
      LineTeamSecHalf.transform.colorTransform = T_ColorTransform;
   }
   else
   {
      LineTeamFirstHalf.transform.colorTransform = T_ColorTransform;
      LineTeamSecHalf.transform.colorTransform = CT_ColorTransform;
   }
   if(numMaxRoundsPlayed < 16)
   {
      LineTeamFirstHalf._visible = true;
      LineTeamFirstHalf._width = _loc1_ * numMaxRoundsPlayed;
   }
   else
   {
      LineTeamSecHalf._visible = true;
      LineTeamFirstHalf._visible = true;
      LineTeamFirstHalf._width = _loc1_ * 15;
      LineTeamSecHalf._width = _loc1_ * (numMaxRoundsPlayed - 15);
      if(LineTeamSecHalf._width > _loc1_ * 15)
      {
         LineTeamSecHalf._width = _loc1_ * 15;
      }
   }
}
function TintKillsBasedOnRound(objRound, Team, numRound)
{
   if(numRound < 15)
   {
      if(Team == 0)
      {
         objRound.KillsBg.transform.colorTransform = CT_ColorTransform;
         TintSkulls(objRound,Grey_ColorTransform);
      }
      else
      {
         objRound.KillsBg.transform.colorTransform = T_ColorTransform;
         TintSkulls(objRound,Grey_ColorTransform);
      }
   }
   else if(numRound >= 15)
   {
      if(Team == 0)
      {
         objRound.KillsBg.transform.colorTransform = T_ColorTransform;
         TintSkulls(objRound,Grey_ColorTransform);
      }
      else
      {
         objRound.KillsBg.transform.colorTransform = CT_ColorTransform;
         TintSkulls(objRound,Grey_ColorTransform);
      }
   }
   objRound.KillsBg._alpha = 50;
}
function TintSkulls(objRound, TeamColorTransform)
{
   var _loc1_ = 0;
   while(_loc1_ < 5)
   {
      var _loc2_ = objRound["Skull" + _loc1_].Skull;
      _loc2_.transform.colorTransform = TeamColorTransform;
      _loc1_ = _loc1_ + 1;
   }
}
function ShowKillsAndHeadshots(objRound, numKillsThisRound, numHeadshotsThisRound)
{
   if(numKillsThisRound > 0)
   {
      objRound.KillsBg._visible = true;
      var _loc1_ = 0;
      while(_loc1_ < 5)
      {
         var _loc2_ = objRound["Skull" + _loc1_];
         if(_loc1_ > numKillsThisRound - 1)
         {
            _loc2_._visible = false;
         }
         else
         {
            if(_loc1_ > numHeadshotsThisRound - 1)
            {
               _loc2_.Headshot._visible = false;
            }
            else
            {
               _loc2_.Headshot._visible = true;
            }
            _loc2_._visible = true;
         }
         _loc1_ = _loc1_ + 1;
      }
   }
   else
   {
      objRound.KillsBg._visible = false;
      _loc1_ = 0;
      while(_loc1_ < 5)
      {
         _loc2_ = objRound["Skull" + _loc1_];
         _loc2_._visible = false;
         _loc1_ = _loc1_ + 1;
      }
   }
}
function ShowDeaths(objRound, numDeathsThisRound)
{
   if(numDeathsThisRound > 0)
   {
      objRound.DeathSkull._visible = true;
   }
   else
   {
      objRound.DeathSkull._visible = false;
   }
}
function ShowMvp(objRound, numMvpThisRound)
{
   if(numMvpThisRound > 0)
   {
      objRound.Star._visible = true;
   }
   else
   {
      objRound.Star._visible = false;
   }
}
function ShowRoundWins(objRound, numWins, bOverMaxRoundsPlayed, bHasNoRoundData)
{
   objRound.DeathBg._visible = false;
   objRound.KillsBg._visible = false;
   if(bHasNoRoundData)
   {
      return undefined;
   }
   if(numWins > 0)
   {
      objRound.KillsBg._visible = true;
   }
   else if(!bOverMaxRoundsPlayed)
   {
      objRound.DeathBg._visible = true;
   }
}
function GetMaxRounds(MatchId)
{
   var _loc3_ = _global.CScaleformComponent_MatchInfo.GetMatchRoundScoreForTeam(MatchId,0);
   var _loc2_ = _global.CScaleformComponent_MatchInfo.GetMatchRoundScoreForTeam(MatchId,1);
   return _loc3_ + _loc2_;
}
function ShowNoData(MatchId)
{
   var _loc3_ = 0;
   while(_loc3_ < 30)
   {
      var _loc4_ = this["Round" + _loc3_];
      _loc4_._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   WatchRoundProxy._visible = false;
   ErrorPanel._visible = true;
   ErrorPanel.btnRedownload._visible = false;
   var _loc5_ = _global.CScaleformComponent_MatchInfo.GetMatchState(MatchId);
   if(_loc5_ == "live")
   {
      ErrorPanel.ErrorText.Text.htmlText = "#CSGO_Watch_Error_RoundStats_Live";
   }
   else if(_loc5_ == "downloaded")
   {
      ErrorPanel.ErrorText.Text.htmlText = "#CSGO_Watch_Error_RoundStats_MetaData";
      ErrorPanel.btnRedownload._visible = true;
      ErrorPanel.btnRedownload.dialog = this;
      ErrorPanel.btnRedownload.SetText("#CSGO_Watch_ReDownload_MetaData");
      ErrorPanel.btnRedownload.Action = function()
      {
         this.dialog.OnReDownload(MatchId);
      };
   }
   else
   {
      ErrorPanel.ErrorText.Text.htmlText = "#CSGO_Watch_Error_RoundStats_None";
   }
   ErrorPanel.ErrorText.Text.autoSize = "left";
   ErrorPanel.ErrorText._x = (ErrorPanel._width - ErrorPanel.ErrorText._width) / 2;
}
function OnReDownload(MatchId)
{
   _global.CScaleformComponent_MatchInfo.DownloadWithShareToken(MatchId);
}
function GetSelectedPlayerActionBtns(MatchId, SelectedXuid, bIsSelf)
{
   var _loc21_ = _global.CScaleformComponent_FriendsList.IsFriendInvited(SelectedXuid);
   var _loc19_ = _global.CScaleformComponent_FriendsList.IsFriendJoinable(SelectedXuid);
   var _loc17_ = _global.CScaleformComponent_FriendsList.IsFriendWatchable(SelectedXuid);
   var _loc18_ = _global.CScaleformComponent_MatchInfo.CanWatchHighlights(MatchId,SelectedXuid);
   var _loc20_ = _global.CScaleformComponent_FriendsList.IsFriendPlayingCSGO(SelectedXuid);
   var _loc15_ = _global.CScaleformComponent_MyPersona.GetLauncherType() != "perfectworld"?false:true;
   var _loc8_ = 24;
   var _loc9_ = "images/ui_icons/";
   var _loc13_ = false;
   this.CurrentXuid = SelectedXuid;
   this.CurrentMatchId = MatchId;
   this.IsSelf = bIsSelf;
   var _loc14_ = _global.CScaleformComponent_FriendsList.GetFriendRelationship(SelectedXuid);
   trace("---------------------------------FriendRelationship----------------------------" + _loc14_);
   if("friend" == _loc14_)
   {
      _loc13_ = true;
   }
   var _loc5_ = [];
   var _loc7_ = [];
   if(!bIsSelf && _loc13_)
   {
      _loc5_.push("invite");
      _loc7_.push("#SFUI_Invite");
   }
   if(_loc19_)
   {
      _loc5_.push("join");
      _loc7_.push("#SFUI_Join_Game");
   }
   if(_loc17_)
   {
      _loc5_.push("watch");
      _loc7_.push("#SFUI_Watch");
   }
   if(_loc20_)
   {
      _loc5_.push("goprofile");
      _loc7_.push("#SFUI_Lobby_ShowCSGOProfile");
   }
   else if(!_loc15_)
   {
      _loc5_.push("steamprofile");
      _loc7_.push("#SFUI_Lobby_ShowGamercard");
   }
   if(!bIsSelf && _loc13_ && !_loc15_)
   {
      _loc5_.push("message");
      _loc7_.push("#SFUI_Steam_Message");
   }
   if(!bIsSelf && _loc14_ == "none")
   {
      _loc5_.push("addfriend");
      _loc7_.push("#SFUI_Friend_Add");
   }
   if(_loc18_)
   {
      var _loc12_ = "";
      var _loc10_ = "";
      var _loc11_ = "";
      if(_global.CScaleformComponent_MyPersona.GetXuid() == SelectedXuid)
      {
         _loc10_ = _global.GameInterface.Translate("#CSGO_Watch_Your_Highlights");
         _loc11_ = _global.GameInterface.Translate("#CSGO_Watch_Your_Lowlights");
      }
      else
      {
         _loc10_ = _global.GameInterface.Translate("#CSGO_Watch_Selected_Highlights");
         _loc11_ = _global.GameInterface.Translate("#CSGO_Watch_Selected_Lowlights");
         if(IsTournament(MatchId))
         {
            _loc12_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerStat(MatchId,SelectedXuid,"name");
         }
         else
         {
            _loc12_ = _global.CScaleformComponent_FriendsList.GetFriendName(SelectedXuid);
         }
      }
      _loc5_.push("highlights");
      _loc10_ = _global.ConstructString(_loc10_,_loc12_);
      _loc7_.push(_loc10_);
      _loc5_.push("lowlights");
      _loc11_ = _global.ConstructString(_loc11_,_loc12_);
      _loc7_.push(_loc11_);
   }
   var _loc4_ = 0;
   while(_loc4_ < 5)
   {
      var _loc3_ = this["PlayerInfoBtn" + _loc4_];
      if(_loc4_ >= _loc5_.length)
      {
         _loc3_._visible = false;
      }
      else
      {
         _loc3_.dialog = this;
         _loc3_._visible = true;
         _loc3_._alpha = 100;
         _loc3_.SetText(_loc7_[_loc4_]);
         _loc3_._Type = aInfo[_loc4_];
         _loc3_._Capability = _loc5_[_loc4_];
         _loc3_.ButtonText.Text.autoSize = "left";
         _loc3_.ButtonText.Text._x = 15;
         _loc3_.Action = function()
         {
            this.dialog.onPressPlayerActionButton(this._Capability,SelectedXuid,MatchId);
         };
         LoadImage(_loc9_ + _loc5_[_loc4_] + ".png",_loc3_.ImageHolder,28,28,false);
         if(_loc4_ == 0)
         {
            _loc3_._x = 760 - (_loc8_ + _loc3_._width);
         }
         else
         {
            var _loc6_ = this["PlayerInfoBtn" + (_loc4_ - 1)];
            _loc3_._x = _loc6_._x - (_loc3_._width + _loc8_);
         }
      }
      _loc4_ = _loc4_ + 1;
   }
}
function onPressPlayerActionButton(strMenuItem, SelectedXuid, MatchId)
{
   switch(strMenuItem)
   {
      case "invite":
         _global.CScaleformComponent_FriendsList.ActionInviteFriend(SelectedXuid);
         break;
      case "join":
         _global.CScaleformComponent_FriendsList.ActionJoinFriendSession(SelectedXuid);
         break;
      case "watch":
         _global.CScaleformComponent_FriendsList.ActionWatchFriendSession(SelectedXuid);
         break;
      case "goprofile":
         _global.CScaleformComponent_FriendsList.ActionShowCSGOProfile(SelectedXuid);
         break;
      case "steamprofile":
         _global.CScaleformComponent_SteamOverlay.ShowUserProfilePage(SelectedXuid);
         break;
      case "message":
         _global.CScaleformComponent_SteamOverlay.StartChatWithUser(SelectedXuid);
         break;
      case "addfriend":
         _global.CScaleformComponent_SteamOverlay.InteractWithUser(SelectedXuid,"friendadd");
         break;
      case "highlights":
         _global.CScaleformComponent_MatchInfo.WatchHighlights(MatchId,SelectedXuid,true);
         break;
      case "lowlights":
         _global.CScaleformComponent_MatchInfo.WatchLowlights(MatchId,SelectedXuid,false);
   }
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
function IsTournament(MatchId)
{
   var _loc2_ = _global.CScaleformComponent_MatchInfo.GetMatchTournamentName(MatchId);
   if(_loc2_ == "" || _loc2_ == null || _loc2_ == undefined)
   {
      return false;
   }
   return true;
}
function OnWatchRound(MatchId, RoundIndex)
{
   _global.CScaleformComponent_MatchInfo.Watch(MatchId,RoundIndex);
   _global.MainMenuMovie.RemoveAllMainMenuNav();
}
function UpdateBtns(xuid)
{
   if(this.CurrentXuid == xuid)
   {
      GetSelectedPlayerActionBtns(this.CurrentMatchId,xuid,this.IsSelf);
   }
}
var CTColor = "0x55708c";
var TColor = "0x8e7140";
var GreyColor = "0x666666";
var T_ColorTransform = new flash.geom.ColorTransform();
T_ColorTransform.rgb = parseInt(TColor);
var CT_ColorTransform = new flash.geom.ColorTransform();
CT_ColorTransform.rgb = parseInt(CTColor);
var Grey_ColorTransform = new flash.geom.ColorTransform();
Grey_ColorTransform.rgb = parseInt(GreyColor);
stop();
