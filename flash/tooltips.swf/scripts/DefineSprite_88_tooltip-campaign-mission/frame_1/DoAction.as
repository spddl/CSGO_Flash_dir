function TooltipItemShowHide(bShow)
{
   if(bShow)
   {
      this._visible = true;
      this.gotoAndPlay("StartShow");
      Content.HitBox._visible = true;
   }
   else if(!Content.btnPlayMission._visible && !Content.Leaderboard.btnLeaderboard._visible || !Content.HitBox.hitTest(_root._xmouse,_root._ymouse,true))
   {
      HideTooltip();
   }
}
function HideTooltip()
{
   this._visible = false;
   Content.HitBox._visible = false;
}
function TooltipCampaignMissionInfo(m_PlayerXuid, strId, CampaignID, NodeID, numSeason, bIsComic, File, numComicSection)
{
   var _loc7_ = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,strId);
   var _loc10_ = _global.CScaleformComponent_Inventory.GetItemType(m_PlayerXuid,strId);
   var _loc9_ = 0;
   this._CampaignID = CampaignID;
   this._NodeID = NodeID;
   this._NodeState = _global.CScaleformComponent_Inventory.GetCampaignNodeState(CampaignID,NodeID);
   this._Points = _global.CScaleformComponent_Inventory.GetCampaignNodeOperationalPoints(CampaignID,NodeID);
   this._Character = _global.CScaleformComponent_Inventory.GetCampaignNodeCharacterName(CampaignID,NodeID);
   this._bHasAudio = _global.CScaleformComponent_Inventory.DoesCampaignNodeHaveAudio(CampaignID,NodeID);
   this._QuestID = _global.CScaleformComponent_Inventory.GetCampaignNodeQuestID(CampaignID,NodeID);
   this._IsComicNode = bIsComic;
   this._File = File;
   this._ItemID = strId;
   this._PlayerXuid = m_PlayerXuid;
   this._LeaderboardType = "official_leaderboard_quest_" + this._QuestID;
   this._Season = numSeason;
   if(this._NodeState == "complete" && CampaignID == 8 && !bIsComic)
   {
      this._bIsReplayingMission = true;
   }
   else
   {
      this._bIsReplayingMission = false;
   }
   if(bIsComic)
   {
      Content.Name.htmlText = "#cp" + CampaignID + "_comicsection_title_" + numComicSection;
      Content.DescMission.htmlText = "#op07_comic_part_" + numComicSection + "_desc";
   }
   else
   {
      Content.Name.htmlText = SeperateName(_loc7_);
      Content.DescMission.htmlText = _global.CScaleformComponent_Inventory.GetItemDescription(m_PlayerXuid,this._ItemID,"default,-lootlist");
   }
   _global.AutosizeTextDown(Content.Name,8);
   Content.DescMission.autoSize = "left";
   SetStatusBlock(numSeason);
   SetLootListBlock();
   if(CampaignID == 8 && !bIsComic)
   {
      RefreshLeaderboardData();
   }
   else
   {
      Content.Leaderboard._visible = false;
   }
   LayoutTooltip();
}
function LayoutTooltip()
{
   var _loc7_ = 10;
   var _loc12_ = 0;
   Content.StatusText._y = Content.DescMission._x + Content.DescMission._height + _loc7_ + _loc7_;
   if(this._NodeState == "complete" && this._bHasAudio && !this._IsComicNode)
   {
      Content.btnPlayMission._y = Content.StatusText._y + Content.StatusText._height;
   }
   else
   {
      Content.btnPlayMission._y = Content.StatusText._y;
   }
   Content.Desc._y = Content.btnPlayMission._y + Content.btnPlayMission._height + _loc7_;
   Content.Leaderboard._y = Content.Desc._y;
   if(Content.Desc._visible)
   {
      numBgHeight = Content.Desc._y + Content.Desc._height + _loc7_;
   }
   else
   {
      numBgHeight = Content.Desc._y;
   }
   _loc12_ = numBgHeight;
   if(Content.Leaderboard._visible)
   {
      var _loc4_ = 0;
      _loc12_ = Content.Leaderboard._y + Content.Leaderboard.NoFriends._height + _loc7_;
      var _loc9_ = 5;
      var _loc8_ = 0;
      Content.Leaderboard.Bg._height = 0;
      Content.Leaderboard.Bg._y = 0;
      if(Content.Leaderboard.Tile0._visible)
      {
         var _loc6_ = 4;
         var _loc3_ = 0;
         while(_loc3_ < _loc6_)
         {
            var _loc5_ = Content.Leaderboard["Tile" + _loc3_];
            if(_loc5_._visible)
            {
               _loc8_ = _loc8_ + 1;
               _loc4_ = _loc4_ + _loc5_._height;
            }
            _loc3_ = _loc3_ + 1;
         }
      }
      if(Content.Leaderboard.btnLeaderboard._visible)
      {
         Content.Leaderboard.btnLeaderboard._y = Content.Leaderboard.NoFriends._height + _loc4_;
      }
      else
      {
         Content.Leaderboard.btnLeaderboard._y = 0;
      }
      if(Content.Leaderboard.btnLeaderboard._visible)
      {
         _loc4_ = _loc4_ + Content.Leaderboard.NoFriends._height + Content.Leaderboard.btnLeaderboard._height;
      }
      else
      {
         _loc4_ = _loc4_ + Content.Leaderboard.NoFriends._height;
      }
      numBgHeight = Content.Leaderboard._y + _loc4_ + _loc7_;
      Content.HitBox._height = Content.Background._height;
      var _loc10_ = {x:this._x,y:this._y};
      _root.localToGlobal(_loc10_);
      CheckBottomBounds(_loc10_,numBgHeight);
      var _loc11_ = _loc4_ + _loc7_ + _loc9_;
      Content.Leaderboard.Bg._y = - _loc9_;
      Content.Leaderboard.Bg._visible = Content.Leaderboard.Tile0._visible;
      new Lib.Tween(Content.Leaderboard.Bg,"_height",mx.transitions.easing.Strong.easeOut,0,_loc11_,0.5,true);
      new Lib.Tween(Content.Leaderboard.btnLeaderboard,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
      _loc3_ = 0;
      while(_loc3_ < _loc6_)
      {
         _loc5_ = Content.Leaderboard["Tile" + _loc3_];
         new Lib.Tween(_loc5_,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
         _loc3_ = _loc3_ + 1;
      }
   }
   else if(!Content.Desc._visible)
   {
      numBgHeight = Content.Leaderboard._y + _loc7_;
      Content.LootIcon._y = Content.Desc._y + Content.Desc._height / 2;
   }
   new Lib.Tween(Content.Background,"_height",mx.transitions.easing.Strong.easeOut,_loc12_,numBgHeight,0.5,true);
   Content.Background._height = numBgHeight;
   Content.HitBox._height = numBgHeight;
   this._BgHeight = numBgHeight;
}
function SetStatusBlock(numSeason)
{
   var _loc6_ = _global.CScaleformComponent_Inventory.GetMissionBacklog();
   var _loc4_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
   Content.btnPlayMission._visible = false;
   Content.StatusText._visible = false;
   Content.DescMission._alpha = 100;
   if(this._IsComicNode == true && (this._NodeState == "accessible" || this._NodeState == "complete"))
   {
      Content.btnPlayMission._visible = true;
      Content.btnPlayMission.dialog = this;
      Content.btnPlayMission.SetText("#SFUI_Missions_Comic");
      Content.btnPlayMission.Action = function()
      {
         this.dialog.RequestMission();
      };
      Content.btnPlayMission.setDisabled(false);
   }
   else if((this._NodeState == "active" || this._NodeState == "accessible") && (_loc6_ > 0 || HasActiveMission()) && _loc4_ > -1)
   {
      Content.btnPlayMission._visible = true;
      Content.btnPlayMission.dialog = this;
      Content.btnPlayMission.SetText("#SFUI_Missions_Play");
      Content.btnPlayMission.Action = function()
      {
         this.dialog.RequestMission();
      };
      Content.btnPlayMission.setDisabled(false);
   }
   else
   {
      if(this._NodeState == "complete" && this._bHasAudio)
      {
         Content.btnPlayMission._visible = true;
         Content.btnPlayMission.dialog = this;
         if(this._bIsReplayingMission)
         {
            Content.btnPlayMission.SetText("#SFUI_Missions_Replay");
            Content.DescMission._alpha = 50;
         }
         else
         {
            Content.btnPlayMission.SetText("#SFUI_Missions_Audio");
         }
         Content.btnPlayMission.Action = function()
         {
            this.dialog.RequestMission();
         };
         Content.btnPlayMission.setDisabled(false);
      }
      Content.StatusText._visible = true;
      if(_loc4_ != numSeason)
      {
         Content.StatusText.Text.htmlText = "#CSGO_Journal_Mission_Inactive";
      }
      else if(!_global.CScaleformComponent_Inventory.CheckCampaignOwnership(this._CampaignID))
      {
         Content.StatusText.Text.htmlText = "#CSGO_Journal_Mission_Buy";
      }
      else if(this._NodeState == "locked")
      {
         Content.StatusText.Text.htmlText = "#CSGO_Journal_Mission_Unlock";
      }
      else if(this._bIsReplayingMission)
      {
         Content.StatusText.Text.htmlText = "#CSGO_Journal_Mission_Complete_Replay";
      }
      else if(this._NodeState == "complete")
      {
         Content.StatusText.Text.htmlText = "#CSGO_Journal_Mission_Complete";
      }
      else if(_loc6_ <= 0)
      {
         var _loc5_ = _global.CScaleformComponent_Inventory.GetSecondsUntilNextMission();
         var _loc3_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_Timer_day_hr");
         if(_loc5_ > 0)
         {
            _loc3_ = _global.ConstructString(_loc3_,_global.FormatSecondsToDaysHourString(_loc5_));
            objCampaign.Bg.InfoPanel.InfoPanel.AvailableStatus.htmlText = _loc3_;
         }
         else
         {
            _loc3_ = global.GameInterface.Translate("#CSGO_Journal_Mission_Unavailable");
         }
         Content.StatusText.Text.htmlText = _loc3_;
      }
      _global.AutosizeTextDown(Content.StatusText.Text,8);
      Content.StatusText.Text.autoSize = true;
      Content.StatusText.Text._y = Content.StatusText._height * 0.5 - Content.StatusText.Text._height * 0.5;
   }
}
function SetLootListBlock()
{
   Content.LootIcon._visible = false;
   Content.Desc._visible = false;
   var _loc3_ = _global.CScaleformComponent_Inventory.GetLootListItemIdByIndex(this._PlayerXuid,this._ItemID,0);
   if(_loc3_ != "" && _loc3_ != undefined)
   {
      var _loc6_ = false;
      var _loc8_ = "";
      var _loc9_ = _global.CScaleformComponent_Inventory.GetItemDescription(this._PlayerXuid,this._ItemID,"lootlist");
      Content.Desc._visible = true;
      Content.Desc.htmlText = _loc9_;
      Content.Desc.autoSize = true;
      var _loc4_ = _global.CScaleformComponent_Inventory.GetSet(this._PlayerXuid,_loc3_);
      if(_loc4_ != "" && _loc4_ != undefined)
      {
         _loc8_ = "econ/set_icons/" + _loc4_ + ".png";
         Content.LootIcon._alpha = 40;
         _loc6_ = true;
      }
      if(_loc6_)
      {
         var _loc7_ = new Object();
         _loc7_.onLoadInit = function(target_mc)
         {
            target_mc._width = 58;
            target_mc._height = 43;
            target_mc.forceSmoothing = true;
         };
         var _loc5_ = new MovieClipLoader();
         _loc5_.addListener(_loc7_);
         _loc5_.loadClip(_loc8_,Content.LootIcon.LootIconImage);
         Content.LootIcon._visible = true;
         Content.Difficulty.DifIcon._visible = true;
      }
   }
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
function SeperateDesc(strDesc)
{
   if(strDesc.indexOf("\n") != -1)
   {
      var _loc1_ = strDesc.split("\n",4);
   }
   else
   {
      _loc1_ = new Array(strDesc);
   }
   return _loc1_[2] + "\n" + _loc1_[3];
}
function TooltipCampaignMissionLayout(PositionX, PositionY, objColor, bUpdateColor)
{
   var _loc7_ = {x:PositionX,y:PositionY};
   _root.localToGlobal(_loc7_);
   var _loc6_ = false;
   var _loc5_ = 0;
   if(bUpdateColor)
   {
      Arrows.RightArrow.transform.colorTransform = objColor;
      Arrows.LeftArrow.transform.colorTransform = objColor;
      Content.Bar.transform.colorTransform = objColor;
      Content.btnPlayMission.Shape.transform.colorTransform = objColor;
      Content.btnPlayMission.Anim.transform.colorTransform = objColor;
      Content.btnStartCancel.transform.colorTransform = objColor;
      Content.btnStartMission.transform.colorTransform = objColor;
   }
   Arrows.RightArrow._y = 0;
   Arrows.LeftArrow._y = 0;
   this._x = PositionX;
   this._y = PositionY;
   _loc5_ = m_numPortraitWidth;
   Content.Bar._width = _loc5_;
   Content.Background._width = _loc5_;
   Content.HitBox._width = _loc5_ + 60;
   if(_global.CheckOverRightScreenBounds(_loc7_,Content.Background))
   {
      this._x = this._x - (Content.Background._width + 25);
      _loc6_ = true;
   }
   else
   {
      this._x = this._x + 25;
   }
   var _loc8_ = this._BgHeight;
   CheckBottomBounds(_loc7_,_loc8_);
   Arrows.LeftArrow._visible = !_loc6_;
   Arrows.RightArrow._visible = _loc6_;
}
function CheckBottomBounds(PosPoint, Height)
{
   if(_global.CheckOverBottomScreenBounds(PosPoint,Height,this))
   {
      this._y = this._y - (PosPoint.y + Height - 720);
      Arrows.LeftArrow._y = Arrows.LeftArrow._y + (PosPoint.y + Height - 720);
      Arrows.RightArrow._y = Arrows.LeftArrow._y;
   }
}
function RequestMission()
{
   HideTooltip();
   _global.MainMenuMovie.Panel.JournalPanel.Journal.SetDoublePageDialog(this);
}
function HasActiveMission()
{
   var _loc4_ = _global.CScaleformComponent_Inventory.GetActiveSeasonCoinItemId(this._PlayerXuid);
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(this._PlayerXuid,_loc4_,"quest id");
   if(_loc3_ != 0 && _loc3_ != undefined && _loc3_ != null)
   {
      return true;
   }
   return false;
}
function UpdateLeaderboard(strType)
{
   if(strType == this._LeaderboardType)
   {
      RefreshLeaderboardData();
      LayoutTooltip();
   }
}
function RefreshLeaderboardData()
{
   var strTypeOfLeaderboard = this._LeaderboardType;
   var _loc4_ = _global.CScaleformComponent_Leaderboards.GetState(strTypeOfLeaderboard);
   var _loc5_ = [];
   Content.Leaderboard._visible = false;
   _global.AutosizeTextDown(Content.Leaderboard.Titles.Friends,6);
   _global.AutosizeTextDown(Content.Leaderboard.Titles.Score,6);
   _global.AutosizeTextDown(Content.Leaderboard.Loading.Text,6);
   _global.AutosizeTextDown(Content.Leaderboard.NoFriends.Text,6);
   trace("------------------------------strTypeOfLeaderboard---------------------------" + strTypeOfLeaderboard);
   trace("------------------------------Status---------------------------" + _loc4_);
   if("none" == _loc4_)
   {
      Content.Leaderboard._visible = true;
      Content.Leaderboard.Loading._visible = true;
      Content.Leaderboard.NoFriends._visible = false;
      Content.Leaderboard.Titles._visible = false;
      Content.Leaderboard.btnLeaderboard._visible = false;
      var numLoop = 0;
      var numDelay = 20;
      Content.Leaderboard.onEnterFrame = function()
      {
         if(numLoop >= numDelay)
         {
            _global.CScaleformComponent_Leaderboards.Refresh(strTypeOfLeaderboard);
            delete Content.Leaderboard.onEnterFrame;
         }
         numLoop++;
      };
   }
   if("loading" == _loc4_)
   {
      Content.Leaderboard._visible = true;
      Content.Leaderboard.Loading._visible = true;
      Content.Leaderboard.NoFriends._visible = false;
      Content.Leaderboard.Titles._visible = false;
      Content.Leaderboard.btnLeaderboard._visible = false;
   }
   if("ready" == _loc4_)
   {
      var _loc3_ = _global.CScaleformComponent_Leaderboards.GetCount(strTypeOfLeaderboard);
      trace("------------------------------ready---------------------------");
      trace("------------------------------numEntires---------------------------" + _loc3_);
      Content.Leaderboard._visible = true;
      if(_loc3_ == 0)
      {
         Content.Leaderboard.Loading._visible = false;
         Content.Leaderboard.NoFriends._visible = true;
         Content.Leaderboard.Titles._visible = false;
         Content.Leaderboard.btnLeaderboard._visible = false;
      }
      else
      {
         Content.Leaderboard.Loading._visible = false;
         Content.Leaderboard.NoFriends._visible = false;
         Content.Leaderboard.Titles._visible = true;
         Content.Leaderboard.btnLeaderboard._visible = false;
         _loc5_ = GetFriendsWithAdjacentIndexes(GetPlayerPos(strTypeOfLeaderboard),_loc3_);
         if(_loc3_ > 2)
         {
            Content.Leaderboard.btnLeaderboard._visible = true;
            Content.Leaderboard.btnLeaderboard.dialog = this;
            Content.Leaderboard.btnLeaderboard.SetText("#CSGO_Journal_Tooltip_Leaderboard_open");
            Content.Leaderboard.btnLeaderboard.Action = function()
            {
               this.dialog.OpenLeaderboard();
            };
            Content.Leaderboard.btnLeaderboard.setDisabled(false);
         }
         trace("-------------------numEntires------------" + _loc3_);
      }
      if(3 <= _global.CScaleformComponent_Leaderboards.HowManyMinutesAgoCached(strTypeOfLeaderboard))
      {
         _global.CScaleformComponent_Leaderboards.Refresh(strTypeOfLeaderboard);
      }
   }
   RefreshEntries(_loc5_,strTypeOfLeaderboard);
}
function GetPlayerPos(strTypeOfLeaderboard, numEntires)
{
   var _loc5_ = undefined;
   var _loc2_ = 0;
   while(_loc2_ < numEntires)
   {
      var _loc3_ = _global.CScaleformComponent_Leaderboards.GetEntryXuidByIndex(Type,_loc2_);
      if(_loc3_ == m_PlayerXuid)
      {
         return _loc2_;
      }
      _loc2_ = _loc2_ + 1;
   }
   return null;
}
function GetFriendsWithAdjacentIndexes(PlayerIndex, numEntires)
{
   var _loc2_ = [];
   var _loc6_ = 5;
   if(PlayerIndex == null)
   {
      PlayerIndex = 0;
   }
   _loc2_.push(PlayerIndex);
   var _loc1_ = 1;
   while(_loc1_ <= _loc6_)
   {
      var _loc4_ = PlayerIndex - _loc1_;
      var _loc5_ = PlayerIndex + _loc1_;
      if(_loc4_ != PlayerIndex && _loc4_ >= 0)
      {
         _loc2_.push(PlayerIndex - _loc1_);
         if(_loc2_.length >= _loc6_)
         {
            return _loc2_.sort(Array.NUMERIC);
         }
      }
      if(_loc5_ != PlayerIndex && _loc5_ < numEntires)
      {
         _loc2_.push(PlayerIndex + _loc1_);
         if(_loc2_.length >= _loc6_)
         {
            return _loc2_.sort(Array.NUMERIC);
         }
      }
      _loc1_ = _loc1_ + 1;
   }
   _loc2_.sort(Array.NUMERIC);
   trace("-------------------Pos------------" + _loc2_);
   return _loc2_;
}
function RefreshEntries(aFriends, strTypeOfLeaderboard)
{
   var _loc9_ = 4;
   var _loc7_ = aFriends.length;
   var _loc10_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc3_ = 0;
   while(_loc3_ < _loc9_)
   {
      var _loc2_ = Content.Leaderboard["Tile" + _loc3_];
      if(_loc3_ >= _loc7_ || _loc7_ == null || _loc7_ == undefined)
      {
         _loc2_._visible = false;
      }
      else
      {
         var _loc4_ = _global.CScaleformComponent_Leaderboards.GetEntryXuidByIndex(strTypeOfLeaderboard,aFriends[_loc3_]);
         var _loc6_ = _global.CScaleformComponent_Leaderboards.GetEntryScoreByIndex(strTypeOfLeaderboard,aFriends[_loc3_]);
         trace("-------------------Pos------------" + aFriends[_loc3_]);
         trace("-------------------Xuid------------" + _loc4_);
         trace("-------------------Score------------" + _loc6_);
         trace("-------------------Name------------" + _global.CScaleformComponent_FriendsList.GetFriendName(_loc4_));
         if(_loc4_ == _loc10_)
         {
            _loc2_.Bg._alpha = 60;
            _loc2_.Name.htmlText = "<b>" + _global.CScaleformComponent_FriendsList.GetFriendName(_loc4_) + "</b>";
            _loc2_.Pos.htmlText = "<b>" + (aFriends[_loc3_] + 1) + "</b>";
            _loc2_.Value.htmlText = "<b>" + _loc6_ + "</b>";
         }
         else
         {
            _loc2_.Bg._alpha = 30;
            _loc2_.Name.htmlText = _global.CScaleformComponent_FriendsList.GetFriendName(_loc4_);
            _loc2_.Pos.htmlText = aFriends[_loc3_] + 1;
            _loc2_.Value.htmlText = _loc6_;
         }
         if(_loc3_ % 2)
         {
            _loc2_.Bg._visible = false;
         }
         else
         {
            _loc2_.Bg._visible = true;
         }
         _loc2_.Avatar.m_bShowFlair = false;
         _loc2_.Avatar._visible = true;
         _loc2_.Avatar.ShowAvatar(3,_loc4_,true,false);
         _loc2_.Avatar.SetFlairItem(_loc4_);
         _loc2_._visible = true;
      }
      _loc3_ = _loc3_ + 1;
   }
}
function OpenLeaderboard()
{
   HideTooltip();
   _global.MainMenuMovie.Panel.JournalPanel.Journal.ShowDoublePageDialog("Leaderboard",this);
   Content.Leaderboard.btnLeaderboard.setDisabled(true);
}
Content.Background.onRollOver = function()
{
};
Content.HitBox.onRollOver = function()
{
};
Content.Background.onRollOut = function()
{
   TooltipItemShowHide(false);
};
Content.HitBox.onRollOut = function()
{
   TooltipItemShowHide(false);
};
var m_numDefaultBgHeight = 215;
var m_numDefaultBgWidth = 221;
var m_numDefaultforDescMissionY = Content.DescMission._y;
var m_numDefaultforDescMissionX = Content.DescMission._x;
stop();
