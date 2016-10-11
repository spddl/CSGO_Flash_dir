function onResize(rm)
{
   rm.ResetPosition(LobbyPanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.ALIGN_CENTER);
}
function showPanel()
{
   if(FriendsPanel != undefined)
   {
      FriendsPanel.Activated();
   }
   LobbyPanel._visible = true;
   LobbyPanel.gotoAndPlay("StartShow");
}
function hidePanel()
{
   LobbyPanel.gotoAndPlay("StartHide");
   FriendsPanel.Deactivated();
}
function InitLobby(leaderName, leaderXuid, isHost)
{
   FriendsPanel._visible = true;
   SetNavOptions();
}
function RefreshAvatarImages()
{
   if(FriendsPanel != undefined)
   {
      FriendsPanel.RefreshAvatarImages();
   }
}
function UpdateFriend(index, xuid, friendName, friendStatus, mapGroup, gameType, gameMode, numPlayers, numSlots, lobbyId)
{
   FriendsPanel.UpdateFriend(index,xuid,friendName,friendStatus,mapGroup,gameType,gameMode,numPlayers,numSlots,lobbyId);
   SetNavOptions();
}
function HideFriendsAt(index)
{
   FriendsPanel.HideFriendsAt(index);
}
function UpdateFriendCount(numFriends)
{
   var _loc2_ = _global.GameInterface.Translate("#SFUI_Lobby_NumFriendsOnline");
   _loc2_ = _global.ConstructString(_loc2_,numFriends);
   FriendsPanel.LobbyCount.OnlineCount.htmlText = _loc2_;
}
function PageUpList()
{
   if(FriendsPanel != undefined)
   {
      FriendsPanel.PageUpList();
   }
}
function PageDownList()
{
   if(FriendsPanel != undefined)
   {
      FriendsPanel.PageDownList();
   }
}
function FriendsListUp(bNoWrap)
{
   if(FriendsPanel != undefined)
   {
      FriendsPanel.FriendsListUp(bNoWrap);
   }
}
function FriendsListDown(bNoWrap)
{
   if(FriendsPanel != undefined)
   {
      FriendsPanel.FriendsListDown(bNoWrap);
   }
}
function Exit()
{
   hidePanel();
}
function StartMatch()
{
   gameAPI.LaunchGame();
}
function GetActiveFriendXuid()
{
   return FriendsPanel.GetActiveFriendXuid();
}
function onUnload(mc)
{
   if(FriendsPanel != undefined)
   {
      FriendsPanel.Deactivated();
   }
   _global.tintManager.DeregisterAll(this);
   _global.LobbyBrowserMovie = null;
   _global.LobbyBrowserAPI = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onLoaded()
{
   LobbyPanel.Panels.NavigationMaster.PCButtons.BackButton.Action = function()
   {
      Exit();
   };
   LobbyPanel.Panels.NavigationMaster.PCButtons.CreateLobbyButton.Action = function()
   {
      CreateLobby();
   };
   setUIDevice();
   FriendsPanel.Init();
   gameAPI.OnReady();
   LobbyPanel.Panels.ClientPanel.GameModeName.htmlText = "";
   LobbyPanel.Panels.ClientPanel.MapName.htmlText = "";
}
function setUIDevice()
{
   SetNavOptions();
   if(_global.wantControllerShown)
   {
      LobbyPanel.Panels.NavigationMaster.gotoAndStop("ShowController");
   }
   else
   {
      LobbyPanel.Panels.NavigationMaster.gotoAndStop("HideController");
   }
}
function changeUIDevice()
{
   SetNavOptions();
   if(_global.wantControllerShown)
   {
      LobbyPanel.Panels.NavigationMaster.gotoAndPlay("StartShowController");
   }
   else
   {
      LobbyPanel.Panels.NavigationMaster.gotoAndPlay("StartHideController");
   }
}
function SetNavOptions()
{
   var _loc1_ = LobbyPanel.Panels.NavigationMaster;
   var _loc2_ = _loc1_.PCButtons;
   _loc2_.CreateLobbyButton.SetText("#SFUI_LobbyBrowser_CreateLobby");
   _loc2_.BackButton.SetText("#SFUI_LobbyBrowser_Back");
   _loc1_.ControllerNav.SetText("#SFUI_LobbyBrowser_Help@15");
}
function UpdateFriendLobbyInfo(gameType, gameMode, mapGroup)
{
   LobbyPanel.Panels.ClientPanel.GameModeName.htmlText = _global.GameInterface.Translate(gameType) + "-" + _global.GameInterface.Translate(gameMode);
   LobbyPanel.Panels.ClientPanel.MapName.htmlText = _global.GameInterface.Translate(mapGroup);
   UpdateMap(mapGroup);
}
function CreateLobby()
{
   gameAPI.SetReturnToMainMenu(false);
   hidePanel();
   _global.MainMenuAPI.BasePanelRunCommand("ShowLobbyUI","bHidePanel");
}
function JoinPlayer(lobbyId)
{
   gameAPI.JoinLobby(lobbyId);
}
function UpdateMap(HostMap)
{
   var _loc2_ = _global.LobbyMovie.LobbyPanel.Panels.ClientPanel;
   if(_loc2_.MapThumbnail.mapName != HostMap)
   {
      if(_loc2_.MapThumbnail.Icon != undefined)
      {
         _loc2_.MapThumbnail.Icon.unloadMovie();
      }
      if(HostMap.substr(0,1) != "#")
      {
         if(GameModeData == undefined)
         {
            GameModeData = _global.GameInterface.LoadKVFile("GameModes.txt");
         }
         _loc2_.MapThumbnail.DefaultIcon._visible = false;
         var _loc4_ = undefined;
         if(HostMap.substr(0,2) == "mg")
         {
            _loc4_ = GameModeData.mapgroups[HostMap];
         }
         else
         {
            _loc4_ = GameModeData.maps[HostMap];
         }
         var _loc5_ = _loc4_.imagename;
         if(_loc5_ == undefined)
         {
            _loc5_ = "map-random-overall";
         }
         _loc2_.MapThumbnail.attachMovie(_loc5_,"Icon",_loc2_.MapThumbnail.getNextHighestDepth());
         _loc2_.MapName.text = _global.GameInterface.Translate(_loc4_.nameID);
      }
      else
      {
         _loc2_.MapThumbnail.DefaultIcon._visible = true;
         _loc2_.MapName.text = _global.GameInterface.Translate(HostMap);
      }
      _loc2_.MapThumbnail.mapName = HostMap;
   }
}
function isDoubleClickActive()
{
   return bDoubleClickEnabled;
}
function startDoubleClickTimer()
{
   stopDoubleClickTimer();
   bDoubleClickEnabled = true;
   doubleClickInterval = setInterval(this,"stopDoubleClickTimer",doubleClickTiming);
}
function stopDoubleClickTimer()
{
   clearInterval(doubleClickInterval);
   bDoubleClickEnabled = false;
}
_global.LobbyBrowserMovie = this;
_global.LobbyBrowserAPI = gameAPI;
var bConsoleVersion = _global.IsXbox() || _global.IsPS3();
var FriendsPanel = LobbyPanel.Panels.LobbyFriendsPanel;
var bDoubleClickEnabled = false;
var doubleClickInterval;
var doubleClickTiming = 750;
_global.resizeManager.AddListener(this);
stop();
