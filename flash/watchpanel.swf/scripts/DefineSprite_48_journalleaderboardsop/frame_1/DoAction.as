function SetUpPickEmLeaderboard(EventId, bIsFantasy)
{
   SetUpPickEmLeaderboardsButtons(bIsFantasy);
   if(EventId == "tournament:4")
   {
      SetUpLister("official_leaderboard_pickem_eslcologne2014");
   }
   else if(EventId == "tournament:5")
   {
      SetUpLister("official_leaderboard_pickem_dhw2014");
   }
   else if(EventId == "tournament:6")
   {
      SetUpLister("official_leaderboard_pickem_kat2015");
   }
   else if(EventId == "tournament:7")
   {
      SetUpLister("official_leaderboard_pickem_eslcologne2015");
   }
   else if(EventId == "tournament:8")
   {
      if(bIsFantasy)
      {
         SetUpLister("official_leaderboard_pickem_cluj2015_fantasy");
      }
      else
      {
         SetUpLister("official_leaderboard_pickem_cluj2015_team");
      }
   }
   else if(EventId == "tournament:9")
   {
      if(bIsFantasy)
      {
         SetUpLister("official_leaderboard_pickem_columbus2016_fantasy");
      }
      else
      {
         SetUpLister("official_leaderboard_pickem_columbus2016_team");
      }
   }
   else if(EventId == "tournament:10")
   {
      if(bIsFantasy)
      {
         SetUpLister("official_leaderboard_pickem_cologne2016_fantasy");
      }
      else
      {
         SetUpLister("official_leaderboard_pickem_cologne2016_team");
      }
   }
}
function SetUpPickEmLeaderboardsButtons(bIsFantasy)
{
   BtnPrev.dialog = this;
   BtnPrev.actionSound = "PageScroll";
   BtnPrev.SetText("#CSGO_Operation_Leaderboard_Prev");
   BtnPrev.Action = function()
   {
      this.dialog.onScrollBackward(LeaderboardListerInfo,RefreshEntries);
   };
   BtnNext.dialog = this;
   BtnNext.actionSound = "PageScroll";
   BtnNext.SetText("#CSGO_Operation_Leaderboard_Next");
   BtnNext.Action = function()
   {
      this.dialog.onScrollForward(LeaderboardListerInfo,RefreshEntries);
   };
   if(bIsFantasy)
   {
      Title.htmlText = "#CSGO_Fantasy_Leaderboard_Title";
   }
   else
   {
      Title.htmlText = "#CSGO_PickEm_Leaderboard_Title";
   }
}
function SetUpPage(numSeason, TypeOfLeaderboard, CoinId)
{
   SetUpArrayOfCatagories(numSeason);
   SetUpButtons(TypeOfLeaderboard,numSeason);
   if(TypeOfLeaderboard == "competitive")
   {
      SetUpLister("official_leaderboard_season_" + numSeason + "_wins_cm");
   }
   else
   {
      SetUpLister("official_leaderboard_season_" + numSeason + "_wins_op");
   }
   SelectButton(BtnCompType0);
}
function SetUpArrayOfCatagories(numSeason)
{
   m_aTypesComp = new Array("official_leaderboard_season_" + numSeason + "_wins_cm","official_leaderboard_season_" + numSeason + "_hours_cm","official_leaderboard_season_" + numSeason + "_kills_cm","official_leaderboard_season_" + numSeason + "_hsp_cm","official_leaderboard_season_" + numSeason + "_mvps_cm");
   m_aTypesOp = new Array("official_leaderboard_season_" + numSeason + "_wins_op","official_leaderboard_season_" + numSeason + "_hours_op","official_leaderboard_season_" + numSeason + "_kills_op","official_leaderboard_season_" + numSeason + "_hsp_op","official_leaderboard_season_" + numSeason + "_mvps_op","official_leaderboard_season_" + numSeason + "_points");
   trace("------------------------------------------------------m_aTypesOp------------------------" + m_aTypesOp);
}
function SetUpButtons(TypeOfLeaderboard, numSeason)
{
   var _loc8_ = [];
   if(OperationLogo != undefined)
   {
      OperationLogo.unloadMovie();
   }
   BtnPrev.dialog = this;
   BtnPrev.actionSound = "PageScroll";
   BtnPrev.SetText("#CSGO_Operation_Leaderboard_Prev");
   BtnPrev.Action = function()
   {
      this.dialog.onScrollBackward(LeaderboardListerInfo,RefreshEntries);
   };
   BtnNext.dialog = this;
   BtnNext.actionSound = "PageScroll";
   BtnNext.SetText("#CSGO_Operation_Leaderboard_Next");
   BtnNext.Action = function()
   {
      this.dialog.onScrollForward(LeaderboardListerInfo,RefreshEntries);
   };
   if(TypeOfLeaderboard == "competitive")
   {
      var _loc4_ = [];
      _loc4_ = m_aTypesComp;
      Desc.htmlText = "#CSGO_Operation_Leaderboard_Desc_Active";
      Title.htmlText = "#CSGO_Operation_Leaderboard_Active";
      OperationLogo._visible = false;
      CompLogo._visible = true;
   }
   else
   {
      _loc4_ = [];
      _loc4_ = m_aTypesOp;
      Desc.htmlText = "#CSGO_Operation_Leaderboard_Desc_Op";
      Title.htmlText = "#CSGO_Operation_Leaderboard_Active";
      Text.Title.htmlText = "#CSGO_Operation_Leaderboard_TitleActive";
      OperationLogo._visible = true;
      CompLogo._visible = false;
      var _loc7_ = "econ/season_icons/season_" + numSeason + ".png";
      var _loc6_ = new Object();
      _loc6_.onLoadInit = function(target_mc)
      {
         target_mc._width = 78;
         target_mc._height = 60;
         target_mc.forceSmoothing = true;
      };
      var _loc5_ = new MovieClipLoader();
      _loc5_.addListener(_loc6_);
      _loc5_.loadClip(_loc7_,OperationLogo);
   }
   var _loc2_ = 0;
   while(_loc2_ < NUM_TYPE_BUTTONS)
   {
      var _loc3_ = this["BtnCompType" + _loc2_];
      trace("------------------------------------------------------aTypesToUse[i]------------------------" + _loc4_[_loc2_]);
      if(_loc4_[_loc2_] == "" || _loc4_[_loc2_] == null || _loc4_[_loc2_] == undefined)
      {
         _loc3_._visible = false;
      }
      else
      {
         _loc3_._visible = true;
      }
      _loc3_.dialog = this;
      _loc3_.Text.htmlText = "#CSGO_" + _loc4_[_loc2_];
      _loc3_._Type = _loc4_[_loc2_];
      _loc3_.Action = function()
      {
         this.dialog.SetUpLister(this._Type);
         SelectButton(this);
      };
      _loc3_.Selected._visible = false;
      _loc2_ = _loc2_ + 1;
   }
   MissionsDisclaimer.htmlText = "#CSGO_official_leaderboard_season_" + numSeason + "_points_desc";
}
function SelectButton(objButton)
{
   m_ObjButtonType.Selected._visible = false;
   objButton.Selected._visible = true;
   m_ObjButtonType = objButton;
}
function SetUpLister(Type)
{
   m_TypeOfLeaderboard = Type;
   m_bAlreadyScrolledToPlayer = false;
   NoData._visible = false;
   Loading._visible = false;
   var _loc5_ = _global.GameInterface.Translate("#CSGO_" + Type);
   var _loc3_ = _global.CScaleformComponent_Leaderboards.GetState(m_TypeOfLeaderboard);
   if("none" == _loc3_)
   {
      Loading._visible = true;
      Loading.Text.htmlText = "#CSGO_Operation_Leaderboard_Loading";
      _global.CScaleformComponent_Leaderboards.Refresh(m_TypeOfLeaderboard);
   }
   if("loading" == _loc3_)
   {
      var _loc4_ = _global.GameInterface.Translate("#CSGO_Operation_Leaderboard_Loading_Type");
      _loc4_ = _global.ConstructString(_loc4_,_loc5_);
      Loading.Text.htmlText = _loc4_;
      Loading._visible = true;
   }
   if("ready" == _loc3_)
   {
      Loading._visible = false;
      if(_global.CScaleformComponent_Leaderboards.GetCount(m_TypeOfLeaderboard) == 0)
      {
         var _loc2_ = _global.GameInterface.Translate("#CSGO_Operation_Leaderboard_NoData");
         _loc2_ = _global.ConstructString(_loc2_,_loc5_);
         NoData.Text.htmlText = _loc2_;
         NoData._visible = true;
      }
      if(3 <= _global.CScaleformComponent_Leaderboards.HowManyMinutesAgoCached(m_TypeOfLeaderboard))
      {
         _global.CScaleformComponent_Leaderboards.Refresh(m_TypeOfLeaderboard);
      }
   }
   ScrollReset(LeaderboardListerInfo);
   RefreshEntries();
}
function RefreshEntries()
{
   if(_global.CScaleformComponent_Leaderboards.GetCount(m_TypeOfLeaderboard) != undefined)
   {
      LeaderboardListerInfo._m_numItems = _global.CScaleformComponent_Leaderboards.GetCount(m_TypeOfLeaderboard);
   }
   else
   {
      LeaderboardListerInfo._m_numItems = 0;
   }
   var _loc3_ = false;
   var _loc2_ = 0;
   while(_loc2_ < LeaderboardListerInfo._TotalTiles)
   {
      _loc3_ = SetLeaderboardData(_loc2_,LeaderboardListerInfo._m_numTopItemTile + _loc2_,m_TypeOfLeaderboard,_loc3_);
      _loc2_ = _loc2_ + 1;
   }
   EnableDisableScrollButtons(LeaderboardListerInfo);
   UpdatePageCount(LeaderboardListerInfo);
   if(!m_bAlreadyScrolledToPlayer)
   {
      GetPlayerPos(m_TypeOfLeaderboard);
   }
}
function SetLeaderboardData(numTile, numItemIndex, Type)
{
   var _loc2_ = Rows["Row" + numTile];
   var _loc9_ = undefined;
   if(numItemIndex < 0 || numItemIndex > LeaderboardListerInfo._m_numItems - 1)
   {
      _loc2_._visible = false;
      return undefined;
   }
   var _loc3_ = _global.CScaleformComponent_Leaderboards.GetEntryXuidByIndex(Type,numItemIndex);
   var _loc6_ = _global.CScaleformComponent_Leaderboards.GetEntryScoreByIndex(Type,numItemIndex);
   var _loc7_ = _global.CScaleformComponent_Leaderboards.GetEntryGlobalPctByIndex(Type,numItemIndex);
   _loc2_.Avatar.m_bShowFlair = false;
   _loc2_.Avatar._visible = true;
   _loc2_.Avatar.ShowAvatar(3,_loc3_,true,false);
   _loc2_.Avatar.SetFlairItem(_loc3_);
   _loc2_._visible = true;
   _loc2_._alpha = 100;
   _loc2_.Bg._visible = !bShowBg;
   bShowBg = !bShowBg;
   if(_loc3_ == m_PlayerXuid)
   {
      _loc2_.Player._visible = true;
      _loc2_.Name.htmlText = "<b>" + _global.CScaleformComponent_FriendsList.GetFriendName(_loc3_) + "</b>";
      _loc2_.Pos.htmlText = "<b>" + (numItemIndex + 1) + "</b>";
   }
   else
   {
      _loc2_.Player._visible = false;
      _loc2_.Name.htmlText = _global.CScaleformComponent_FriendsList.GetFriendName(_loc3_);
      _loc2_.Pos.htmlText = numItemIndex + 1;
   }
   if(Type.indexOf("hsp") != -1)
   {
      _loc2_.Value.htmlText = _loc6_ + " %";
   }
   else
   {
      _loc2_.Value.htmlText = _loc6_;
   }
   _loc2_.Percent.htmlText = _loc7_ + " %";
   return bShowBg;
}
function GetPlayerPos(Type)
{
   var _loc5_ = _global.CScaleformComponent_Leaderboards.GetCount(m_TypeOfLeaderboard);
   var _loc4_ = undefined;
   var _loc2_ = 0;
   while(_loc2_ < _loc5_)
   {
      var _loc3_ = _global.CScaleformComponent_Leaderboards.GetEntryXuidByIndex(Type,_loc2_);
      if(_loc3_ == m_PlayerXuid)
      {
         _loc4_ = _loc2_;
      }
      _loc2_ = _loc2_ + 1;
   }
   if(_loc4_ > LeaderboardListerInfo._SelectableTiles - 1)
   {
      GotoPageWithPlayerOnit(_loc4_);
   }
}
function GotoPageWithPlayerOnit(PlayerPos)
{
   var _loc2_ = GetPageCount(LeaderboardListerInfo._m_numItems,LeaderboardListerInfo._SelectableTiles);
   var _loc1_ = Math.floor(PlayerPos / LeaderboardListerInfo._SelectableTiles);
   trace("------------------------------------------------------numPages------------------------" + _loc2_);
   trace("------------------------------------------------------NumPagePlayerIsOn------------------------" + _loc1_);
   LeaderboardListerInfo._m_numTopItemTile = _loc1_ * LeaderboardListerInfo._SelectableTiles;
   m_bAlreadyScrolledToPlayer = true;
   RefreshEntries();
}
function onScrollForward(objPanelInfo, RefreshTiles)
{
   if(objPanelInfo._m_numTopItemTile + objPanelInfo._SelectableTiles < objPanelInfo._m_numItems)
   {
      ScrollNext(objPanelInfo,RefreshTiles);
      objPanelInfo._NextButton.setDisabled(true);
   }
}
function onScrollBackward(objPanelInfo, RefreshTiles)
{
   if(objPanelInfo._m_numTopItemTile != 0)
   {
      ScrollPrev(objPanelInfo,RefreshTiles);
      objPanelInfo._PrevButton.setDisabled(true);
   }
}
function ScrollNext(objPanelInfo, RefreshTiles)
{
   var LoopCount = 0;
   var mcMovie = objPanelInfo._AnimObject;
   var SpeedOut = 0.6;
   var _loc1_ = 1;
   mcMovie.onEnterFrame = function()
   {
      if(LoopCount < 1)
      {
         mcMovie._x = mcMovie._x + (objPanelInfo._EndPos - 1 - mcMovie._x) * SpeedOut;
      }
      if(mcMovie._x < objPanelInfo._EndPos)
      {
         LoopCount++;
         mcMovie._x = objPanelInfo._StartPos;
         objPanelInfo._m_numTopItemTile = objPanelInfo._m_numTopItemTile + objPanelInfo._SelectableTiles;
         RefreshTiles();
         EnableDisableScrollButtons(objPanelInfo);
         UpdatePageCount(objPanelInfo);
         delete mcMovie.onEnterFrame;
      }
   };
}
function ScrollPrev(objPanelInfo, RefreshTiles)
{
   var LoopCount = 0;
   var mcMovie = objPanelInfo._AnimObject;
   var SpeedOut = 0.6;
   var _loc1_ = 1;
   mcMovie._x = objPanelInfo._EndPos;
   objPanelInfo._m_numTopItemTile = objPanelInfo._m_numTopItemTile - objPanelInfo._SelectableTiles;
   RefreshTiles();
   mcMovie.onEnterFrame = function()
   {
      if(LoopCount < 1)
      {
         mcMovie._x = mcMovie._x + (objPanelInfo._StartPos + 1 - mcMovie._x) * SpeedOut;
      }
      if(mcMovie._x > objPanelInfo._StartPos)
      {
         LoopCount++;
         mcMovie._x = objPanelInfo._StartPos;
         EnableDisableScrollButtons(objPanelInfo);
         UpdatePageCount(objPanelInfo);
         delete mcMovie.onEnterFrame;
      }
   };
}
function ScrollReset(objPanelInfo)
{
   if(GetCurrentPageNumber(objPanelInfo._m_numTopItemTile,objPanelInfo._SelectableTiles) > 1)
   {
      objPanelInfo._m_numTopItemTile = objPanelInfo._SelectableTiles;
      ScrollPrev(objPanelInfo);
   }
}
function EnableDisableScrollButtons(objPanelInfo)
{
   if(objPanelInfo._m_numTopItemTile != 0)
   {
      objPanelInfo._PrevButton.setDisabled(false);
   }
   else
   {
      objPanelInfo._PrevButton.setDisabled(true);
   }
   if(objPanelInfo._m_numTopItemTile + objPanelInfo._SelectableTiles < objPanelInfo._m_numItems)
   {
      objPanelInfo._NextButton.setDisabled(false);
   }
   else
   {
      objPanelInfo._NextButton.setDisabled(true);
   }
}
function UpdatePageCount(objPanelInfo)
{
   var _loc2_ = GetPageCount(objPanelInfo._m_numItems,objPanelInfo._SelectableTiles);
   var _loc3_ = GetCurrentPageNumber(objPanelInfo._m_numTopItemTile,objPanelInfo._SelectableTiles);
   if(_loc2_ > 1)
   {
      objPanelInfo._PageCountObject.htmlText = "Page " + _loc3_ + "/" + _loc2_;
   }
   else
   {
      objPanelInfo._PageCountObject.htmlText = "";
   }
}
function GetPageCount(numItems, NumTotalTiles)
{
   var _loc1_ = Math.ceil(numItems / NumTotalTiles);
   return _loc1_;
}
function GetCurrentPageNumber(numTopItemTile, NumTotalTiles)
{
   var _loc1_ = Math.ceil(numTopItemTile / NumTotalTiles);
   _loc1_ = _loc1_ + 1;
   return _loc1_;
}
stop();
var LeaderboardListerInfo = new Object();
var objRightClick = null;
var m_TypeOfLeaderboard = "";
var NUM_TYPE_BUTTONS = 6;
var m_ObjButtonType = null;
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var m_bAlreadyScrolledToPlayer = false;
LeaderboardListerInfo._TotalTiles = 24;
LeaderboardListerInfo._SelectableTiles = 12;
LeaderboardListerInfo._StartPos = Rows._x;
LeaderboardListerInfo._EndPos = Rows._x - Rows._width / 2 + 3;
LeaderboardListerInfo._PrevButton = BtnPrev;
LeaderboardListerInfo._NextButton = BtnNext;
LeaderboardListerInfo._AnimObject = Rows;
LeaderboardListerInfo._PageCountObject = PageCount;
LeaderboardListerInfo._m_numItems = 0;
LeaderboardListerInfo._m_numTopItemTile = 0;
var m_aTypesComp = [];
var m_aTypesOp = [];
