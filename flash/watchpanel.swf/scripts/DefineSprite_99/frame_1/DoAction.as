function SetUpMatchInfo(strMatchId, PlayerXuid, TypeOfLister, bPlayerWonMatch, bPlayShowAnims)
{
   if(strMatchId == "" || strMatchId == undefined || strMatchId == null)
   {
      HideMatchInfo();
      return undefined;
   }
   SetMatchMap(GetMatchMap(strMatchId));
   SetInfoText(strMatchId,24);
   SetInfoBtns(strMatchId,24);
   if(DidUserWinTheMatch(strMatchId,TypeOfLister,PlayerXuid,0) || DidUserWinTheMatch(strMatchId,TypeOfLister,PlayerXuid,1))
   {
      SetWinBanner(true);
   }
   else
   {
      SetWinBanner(false);
   }
   ShowMatchInfo(bPlayShowAnims);
}
function SetInfoText(strMatchId, numLeftOffset)
{
   var _loc5_ = new Array();
   var _loc7_ = new Array();
   var _loc8_ = GetMapShareToken(strMatchId);
   var _loc9_ = GetMatchDuration(strMatchId);
   var _loc10_ = GetMatchTimestamp(strMatchId);
   var _loc11_ = "#SFUI_Map_" + GetMatchMap(strMatchId);
   if(_loc8_ != "" && _loc8_ != undefined)
   {
      _loc5_.push(_loc8_);
      _loc7_.push("#CSGO_Watch_Info_0");
   }
   if(_loc9_ != "" && _loc9_ != undefined)
   {
      _loc5_.push(_loc9_);
      _loc7_.push("#CSGO_Watch_Info_1");
   }
   if(_loc10_ != "" && _loc10_ != undefined)
   {
      _loc5_.push(_loc10_);
      _loc7_.push("#CSGO_Watch_Info_2");
   }
   if(_loc11_ != "" && _loc11_ != undefined)
   {
      _loc5_.push(_loc11_);
      _loc7_.push("#CSGO_Watch_Info_3");
   }
   var _loc3_ = 0;
   while(_loc3_ < 4)
   {
      var _loc2_ = this["Info" + _loc3_];
      if(_loc3_ >= _loc5_.length)
      {
         _loc2_._visible = false;
      }
      else
      {
         _loc2_._visible = true;
         _loc2_._alpha = 100;
         _loc2_.Text.htmlText = _loc5_[_loc3_];
         _loc2_.Title.htmlText = _loc7_[_loc3_];
         _loc2_.Title.autoSize = "left";
         _loc2_.Text.autoSize = "left";
         if(_loc3_ == 0)
         {
            _loc2_._x = 760 - (numLeftOffset + _loc2_._width);
         }
         else
         {
            var _loc4_ = this["Info" + (_loc3_ - 1)];
            _loc2_._x = _loc4_._x - (_loc2_._width + numLeftOffset);
         }
      }
      _loc3_ = _loc3_ + 1;
   }
}
function SetInfoBtns(strMatchId, numLeftOffset)
{
   Status._visible = false;
   var _loc5_ = new Array();
   var _loc9_ = _global.CScaleformComponent_MatchInfo.GetMatchState(strMatchId);
   var _loc8_ = "images/ui_icons/";
   trace("-----------------------------------strMatchStatus--------------------" + _loc9_);
   if(CanDelete(strMatchId))
   {
      _loc5_.push("delete");
   }
   if(GetMapShareToken(strMatchId) != "" && GetMapShareToken(strMatchId) != undefined)
   {
      _loc5_.push("link");
   }
   if(!CanWatch(strMatchId) && CanDelete(strMatchId))
   {
      ShowStatusText("error");
   }
   if(CanDownload(strMatchId))
   {
      _loc5_.push("download");
   }
   if(_loc9_ == "downloading")
   {
      ShowStatusText("downloading");
   }
   else if(_loc9_ == "live")
   {
      _loc5_.push("gotv");
   }
   else if(CanWatch(strMatchId))
   {
      _loc5_.push("gotv");
   }
   var _loc4_ = 0;
   while(_loc4_ < 4)
   {
      var _loc3_ = this["MatchInfoBtn" + _loc4_];
      if(_loc4_ >= _loc5_.length)
      {
         _loc3_._visible = false;
      }
      else
      {
         _loc3_.dialog = this;
         _loc3_._visible = true;
         _loc3_._alpha = 100;
         _loc3_.SetText("#CSGO_Watch_Info_" + _loc5_[_loc4_]);
         _loc3_._Type = _loc5_[_loc4_];
         _loc3_.ButtonText.Text.autoSize = "left";
         _loc3_.ButtonText.Text._x = 15;
         _loc3_.Action = function()
         {
            this.dialog.onPressMatchActionButton(this,strMatchId);
         };
         LoadImage(_loc8_ + _loc5_[_loc4_] + ".png",_loc3_.ImageHolder,28,28,false);
         if(_loc4_ == 0)
         {
            _loc3_._x = 760 - (numLeftOffset + _loc3_._width);
         }
         else
         {
            var _loc6_ = this["MatchInfoBtn" + (_loc4_ - 1)];
            _loc3_._x = _loc6_._x - (_loc3_._width + numLeftOffset);
         }
      }
      _loc4_ = _loc4_ + 1;
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
function onPressMatchActionButton(objBtn, MatchId)
{
   switch(objBtn._Type)
   {
      case "delete":
         ShowStatusText("delete");
         this._parent.Scoreboard.DeleteAnim();
         this._parent.Rounds.DeleteAnim();
         if(this._parent._parent.m_TypeOfLister == "downloaded")
         {
            this._parent._parent.mcAccordianMenu.DeleteBtnAnim(this._parent._parent.m_objSelectedMatchBtn);
         }
         DeleteAnim();
         m_numTimerDelay = setTimeout(DeleteEntry,1000,MatchId);
         break;
      case "gotv":
         OnWatch(MatchId);
         break;
      case "stream":
         break;
      case "download":
         OnDownload(MatchId);
         this._parent._parent.RefreshSelectedbtn();
         SetInfoBtns(MatchId,24);
         break;
      case "link":
         CopyMatchUrl(MatchId);
         ShowStatusText("copy");
         m_numTimerDelay = setTimeout(HideStatusText,1000);
   }
}
function ShowStatusText(strType)
{
   Status._visible = true;
   Status.gotoAndStop(strType);
   Status.Text.htmlText = "#CSGO_Watch_Info_Status_" + strType;
   new Lib.Tween(Status,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
   _global.AutosizeTextDown(Status.Text,8);
}
function HideStatusText()
{
   new Lib.Tween(Status,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,3,true);
}
function DeleteEntry(MatchId)
{
   OnDelete(MatchId);
}
function ShowMatchInfo(bPlayShowAnims)
{
   this._visible = true;
   if(!bPlayShowAnims)
   {
      return undefined;
   }
   new Lib.Tween(this,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,2,true);
}
function HideMatchInfo()
{
   this._visible = false;
}
function DeleteAnim()
{
   var _loc2_ = 0;
   while(_loc2_ < 4)
   {
      var _loc3_ = this["MatchInfoBtn" + _loc2_];
      var _loc4_ = this["Info" + _loc2_];
      new Lib.Tween(_loc3_,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,0.5,true);
      new Lib.Tween(_loc4_,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,0.5,true);
      _loc2_ = _loc2_ + 1;
   }
}
function SetMatchMap(MapName)
{
   if(MapImage.Image.MapImage)
   {
      delete MapImage.Image.MapImage;
   }
   var _loc2_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + MapName,"imagename");
   MapImage.Image.attachMovie(_loc2_,"MapImage",MapImage.Image.getDepth() + 1);
   MapImage.Image._width = 761;
   MapImage.Image._height = 428;
   MapImage.Image._alpha = 40;
   MapImage.Image._y = -16;
}
function SetWinBanner(bShow)
{
   Winner._visible = bShow;
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
function DidUserWinTheMatch(MatchId, TypeOfLister, PlayerXuid, Team)
{
   if(TypeOfLister == PlayerXuid)
   {
      var _loc3_ = _global.CScaleformComponent_MatchInfo.GetMatchRoundScoreForTeam(MatchId,0);
      var _loc4_ = _global.CScaleformComponent_MatchInfo.GetMatchRoundScoreForTeam(MatchId,1);
      if(_loc3_ > _loc4_ && Team == 0)
      {
         return IsPlayerOnTeam(MatchId,0,PlayerXuid);
      }
      if(_loc3_ < _loc4_ && Team == 1)
      {
         return IsPlayerOnTeam(MatchId,1,PlayerXuid);
      }
   }
   return false;
}
function IsPlayerOnTeam(MatchId, Team, PlayerXuid)
{
   var _loc2_ = 0;
   while(_loc2_ <= 4)
   {
      var _loc3_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerXuidByIndexForTeam(MatchId,Team,_loc2_);
      if(PlayerXuid == _loc3_)
      {
         return true;
      }
      _loc2_ = _loc2_ + 1;
   }
   return false;
}
function GetMatchTournamentStageName(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchTournamentStageName(strMatchId);
}
function GetMatchTournamentTeamName(Team, strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchTournamentTeamName(strMatchId,Team);
}
function GetMatchTournamentTeamFlag(Team, strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchTournamentTeamFlag(strMatchId,Team);
}
function GetViewers(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchSpectators(strMatchId);
}
function GetMatchTimestamp(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchTimestamp(strMatchId);
}
function GetTeamId(Team, strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchTournamentTeamID(strMatchId,Team);
}
function GetMatchDuration(strMatchId)
{
   var _loc5_ = "";
   var _loc2_ = _global.CScaleformComponent_MatchInfo.GetMatchDuration(strMatchId);
   var _loc3_ = _global.GameInterface.Translate("#CSGO_competitive_Time_Played");
   trace("----------------------------------------------Seconds:" + _loc2_);
   if(_loc2_ == 0)
   {
      return "#CSGO_Watch_JustStarted";
   }
   if(_loc2_ > 60)
   {
      var _loc4_ = Math.ceil(_loc2_ / 60);
      _loc2_ = Math.ceil(_loc2_ - _loc4_ * 60);
      _loc3_ = _loc4_ + " " + _global.GameInterface.Translate("#CSGO_Watch_Minutes");
   }
   else
   {
      _loc3_ = "1 " + _global.GameInterface.Translate("#CSGO_Watch_Minute");
   }
   return _loc3_;
}
function GetMatchRoundScoreForTeam(Team, strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchRoundScoreForTeam(strMatchId,Team);
}
function GetMatchPlayerXuidByIndexForTeam(Team, strMatchId)
{
   var _loc4_ = [];
   var _loc2_ = 0;
   while(_loc2_ <= 4)
   {
      var _loc3_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerXuidByIndexForTeam(strMatchId,Team,_loc2_);
      _loc4_.push(_loc3_);
      _loc2_ = _loc2_ + 1;
   }
   return _loc4_;
}
function GetMatchMap(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchMap(strMatchId);
}
function CanWatch(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.CanWatch(strMatchId);
}
function CanDownload(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.CanDownload(strMatchId);
}
function CanDelete(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.CanDelete(strMatchId);
}
function CanWatchHighlights(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.CanWatchHighlights(strMatchId,PlayerXuid);
}
function OnDownload(strMatchId)
{
   _global.CScaleformComponent_MatchInfo.Download(strMatchId);
}
function OnWatch(strMatchId)
{
   _global.CScaleformComponent_MatchInfo.Watch(strMatchId);
}
function OnDelete(strMatchId)
{
   _global.CScaleformComponent_MatchInfo.Delete(strMatchId);
}
function GetMapShareToken(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchShareToken(strMatchId,"text");
}
function CopyMatchUrl(strMatchId)
{
   _global.CScaleformComponent_MatchInfo.GetMatchShareToken(strMatchId,"copyurl");
}
stop();
var m_numTimerDelay = 20;
