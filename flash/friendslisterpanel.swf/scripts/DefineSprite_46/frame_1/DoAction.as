function GetTileInfo(friendXuid)
{
   var _loc5_ = _global.CScaleformComponent_FriendsList.GetFriendName(friendXuid);
   var _loc8_ = _global.CScaleformComponent_FriendsList.GetFriendStatus(friendXuid);
   var _loc9_ = _global.CScaleformComponent_FriendsList.IsFriendInvited(friendXuid);
   var _loc6_ = _global.CScaleformComponent_FriendsList.IsFriendJoinable(friendXuid);
   var _loc4_ = _global.CScaleformComponent_FriendsList.IsFriendWatchable(friendXuid);
   var _loc7_ = _global.CScaleformComponent_FriendsList.IsFriendPlayingCSGO(friendXuid);
   this._xuid = friendXuid;
   UpdateTile(friendXuid,_loc5_,_loc8_,_loc9_,_loc6_,_loc4_,_loc7_);
}
function UpdateTile(friendXuid, friendName, friendStatus, bInvited, bCanJoin, bCanWatch, bIsPlayingGame)
{
   var _loc5_ = "0x98C840";
   var _loc6_ = "0x6B92AD";
   var _loc3_ = [];
   PlayerStatus.htmlText = friendStatus;
   if(PlayerStatus.textWidth > PlayerStatus._width)
   {
      var _loc4_ = _global.GameInterface.Translate(friendStatus);
      PlayerStatus.htmlText = _loc4_ + " - " + _loc4_;
      ScrollStatusText();
   }
   else
   {
      PlayerStatus.hscroll = PlayerStatus.hscroll - PlayerStatus.maxhscroll;
      delete this.onEnterFrame;
   }
   _global.MainMenuAPI.EnsureAvatarCached(friendXuid);
   if(bCanJoin)
   {
      _loc3_.push(this.JoinIcon);
   }
   if(bCanWatch)
   {
      _loc3_.push(this.WatchIcon);
   }
   if(bInvited)
   {
      _loc3_.push(this.InvitedIcon);
   }
   PlaceJoinWatchIcons(_loc3_);
   InGameStatus._visible = bIsPlayingGame;
   if(bIsPlayingGame)
   {
      PlayerStatus.textColor = _loc5_;
   }
   else
   {
      PlayerStatus.textColor = _loc6_;
   }
   RefreshAvatarImage();
   SetPlayerData(bIsPlayingGame);
}
function ScrollStatusText()
{
   var _loc2_ = 0;
   var numHalfTextWidth = PlayerStatus.textWidth / 2;
   var _loc3_ = false;
   this.onEnterFrame = function()
   {
      PlayerStatus.hscroll = PlayerStatus.hscroll + 1;
      if(PlayerStatus.hscroll > numHalfTextWidth + 3)
      {
         PlayerStatus.hscroll = PlayerStatus.hscroll - PlayerStatus.maxhscroll;
      }
   };
}
function PlaceJoinWatchIcons(aIcons)
{
   WatchIcon._visible = false;
   JoinIcon._visible = false;
   InvitedIcon._visible = false;
   var _loc1_ = 0;
   while(_loc1_ < aIcons.length)
   {
      aIcons[_loc1_]._visible = true;
      aIcons[_loc1_]._x = NUM_STATUS_ICON_POS + _loc1_ * NUM_STATUS_ICON_OFFSET;
      _loc1_ = _loc1_ + 1;
   }
}
function RefreshAvatarImage()
{
   if(this._xuid == "" || this._xuid == undefined || this._xuid == null)
   {
      this._xuid = _global.CScaleformComponent_MyPersona.GetXuid();
   }
   Avatar.SetShowFlairItem(false);
   Avatar._visible = true;
   Avatar.ShowAvatar(3,this._xuid,false,false);
   var _loc3_ = Avatar.GetFlairItemName(this._xuid);
}
function SetPlayerData(bIsPlayingGame)
{
   var _loc3_ = "0x98C840";
   var _loc5_ = "0x6B92AD";
   if(this._xuid == "")
   {
      this._xuid = _global.CScaleformComponent_MyPersona.GetXuid();
   }
   var _loc4_ = _global.CScaleformComponent_FriendsList.GetFriendName(this._xuid);
   PlayerName.htmlText = _loc4_;
   _global.AutosizeTextDown(PlayerName,10);
   if(bIsPlayingGame)
   {
      PlayerName.textColor = _loc3_;
   }
   else
   {
      PlayerName.textColor = _loc5_;
   }
   RefreshAvatarImage(this._xuid);
}
function SetXpRank()
{
   Rank._visible = false;
   var _loc3_ = _global.CScaleformComponent_FriendsList.GetFriendLevel(this._xuid);
   if(_loc3_ != undefined && _loc3_ != 0 && _loc3_ != null)
   {
      trace("=============================NumXpLevel=========================" + _loc3_);
      Rank._visible = true;
      var _loc5_ = new Object();
      _loc5_.onLoadInit = function(target_mc)
      {
         target_mc._width = 20;
         target_mc._height = 20;
      };
      var _loc6_ = "econ/status_icons/level" + _loc3_ + ".png";
      var _loc4_ = new MovieClipLoader();
      _loc4_.addListener(_loc5_);
      _loc4_.loadClip(_loc6_,Rank);
   }
}
Lib.Controls.SFButton.InitAsStandardSFButton(this);
var NUM_STATUS_ICON_POS = JoinIcon._x;
var NUM_STATUS_ICON_OFFSET = 15;
stop();
