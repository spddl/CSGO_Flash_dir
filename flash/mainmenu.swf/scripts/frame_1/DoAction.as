function onResize(rm)
{
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_NONE);
   rm.DisableAdditionalScaling = true;
}
function onUIHide(mc, rm)
{
   hidePanel();
}
function onUIShow(mc, rm)
{
   showPanel();
}
function showPanel()
{
   _global.GameInterface.SendUIEvent("show","mainmenu");
   ShowFloatingPanels();
}
function hidePanel()
{
   _global.GameInterface.SendUIEvent("hide","mainmenu");
   HideFloatingPanels();
}
function restorePanel()
{
   _global.GameInterface.SendUIEvent("show","mainmenu");
   ShowFloatingPanels();
}
function hidePanelImmediate()
{
   _global.GameInterface.SendUIEvent("hide","mainmenu");
   HideFloatingPanels();
}
function ShowJournal()
{
   Panel.JournalPanel._visible = true;
   Panel.JournalPanel.Journal.ShowPanel();
}
function ShowFloatingPanels()
{
   SetupNavDetectRollOvers();
   SetMainMenuNav("Default");
   var _loc2_ = _global.MainMenuMovie.Panel.TooltipItemPreview;
   _loc2_.ShowHidePreview(false);
   if(Panel.SelectPanel.IsQuitSelected())
   {
      return undefined;
   }
   _global.MainMenuMovie.Panel.SelectPanel.MainMenuTopBar.QuitButton.setDisabled(false);
   ShowNews();
   Panel.StreamPanel.InitStream();
   Panel.BannerPanel.ShowPanel();
   Panel.SelectPanel._visible = true;
   Panel.PlayerProfile._visible = true;
   Panel.FriendsListerPanel._visible = true;
   Panel.OverwatchPanel._visible = true;
   Panel.MissionsPanel._visible = true;
   Panel.Warnings._visible = true;
   Panel.WarningsClientRestart._visible = true;
   Panel.NavDetect._visible = true;
   ShowNewItemAlert();
   CheckForUnacknowlegedGameAlerts();
   EnableRightClick();
   Panel.MissionsPanel.InitMissionsPanel(false);
   panelVisible = true;
}
function HideFloatingPanels()
{
   var _loc2_ = _global.MainMenuMovie.Panel.TooltipItemPreview;
   _loc2_.ShowHidePreview(false);
   if(Panel.SelectPanel.IsQuitSelected())
   {
      return undefined;
   }
   Panel.NavDetect._visible = false;
   Panel.InventoryPanel._visible = false;
   Panel.WatchPanel._visible = false;
   Panel.PlayerProfile._visible = false;
   Panel.MissionsPanel._visible = false;
   Panel.FriendsListerPanel._visible = false;
   Panel.OverwatchPanel._visible = false;
   Panel.Guides._visible = false;
   Panel.Warnings._visible = false;
   Panel.WarningsClientRestart._visible = false;
   Panel.MapVotePanel._visible = false;
   Panel.BannerPanel.HidePanel();
   Panel.StreamPanel.HideStreamPanel();
   HideNews();
   Panel.TooltipItem._visible = false;
   Panel.TooltipCampaign._visible = false;
   Panel.TooltipContextMenu._visible = false;
   Panel.TooltipItemPreview._visible = false;
   Panel.StoreListerPanel._visible = false;
   panelVisible = false;
}
function HideWarningOverwatchPanel()
{
   Panel.OverwatchPanel._visible = false;
   Panel.Warnings._visible = false;
   Panel.WarningsClientRestart._visible = false;
   Panel.StreamPanel.HideStreamPanel();
}
function ShowPanelsWhenInInventory()
{
   Panel.PlayerProfile._visible = true;
   Panel.FriendsListerPanel._visible = true;
   Panel.MissionsPanel._visible = true;
   Panel.MissionsPanel.InitMissionsPanel(false);
}
function ShowNews()
{
   if(blogActive)
   {
      if(!Panel.Blog._visible && !Panel.StreamPanel._visible)
      {
         Panel.Blog.ShowBlogPanel();
      }
   }
   else if(Panel.Blog._visible)
   {
      Panel.Blog.HideBlogPanel();
   }
}
function HideNews()
{
   Panel.Blog.HideBlogPanel();
}
function ShowGuidesPanel()
{
   trace("ShowGuidesPanel!!!!!!!!!!!!");
   if(!Panel.Guides._visible)
   {
      Panel.Guides.ShowGuidesPanel();
   }
}
function HideGuidesPanel()
{
   Panel.Blog.HideBlogPanel();
}
function ScaleformComponent_FriendsList_RebuildFriendsList()
{
   Panel.FriendsListerPanel.RefreshFriendsTiles();
}
function ScaleformComponent_MyPersona_MedalsChanged()
{
   Panel.PlayerProfile.GetMedalsInfo();
}
function ScaleformComponent_MyPersona_ElevatedStateUpdate()
{
   trace("-------------------------------------------------ScaleformComponent_MyPersona_ElevatedStateUpdate----------------");
   if(_global.MainMenuMovie.Panel.mcElevatedStatus)
   {
      _global.MainMenuMovie.Panel.mcElevatedStatus.Panel.UpdateEleveatedStatusPanel();
   }
}
function ScaleformComponent_MyPersona_NameChanged()
{
   Panel.PlayerProfile.SetPlayerData();
}
function ScaleformComponent_Device_Reset()
{
   Panel.PlayerProfile.RefreshAvatarImage();
   Panel.FriendsListerPanel.RefreshAvatarImage();
   if(Panel.InventoryPanel._visible == true)
   {
      Panel.InventoryPanel.RefreshItemImage();
   }
}
function ScaleformComponent_Device_Tick()
{
   Panel.Warnings.GetWarnings();
}
function ScaleformComponent_GC_Hello()
{
   if(m_bAskedForLiveMatches == false)
   {
      _global.CScaleformComponent_MatchList.Refresh("live");
      m_bAskedForLiveMatches = true;
   }
   Panel.PlayerProfile.SetEloBracketInfo();
   Panel.PlayerProfile.SetXpLevelInfo();
   Panel.PlayerProfile.SetCommendationsInfo();
   Panel.PlayerProfile.SetTeamPanel();
   Panel.PlayerProfile.SetElevatedStatusPanel();
   InitWarningClientRestart();
   Panel.OverwatchPanel.InitOverwatchPanel();
   Panel.Warnings.HideWarningsPanel();
}
function ScaleformComponent_Overwatch_CaseUpdated()
{
   Panel.OverwatchPanel.InitOverwatchPanel();
}
function ScaleformComponent_Store_PriceSheetChanged()
{
   Panel.BannerPanel.PlaceStoreTiles();
   _global.FrontEndBackgroundMovie.showBackground();
}
function ScaleformComponent_MatchList_FantasyUploaded()
{
   var _loc2_ = _global.MainMenuAPI.GetScaleformComponentEventParamString("ScaleformComponent_MatchList_FantasyUploaded","matchlist");
   var _loc3_ = _global.MainMenuAPI.GetScaleformComponentEventParamString("ScaleformComponent_MatchList_FantasyUploaded","sectionid");
   trace("------------------------------------------------------ ScaleformComponent_MatchList_FantasyUploaded" + _loc2_);
   trace("------------------------------------------------------ ScaleformComponent_MatchList_FantasyUploaded" + _loc3_);
   Panel.WatchPanel.TournamentPanel.FantasyTeamPredictionUploaded(_loc2_,_loc3_);
}
function ScaleformComponent_MatchList_PredictionUploaded()
{
   var _loc3_ = _global.MainMenuAPI.GetScaleformComponentEventParamString("ScaleformComponent_MatchList_PredictionUploaded","teamid");
   var _loc2_ = _global.MainMenuAPI.GetScaleformComponentEventParamString("ScaleformComponent_MatchList_PredictionUploaded","groupid");
   trace("------------------------------------------------------ ScaleformComponent_MatchList_PredictionUploaded" + _loc3_);
   trace("------------------------------------------------------ ScaleformComponent_MatchList_PredictionUploaded" + _loc2_);
   Panel.WatchPanel.TournamentPanel.PredictionUploaded(_loc3_,_loc2_);
}
function ScaleformComponent_MatchList_StateChange()
{
   var _loc2_ = _global.MainMenuAPI.GetScaleformComponentEventParamString("ScaleformComponent_MatchList_StateChange","matchlist");
   trace("------------------------------------------------------ _Match_LIST_StateChange: " + _loc2_);
   Panel.WatchPanel.RefreshWatchMatchList(_loc2_);
   Panel.SelectPanel.ShowLiveMatchAlert();
}
function ScaleformComponent_MatchInfo_StateChange()
{
   var _loc2_ = _global.MainMenuAPI.GetScaleformComponentEventParamString("ScaleformComponent_MatchInfo_StateChange","matchinfo");
   trace("-------------------------------------------------------Match_INFO_StateChange:" + _loc2_);
   Panel.WatchPanel.RefreshSelectedMatch(_loc2_);
}
function ScaleformComponent_Leaderboards_StateChange()
{
   var _loc2_ = _global.MainMenuAPI.GetScaleformComponentEventParamString("ScaleformComponent_Leaderboards_StateChange","leaderboard");
   if(_loc2_.indexOf("_quest") != -1)
   {
      Panel.TooltipCampaign.UpdateLeaderboard(_loc2_);
      trace("-------------------------------------------------------ScaleformComponent_Leaderboards_StateChange:" + _loc2_);
   }
   if(_loc2_.indexOf("_fantasy") != -1)
   {
      Panel.WatchPanel.TournamentPanel.SetFantasyScore(_loc2_);
   }
   if(_loc2_.indexOf("_pickem") != -1)
   {
      if(Panel.WatchPanel.TournamentPanel.Leaderboard._visible)
      {
         Panel.WatchPanel.TournamentPanel.Leaderboard.SetUpLister(_loc2_);
      }
   }
   if(_loc2_.indexOf("_cm") != -1)
   {
      if(Panel.JournalPanel.Journal.journalleaderboardscomp)
      {
         Panel.JournalPanel.Journal.journalleaderboardscomp.SetUpLister(_loc2_);
      }
      if(Panel.JournalPanel.Journal.BackPage.Page.BackPageContents.journalleaderboardscomp)
      {
         Panel.JournalPanel.Journal.BackPage.Page.BackPageContents.journalleaderboardscomp.SetUpLister(_loc2_);
      }
   }
   else
   {
      if(Panel.JournalPanel.Journal.journalleaderboardsop)
      {
         Panel.JournalPanel.Journal.journalleaderboardsop.SetUpLister(_loc2_);
      }
      if(Panel.JournalPanel.Journal.BackPage.Page.BackPageContents.journalleaderboardsop)
      {
         Panel.JournalPanel.Journal.BackPage.Page.BackPageContents.journalleaderboardsop.SetUpLister(_loc2_);
      }
   }
}
function ScaleformComponent_Streams_MyTwitchTvStateUpdate()
{
   Panel.WatchPanel.StreamsPanel.GetTwitchTvState();
}
function ScaleformComponent_Inventory_ModelPanelReady()
{
   trace("-----------------------------------------------------------ScaleformComponent_Inventory_ModelPanelReady----------");
   if(_global.LobbyMovie)
   {
      _global.LobbyMovie.LobbyPanel.Panels.InventoryPanel.Inventory.SetStickerSlotsInfo();
   }
   else
   {
      Panel.InventoryPanel.Inventory.SetStickerSlotsInfo();
   }
}
function ScaleformComponent_FriendsList_NameChanged()
{
   var _loc2_ = _global.MainMenuAPI.GetScaleformComponentEventParamString("ScaleformComponent_FriendsList_NameChanged","xuid");
   Panel.WatchPanel.MatchData.Scoreboard.UpdateScoreBoardNames(0);
   Panel.WatchPanel.MatchData.Scoreboard.UpdateScoreBoardNames(1);
}
function ScaleformComponent_MyPersona_InventoryUpdated()
{
   trace("------------------------------ScaleformComponent_MyPersona_InventoryUpdated()-------------------------------------");
   if(Panel.WatchPanel.TournamentPanel._visible)
   {
      var _loc3_ = _global.CScaleformComponent_News.GetActiveTournamentEventID();
      var _loc6_ = Panel.WatchPanel.TournamentPanel["Bracket" + _loc3_];
      var _loc4_ = _global.CScaleformComponent_Predictions.GetEventSectionsCount("tournament:" + _loc3_);
      var _loc5_ = _global.CScaleformComponent_MyPersona.GetXuid();
      if(Panel.WatchPanel.TournamentPanel.FantasyTeam._visible)
      {
         Panel.WatchPanel.TournamentPanel.UpdateRows();
      }
      else if(_loc6_._visible)
      {
         Panel.WatchPanel.TournamentPanel.SetUpStages(_loc3_,_loc4_,"tournament:" + _loc3_,_loc5_,false);
      }
   }
   if(CheckForUnacknowledgedItemsByType("campaign") > 0)
   {
      if(Panel.JournalPanel._visible)
      {
         Panel.JournalPanel.Journal.ReLoadVisiblePages();
      }
   }
   CheckForUnacknowlegedGameAlerts();
   InitMissionsPanelNewAcknowlegedMissions();
   if(_global.LobbyMovie)
   {
      var _loc2_ = _global.LobbyMovie.LobbyPanel.Panels.InventoryPanel;
      _global.LobbyMovie.LobbyPanel.Panels.PlayerProfile.RefreshAvatarImage();
      _global.LobbyMovie.LobbyPanel.Panels.FriendsListerPanel.RefreshAvatarImage();
      _global.LobbyMovie.LobbyPanel.Panels.PlayerProfile.SetJournalBtn();
   }
   else
   {
      _loc2_ = Panel.InventoryPanel;
      Panel.PlayerProfile.RefreshAvatarImage();
      Panel.FriendsListerPanel.RefreshAvatarImage();
      Panel.PlayerProfile.SetJournalBtn();
   }
   if(_loc2_.CanShowAcknowlegePanel())
   {
      _loc2_.InitInventoryPanelMaster();
   }
   else if(_loc2_.Inventory.IsInItemScroll() == false && !_loc2_.Inventory.ItemUsePanel._visible)
   {
      if(_loc2_.Inventory._visible)
      {
         _loc2_.Inventory.RefreshItemTiles();
      }
      if(_loc2_.Loadout._visible)
      {
         _loc2_.Loadout.RefreshLoadoutItemTiles();
      }
   }
   if(_loc2_.Inventory.IsInItemScroll() == false && !_loc2_.Crafting.IsWaitingForCraftingItem())
   {
      ShowNewItemAlert();
   }
   _loc2_.Inventory.CallbackStickerWearApplied();
   Panel.PlayerProfile.SetTeamPanel();
   Panel.PlayerProfile.SetElevatedStatusPanel();
   if(Panel.BannerPanel._visible && Panel.StoreListerPanel._visible == false)
   {
      Panel.BannerPanel.PlaceStoreTiles();
   }
}
function CheckForUnacknowlegedItems(strType)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemsCount();
   return _loc2_;
}
function CheckForUnacknowledgedItemsByType(strType)
{
   var _loc6_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemsCount();
   var _loc7_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc5_ = 0;
   if(_loc6_ > 0)
   {
      var _loc2_ = 0;
      while(_loc2_ < _loc6_)
      {
         var _loc3_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemByIndex(_loc2_);
         var _loc4_ = _global.CScaleformComponent_Inventory.GetItemTypeFromEnum(_loc3_);
         if(strType == _loc4_)
         {
            _global.CScaleformComponent_Inventory.AcknowledgeNewItembyItemID(_loc7_,_loc3_);
            _loc5_ = _loc5_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc5_;
   }
   return 0;
}
function InitMissionsPanelNewAcknowlegedMissions()
{
   if(_global.SinglePlayerMovie)
   {
      _global.SinglePlayerMovie.Panel.MissionsPanel.InitMissionsPanel(true);
   }
   else if(_global.LobbyMovie)
   {
      _global.LobbyMovie.LobbyPanel.Panels.MissionsPanel.InitMissionsPanel(true);
   }
   else
   {
      Panel.MissionsPanel.InitMissionsPanel(true);
   }
}
function CheckForUnacknowlegedGameAlerts()
{
   Panel.SelectPanel.ShowNewGameAlert();
}
function ShowNewItemAlert()
{
   var _loc1_ = CheckForUnacknowlegedItems();
   var _loc3_ = CheckForUnacknowledgedItemsByType("quest");
   var _loc2_ = CheckForUnacknowledgedItemsByType("coupon_crate");
   var _loc4_ = CheckForUnacknowledgedItemsByType("campaign");
   _loc1_ = _loc1_ - (_loc3_ + _loc2_ + _loc4_);
   if(_loc1_ > 0)
   {
      Panel.SelectPanel.ShowNewItemAlert();
   }
   else
   {
      Panel.SelectPanel.HideNewItemAlert();
   }
}
function ScaleformComponent_Inventory_CrateOpened()
{
   var _loc2_ = _global.MainMenuAPI.GetScaleformComponentEventParamString("ScaleformComponent_Inventory_CrateOpened","itemid");
   if(_global.LobbyMovie)
   {
      _global.LobbyMovie.LobbyPanel.Panels.InventoryPanel.Inventory.SetItemThatCameFromOpeningCrate(_loc2_);
      _global.LobbyMovie.LobbyPanel.Panels.InventoryPanel.Crafting.SetCraftedItem(_loc2_);
   }
   else
   {
      Panel.InventoryPanel.Inventory.SetItemThatCameFromOpeningCrate(_loc2_);
      Panel.InventoryPanel.Crafting.SetCraftedItem(_loc2_);
   }
}
function ScaleformComponent_Inventory_WeaponPreviewRequest()
{
   var _loc5_ = Panel.TooltipItemPreview;
   var _loc3_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc2_ = _global.MainMenuAPI.GetScaleformComponentEventParamString("ScaleformComponent_Inventory_WeaponPreviewRequest","itemid");
   var _loc8_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(_loc3_,_loc2_,"spraypaint");
   var _loc6_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(_loc3_,_loc2_,"spray");
   var _loc4_ = "";
   _loc5_.ShowHidePreview(false);
   if(_loc8_ || _loc6_)
   {
      _loc4_ = "vmt://spraypreview_" + _loc2_;
   }
   else
   {
      _loc4_ = "img://inventory_" + _loc2_;
   }
   var _loc7_ = _global.CScaleformComponent_Inventory.GetItemName(_loc3_,_loc2_);
   var _loc9_ = _global.CScaleformComponent_Inventory.GetItemRarityColor(_loc3_,_loc2_);
   _loc5_.ShowHidePreview(true,_loc7_,_loc9_);
   _loc5_.SetModel(_loc4_);
}
function ScaleformComponent_EmbeddedStream_VideoPlaying()
{
   Panel.StreamPanel.ShowStreamPanel();
}
function ScaleformComponent_EmbeddedStream_VolumeChanged()
{
   Panel.StreamPanel.SetVolumeFromExternalValue();
}
function ScaleformComponent_Blog_ShowBlog()
{
   blogActive = true;
   if(panelVisible)
   {
      ShowNews();
   }
}
function ScaleformComponent_Blog_HideBlog()
{
   blogActive = false;
   if(panelVisible)
   {
      ShowNews();
   }
}
function onLoaded()
{
   Panel.SelectPanel.InitSelectMenu();
   _global.resizeManager.doResize(true);
   gameAPI.OnReady();
   Panel.FriendsListerPanel.InitFriendsLister();
   Panel.PlayerProfile.InitPlayerProfile();
   Panel.Blog.InitBlog();
   Panel.StreamPanel.InitStream();
   Panel.Guides.InitGuides();
   Panel.BannerPanel.ShowPanel();
   Panel.OverwatchPanel.InitOverwatchPanel();
   InitWarningClientRestart();
   Panel.Warnings.GetWarnings();
   Panel.InventoryPanel._visible = false;
   Panel.InventoryPanel._x = Panel.InventoryPanel._x + 452;
   Panel.Guides._visible = false;
   Panel.BannerPanel._x = Panel.BannerPanel._x + 452;
   Panel.TooltipItem._visible = false;
   Panel.TooltipCampaign._visible = false;
   Panel.TooltipItemPreview._visible = false;
   Panel.TooltipContextMenu._visible = false;
   Panel.StoreListerPanel._visible = false;
   Panel.WatchPanel._visible = false;
   PlacePanelInCenterOfStage(Panel.WatchPanel,Panel.WatchPanel.Bg.width);
   Panel.MapVotePanel._visible = false;
   Panel.MapVotePanel.InitMapVotePanel();
   blogActive = true;
   ShowNews();
   EnableRightClick();
   _global.FrontEndBackgroundMovie.showBackground();
   _global.FrontEndBackgroundMovie.PlayFadeIn();
}
function PlacePanelInCenterOfStage(objPanel, numPanelBounds)
{
   objPanel._x = Stage.width / 2 + numPanelBounds / 2;
}
function InitWarningClientRestart()
{
   Panel.WarningsClientRestart.Panel._visible = _global.CScaleformComponent_News.IsNewClientAvailable();
}
function EnableRightClick()
{
   _global.KeyDownEvent = function(key, vkey, slot, binding)
   {
      Lib.SFKey.setKeyCode(key,vkey,slot,binding);
      var _loc2_ = Lib.SFKey.KeyName(Lib.SFKey.getKeyCode());
      if(_loc2_ == "MOUSE_RIGHT")
      {
         RightClickManager();
      }
      return _global.navManager.onKeyDown();
   };
}
function RightClickManager()
{
   var _loc3_ = Panel.InventoryPanel.Inventory;
   var _loc4_ = Panel.InventoryPanel.Loadout;
   var _loc5_ = Panel.InventoryPanel.Crafting;
   var _loc6_ = Panel.FriendsListerPanel;
   var _loc7_ = Panel.MissionsPanel;
   var _loc2_ = Panel.WatchPanel;
   if(Panel.MapVotePanel._visible)
   {
      return undefined;
   }
   if(_loc2_.hitTest(_root._xmouse,_root._ymouse,true) && _loc2_._visible == true)
   {
      if(_loc2_.Scoreboard._visible && _loc2_.objRightClick != null)
      {
         _loc2_.OpenContextMenu(_loc2_.objRightClick);
      }
      else if(_loc2_.StreamsPanel._visible == false && _loc2_.WatchPanel._visible == true && _loc2_.WatchPanel.objRightClick != null)
      {
         _loc2_.WatchPanel.OpenContextMenu(_loc2_.WatchPanel.objRightClick);
      }
      else if(_loc2_.StreamsPanel._visible == false && _loc2_.TournamentPanel._visible == true && _loc2_.TournamentPanel.objRightClick != null)
      {
         _loc2_.TournamentPanel.OpenContextMenu(_loc2_.TournamentPanel.objRightClick);
      }
   }
   else if(Panel.InventoryPanel.hitTest(_root._xmouse,_root._ymouse,true))
   {
      if(_loc3_._visible)
      {
         _loc3_.OpenContextMenu(_loc3_.m_objInvHoverSelection,true);
         _loc3_.FilterDropdown.HideList();
         _loc3_.SortDropdown.HideList();
      }
      else if(_loc4_._visible)
      {
         _loc4_.OpenLoadoutContextMenu(_loc4_.m_objLoadoutHoverSelection,true);
         _loc4_.SortDropdown.HideList();
      }
      else if(_loc5_._visible)
      {
         _loc5_.m_objCraftingHoverSelection.Action();
         _loc5_.SortDropdown.HideList();
      }
   }
   else if(_loc6_.objRightClick.hitTest(_root._xmouse,_root._ymouse,true))
   {
      _loc6_.OpenContextMenu(_loc6_.objRightClick);
   }
   else if(_loc7_.objRightClick.hitTest(_root._xmouse,_root._ymouse,true))
   {
      _loc7_.OpenContextMenu(_loc7_.objRightClick);
   }
}
function onLoadInit(movieClip)
{
   movieClip._x = avatarX;
   movieClip._y = avatarY;
   movieClip._width = avatarWidth;
   movieClip._height = avatarHeight;
}
function onUnload(mc)
{
   Panel.Blog.ShutdownBlog();
   Panel.StreamPanel.ShutdownStreamPanel();
   RemoveAllMainMenuNav();
   _global.tintManager.DeregisterAll(this);
   _global.MainMenuMovie = null;
   _global.MainMenuAPI = null;
   _global.resizeManager.RemoveListener(this);
   _global.resizeManager.RemoveListener(_global.FrontEndBackgroundMovie);
   unloadMovie(_global.FrontEndBackgroundMovie);
   delete _global.FrontEndBackgroundMovie;
   unloadMovie(_global.GrimeMovie);
   delete _global.GrimeMovie;
   return true;
}
function SetupNavDetectRollOvers()
{
   Panel.Blog.MouseOver.onRollOver = function()
   {
      SetMainMenuNav("Blog");
   };
   Panel.FriendsListerPanel.MouseOver.onRollOver = function()
   {
      SetMainMenuNav("Friends");
   };
   Panel.BannerPanel.MouseOver.onRollOver = function()
   {
      SetMainMenuNav("Default");
   };
   Panel.SelectPanel.MouseOver.onRollOver = function()
   {
      SetMainMenuNav("Default");
   };
   Panel.InventoryPanel.MouseOver.onRollOver = function()
   {
      SetMainMenuNav("Inv");
   };
}
function SetMainMenuNav(strNavToSet)
{
   if(m_CurrentNav != strNavToSet)
   {
      m_CurrentNav = strNavToSet;
      Panel.FriendsListerPanel.RemoveLayout();
      RemoveLayout();
      Panel.Blog.chrome_html_mc.RemoveLayout();
      Panel.Blog.MouseOver._visible = true;
      Panel.FriendsListerPanel.MouseOver._visible = true;
      Panel.BannerPanel.MouseOver._visible = true;
      Panel.SelectPanel.MouseOver._visible = true;
      Panel.InventoryPanel.MouseOver._visible = true;
      if(strNavToSet == "Blog" && Panel.StreamPanel._visible)
      {
         strNavToSet = "";
      }
      switch(strNavToSet)
      {
         case "Blog":
            Panel.Blog.chrome_html_mc.PushLayout();
            Panel.Blog.MouseOver._visible = false;
            trace("-----------------------------------------BLOGNAV");
            break;
         case "Friends":
            Panel.FriendsListerPanel.PushLayout();
            Panel.FriendsListerPanel.MouseOver._visible = false;
            trace("-----------------------------------------FRIENDSNAV");
            break;
         case "Inv":
            Panel.InventoryPanel.PushLayout();
            Panel.InventoryPanel.MouseOver._visible = false;
            trace("-----------------------------------------INVNAV");
            break;
         default:
            PushLayout();
            Panel.SelectPanel.MouseOver._visible = false;
            Panel.BannerPanel.MouseOver._visible = false;
            trace("-----------------------------------------DEFAULTNAV");
      }
   }
}
function PushLayout()
{
   _global.navManager.PushLayout(mainMenuNav,"mainMenuNav");
}
function RemoveLayout()
{
   _global.navManager.RemoveLayout(mainMenuNav);
}
function RemoveAllMainMenuNav()
{
   Panel.FriendsListerPanel.RemoveLayout();
   Panel.InventoryPanel.RemoveLayout();
   RemoveLayout();
   Panel.Blog.chrome_html_mc.RemoveLayout();
}
_global.MainMenuMovie = this;
_global.MainMenuAPI = gameAPI;
var avatarX = 0;
var avatarY = 0;
var avatarWidth = 55;
var avatarHeight = 55;
var numCalledFunction = 0;
var _avatarCache = undefined;
var blogActive = false;
var panelVisible = false;
var m_bAskedForLiveMatches = false;
var m_CurrentNav = "";
var m_aNotSavedFantasyTeam = new Array();
var mainMenuNav = new Lib.NavLayout();
Panel.JournalPanel._visible = false;
mainMenuNav.ShowCursor(true);
_global.resizeManager.AddListener(this);
stop();
