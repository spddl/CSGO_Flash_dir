function InitFriendsLister()
{
   SetupScrollButtons();
   SetupTileButtons();
   UpdateTotalFriendsCount();
   if(m_MissionPanelState > 0)
   {
      ChooseFriendLister(MoreThanTenFriendsPlayingGame(),m_MissionPanelState);
   }
   else
   {
      ChooseFriendLister(MoreThanTenFriendsPlayingGame(),0);
   }
   RefreshFriendsTiles();
}
function SetupScrollButtons()
{
   ButtonDown.dialog = this;
   ButtonDown.actionSound = "PageScroll";
   ButtonDown.Action = function()
   {
      this.dialog.onScrollDown(this);
   };
   ButtonDown.setDisabled(true);
   ButtonUp.dialog = this;
   ButtonUp.actionSound = "PageScroll";
   ButtonUp.Action = function()
   {
      this.dialog.onScrollUp(this);
   };
   ButtonUp.setDisabled(true);
}
function SetupTileButtons()
{
   var _loc3_ = 0;
   while(_loc3_ < 22)
   {
      var _loc2_ = FriendsList["Player" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         this.dialog.OpenContextMenu(this);
      };
      _loc2_.RolledOver = function()
      {
         objRightClick = this;
      };
      _loc2_.RolledOut = function()
      {
         objRightClick = null;
      };
      _loc2_.Selected._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   _loc3_ = 0;
   while(_loc3_ < 20)
   {
      _loc2_ = FriendsListPos1["Player" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         this.dialog.OpenContextMenu(this);
      };
      _loc2_.RolledOver = function()
      {
         objRightClick = this;
      };
      _loc2_.RolledOut = function()
      {
         objRightClick = null;
      };
      _loc2_.Selected._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   _loc3_ = 0;
   while(_loc3_ < 18)
   {
      _loc2_ = FriendsListPos2["Player" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         this.dialog.OpenContextMenu(this);
      };
      _loc2_.RolledOver = function()
      {
         objRightClick = this;
      };
      _loc2_.RolledOut = function()
      {
         objRightClick = null;
      };
      _loc2_.Selected._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   _loc3_ = 0;
   while(_loc3_ < 14)
   {
      _loc2_ = FriendsListPos3["Player" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         this.dialog.OpenContextMenu(this);
      };
      _loc2_.RolledOver = function()
      {
         objRightClick = this;
      };
      _loc2_.RolledOut = function()
      {
         objRightClick = null;
      };
      _loc2_.Selected._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   _loc3_ = 0;
   while(_loc3_ < 44)
   {
      _loc2_ = FriendsListDouble["Player" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         this.dialog.OpenContextMenu(this);
      };
      _loc2_.RolledOver = function()
      {
         objRightClick = this;
      };
      _loc2_.RolledOut = function()
      {
         objRightClick = null;
      };
      _loc2_.Selected._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   _loc3_ = 0;
   while(_loc3_ < 36)
   {
      _loc2_ = FriendsListDoublePos1["Player" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         this.dialog.OpenContextMenu(this);
      };
      _loc2_.RolledOver = function()
      {
         objRightClick = this;
      };
      _loc2_.RolledOut = function()
      {
         objRightClick = null;
      };
      _loc2_.Selected._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   _loc3_ = 0;
   while(_loc3_ < 36)
   {
      _loc2_ = FriendsListDoublePos2["Player" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         this.dialog.OpenContextMenu(this);
      };
      _loc2_.RolledOver = function()
      {
         objRightClick = this;
      };
      _loc2_.RolledOut = function()
      {
         objRightClick = null;
      };
      _loc2_.Selected._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   _loc3_ = 0;
   while(_loc3_ < 24)
   {
      _loc2_ = FriendsListDoublePos3["Player" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         this.dialog.OpenContextMenu(this);
      };
      _loc2_.RolledOver = function()
      {
         objRightClick = this;
      };
      _loc2_.RolledOut = function()
      {
         objRightClick = null;
      };
      _loc2_.Selected._visible = false;
      _loc3_ = _loc3_ + 1;
   }
}
function CheckMouseInBounds(x, y)
{
   if(x < 0 || x > this._width)
   {
      return false;
   }
   if(y < 0 || y > this._height)
   {
      return false;
   }
   return true;
}
function PushLayout()
{
   _global.navManager.PushLayout(friendsNav,"friendsNav");
}
function RemoveLayout()
{
   _global.navManager.RemoveLayout(friendsNav);
}
function onScrollUp()
{
   if(FriendListInfo._m_numTopItemTile != 0)
   {
      ScrollPrev();
      ButtonUp.setDisabled(true);
      ForceCloseContextMenu();
   }
}
function onScrollDown()
{
   if(FriendListInfo._m_numTopItemTile + FriendListInfo._SelectableTiles < FriendListInfo._m_numItems)
   {
      ScrollNext();
      ButtonDown.setDisabled(true);
      ForceCloseContextMenu();
   }
}
function ForceCloseContextMenu()
{
   var _loc2_ = _global.MainMenuMovie.Panel.TooltipContextMenu;
   _loc2_._visible = false;
}
function ScrollNext()
{
   m_testCount = 30;
   var LoopCount = 0;
   var SpeedOut = 0.6;
   var _loc1_ = 1;
   FriendListInfo._AnimObject.onEnterFrame = function()
   {
      if(LoopCount < 1)
      {
         FriendListInfo._AnimObject._y = FriendListInfo._AnimObject._y + (FriendListInfo._EndPos - 1 - FriendListInfo._AnimObject._y) * SpeedOut;
      }
      if(FriendListInfo._AnimObject._y < FriendListInfo._EndPos)
      {
         LoopCount++;
         FriendListInfo._AnimObject._y = FriendListInfo._StartPos;
         FriendListInfo._m_numTopItemTile = FriendListInfo._m_numTopItemTile + FriendListInfo._SelectableTiles;
         RefreshFriendsTiles();
         EnableDisableScrollButtons();
         delete FriendListInfo._AnimObject.onEnterFrame;
      }
   };
}
function ScrollPrev()
{
   var LoopCount = 0;
   var SpeedOut = 0.6;
   var _loc1_ = 1;
   FriendListInfo._AnimObject._y = FriendListInfo._EndPos;
   FriendListInfo._m_numTopItemTile = FriendListInfo._m_numTopItemTile - FriendListInfo._SelectableTiles;
   RefreshFriendsTiles();
   FriendListInfo._AnimObject.onEnterFrame = function()
   {
      if(LoopCount < 1)
      {
         FriendListInfo._AnimObject._y = FriendListInfo._AnimObject._y + (FriendListInfo._StartPos + 1 - FriendListInfo._AnimObject._y) * SpeedOut;
      }
      if(FriendListInfo._AnimObject._y > FriendListInfo._StartPos)
      {
         LoopCount++;
         FriendListInfo._AnimObject._y = FriendListInfo._StartPos;
         EnableDisableScrollButtons();
         delete FriendListInfo._AnimObject.onEnterFrame;
      }
   };
}
function ScrollReset()
{
   FriendListInfo._m_numTopItemTile = FriendListInfo._SelectableTiles;
   ScrollPrev();
}
function EnableDisableScrollButtons()
{
   if(FriendListInfo._m_numTopItemTile != 0)
   {
      ButtonUp.setDisabled(false);
   }
   else
   {
      ButtonUp.setDisabled(true);
   }
   if(FriendListInfo._m_numTopItemTile + FriendListInfo._SelectableTiles < FriendListInfo._m_numItems)
   {
      ButtonDown.setDisabled(false);
   }
   else
   {
      ButtonDown.setDisabled(true);
   }
}
function RefreshAvatarImage()
{
   i = 0;
   while(i < FriendListInfo._m_numItems)
   {
      if(FriendListInfo._m_numItems > 10)
      {
         var _loc1_ = FriendsListDouble["Player" + i];
      }
      else
      {
         _loc1_ = FriendsList["Player" + i];
      }
      _loc1_.RefreshAvatarImage();
      i++;
   }
}
function RefreshFriendsTiles()
{
   UpdateTotalFriendsCount();
   if(FriendListInfo._m_numItems < FriendListInfo._m_numTopItemTile)
   {
      FriendListInfo._m_numTopItemTile = FriendListInfo._m_numTopItemTile - FriendListInfo._SelectableTiles;
   }
   i = 0;
   while(i < FriendListInfo._TotalTiles)
   {
      SetDataFriendsTiles(i,FriendListInfo._m_numTopItemTile + i);
      i++;
   }
   CheckIfSelectedTileXuidHasChanged();
   EnableDisableScrollButtons();
}
function SetDataFriendsTiles(numFriendTile, numFriendIndex)
{
   var _loc6_ = false;
   var _loc5_ = FriendListInfo._AnimObject;
   var _loc2_ = _loc5_["Player" + i];
   if(numFriendIndex < 0 || numFriendIndex > FriendListInfo._m_numItems - 1)
   {
      _loc2_._visible = false;
   }
   else
   {
      var _loc4_ = _global.CScaleformComponent_FriendsList.GetXuidByIndex(numFriendIndex);
      _loc2_._xuid = _loc4_;
      _loc2_._friendIndex = numFriendIndex;
      _loc2_.GetTileInfo(_loc4_);
      _loc2_._visible = true;
   }
}
function CheckIfSelectedTileXuidHasChanged()
{
   if(objSelectedTile._xuid != null && objSelectedTile._xuid != undefined && objSelectedTile._xuid != "0")
   {
      var _loc2_ = _global.CScaleformComponent_FriendsList.GetXuidByIndex(objSelectedTile._friendIndex);
      if(_loc2_ != objSelectedTile._xuid)
      {
      }
   }
}
function UpdateTotalFriendsCount()
{
   FriendListInfo._m_numItems = _global.CScaleformComponent_FriendsList.GetCount();
   FriendsOnlineNumber.Text.htmlText = FriendListInfo._m_numItems + _global.GameInterface.Translate("#SFUI_UsersCountLabel");
}
function MoreThanTenFriendsPlayingGame()
{
   if(FriendListInfo._m_numItems > 20)
   {
      return true;
   }
   if(FriendListInfo._m_numItems > 10)
   {
      var _loc4_ = 0;
      i = 0;
      while(i < FriendListInfo._m_numItems)
      {
         var _loc2_ = _global.CScaleformComponent_FriendsList.GetXuidByIndex(i);
         var _loc3_ = _global.CScaleformComponent_FriendsList.IsFriendPlayingCSGO(_loc2_);
         if(_loc3_)
         {
            _loc4_ = _loc4_ + 1;
         }
         if(_loc4_ > 10)
         {
            return true;
         }
         i++;
      }
   }
   return false;
}
function ChooseFriendLister(bShowDoubleLister, Pos)
{
   FriendsListDouble._visible = false;
   FriendsListDoublePos1._visible = false;
   FriendsListDoublePos2._visible = false;
   FriendsListDoublePos3._visible = false;
   FriendsList._visible = false;
   FriendsListPos1._visible = false;
   FriendsListPos2._visible = false;
   FriendsListPos3._visible = false;
   if(bShowDoubleLister)
   {
      if(Pos == 3)
      {
         FriendsListDoublePos3._visible = true;
         FriendListInfo._AnimObject = this.FriendsListDoublePos3;
         FriendListInfo._TotalTiles = 24;
         FriendListInfo._SelectableTiles = 12;
         FriendListInfo._EndPos = - FriendsListDoublePos3._height / 2 - (FriendsListDoublePos3._y + 2);
         Background.Bg.Rect._height = 266;
      }
      else if(Pos == 2)
      {
         FriendsListDoublePos2._visible = true;
         FriendListInfo._AnimObject = this.FriendsListDoublePos2;
         FriendListInfo._TotalTiles = 36;
         FriendListInfo._SelectableTiles = 18;
         FriendListInfo._EndPos = - FriendsListDoublePos2._height / 2 - (FriendsListDoublePos2._y - 2);
         Background.Bg.Rect._height = 383;
      }
      else if(Pos == 1)
      {
         FriendsListDoublePos1._visible = true;
         FriendListInfo._AnimObject = this.FriendsListDoublePos1;
         FriendListInfo._TotalTiles = 40;
         FriendListInfo._SelectableTiles = 20;
         FriendListInfo._StartPos = NUM_FRIENDS_LISTERDOUBLE_START_POS;
         FriendListInfo._EndPos = - FriendsListDoublePos1._height / 2 - (FriendsListDoublePos1._y - 10);
         Background.Bg.Rect._height = 428;
      }
      else
      {
         FriendsListDouble._visible = true;
         FriendListInfo._AnimObject = this.FriendsListDouble;
         FriendListInfo._TotalTiles = 44;
         FriendListInfo._SelectableTiles = 22;
         FriendListInfo._EndPos = NUM_FRIENDS_LISTERDOUBLE_END_POS;
         Background.Bg.Rect._height = 466;
      }
      FriendListInfo._StartPos = NUM_FRIENDS_LISTERDOUBLE_START_POS;
      ButtonDown._y = Background.Bg.Rect._y + Background.Bg.Rect._height - 1;
      Mask._height = Background.Bg.Rect._height - Background.Bg.Bar._height;
   }
   else
   {
      if(Pos == 3)
      {
         FriendsListPos3._visible = true;
         FriendListInfo._EndPos = - FriendsListPos3._height / 2 - (FriendsListPos3._y + 2);
         FriendListInfo._AnimObject = this.FriendsListPos3;
         FriendListInfo._TotalTiles = 12;
         FriendListInfo._SelectableTiles = 6;
         Background.Bg.Rect._height = 266;
      }
      else if(Pos == 2)
      {
         FriendsListPos2._visible = true;
         FriendListInfo._EndPos = - FriendsListPos2._height / 2 - (FriendsListPos2._y - 10);
         FriendListInfo._AnimObject = this.FriendsListPos2;
         FriendListInfo._TotalTiles = 18;
         FriendListInfo._SelectableTiles = 9;
         Background.Bg.Rect._height = 383;
      }
      else if(Pos == 1)
      {
         FriendsListPos1._visible = true;
         FriendListInfo._EndPos = - FriendsListPos1._height / 2 - (FriendsListPos1._y - 10);
         FriendListInfo._AnimObject = this.FriendsListPos1;
         FriendListInfo._TotalTiles = 20;
         FriendListInfo._SelectableTiles = 10;
         Background.Bg.Rect._height = 428;
      }
      else
      {
         FriendsList._visible = true;
         FriendListInfo._EndPos = NUM_FRIENDS_LISTER_END_POS;
         FriendListInfo._AnimObject = this.FriendsList;
         FriendListInfo._TotalTiles = 22;
         FriendListInfo._SelectableTiles = 11;
         Background.Bg.Rect._height = 466;
      }
      FriendListInfo._StartPos = NUM_FRIENDS_LISTER_START_POS;
      ButtonDown._y = Background.Bg.Rect._y + Background.Bg.Rect._height - 1;
      Mask._height = Background.Bg.Rect._height - Background.Bg.Bar._height;
   }
   RefreshFriendsTiles();
   trace("----------------------------------------------FriendListInfo._AnimObject-------------------------:" + FriendListInfo._AnimObject);
}
function SetPanelPosAndSize(MissionPanelState)
{
   m_MissionPanelState = MissionPanelState;
   this._y = 0;
   if(MissionPanelState == 3)
   {
      this._y = NUM_PANEL_Y + 200;
   }
   else if(MissionPanelState == 2)
   {
      this._y = NUM_PANEL_Y + 82;
   }
   else if(MissionPanelState == 1)
   {
      this._y = NUM_PANEL_Y + 38;
   }
   else
   {
      this._y = NUM_PANEL_Y;
   }
   ChooseFriendLister(MoreThanTenFriendsPlayingGame(),MissionPanelState);
}
function OpenContextMenu(objPlayerTile)
{
   var _loc10_ = _global.MainMenuMovie.Panel.TooltipContextMenu;
   var _loc16_ = {x:objPlayerTile._x + objPlayerTile._width,y:objPlayerTile._y};
   trace("----------------------------------------------objPlayerTile._xuid-------------------------:" + objPlayerTile._xuid);
   var _loc7_ = objPlayerTile._xuid;
   var _loc13_ = _global.CScaleformComponent_FriendsList.IsFriendInvited(_loc7_);
   var _loc12_ = _global.CScaleformComponent_FriendsList.IsFriendJoinable(_loc7_);
   var _loc11_ = _global.CScaleformComponent_FriendsList.IsFriendWatchable(_loc7_);
   var _loc9_ = _global.CScaleformComponent_FriendsList.IsFriendPlayingCSGO(_loc7_);
   var _loc8_ = _global.CScaleformComponent_MyPersona.GetLauncherType() != "perfectworld"?false:true;
   var _loc5_ = _global.CScaleformComponent_FriendsList.GetFriendStatusBucket(_loc7_);
   var _loc3_ = [];
   var _loc4_ = [];
   if(_loc5_ == "PlayingCSGO" || _loc5_ == "Online")
   {
      _loc3_.push("invite");
      _loc4_.push("#SFUI_Invite_Lobby");
   }
   if(CanSummonForCoop() && !_global.LobbyMovie)
   {
      _loc3_.push("summonmissioncoop");
      _loc4_.push("#SFUI_Summon_For_Guardian");
   }
   if(CanSummonForCoopMission() && !_global.LobbyMovie)
   {
      _loc3_.push("summonmissioncoopmission");
      _loc4_.push("#SFUI_Summon_For_Assult");
   }
   if(_loc12_)
   {
      _loc3_.push("join");
      _loc4_.push("#SFUI_Join_Game");
   }
   if(_loc11_)
   {
      _loc3_.push("watch");
      _loc4_.push("#SFUI_Watch");
   }
   if(_loc5_ == "AwaitingLocalAccept" || _loc5_ == "AwaitingRemoteAccept")
   {
      if(_loc3_.length > 0)
      {
         _loc3_.push("seperator");
         _loc4_.push("");
      }
      if(_loc5_ == "AwaitingLocalAccept")
      {
         _loc3_.push("friendaccept");
         _loc4_.push("#SFUI_Accept_Friend_Request");
         _loc3_.push("friendignore");
         _loc4_.push("#SFUI_Ignore_Friend_Request");
      }
      if(_loc5_ == "AwaitingRemoteAccept")
      {
         _loc3_.push("cancelinvite");
         _loc4_.push("#SFUI_Friend_Invite_Canel");
      }
   }
   if(_loc9_ || !_loc8_)
   {
      _loc3_.push("seperator");
      _loc4_.push("");
      if(_loc9_)
      {
         _loc3_.push("goprofile");
         _loc4_.push("#SFUI_Lobby_ShowCSGOProfile");
      }
      if(!_loc8_)
      {
         _loc3_.push("steamprofile");
         _loc4_.push("#SFUI_Lobby_ShowGamercard");
         _loc3_.push("message");
         _loc4_.push("#SFUI_Steam_Message");
      }
   }
   if(_loc8_ && (_loc5_ != "AwaitingRemoteAccept" && _loc5_ != "AwaitingLocalAccept"))
   {
      if(_loc3_.length > 0)
      {
         _loc3_.push("seperator");
         _loc4_.push("");
      }
      _loc3_.push("removefriend");
      _loc4_.push("#SFUI_Friend_Remove");
   }
   if(_loc3_.length > 0)
   {
      _loc10_.TooltipShowHide(objPlayerTile);
      _loc10_.TooltipLayout(_loc3_,_loc4_,objPlayerTile,this.AssignContextMenuAction);
   }
}
function AssignContextMenuAction(strMenuItem, objTargetTile)
{
   switch(strMenuItem)
   {
      case "invite":
         onInvite(objTargetTile._xuid);
         break;
      case "join":
         onJoin(objTargetTile._xuid);
         break;
      case "watch":
         onWatch(objTargetTile._xuid);
         break;
      case "goprofile":
         onGoProfile(objTargetTile._xuid);
         break;
      case "steamprofile":
         onSteamProfile(objTargetTile._xuid);
         break;
      case "message":
         onMessage(objTargetTile._xuid);
         break;
      case "summonmissioncoopmission":
         onSummonForCoopMission(objTargetTile._xuid);
         break;
      case "summonmissioncoop":
         onSummonForCoopMission(objTargetTile._xuid);
         break;
      case "friendaccept":
         onFriendAction(objTargetTile._xuid,"friendrequestaccept");
         break;
      case "friendignore":
         onFriendAction(objTargetTile._xuid,"friendrequestignore");
         break;
      case "cancelinvite":
         onFriendAction(objTargetTile._xuid,"friendremove");
         break;
      case "removefriend":
         onFriendAction(objTargetTile._xuid,"friendremove");
   }
}
function CanSummonForCoop()
{
   var _loc3_ = GetActiveMission();
   if(_loc3_ != "")
   {
      var _loc4_ = _global.CScaleformComponent_MyPersona.GetXuid();
      var _loc2_ = _global.CScaleformComponent_Inventory.GetQuestGameMode(_loc4_,_loc3_);
      trace("-------------------------------GameMode: " + _loc2_);
      if(_loc2_ == "cooperative")
      {
         return true;
      }
   }
   return false;
}
function CanSummonForCoopMission()
{
   var _loc3_ = GetActiveMission();
   if(_loc3_ != "")
   {
      var _loc4_ = _global.CScaleformComponent_MyPersona.GetXuid();
      var _loc2_ = _global.CScaleformComponent_Inventory.GetQuestGameMode(_loc4_,_loc3_);
      trace("-------------------------------GameMode: " + _loc2_);
      if(_loc2_ == "coopmission")
      {
         return true;
      }
   }
   return false;
}
function GetActiveMission()
{
   var _loc3_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc5_ = _global.CScaleformComponent_Inventory.GetActiveSeasonCoinItemId(_loc3_);
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(_loc3_,_loc5_,"quest id");
   trace("-------------------------------xuid: " + _loc3_);
   trace("-------------------------------numActiveMission: " + _loc2_);
   trace("-------------------------------strSeasonCoinId: " + _loc2_);
   if(_loc2_ != 0 && _loc2_ != undefined && _loc2_ != null)
   {
      var _loc6_ = _global.CScaleformComponent_Inventory.GetCampaignFromQuestID(_loc2_);
      var _loc7_ = _global.CScaleformComponent_Inventory.GetCampaignNodeFromQuestID(_loc2_);
      var _loc4_ = _global.CScaleformComponent_Inventory.GetAQuestItemIDGivenCampaignNodeID(_loc7_,_loc6_);
      trace("-------------------------------QuestID: " + _loc4_);
      return _loc4_;
   }
   return "";
}
function onSummonForCoopMission(FriendXuid)
{
   var _loc4_ = GetActiveMission();
   if(_loc4_ != "")
   {
      var _loc5_ = _global.CScaleformComponent_MyPersona.GetXuid();
      var _loc2_ = _global.CScaleformComponent_Inventory.GetQuestMap(_loc5_,_loc4_);
      var _loc3_ = _global.CScaleformComponent_Inventory.GetQuestMapGroup(_loc5_,_loc4_);
      if(_loc2_ != "" && _loc2_ != undefined && _loc2_ != null && _loc2_ != " ")
      {
         _loc3_ = "mg_" + _loc2_;
      }
      trace("-------------------------------SummonFriend: " + _loc3_);
      CScaleformComponent_FriendsList.ActionInviteFriend(FriendXuid,"delayedlobby");
      _global.CScaleformComponent_CompetitiveMatch.ActionMatchmaking("cooperative",_loc3_,"search");
   }
   trace("-------------------------------BAD QUEST ID: ");
}
function onInvite(xuid)
{
   _global.CScaleformComponent_FriendsList.ActionInviteFriend(xuid);
}
function onJoin(xuid)
{
   _global.CScaleformComponent_FriendsList.ActionJoinFriendSession(xuid);
}
function onWatch(xuid)
{
   _global.CScaleformComponent_FriendsList.ActionWatchFriendSession(xuid);
}
function onGoProfile(xuid)
{
   _global.CScaleformComponent_FriendsList.ActionShowCSGOProfile(xuid);
}
function onSteamProfile(xuid)
{
   _global.CScaleformComponent_SteamOverlay.ShowUserProfilePage(xuid);
}
function onMessage(xuid)
{
   _global.CScaleformComponent_SteamOverlay.StartChatWithUser(xuid);
}
function onFriendAction(xuid, strAction)
{
   _global.CScaleformComponent_SteamOverlay.InteractWithUser(xuid,strAction);
}
var m_testCount = 19;
var FriendListInfo = new Object();
var m_MissionPanelState = 0;
FriendListInfo._TotalTiles = 0;
FriendListInfo._SelectableTiles = 0;
FriendListInfo._StartPos = 0;
FriendListInfo._EndPos = 0;
FriendListInfo._AnimObject = null;
FriendListInfo._m_numItems = 0;
FriendListInfo._m_numTopItemTile = 0;
var NUM_FRIENDS_LISTER_START_POS = FriendsList._y;
var NUM_FRIENDS_LISTER_END_POS = - FriendsList._height / 2 - (FriendsList._y - 5);
var NUM_FRIENDS_LISTERDOUBLE_START_POS = FriendsListDouble._y;
var NUM_FRIENDS_LISTERDOUBLE_END_POS = - FriendsListDouble._height / 2 - (FriendsListDouble._y - 10);
var NUM_PANEL_Y = this._y;
trace("----------------------NUM_FRIENDS_LISTER_START_POS" + NUM_FRIENDS_LISTER_START_POS);
trace("----------------------NUM_FRIENDS_LISTER_END_POS" + NUM_FRIENDS_LISTER_END_POS);
var objSelectedTile = null;
var objRightClick = null;
var friendsNav = new Lib.NavLayout();
friendsNav.ShowCursor(true);
friendsNav.AddKeyHandlerTable({MOUSE_WHEEL_UP:{onDown:function(button, control, keycode)
{
   if(CheckMouseInBounds(_xmouse,_ymouse))
   {
      onScrollUp();
   }
   return true;
}},MOUSE_WHEEL_DOWN:{onDown:function(button, control, keycode)
{
   if(CheckMouseInBounds(_xmouse,_ymouse))
   {
      onScrollDown();
   }
   return true;
}}});
this.stop();
