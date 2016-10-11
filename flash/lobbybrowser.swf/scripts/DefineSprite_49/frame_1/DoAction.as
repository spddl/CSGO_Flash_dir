function Init()
{
   SliderControl.Init(false);
   idx = 0;
   while(idx < NumButtons)
   {
      var _loc3_ = this["PlayerButton0" + idx];
      if(_loc3_ != undefined)
      {
         _loc3_._visible = false;
         _loc3_.Selected._visible = false;
         _loc3_.dialog = this;
         _loc3_.Action = function()
         {
            this.dialog.onSelectedPlayer(this);
         };
      }
      idx++;
   }
   JoinButton.dialog = this;
   JoinButton.SetText("#SFUI_LobbyBrowser_Join");
   JoinButton.Action = function()
   {
      this.dialog.onJoin();
   };
   GamercardButton.dialog = this;
   GamercardButton.SetText("#SFUI_Lobby_ShowGamercard");
   GamercardButton.Action = function()
   {
      _global.LobbyBrowserAPI.DisplayUserInfo(_global.LobbyBrowserMovie.GetActiveFriendXuid());
   };
   GamercardButton._visible = bConsoleVersion;
   UpdateGamercardButton();
   SliderControl.m_bNotifyWhileMoving = true;
   SliderControl.NotifyValueChange = this.SliderValueChanged;
   SliderControl.m_nIncrementAmount = 15;
   TotalFriends = 0;
   TopFriendIdx = 0;
   _global.LobbyBrowserAPI.SetFriendsParams(0,NumButtons);
   MouseOverPanel.onRollOver = MouseOverPanel.onDragOver = function()
   {
      _global.LobbyBrowserMovie.onRolloverChange(_global.LobbyBrowserMovie.Panel_Friends);
   };
   Deactivated();
}
function RefreshAvatarImages()
{
   idx = 0;
   while(idx < NumButtons)
   {
      var _loc2_ = this["PlayerButton0" + idx];
      if(_loc2_ != undefined)
      {
         if(_loc2_.Avatar.DynamicAvatar.Image != undefined)
         {
            _loc2_.Avatar.DynamicAvatar.Image.unloadMovie();
         }
         _loc2_._xuid = undefined;
      }
      idx++;
   }
}
function Activated()
{
   MouseOverPanel._visible = false;
   steamNav.SetInitialHighlight(ButtonList[ActiveButton]);
   _global.navManager.PushLayout(steamNav);
}
function Deactivated()
{
   UnselectPlayer();
   _global.navManager.RemoveLayout(steamNav);
}
function UpdateGamercardButton()
{
   var _loc1_ = GetActiveFriendXuid();
   GamercardButton._visible = bConsoleVersion && _loc1_ != undefined && _loc1_ != "0";
}
function UpdateFriendCount()
{
   TotalFriends = _global.LobbyBrowserAPI.GetNumFriends();
   if(TotalFriends <= NumButtons)
   {
      SliderControl._visible = false;
   }
   else
   {
      SliderControl._visible = true;
      SliderControl.m_nIncrementAmount = 100 / Math.min(2,TotalFriends / NumButtons);
   }
   OnlineCount.OnlineCount.text = TotalFriends + _global.GameInterface.Translate("#SFUI_UsersCountLabel");
}
function GetActiveFriendXuid()
{
   return ButtonList[ActiveButton]._xuid;
}
function GetActiveFriendLobbyId()
{
   return ButtonList[ActiveButton]._lobbyId;
}
function FriendsListUp(bNoWrap)
{
   if(bNoWrap == undefined)
   {
      bNoWrap = false;
   }
   UnselectPlayer();
   UpdateFriendCount();
   if(TotalFriends <= 1)
   {
      return undefined;
   }
   var _loc2_ = ActiveButton;
   if(ActiveButton > 0)
   {
      ActiveButton--;
   }
   else if(TopFriendIdx > 0)
   {
      TopFriendIdx--;
   }
   else if(!bNoWrap)
   {
      TopFriendIdx = Math.max(0,TotalFriends - NumButtons);
      ActiveButton = Math.min(NumButtons - 1,TotalFriends - 1);
   }
   _global.LobbyBrowserAPI.SetFriendsParams(TopFriendIdx,NumButtons);
   _global.navManager.SetHighlightedObject(ButtonList[ActiveButton]);
   if(_loc2_ == ActiveButton)
   {
      _global.navManager.PlayNavSound("ButtonRollover");
   }
   UpdateSliderPip();
   UpdateGamercardButton();
}
function FriendsListDown(bNoWrap)
{
   if(bNoWrap == undefined)
   {
      bNoWrap = false;
   }
   UnselectPlayer();
   UpdateFriendCount();
   if(TotalFriends <= 1)
   {
      return undefined;
   }
   var _loc2_ = ActiveButton;
   if(ActiveButton < NumButtons - 1 && ActiveButton < TotalFriends - 1)
   {
      ActiveButton++;
   }
   else if(TopFriendIdx + ActiveButton < TotalFriends - 1)
   {
      TopFriendIdx++;
   }
   else if(!bNoWrap)
   {
      TopFriendIdx = 0;
      ActiveButton = 0;
   }
   _global.LobbyBrowserAPI.SetFriendsParams(TopFriendIdx,NumButtons);
   _global.navManager.SetHighlightedObject(ButtonList[ActiveButton]);
   if(_loc2_ == ActiveButton)
   {
      _global.navManager.PlayNavSound("ButtonRollover");
   }
   UpdateSliderPip();
   UpdateGamercardButton();
}
function PageUpList()
{
   UpdateFriendCount();
   if(TotalFriends <= NumButtons)
   {
      ActiveButton = 0;
      _global.navManager.SetHighlightedObject(ButtonList[ActiveButton]);
      return undefined;
   }
   var _loc2_ = TopFriendIdx + ActiveButton;
   if(ActiveButton > 0)
   {
      ActiveButton = 0;
   }
   else
   {
      TopFriendIdx = Math.max(0,TopFriendIdx - NumButtons);
   }
   _global.navManager.SetHighlightedObject(ButtonList[ActiveButton]);
   _global.LobbyBrowserAPI.SetFriendsParams(TopFriendIdx,NumButtons);
   UpdateSliderPip();
   UpdateGamercardButton();
}
function PageDownList()
{
   UpdateFriendCount();
   if(TotalFriends <= NumButtons)
   {
      ActiveButton = TotalFriends - 1;
      _global.navManager.SetHighlightedObject(ButtonList[ActiveButton]);
      return undefined;
   }
   var _loc2_ = TopFriendIdx;
   TopFriendIdx = Math.min(TotalFriends - NumButtons,TopFriendIdx + NumButtons);
   if(TopFriendIdx < _loc2_ + NumButtons)
   {
      ActiveButton = NumButtons - 1;
      _global.navManager.SetHighlightedObject(ButtonList[ActiveButton]);
   }
   _global.LobbyBrowserAPI.SetFriendsParams(TopFriendIdx,NumButtons);
   UpdateSliderPip();
   UpdateGamercardButton();
}
function UpdateSliderPip()
{
   bIgnoreUpdate = true;
   SliderControl.SetValue((TopFriendIdx + ActiveButton + (ActiveButton <= 0?0:1)) / TotalFriends * 100);
}
function SliderValueChanged()
{
   if(bIgnoreUpdate)
   {
      bIgnoreUpdate = false;
      return undefined;
   }
   UpdateFriendCount();
   var _loc2_ = TopFriendIdx;
   TopFriendIdx = Math.max(Math.floor(SliderControl.GetValue() / 100 * (TotalFriends - NumButtons)),0);
   if(_loc2_ != TopFriendIdx)
   {
      UnselectPlayer();
      _global.LobbyBrowserAPI.SetFriendsParams(TopFriendIdx,NumButtons);
   }
}
function UnselectPlayer()
{
   if(SelectedButton != undefined)
   {
      SelectedButton.Selected._visible = false;
      SelectedButton = undefined;
      SelectedXuid = undefined;
      SelectedLobbyId = undefined;
   }
   _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.GameModeName.htmlText = "";
   _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.MapName.htmlText = "";
   _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.MapThumbnail.Icon.removeMovieClip();
   _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.MapThumbnail.mapName = mapGroup;
   JoinButton._visible = bConsoleVersion;
}
function onSelectedPlayer(button)
{
   if(button._xuid == "0")
   {
      return undefined;
   }
   if(bConsoleVersion)
   {
      SelectedXuid = button._xuid;
      SelectedLobbyId = button._lobbyId;
      _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.GameModeName.htmlText = button._gameMode;
      _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.MapName.htmlText = button._mapGroup;
      UpdateMap(button._mapGroup);
      onJoin();
      return undefined;
   }
   if(_global.LobbyBrowserMovie.isDoubleClickActive() && SelectedButton == button)
   {
      _global.LobbyBrowserMovie.stopDoubleClickTimer();
      onJoin();
      UnselectPlayer();
   }
   else
   {
      _global.LobbyBrowserMovie.startDoubleClickTimer();
      UnselectPlayer();
      button.Selected._visible = true;
      SelectedButton = button;
      SelectedXuid = button._xuid;
      SelectedLobbyId = button._lobbyId;
      _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.GameModeName.htmlText = button._gameMode;
      _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.MapName.htmlText = button._mapGroup;
      UpdateMap(button._mapGroup);
      JoinButton._visible = true;
   }
}
function onJoin()
{
   _global.LobbyBrowserMovie.JoinPlayer(SelectedLobbyId);
}
function UpdateFriend(index, xuid, friendName, friendStatus, mapGroup, gameType, gameMode, numPlayers, numSlots, lobbyId)
{
   UpdateFriendCount();
   if(index == ActiveButton)
   {
      UpdateGamercardButton();
   }
   var _loc3_ = this["PlayerButton0" + index];
   if(_loc3_ != undefined)
   {
      translatedGameMode = "";
      if(gameMode != "")
      {
         translatedGameMode = _global.GameInterface.Translate(gameMode);
      }
      _loc3_._visible = true;
      _loc3_.PlayerText.PlayerText.text = friendName;
      _loc3_.PlayerText.GameMode.htmlText = _global.GameInterface.Translate(friendStatus);
      if(numPlayers != -1 && numSlots != -1)
      {
         _loc3_.PlayerText.GameMode.htmlText = _loc3_.PlayerText.GameMode.htmlText + (" (" + numPlayers + "/" + numSlots + ")");
      }
      _loc3_._lobbyId = lobbyId;
      _loc3_._gameMode = translatedGameMode;
      _loc3_._mapGroup = mapGroup;
      if(SelectedButton == _loc3_)
      {
         _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.GameModeName.htmlText = _loc3_._gameMode;
         _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.MapName.htmlText = _loc3_._mapGroup;
         UpdateMap(_loc3_._mapGroup);
      }
      var _loc4_ = _loc3_.Avatar;
      _loc4_.SoundIcon._visible = false;
      if(xuid != _loc3_._xuid)
      {
         if(xuid != "0" && xuid != "" && xuid != undefined)
         {
            _loc4_.DefaultAvatar._visible = false;
            _loc4_.DynamicAvatar._visible = true;
            if(_loc4_.DynamicAvatar.Image != undefined)
            {
               _loc4_.DynamicAvatar.Image.unloadMovie();
            }
            var _loc7_ = "img://avatar_" + xuid;
            var _loc6_ = new MovieClipLoader();
            _loc6_.addListener(this);
            _loc6_.loadClip(_loc7_,_loc4_.DynamicAvatar.Image);
         }
         else
         {
            _loc4_.DefaultAvatar._visible = true;
            _loc4_.DynamicAvatar._visible = false;
         }
         _loc3_._xuid = xuid;
      }
   }
}
function UpdateMap(mapGroup)
{
   if(mapGroup == "")
   {
      _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.MapName.htmlText = "";
   }
   else
   {
      if(GameModeData == undefined)
      {
         GameModeData = _global.GameInterface.LoadKVFile("GameModes.txt");
      }
      var _loc4_ = undefined;
      if(mapGroup.substr(0,2) == "mg")
      {
         _loc4_ = GameModeData.mapgroups[mapGroup];
      }
      else
      {
         _loc4_ = GameModeData.maps[mapGroup];
      }
      mapGroupFriendlyName = _global.GameInterface.Translate(_loc4_.nameID);
      if(mapGroupFriendlyName != undefined)
      {
         _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel.MapName.htmlText = mapGroupFriendlyName;
      }
   }
   var _loc3_ = _global.LobbyBrowserMovie.LobbyPanel.Panels.ClientPanel;
   if(_loc3_.MapThumbnail.mapName != mapGroup)
   {
      _loc3_.MapThumbnail.Icon.removeMovieClip();
      if(mapGroup.substr(0,1) != "#")
      {
         if(GameModeData == undefined)
         {
            GameModeData = _global.GameInterface.LoadKVFile("GameModes.txt");
         }
         _loc3_.MapThumbnail.DefaultIcon._visible = false;
         _loc4_ = undefined;
         if(mapGroup.substr(0,2) == "mg")
         {
            _loc4_ = GameModeData.mapgroups[mapGroup];
         }
         else
         {
            _loc4_ = GameModeData.maps[mapGroup];
         }
         var _loc5_ = _loc4_.imagename;
         if(_loc5_ != undefined)
         {
            _loc3_.MapThumbnail.attachMovie(_loc5_,"Icon",_loc3_.MapThumbnail.getNextHighestDepth());
         }
      }
      else
      {
         _loc3_.MapThumbnail.DefaultIcon._visible = true;
         _loc3_.MapName.text = _global.GameInterface.Translate(mapGroup);
      }
      _loc3_.MapThumbnail.mapName = mapGroup;
   }
}
function HideFriendsAt(index)
{
   UpdateFriendCount();
   idx = index;
   while(idx < NumButtons)
   {
      var _loc2_ = this["PlayerButton0" + idx];
      if(_loc2_ != undefined)
      {
         _loc2_._visible = false;
      }
      idx++;
   }
}
function onLoadInit(movieClip)
{
   movieClip._x = avatarX;
   movieClip._y = avatarY;
   movieClip._width = avatarWidth;
   movieClip._height = avatarHeight;
}
var bConsoleVersion = _global.IsXbox() || _global.IsPS3();
var avatarX = 0;
var avatarY = 0;
var avatarWidth = 42;
var avatarHeight = 42;
var TopFriendIdx = 0;
var TotalFriends = 0;
var SelectedXuid = undefined;
var SelectedLobbyId = undefined;
var SelectedButton = undefined;
var GameModeData = undefined;
var steamNav = new Lib.NavLayout();
steamNav.ShowCursor(true);
steamNav.MakeModal(false);
steamNav.AddRepeatKeys("DOWN","UP","KEY_XSTICK2_UP","KEY_XSTICK2_DOWN","KEY_PAGEUP","KEY_PAGEDOWN","MOUSE_WHEEL_UP","MOUSE_WHEEL_DOWN");
steamNav.RepeatRate = 50;
var ButtonList;
ButtonList = [PlayerButton00,PlayerButton01,PlayerButton02,PlayerButton03,PlayerButton04,PlayerButton05,PlayerButton06,PlayerButton07,PlayerButton08];
var NumButtons = ButtonList.length;
steamNav.AddTabOrder(ButtonList);
var ActiveButton = 0;
steamNav.AddKeyHandlerTable({LEFT:{onDown:function(button, control, keycode)
{
   return true;
}},RIGHT:{onDown:function(button, control, keycode)
{
   return true;
}},UP:{onDown:function(button, control, keycode)
{
   _global.LobbyBrowserMovie.FriendsListUp();
   return true;
}},DOWN:{onDown:function(button, control, keycode)
{
   _global.LobbyBrowserMovie.FriendsListDown();
   return true;
}},KEY_XBUTTON_BACK:{onDown:function(button, control, keycode)
{
   return true;
}},KEY_XBUTTON_START:{onDown:function(button, control, keycode)
{
   return true;
}},KEY_XBUTTON_Y:{onDown:function(button, control, keycode)
{
   return true;
}},KEY_XBUTTON_X:{onDown:function(button, control, keycode)
{
   _global.LobbyBrowserMovie.CreateLobby();
   return true;
}},KEY_XBUTTON_LEFT_SHOULDER:{onDown:function(button, control, keycode)
{
   if(!_global.IsXbox() && !_global.IsPS3())
   {
      return false;
   }
   var _loc2_ = _global.LobbyBrowserMovie.GetActiveFriendXuid();
   if(_loc2_ != undefined && _loc2_ != "0")
   {
      _global.LobbyBrowserAPI.DisplayUserInfo(_loc2_);
   }
   return true;
}},KEY_XBUTTON_RIGHT_SHOULDER:{onDown:function(button, control, keycode)
{
   return true;
}}});
steamNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.LobbyBrowserMovie.PageUpList();
   return true;
}},"KEY_XSTICK2_UP");
steamNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.LobbyBrowserMovie.PageDownList();
   return true;
}},"KEY_XSTICK2_DOWN");
steamNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.LobbyBrowserMovie.FriendsListUp(true);
   return true;
}},"MOUSE_WHEEL_UP");
steamNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.LobbyBrowserMovie.FriendsListDown(true);
   return true;
}},"MOUSE_WHEEL_DOWN");
steamNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   _global.LobbyBrowserMovie.Exit();
   return true;
}},"KEY_ESCAPE","KEY_XBUTTON_B");
_global.LobbyBrowserMovie.AddChatKeyHandlers(steamNav);
var bIgnoreUpdate = false;
stop();
