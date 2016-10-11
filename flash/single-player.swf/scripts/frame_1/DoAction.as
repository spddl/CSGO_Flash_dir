function onResize(rm)
{
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_NONE);
   rm.DisableAdditionalScaling = true;
}
function showPanel()
{
   _global.GameInterface.SendUIEvent("show","creategamedialog");
   Panel.gotoAndPlay("StartShow");
   Panel.Panel.onShow();
}
function hidePanel(bHideFast)
{
   _global.GameInterface.SendUIEvent("hide","creategamedialog");
   if(bHideFast == true)
   {
      Panel.gotoAndPlay("StartHideFast");
   }
   else
   {
      Panel.gotoAndPlay("StartHide");
   }
   Panel.Panel.onHide();
}
function InitDialogData(usingMatchmaking, teamLobbyInitiated, isTrainingMode)
{
   Panel.Panel.dialog.InitDialogData(usingMatchmaking,teamLobbyInitiated,isTrainingMode);
   if(teamLobbyInitiated)
   {
      Panel.Title.SetText("#SFUI_CreateTeamMultiplayerTitle");
   }
   else if(usingMatchmaking)
   {
      Panel.Title.SetText("#SFUI_CreateMultiplayerTitle");
   }
   else
   {
      Panel.Title.SetText("#SFUI_CreateSinglePlayerTitle");
   }
}
function onUnload(mc)
{
   Panel.Panel.onHide();
   RemoveAllNav();
   clearInterval(_global.UpdateInviteInterval);
   delete _global.UpdateInviteInterval;
   _global.SinglePlayerMovie = null;
   _global.SinglePlayerAPI = null;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   _global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.Release();
   delete MainUI.StartSinglePlayerDialog.SinglePlayerDialog;
   return true;
}
function SetWorkshopMapInfo(numIndex, srtTitle, strDesc, strBspname, strGameModes, strTags, numScore, numUpvotes, numDownvotes, srtAuthor, strImagePath, bMapWasUpdated, numMapsRequested)
{
   Panel.Panel.SetWorkshopMapInfo(numIndex,srtTitle,strDesc,strBspname,strGameModes,strTags,numScore,numUpvotes,numDownvotes,srtAuthor,strImagePath,bMapWasUpdated,numMapsRequested);
}
function UpdateCurrentGamesCount(strGameMode, strPath, numServers)
{
   Panel.Panel.DisplayMapsWithServerCount(strGameMode,strPath,numServers);
}
function ScaleformComponent_MyPersona_MedalsChanged()
{
   var _loc3_ = _global.SinglePlayerMovie.Panel.Panel.dialog.GetUsingMatchmaking();
   var _loc2_ = _global.SinglePlayerMovie.Panel.Panel.dialog.GetInTeamMode();
   InitDialogData(_loc3_,_loc2_);
   Panel.Panel.dialog.OnSelectMode(Panel.Panel.dialog.objSelectedButton);
}
function ScaleformComponent_FriendsList_RebuildFriendsList()
{
   Panel.Friends.RefreshFriendsTiles();
}
function onLoaded()
{
   Panel.Panel._x = Panel.Panel._x + 451;
   Panel.Panel.dialog.setUIDevice();
   Panel.Panel.InitDialog();
   _global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.Init();
   gameAPI.OnReady();
   _global.UpdateInviteInterval = setInterval(_global.SinglePlayerAPI.UpdatePendingInvites,5000);
   handlePendingInvites(_global.GameInterface.GetConvarBoolean("cl_invitation_pending"));
   var _loc3_ = _global.SinglePlayerAPI.GetQueuedMatchmakingPreferredMaplist();
   arrCheckedMapNames = _loc3_.split(",");
   _global.SinglePlayerMovie.Panel.Panel.dialog.UpdateMapImage();
   trace("arrCheckedMapNames :" + arrCheckedMapNames);
   Panel.Friends.InitFriendsLister();
   Panel.PlayerProfile.InitPlayerProfile();
   Panel.MissionsPanel.InitMissionsPanel(false);
   _global.KeyDownEvent = function(key, vkey, slot, binding)
   {
      Lib.SFKey.setKeyCode(key,vkey,slot,binding);
      var _loc2_ = Lib.SFKey.KeyName(Lib.SFKey.getKeyCode());
      if(_loc2_ == "MOUSE_RIGHT")
      {
         SinglePlayerRightClickManager();
      }
      return _global.navManager.onKeyDown();
   };
   SetupNavDetectRollOvers();
   SetNav("Default");
}
function SinglePlayerRightClickManager()
{
   var _loc2_ = Panel.Friends;
   if(Panel.Friends.objRightClick.hitTest(_root._xmouse,_root._ymouse,true))
   {
      _loc2_.OpenContextMenu(Panel.Friends.objRightClick);
      return undefined;
   }
   if(Panel.MissionsPanel.objRightClick.hitTest(_root._xmouse,_root._ymouse,true))
   {
      Panel.MissionsPanel.OpenContextMenu(Panel.MissionsPanel.objRightClick);
   }
   else if(Panel.PlayerProfile.m_objHoverSelection.hitTest(_root._xmouse,_root._ymouse,true))
   {
      Panel.PlayerProfile.OpenContextMenu(Panel.PlayerProfile.m_objHoverSelection);
   }
}
function changeUIDevice()
{
   Panel.Panel.dialog.changeUIDevice();
}
function handlePendingInvites(bPendingInvite)
{
   Panel.Panel.dialog.handlePendingInvites(bPendingInvite);
}
function SetupNavDetectRollOvers()
{
   Panel.MouseOver.onRollOver = function()
   {
      SetNav("Blog");
   };
   Panel.Friends.MouseOver.onRollOver = function()
   {
      SetNav("Friends");
   };
}
function SetNav(strNavToSet)
{
   if(m_CurrentNav != strNavToSet)
   {
      m_CurrentNav = strNavToSet;
      Panel.Friends.RemoveLayout();
      Panel.MouseOver._visible = true;
      Panel.Friends.MouseOver._visible = true;
      if((var _loc0_ = strNavToSet) !== "Friends")
      {
         PushLayout();
         Panel.MouseOver._visible = false;
      }
      else
      {
         Panel.Friends.PushLayout();
         Panel.Friends.MouseOver._visible = false;
      }
   }
}
function PushLayout()
{
   _global.navManager.PushLayout(Panel.Panel.navSelectMap,"navSelectMap");
   Panel.Panel.AddFilterKeyHandlers(Panel.Panel.navSelectMap);
}
function RemoveLayout()
{
   _global.navManager.RemoveLayout(Panel.Panel.navSelectMap);
}
function RemoveAllNav()
{
   Panel.Friends.RemoveLayout();
   RemoveLayout();
}
_global.SinglePlayerMovie = this;
_global.SinglePlayerAPI = gameAPI;
var arrCheckedMapNames = new Array();
var bLoadedDefaultCheckedMaps = false;
var bDoneDefaultListingOfMaps = false;
_global.resizeManager.AddListener(this);
stop();
