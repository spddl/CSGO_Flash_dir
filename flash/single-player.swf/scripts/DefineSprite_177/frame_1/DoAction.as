var PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var arrMapNames = new Array();
var arrImagePaths = new Array();
var arrWorkshopMapsInfo = new Array();
var arrListMapsNotDownloaded = new Array();
var arrListMapsToForServerCount = new Array();
var aFilterDropdown = new Array("all","sub_only","fav_only");
var aFilterSort = [];
var objSelectedButton = undefined;
var objOpenInOverlayButton = undefined;
var bIsWorkshopmap = false;
var bQueriedWorkshopMapSubscriptions = false;
var bQueriedMapsCurRefreshTimes = 0;
var nTotalWorkshopMapSubscriptions = 0;
var bIsCompetitive = false;
var m_bIsClassic = false;
var bIsMatchmaking = false;
var bIsTeamMode = false;
var bIsTrainingMode = false;
var bStartedGettingInfo = false;
var bIsHostageMap = false;
var bSingleButtonRefresh = false;
var m_bOwnsOperation = false;
var bOwnsCSGO = false;
var strMapsToLaunch = "";
var strSelectedMapName = "";
var numPageNumber = 1;
var strTagsForQuery = "";
var strFilterTextToSend = "";
var strFilterGameMode = "";
var strFilterUserInputText = "";
var numWorkshopMapsToDownload = 0;
var numPosStartForward = 0;
var numPosStarStartBack = 0;
var numMapDisplayCount = 0;
var MapTilesInfo = new Object();
var MAX_WORKSHOPMAP_REFRESH_TIMES = 25;
MapTilesInfo._TotalTiles = 30;
MapTilesInfo._SelectableTiles = 15;
MapTilesInfo._StartPos = MapChooser.MapTiles._x;
MapTilesInfo._EndPos = MapChooser.MapTiles._x - MapChooser.MapTiles._width / 2 - 5;
MapTilesInfo._PrevButton = ButtonPrev;
MapTilesInfo._NextButton = ButtonNext;
MapTilesInfo._AnimObject = MapChooser.MapTiles;
MapTilesInfo._PageCountObject = MapChooser.PageNumber.Text;
MapTilesInfo._m_numItems = 0;
MapTilesInfo._m_numTopItemTile = 0;
function AddFilterKeyHandlers(navFilter)
{
   navFilter.AddKeyHandlers({onDown:function(button, control, keycode)
   {
      _global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.executeFilter();
   }},"KEY_ENTER");
   navFilter.AddKeyHandlers({onDown:function(button, control, keycode)
   {
      _global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.HomeButtonPressed();
   }},"KEY_HOME");
   navFilter.AddKeyHandlers({onDown:function(button, control, keycode)
   {
      _global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.EndButtonPressed();
   }},"KEY_END");
   navFilter.AddKeyHandlers({onDown:function(button, control, keycode)
   {
      _global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.ShiftPressed();
      return true;
   },onUp:function(button, control, keycode)
   {
      _global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.ShiftReleased();
      return true;
   }},"KEY_LSHIFT","KEY_RSHIFT");
   navFilter.AddKeyHandlers({onDown:function(button, control, keycode)
   {
      _global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.filterStringTyped(String.fromCharCode(_global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.keyDelete));
   }},"KEY_DELETE");
   navFilter.onCharTyped = function(typed)
   {
      var _loc2_ = typed.charCodeAt(0);
      if(_loc2_ == _global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.keyBackquote)
      {
         return false;
      }
      if(_loc2_ == _global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.keyEscape)
      {
         return false;
      }
      if(_global.GameInterface.GetConvarNumber("console_window_open") == 0)
      {
         _global.navManager.SetHighlightedObject(_global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.FilterObject);
         _global.SinglePlayerMovie.Panel.Panel.ModeChooser.TabWorkshop.FilterPanel.filterStringTyped(typed);
         trace("---------->>onCharTyped" + typed);
         return true;
      }
      return false;
   };
}
function InitDialog()
{
   dialog.Init();
   InitNavModeSelect();
   InitWorkshopNavModeSelect();
   InitNavMapSelect();
   InitNavSelectBotDifficulty();
   InitSelectModePanel();
}
function onShow()
{
   SetUpMapButtonsActions();
   _global.SinglePlayerMovie.Panel.Tooltip._visible = false;
}
function SetTrainingMapDropdownFilter(strDropdownOption)
{
   trace("SetTrainingMapDropdownFilter: " + strDropdownOption);
   m_strFilterDropdown = strDropdownOption;
   SendWorkshopFilterData("custom","");
}
function SetTrainingMapDropdownSort(strDropdownOption)
{
   trace("SetTrainingMapDropdownSort: " + strDropdownOption);
   m_strSortDropdown = strDropdownOption;
   SendWorkshopFilterData("custom","");
}
function TrainingRefreshMapTiles()
{
   SendWorkshopFilterData("custom","");
}
function SetUpMapButtonsActions()
{
   bIsMatchmaking = _global.SinglePlayerMovie.Panel.Panel.dialog.GetUsingMatchmaking();
   bIsTeamMode = _global.SinglePlayerMovie.Panel.Panel.dialog.GetInTeamMode();
   bIsTrainingMode = _global.SinglePlayerMovie.Panel.Panel.dialog.GetInTrainingMode();
   trace("!!!!!!!!!!!!!!!!!!!!! IS TRAINING MODE = " + bIsTrainingMode);
   var _loc4_ = _global.CScaleformComponent_MyPersona.GetLicenseType();
   var _loc3_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
   if(_loc4_ == "purchased")
   {
      bOwnsCSGO = true;
   }
   Spinner._visible = false;
   ButtonPrev.dialog = this;
   ButtonPrev.actionSound = "PageScroll";
   ButtonPrev.Action = function()
   {
      this.dialog.onScrollBackward(MapTilesInfo,UpdateTiles);
   };
   ButtonNext.dialog = this;
   ButtonNext.actionSound = "PageScroll";
   ButtonNext.Action = function()
   {
      this.dialog.onScrollForward(MapTilesInfo,UpdateTiles);
   };
   if(bIsTrainingMode)
   {
      ModeChooser.TabWorkshop._visible = false;
      ModeChooser.TrainingTab._visible = true;
      ModeChooser.TabDefaultBtn._visible = false;
      ModeChooser.TabWorkshopBtn._visible = false;
      ModeChooser.TrainingTab.OpenWorkshop.dialog = this;
      ModeChooser.TrainingTab.OpenWorkshop.SetText("#SFUI_View_Maps_Workshop");
      ModeChooser.TrainingTab.OpenWorkshop.Action = function()
      {
         this.dialog.OpenWorkshopInOverlay();
      };
      ModeChooser.TrainingTab.RefreshWorkshop.dialog = this;
      ModeChooser.TrainingTab.RefreshWorkshop.SetText("#SFUI_Refresh_Workshop_Maps");
      ModeChooser.TrainingTab.RefreshWorkshop.Action = function()
      {
         this.dialog.RefreshWorkshopData();
      };
      ModeChooser.TrainingTab.FilterDropdown.SetUpDropDown(aFilterDropdown,"#SFUI_InvPanel_filter_title","#SFUI_InvPanel_filter_",this.SetTrainingMapDropdownFilter,m_strFilterDropdown);
      ModeChooser.TrainingTab.SortDropdown.SetUpDropDown(aFilterSort,"#SFUI_InvPanel_sort_title","#SFUI_InvPanel_sort_",this.SetTrainingMapDropdownSort,m_strSortDropdown);
      ModeChooser.TrainingTab.FilterCustomText.Init("#SFUI_InvPanel_filter_Text",15,this.RefreshItemTiles);
      ModeChooser.TrainingTab.FilterCustomText.EnableAutoExecuteTimer();
      FilterPanel._x = 113.25;
      FilterPanel._y = 141.6;
   }
   else
   {
      ModeChooser.TabWorkshop._visible = bIsWorkshopmap;
      ModeChooser.TrainingTab._visible = false;
      ModeChooser.TabDefaultBtn._visible = true;
      ModeChooser.TabWorkshopBtn._visible = true;
      ModeChooser.TabDefaultBtn.dialog = this;
      ModeChooser.TabDefaultBtn.type = "Default";
      ModeChooser.TabDefaultBtn.SetText("#SFUI_Maps_Offical_Title");
      ModeChooser.TabDefaultBtn.Action = function()
      {
         this.dialog.onSelectedTabButton(this);
      };
      ModeChooser.TabWorkshopBtn.dialog = this;
      ModeChooser.TabWorkshopBtn.type = "Workshop";
      ModeChooser.TabWorkshopBtn.SetText("#SFUI_Maps_Workshop_Title");
      ModeChooser.TabWorkshopBtn.Action = function()
      {
         this.dialog.onSelectedTabButton(this);
      };
      ModeChooser.TabWorkshop.RefreshWorkshop.dialog = this;
      ModeChooser.TabWorkshop.RefreshWorkshop.SetText("#SFUI_Refresh_Workshop_Maps");
      ModeChooser.TabWorkshop.RefreshWorkshop.Action = function()
      {
         this.dialog.RefreshWorkshopData();
      };
      ModeChooser.TabWorkshop.OpenWorkshop.dialog = this;
      ModeChooser.TabWorkshop.OpenWorkshop.SetText("#SFUI_View_Maps_Workshop");
      ModeChooser.TabWorkshop.OpenWorkshop.Action = function()
      {
         this.dialog.OpenWorkshopInOverlay();
      };
      if(bIsMatchmaking)
      {
         ModeChooser.TabWorkshop.DescText.htmlText = "#SFUI_Workshop_Desc";
      }
      else
      {
         ModeChooser.TabWorkshop.DescText.htmlText = "#SFUI_Workshop_Desc_Sp";
      }
      FilterPanel._x = 425;
      FilterPanel._y = 141.6;
   }
   NavigationMaster.PCButtons.UpsellPanel.Upsell.dialog = this;
   NavigationMaster.PCButtons.UpsellPanel.Upsell.SetText("#SFUI_MapSelect_Upsell_Season" + _loc3_);
   NavigationMaster.PCButtons.UpsellPanel.Upsell.Action = function()
   {
      this.dialog.OnPressedPlay();
   };
   OwnsOperation();
   SetUpMapTiles();
   NavigationMaster.PCButtons.ToLobbyButton._visible = false;
   MapChooser.PageNumber._visible = true;
   if(bIsMatchmaking && !bIsTeamMode)
   {
      ModeChooser.Title.htmlText = "#SFUI_Workshop_Online_Title";
   }
   else if(!bIsMatchmaking && !bIsTeamMode)
   {
      ModeChooser.Title.htmlText = "#SFUI_Workshop_Offline_Title";
   }
   else
   {
      ModeChooser.Title.htmlText = "#SFUI_SelectMode";
      NavigationMaster.PCButtons.ToLobbyButton.SetText("#SFUI_Back_To_Lobby");
      NavigationMaster.PCButtons.ToLobbyButton._visible = true;
      MapChooser.PageNumber._visible = false;
   }
   PanelNoWorkshopMaps.OpenWorkshop.dialog = this;
   PanelNoWorkshopMaps.OpenWorkshop.SetText("#SFUI_View_Maps_Workshop");
   PanelNoWorkshopMaps.OpenWorkshop.Action = function()
   {
      this.dialog.OpenWorkshopInOverlay();
   };
   MapChooser.MapInfoButton00.MapInOverlay.dialog = this;
   MapChooser.MapInfoButton00.MapInOverlay.Action = function()
   {
      this.dialog.OpenWorkshopInOverlay();
   };
   SetDefaultTab();
}
function SetDefaultTab()
{
   onSelectedTabButton(ModeChooser.TabDefaultBtn);
}
function OpenWorkshopInOverlay()
{
   if(_global.CScaleformComponent_SteamOverlay.IsEnabled())
   {
      _global.SinglePlayerAPI.ViewAllMapsInWorkshop();
   }
   else
   {
      _global.SinglePlayerMovie.Panel.Panel.dialog.InitErrorPanel(0);
   }
}
function OpenSelectedMapInWorkshop(button)
{
   if(_global.CScaleformComponent_SteamOverlay.IsEnabled())
   {
      var _loc3_ = button.PropertyMapIndex;
      var _loc2_ = arrWorkshopMapsInfo[_loc3_][0];
      _global.SinglePlayerAPI.ViewMapInWorkshop(_loc2_);
   }
   else
   {
      _global.SinglePlayerMovie.Panel.Panel.dialog.InitErrorPanel(0);
   }
}
function onSelectedTabButton(objTabButton)
{
   var _loc2_ = _global.SinglePlayerMovie.Panel.Panel.dialog;
   if(bIsTrainingMode == true || objTabButton.type == "Workshop")
   {
      if(bQueriedWorkshopMapSubscriptions == false)
      {
         var _loc4_ = _global.SinglePlayerAPI.QueryWorkshopMapSubscriptionsFromScript();
         if(_loc4_)
         {
            QueriedWorkshopMapRefreshInterval = setInterval(RefreshMapSubscriptionsAfterQuery,200);
         }
         else
         {
            nTotalWorkshopMapSubscriptions = _global.SinglePlayerAPI.ScriptGetTotalMapSubscriptions();
            bQueriedWorkshopMapSubscriptions = true;
         }
      }
      FilterPanel._visible = true;
      bIsWorkshopmap = true;
      ModeChooser.TabDefaultBtn.Selected._visible = false;
      ModeChooser.TabDefaultBtn.setDisabled(false);
      ModeChooser.TabWorkshopBtn._visible = true;
      _loc2_.OnSelectWorkshopMode(_loc2_.objSelectedWorkshopButton);
      _loc2_.UpdateNavSelection("Workshop");
      CheckSteamConnection();
      if(bIsMatchmaking && !bIsTeamMode)
      {
         NavigationMaster.PCButtons.PlayButton.SetText("#SFUI_Start_ListenServer_Workshop_Map");
      }
      else if(!bIsTeamMode)
      {
         NavigationMaster.PCButtons.PlayButton.SetText("#SFUI_GO");
      }
      else if(bIsTeamMode)
      {
         NavigationMaster.PCButtons.PlayButton.SetText("#SFUI_Accept");
      }
   }
   else
   {
      if(bIsTrainingMode == false)
      {
         bIsWorkshopmap = false;
      }
      FilterPanel._visible = false;
      ModeChooser.TabWorkshopBtn.Selected._visible = false;
      ModeChooser.TabWorkshopBtn.setDisabled(false);
      _loc2_.OnSelectMode(_loc2_.objSelectedButton);
      _loc2_.UpdateNavSelection("Default");
      if(!bIsTeamMode)
      {
         NavigationMaster.PCButtons.PlayButton.SetText("#SFUI_GO");
      }
      else
      {
         NavigationMaster.PCButtons.PlayButton.SetText("#SFUI_Accept");
      }
   }
   ShowOperationUpsell();
   objTabButton.Selected._visible = true;
   objTabButton.setDisabled(true);
   if(bIsTrainingMode)
   {
      ModeChooser.TabWorkshop._visible = false;
      ModeChooser.TrainingTab._visible = true;
      ModeChooser.TabDefault._visible = false;
      ModeChooser.TabDefaultBtn._visible = false;
      ModeChooser.TabWorkshopBtn._visible = false;
   }
   else
   {
      ModeChooser.TabWorkshop._visible = bIsWorkshopmap;
      ModeChooser.TabDefault._visible = !bIsWorkshopmap;
   }
}
function RefreshMapSubscriptionsAfterQuery()
{
   RefreshWorkshopData();
   bQueriedMapsCurRefreshTimes++;
   nTotalWorkshopMapSubscriptions = _global.SinglePlayerAPI.ScriptGetTotalMapSubscriptions();
   if(arrWorkshopMapsInfo.length > nTotalWorkshopMapSubscriptions || bQueriedMapsCurRefreshTimes > MAX_WORKSHOPMAP_REFRESH_TIMES)
   {
      clearInterval(QueriedWorkshopMapRefreshInterval);
      bQueriedWorkshopMapSubscriptions = true;
   }
}
function onSelectedButton(button)
{
   UnselectButton();
   objSelectedButton = button;
   if(button.Steam._visible && button.Steam.hitTest(_root._xmouse,_root._ymouse,true))
   {
      OpenSelectedMapInWorkshop(button);
      UnselectButton();
      return undefined;
   }
   if(bIsCompetitive && bIsMatchmaking)
   {
      button.Selected._visible = false;
   }
   else
   {
      button.Selected._visible = true;
   }
   SetSelectedMapName(button);
}
function UnselectButton()
{
   if(objSelectedButton != undefined)
   {
      objSelectedButton.Selected._visible = false;
      objSelectedButton = undefined;
      strSelectedMapName = "";
      _global.SinglePlayerMovie.Panel.Panel.dialog.EnableDisablePlayButton();
   }
}
function SetSelectedMapName(button)
{
   if(bIsWorkshopmap)
   {
      var _loc3_ = button.PropertyMapIndex;
      strSelectedMapName = arrWorkshopMapsInfo[_loc3_][0];
      trace("------>Array sel:" + strSelectedMapName + button.PropertyMapName);
      UpdateCompetitiveMapList(button);
   }
   else
   {
      strSelectedMapName = button.PropertyMapName;
      UpdateCompetitiveMapList(button);
      trace("---------->Array sel:" + strSelectedMapName);
   }
   _global.SinglePlayerMovie.Panel.Panel.dialog.EnableDisablePlayButton();
}
function UpdateCompetitiveMapList(button)
{
   if(bIsCompetitive && bIsMatchmaking)
   {
      if(!button.Check.Check._visible)
      {
         _global.SinglePlayerMovie.arrCheckedMapNames.push(strSelectedMapName);
         trace("---------->Array +:" + _global.SinglePlayerMovie.arrCheckedMapNames);
      }
      else if(button.Check.Check._visible)
      {
         i = 0;
         while(i < _global.SinglePlayerMovie.arrCheckedMapNames.length)
         {
            if(_global.SinglePlayerMovie.arrCheckedMapNames[i] == strSelectedMapName)
            {
               _global.SinglePlayerMovie.arrCheckedMapNames.splice(i,1);
               trace("---------->Array -:" + _global.SinglePlayerMovie.arrCheckedMapNames);
            }
            i++;
         }
      }
      button.Check.Check._visible = !button.Check.Check._visible;
      _global.SinglePlayerMovie.bIsFirstChangeToCheckedDefaults = true;
   }
}
function GetGameModes()
{
   if(strFilterGameMode == "" || strFilterUserInputText != "")
   {
      var _loc6_ = objSelectedButton.PropertyMapIndex;
      var _loc5_ = arrWorkshopMapsInfo[_loc6_][4];
      var _loc2_ = [];
      var _loc4_ = [];
      var _loc3_ = new Array("AnyMode","Custom","Classic","Competitive","Demolition","Arms Race","Deathmatch");
      _loc2_ = _loc5_.split(",");
      if(_loc5_ != "" || _loc5_ != undefined)
      {
         i = 0;
         while(i <= _loc2_.length)
         {
            if(_loc2_[i] == "Classic")
            {
               _loc2_.splice(i + 1,0,"Competitive");
            }
            i++;
         }
         var i = 0;
         while(i < _loc3_.length)
         {
            var _loc1_ = 0;
            while(_loc1_ < _loc2_.length)
            {
               if(_loc3_[i] == _loc2_[_loc1_])
               {
                  _loc4_.push(_loc2_[_loc1_]);
               }
               _loc1_ = _loc1_ + 1;
            }
            i++;
         }
         if(bIsMatchmaking && _loc2_.length > 1)
         {
            _loc4_.splice(0,0,"AnyMode");
         }
      }
      return _loc4_;
   }
   return "";
}
function GetMapsToLaunch()
{
   if(bIsCompetitive && bIsMatchmaking)
   {
      strMapsToLaunch = _global.SinglePlayerMovie.arrCheckedMapNames.join();
   }
   else if(bIsWorkshopmap)
   {
      var _loc2_ = _global.SinglePlayerAPI.GetWorkshopMapPath(strSelectedMapName);
      strMapsToLaunch = _global.SinglePlayerAPI.GetWorkshopMapID(strSelectedMapName);
      strMapsToLaunch = strMapsToLaunch + "@" + _loc2_;
      trace("---------->strMapsToLaunch: " + strMapsToLaunch);
   }
   else
   {
      strMapsToLaunch = strSelectedMapName;
   }
   trace("---------->strMapsToLaunch: " + strMapsToLaunch);
   return strMapsToLaunch;
}
function RefreshWorkshopData()
{
   trace("RefreshWorkshopData()");
   SendWorkshopFilterData(strFilterGameMode,strFilterUserInputText);
}
function SendWorkshopFilterData(strGameMode, strTextFilter)
{
   strFilterUserInputText = strTextFilter;
   strFilterGameMode = strGameMode;
   if(strFilterGameMode == "" && strFilterUserInputText != "")
   {
      strFilterTextToSend = strFilterUserInputText;
   }
   else if(strFilterGameMode != "" && strFilterUserInputText == "")
   {
      strFilterTextToSend = strFilterGameMode;
   }
   else if(strFilterGameMode == "" && strFilterUserInputText == "")
   {
      strFilterTextToSend = "";
   }
   else
   {
      strFilterTextToSend = strFilterGameMode + "," + strFilterUserInputText;
   }
   var _loc2_ = _global.SinglePlayerAPI.FilterWorkshopMapsByTags(strFilterTextToSend);
   trace("---------->strFilterTextToSend: " + strFilterTextToSend);
   if(!_loc2_)
   {
      CheckMapsSubscribed();
   }
   else
   {
      Spinner._visible = false;
      PanelNoWorkshopMaps._visible = false;
   }
}
function CheckSteamConnection()
{
   var _loc2_ = _global.SinglePlayerAPI.EnumerateWorkshopMapsFailed();
   if(_loc2_)
   {
      _global.SinglePlayerMovie.Panel.Panel.dialog.InitErrorPanel(1);
   }
}
function SetUpMapTiles()
{
   var _loc2_ = 0;
   while(_loc2_ < MapTilesInfo._TotalTiles)
   {
      var _loc3_ = MapChooser.MapTiles["Tile" + _loc2_];
      _loc3_.Action = function()
      {
         onSelectedButton(this);
      };
      _loc3_.RolledOver = function()
      {
         rollOverToolTip(this,true,MapChooser.MapTiles);
      };
      _loc3_.RolledOut = function()
      {
         rollOverToolTip(this,false,MapChooser.MapTiles);
      };
      _loc2_ = _loc2_ + 1;
   }
}
function FillOutMapButtonInfo(TileNumber, ImageNumber)
{
   var _loc2_ = MapChooser.MapTiles["Tile" + TileNumber];
   var _loc7_ = arrWorkshopMapsInfo[MapIndex][12];
   _loc7_ = _loc7_ - 1;
   bIsCompetitive = _global.SinglePlayerMovie.Panel.Panel.dialog.GetIsGameModeCompetitive();
   m_bIsClassic = _global.SinglePlayerMovie.Panel.Panel.dialog.GetIsGameModeClassic();
   _loc2_.Steam._visible = false;
   _loc2_.Selected._visible = false;
   _loc2_.IconActive._visible = false;
   _loc2_.IconOperation._visible = false;
   _loc2_.AuthorName._visible = bIsWorkshopmap;
   _loc2_.RatingNumber._visible = bIsWorkshopmap;
   _loc2_.IconMission._visible = false;
   _loc2_.WaitTime._visible = bIsCompetitive && !bIsWorkshopmap && bIsMatchmaking;
   _loc2_.IconFavorite._visible = false;
   _loc2_.IconSubscribed._visible = false;
   if(!bIsWorkshopmap)
   {
      if(ImageNumber < 0 || ImageNumber > arrImagePaths.length || arrImagePaths[ImageNumber] == undefined || arrMapNames[ImageNumber] == "EMPTY")
      {
         _loc2_._visible = false;
      }
      else
      {
         HideDownloadingStatus(_loc2_);
         _loc2_.Selected._visible = false;
         _loc2_._visible = true;
         _loc2_.MapImage._visible = true;
         _loc2_.MapWorkshopImage._visible = false;
         _loc2_.MapIndex._visible = false;
         _loc2_.MapWorkshopImage.MapImagePlaceholder.unloadMovie();
         _loc2_.MapImage.MapImagePlaceholder.attachMovie(arrImagePaths[ImageNumber],"mapImage",1);
         _loc2_.MapImage.MapImagePlaceholder._parent._width = 115;
         _loc2_.MapImage.MapImagePlaceholder._parent._height = 70;
         var _loc4_ = arrMapNames[ImageNumber];
         _loc2_.PropertyMapName = _loc4_;
         _loc2_.PropertyTileIndex = TileNumber;
         _loc2_.MapName.Text.htmlText = MakeNiceMapName(_loc4_);
         _loc2_.UpVotes._visible = false;
         _loc2_.NewMapTag._visible = false;
         _loc2_.GamesAvailable._visible = false;
         _loc2_.StrikeMission._visible = false;
         PanelNoWorkshopMaps._visible = false;
         _loc2_.Check._visible = bIsCompetitive && !bIsWorkshopmap && bIsMatchmaking;
         _loc2_.Check.Check._visible = false;
         _loc2_.IconBomb._visible = IsBombMap(_loc4_);
         _loc2_.IconHostage._visible = IsHostageMap(_loc4_);
         ShowMapGroupTypeIcon(_loc4_,_loc2_);
         if(bIsMatchmaking)
         {
            ShowStrikeMission(_loc4_,_loc2_);
         }
         if(bIsCompetitive && !bIsWorkshopmap && bIsMatchmaking)
         {
            SetWaitTime(_loc2_,ImageNumber);
            SetCheckedCompetitiveMaps(_loc2_,ImageNumber);
         }
      }
   }
   else
   {
      if(ImageNumber < 0 || ImageNumber >= arrWorkshopMapsInfo.length)
      {
         _loc2_._visible = false;
      }
      else
      {
         var _loc5_ = arrWorkshopMapsInfo[ImageNumber][7];
         _loc2_.PropertyMapIndex = ImageNumber;
         _loc2_.PropertyTileIndex = TileNumber;
         _loc2_.PropertyMapName = arrWorkshopMapsInfo[ImageNumber][1];
         ShowMapGroupTypeIcon(arrWorkshopMapsInfo[ImageNumber][1],_loc2_);
         _loc2_._visible = true;
         _loc2_.Check._visible = false;
         _loc2_.MapImage._visible = false;
         _loc2_.GamesAvailable._visible = false;
         _loc2_.MapIndex._visible = false;
         _loc2_.IconBomb._visible = false;
         _loc2_.IconHostage._visible = false;
         _loc2_.StrikeMission._visible = false;
         _loc2_.NewMapTag._visible = arrWorkshopMapsInfo[ImageNumber][11];
         AddToListOfMapsForServerCount(_loc2_);
         HasMapDownloaded(_loc2_);
         SetWorkshopMapImage(_loc2_,ImageNumber);
         _loc2_.MapName.Text.htmlText = arrWorkshopMapsInfo[ImageNumber][1];
         _loc2_.AuthorName.Text.htmlText = arrWorkshopMapsInfo[ImageNumber][9];
         if(_loc5_ > 0 || _loc5_ == "" || _loc5_ == undefined)
         {
            _loc2_.UpVotes._visible = true;
            _loc2_.RatingNumber._visible = true;
            _loc2_.RatingNumber.Text.htmlText = _loc5_;
         }
         else if(_loc5_ == 0)
         {
            _loc2_.UpVotes._visible = false;
            _loc2_.RatingNumber._visible = false;
         }
      }
      if(TileNumber == MapTilesInfo._TotalTiles || MapTilesInfo._m_numItems <= MapTilesInfo._TotalTiles && ImageNumber == MapTilesInfo._m_numItems)
      {
         StartCheckingMapDownloadStatus();
         SendListOfMapsForServerCount();
      }
   }
}
function ShowNewMapsTag(MapTileButton)
{
   if(MapTileButton.PropertyMapName == "mg_de_overpass" || MapTileButton.PropertyMapName == "mg_de_cbble")
   {
      MapTileButton.NewMapTag._visible = true;
   }
}
function UpdateMissionIcon()
{
   var _loc5_ = 0;
   while(_loc5_ < MapTilesInfo._TotalTiles)
   {
      var _loc2_ = MapChooser.MapTiles["Tile" + _loc5_];
      var _loc3_ = IsMissionModeSelected();
      if(_loc3_ != "" && bIsMatchmaking)
      {
         var _loc4_ = _global.CScaleformComponent_Inventory.GetQuestMapGroup(PlayerXuid,_loc3_);
         trace("--------------------------MissionMapGroup-----------------------" + _loc4_);
         trace("--------------------------MapButton.PropertyMapName-----------------------" + _loc2_.PropertyMapName);
         if(_loc2_.PropertyMapName == _loc4_ || _loc4_ == "")
         {
            _loc2_.IconMission._visible = true;
            _loc2_._MissionID = _loc3_;
         }
         else
         {
            _loc2_.IconMission._visible = false;
            _loc2_._MissionID = "";
         }
      }
      else
      {
         _loc2_.IconMission._visible = false;
         _loc2_._MissionID = "";
      }
      _loc5_ = _loc5_ + 1;
   }
}
function IsMissionModeSelected()
{
   if(_global.SinglePlayerMovie.Panel.MissionsPanel._visible)
   {
      var _loc3_ = 0;
      while(_loc3_ < 2)
      {
         var _loc2_ = _global.SinglePlayerMovie.Panel.MissionsPanel.MissionsPanel.MissionDoc["Tile" + _loc3_]._GameMode;
         if(_loc2_ != "" || _loc2_ != null || _loc2_ != undefined)
         {
            if(_loc2_ == _global.SinglePlayerMovie.Panel.Panel.dialog.GetCurrentMode())
            {
               return _global.SinglePlayerMovie.Panel.MissionsPanel.MissionsPanel.MissionDoc["Tile" + _loc3_]._ItemID;
            }
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   return "";
}
function HasMapDownloaded(MapTileButton)
{
   var _loc2_ = MapTileButton.PropertyMapIndex;
   var _loc7_ = MapTileButton.PropertyTileIndex;
   var _loc4_ = 0;
   if(bQueriedWorkshopMapSubscriptions)
   {
      _loc4_ = _global.SinglePlayerAPI.GetWorkshopMapDownloadProgress(_loc2_);
   }
   var _loc5_ = MapTilesInfo._m_numItems;
   _loc5_ = _loc5_ - 1;
   if(_loc4_ < 1)
   {
      var _loc6_ = new Array();
      if(_loc2_ != undefined && _loc2_ != null)
      {
         arrListMapsNotDownloaded.push(MapTileButton);
      }
      ShowDownloadingStatus(MapTileButton);
   }
   else
   {
      HideDownloadingStatus(MapTileButton);
   }
}
function StartCheckingMapDownloadStatus()
{
   if(arrListMapsNotDownloaded.length > 0)
   {
      RefreshMapDownloadInterval = setInterval(RefreshMapDownloadStatus,200);
   }
}
function RefreshMapDownloadStatus()
{
   var _loc3_ = 0;
   while(_loc3_ < arrListMapsNotDownloaded.length)
   {
      var _loc2_ = arrListMapsNotDownloaded[_loc3_];
      var _loc5_ = _loc2_.PropertyMapIndex;
      var _loc6_ = _loc2_.PropertyTileIndex;
      var _loc4_ = 0;
      if(bQueriedWorkshopMapSubscriptions)
      {
         _loc4_ = _global.SinglePlayerAPI.GetWorkshopMapDownloadProgress(_loc5_);
      }
      if(_loc4_ == 1)
      {
         HideDownloadingStatus(_loc2_);
         RefreshWorkshopData();
      }
      _loc3_ = _loc3_ + 1;
   }
}
function ShowDownloadingStatus(MapTileButton)
{
   MapTileButton.setDisabled(true);
   MapTileButton.Downloading._visible = true;
   MapTileButton.Downloading.Spinner.play();
   MapTileButton.Selected._visible = false;
}
function HideDownloadingStatus(MapTileButton)
{
   MapTileButton.Selected._visible = false;
   MapTileButton.Downloading.Spinner.stop();
   MapTileButton.Downloading._visible = false;
   MapTileButton.setDisabled(false);
}
function SetWaitTime(MapButton, ImageNumber)
{
   var _loc3_ = _global.SinglePlayerAPI.GetQueuedMatchmakingTime(arrMapNames[ImageNumber]);
   if(_loc3_ != "")
   {
      var _loc2_ = "";
      MapButton.WaitTime._visible = true;
      _loc2_ = _global.GameInterface.Translate("#SFUI_Expected_Wait_time");
      _loc2_ = _global.ConstructString(_loc2_,_loc3_);
      MapButton.WaitTime.Text.text = _loc2_;
   }
   else
   {
      MapButton.WaitTime._visible = false;
   }
}
function SetCheckedCompetitiveMaps(MapButton, ImageNumber)
{
   MapButton.Check.Check._visible = false;
   i = 0;
   while(i < _global.SinglePlayerMovie.arrCheckedMapNames.length)
   {
      if(_global.SinglePlayerMovie.arrCheckedMapNames[i] == arrMapNames[ImageNumber])
      {
         MapButton.Check.Check._visible = true;
      }
      i++;
   }
}
function CheckMapsSubscribed(HasMaps)
{
   var _loc2_ = strFilterGameMode;
   ResetMapData();
   PanelNoWorkshopMaps._visible = true;
   if(strFilterUserInputText == "")
   {
      noMapsString = _global.GameInterface.Translate("#SFUI_No_Subscribed_Modes_Title");
      noMapsString = _global.ConstructString(noMapsString,strFilterGameMode);
      PanelNoWorkshopMaps.NoMapsText.Text.htmlText = noMapsString;
   }
   else
   {
      noMapsString = _global.GameInterface.Translate("#SFUI_No_Subscribed_Maps_Title");
      noMapsString = _global.ConstructString(noMapsString,_loc2_,strFilterUserInputText);
      PanelNoWorkshopMaps.NoMapsText.Text.htmlText = noMapsString;
   }
}
function OwnsOperation()
{
   var _loc2_ = _global.CScaleformComponent_MyPersona.GetMyMedalRankByType("7Operation$OperationCoin");
   if(_loc2_ >= 1)
   {
      m_bOwnsOperation = true;
   }
   else
   {
      m_bOwnsOperation = false;
   }
}
function GetActiveSeasonNumber()
{
   return _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
}
function ShowMapGroupTypeIcon(strMapGroupName, MapButton)
{
   var _loc3_ = GetMapGroupType(strMapGroupName,MapButton);
   var _loc4_ = undefined;
   if(_loc3_ == "" || _loc3_ == undefined || _loc3_ == null)
   {
      return undefined;
   }
   var _loc10_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
   var _loc2_ = _loc10_ + 1;
   if(_loc3_ == "op_op0" + _loc2_)
   {
      var _loc7_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(strMapGroupName,"show_medal_icon");
      _loc4_ = "econ/status_icons/operation_" + _loc2_ + "_bronze_small.png";
      if(_loc7_ != "" && bOwnsCSGO == true && bIsMatchmaking)
      {
         var _loc5_ = _global.CScaleformComponent_MyPersona.GetMyMedalRankByType(_loc7_);
         if(_loc5_ == 2)
         {
            _loc4_ = "econ/status_icons/operation_" + _loc2_ + "_bronze_small.png";
         }
         else if(_loc5_ == 3)
         {
            _loc4_ = "econ/status_icons/operation_" + _loc2_ + "_silver_small.png";
         }
         else if(_loc5_ == 4)
         {
            _loc4_ = "econ/status_icons/operation_" + _loc2_ + "_gold_small.png";
         }
      }
      MapButton.IconOperation._visible = true;
      var _loc8_ = new Object();
      _loc8_.onLoadInit = function(target_mc)
      {
         target_mc._width = 25;
         target_mc._height = 20;
         target_mc.forceSmoothing = true;
      };
      var _loc6_ = new MovieClipLoader();
      _loc6_.addListener(_loc8_);
      _loc6_.loadClip(_loc4_,MapButton.IconOperation.Logo);
   }
   else if(_loc3_ == "active")
   {
      MapButton.IconActive._visible = true;
   }
}
function ShowStrikeMission(MapGroup, MapButton)
{
   var _loc2_ = _global.SinglePlayerMovie.Panel.Panel.dialog.GetCurrentMode();
   trace("-----------------------------MissionMode--------------" + _loc2_);
   trace("-----------------------------MapGroup--------------" + MapGroup);
   if(ModeChooser.TabDefault["Alert" + _loc2_]._visible)
   {
      var _loc3_ = ModeChooser.TabDefault["Alert" + _loc2_];
      if(_loc3_._StrikeMissionMap == MapGroup)
      {
         MapButton.StrikeMission._visible = true;
         MapButton._StrikeMissionID = _loc3_._StrikeMissionID;
         LoadImage(MapButton.StrikeMission.Icon.Image,"images/ui_icons/global.png",12,12);
      }
   }
}
function ShowOperationUpsell()
{
   MapChooser.UpsellPanel._visible = false;
   return undefined;
}
function GetMapGroupType(strMapGroupName, MapButton)
{
   var _loc2_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(strMapGroupName,"grouptype");
   return _loc2_;
}
function OpenPurchasePanel()
{
   if(!m_bOwnsOperation && bOwnsCSGO == true)
   {
      _global.CScaleformComponent_Store.PurchaseItemWithStaticAttrValue("season access",GetActiveSeasonNumber());
   }
}
function SetWorkshopMapImage(MapButton, ImageNumber)
{
   var _loc1_ = new Object();
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("---------->Error loading image: " + errorCode + " [" + status + "]");
   };
   _loc1_.onLoadStart = function(target_mc)
   {
   };
   _loc1_.onLoadProgress = function(target_mc, numBytesLoaded, numBytesTotal)
   {
      var _loc1_ = numBytesLoaded / numBytesTotal * 100;
   };
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = 115;
      target_mc._height = 70;
   };
   var _loc4_ = "../../" + arrWorkshopMapsInfo[ImageNumber][10];
   if(MapButton.MapWorkshopImage.MapImagePlaceholder != undefined)
   {
      MapButton.MapWorkshopImage.MapImagePlaceholder.unloadMovie();
   }
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc4_,MapButton.MapWorkshopImage.MapImagePlaceholder);
   MapButton.MapWorkshopImage._visible = true;
}
function rollOverToolTip(button, bShow, objLocation)
{
   var _loc8_ = _global.SinglePlayerMovie.Panel.Tooltip;
   var _loc10_ = {x:button._x + button._width,y:button._y};
   _loc8_.Mission._visible = false;
   objLocation.localToGlobal(_loc10_);
   _loc8_._parent.globalToLocal(_loc10_);
   if(bIsWorkshopmap)
   {
      var _loc7_ = "";
      var _loc9_ = button.PropertyMapIndex;
      if(arrWorkshopMapsInfo[_loc9_][4] != "" && arrWorkshopMapsInfo[_loc9_][4] != undefined)
      {
         var _loc17_ = arrWorkshopMapsInfo[_loc9_][4].split(",");
         var _loc22_ = _loc17_.join("\n");
         _loc7_ = "<b><font color=\'#FFFFFF\'>" + _global.GameInterface.Translate("#SFUI_Map_Workshop_Modes_Title") + "</b></font>";
         _loc7_ = _loc7_ + "\n" + _loc22_;
      }
      else
      {
         _loc7_ = "";
      }
      var _loc21_ = arrWorkshopMapsInfo[_loc9_][2] + "\n\n" + _loc7_;
      var _loc15_ = arrWorkshopMapsInfo[_loc9_][1];
      button.Steam._visible = bShow;
      var _loc11_ = "";
   }
   else
   {
      var _loc18_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(button.PropertyMapName,"tooltipID");
      if(_loc18_ == "")
      {
         return undefined;
      }
      var _loc3_ = "";
      var _loc24_ = GetMapGroupType(button.PropertyMapName,button);
      _loc15_ = MakeNiceMapName(button.PropertyMapName);
      var _loc13_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttributeSubKeys(button.PropertyMapName,"maps");
      _loc21_ = "";
      _loc11_ = "";
      var _loc14_ = "";
      if(_loc13_ != "")
      {
         var _loc5_ = _loc13_.split(",");
         if(_loc5_.length <= 1)
         {
            _loc3_ = "";
         }
         else
         {
            var _loc2_ = 0;
            while(_loc2_ < _loc5_.length)
            {
               var _loc6_ = "";
               if(bIsCompetitive || m_bIsClassic)
               {
                  if(IsHostageMap("mg_" + _loc5_[_loc2_]))
                  {
                     _loc6_ = " (" + _global.GameInterface.Translate("#SFUI_HostageMap") + ")";
                  }
               }
               _loc3_ = _loc3_ + "- " + _global.GameInterface.Translate(MakeNiceMapName("mg_" + _loc5_[_loc2_])) + _loc6_ + "\n";
               _loc2_ = _loc2_ + 1;
            }
            _loc3_ = "<b><font color=\'#FFFFFF\'>" + _global.GameInterface.Translate("#SFUI_Maps_In_Group_Title") + "</b></font>" + "\n" + "<font color=\'#808080\'>" + _loc3_ + "</font>";
         }
      }
      else if(bIsCompetitive || m_bIsClassic)
      {
         _loc3_ = "<b><font color=\'#FFFFFF\'>" + _global.GameInterface.Translate("#SFUI_Map_Type_Title") + "</b></font>";
         if(IsBombMap(button.PropertyMapName))
         {
            _loc3_ = _loc3_ + "\n" + "- " + "<font color=\'#808080\'>" + _global.GameInterface.Translate("#SFUI_BombMap") + "</font>\n";
         }
         else if(IsHostageMap(button.PropertyMapName))
         {
            _loc3_ = _loc3_ + "\n" + "- " + "<font color=\'#808080\'>" + _global.GameInterface.Translate("#SFUI_HostageMap") + "</font>\n";
         }
      }
      else
      {
         _loc3_ = "";
      }
      _loc21_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute(button.PropertyMapName,"tooltipID"));
      if(_loc3_ != "")
      {
         _loc21_ = _loc21_ + "\n\n" + _loc3_;
      }
      if(button._MissionID != "" && button._MissionID != 0 && button._MissionID != undefined)
      {
         _loc11_ = "<b><font color=\'#FFFFFF\'>" + _global.GameInterface.Translate("#CSGO_Journal_Missions_Active") + "</b></font>" + "\n" + _global.CScaleformComponent_Inventory.GetItemDescription(PlayerXuid,button._MissionID);
      }
      else
      {
         _loc11_ = "";
      }
      if(button.StrikeMission._visible)
      {
         var _loc20_ = _global.GameInterface.Translate("#SFUI_Missions_Global_ToolTip");
         var _loc16_ = _global.CScaleformComponent_Inventory.GetItemDescription(PlayerXuid,button._StrikeMissionID,"default,-detailedinfo");
         var _loc19_ = _global.CScaleformComponent_Inventory.GetItemDescription(PlayerXuid,button._StrikeMissionID,"detailedinfo");
         var _loc12_ = _global.GameInterface.Translate("#SFUI_Missions_Title_Global_Time_Left");
         _loc12_ = _global.ConstructString(_loc12_,GetActiveGlobalMission(true));
         _loc14_ = _loc20_ + "\n\n" + "<b>" + _loc12_ + "</b>\n" + _loc16_ + "\n" + _loc19_;
      }
   }
   _loc8_.TooltipItemShowHide(bShow);
   _loc8_.TooltipMapInfo(_loc15_,_loc21_,_loc11_,_loc14_);
   _loc8_.TooltipMapLayout(_loc10_.x,_loc10_.y,button._width);
}
function RemoveOpenMapInOverlayBtn()
{
   t = 0;
   while(t <= MapTilesInfo._TotalTiles)
   {
      var _loc1_ = MapChooser.MapTiles["Tile" + t];
      if(_loc1_._parent.btnOpenMapOverlay)
      {
         removeMovieClip(_loc1_._parent.btnOpenMapOverlay);
      }
      t++;
   }
}
function SetWorkshopMapInfo(numIndex, strTitle, strDesc, strBspname, strGameModes, strTags, numScore, numUpvotes, numDownvotes, strAuthor, strImagePath, bMapWasUpdated, numMapsRequested)
{
   var _loc4_ = new Array();
   numMapsRequested = numMapsRequested - 1;
   var _loc5_ = 0;
   if(bQueriedWorkshopMapSubscriptions)
   {
      _loc5_ = _global.SinglePlayerAPI.GetWorkshopMapDownloadProgress(numIndex);
   }
   if(numIndex == 0)
   {
      if(bIsWorkshopmap)
      {
         ResetMapData();
      }
      PanelNoWorkshopMaps._visible = false;
   }
   _loc4_.push(numIndex,strTitle,strDesc,strBspname,strGameModes,strTags,numScore,numUpvotes,numDownvotes,strAuthor,strImagePath,bMapWasUpdated,numMapsRequested);
   arrWorkshopMapsInfo[numIndex] = _loc4_;
   if(numMapsRequested > MapTilesInfo._TotalTiles && numIndex == MapTilesInfo._TotalTiles || numMapsRequested <= MapTilesInfo._TotalTiles && numIndex == numMapsRequested)
   {
      if(bIsWorkshopmap)
      {
         UpdateTiles(numMapsRequested);
      }
   }
}
function ResetMapsToDownload()
{
   arrListMapsNotDownloaded = [];
   clearInterval(RefreshMapDownloadInterval);
}
function ResetMapData()
{
   ScrollReset(MapTilesInfo);
   arrWorkshopMapsInfo = [];
   bSingleButtonRefresh = false;
   UnselectButton();
   RemoveOpenMapInOverlayBtn();
   var _loc1_ = 0;
   while(_loc1_ <= MapTilesInfo._TotalTiles)
   {
      var _loc2_ = MapChooser.MapTiles["Tile" + _loc1_];
      _loc2_._visible = false;
      _loc1_ = _loc1_ + 1;
   }
}
function IsHostageMap(Name)
{
   if(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute(Name,"icontag") == "hostage")
   {
      return true;
   }
   return false;
}
function IsBombMap(Name)
{
   if(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute(Name,"icontag") == "bomb")
   {
      return true;
   }
   return false;
}
function MakeNiceMapName(Name)
{
   return _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(Name,"nameID");
}
function UpdateTiles(numWorkshopMapsRequested)
{
   ResetMapsToDownload();
   if(bIsWorkshopmap)
   {
      MapTilesInfo._m_numItems = arrWorkshopMapsInfo.length;
   }
   else
   {
      MapTilesInfo._m_numItems = arrImagePaths.length;
   }
   var _loc1_ = 0;
   while(_loc1_ < MapTilesInfo._TotalTiles)
   {
      FillOutMapButtonInfo(_loc1_,MapTilesInfo._m_numTopItemTile + _loc1_);
      UpdateMissionIcon();
      _loc1_ = _loc1_ + 1;
   }
   EnableDisableScrollButtons(MapTilesInfo);
   UpdatePageCount(MapTilesInfo);
}
function ResetAnimation()
{
   var mcMovie = MapChooser.MapButtonContainer;
   var SpeedOut = 0.7;
   mcMovie.onEnterFrame = function()
   {
      mcMovie._x = mcMovie._x + (numPosStartForward - mcMovie._x) * SpeedOut;
      if(mcMovie._x > numPosStartForward + 1)
      {
         mcMovie._x = numPosStartForward;
         delete mcMovie.onEnterFrame;
      }
   };
}
function AddToListOfMapsForServerCount(MapTileButton)
{
   var _loc2_ = MapTileButton.PropertyMapIndex;
   var _loc4_ = MapTileButton.PropertyTileIndex;
   var _loc3_ = _global.SinglePlayerAPI.GetWorkshopMapPath(Number(arrWorkshopMapsInfo[_loc2_][0]));
   arrListMapsToForServerCount.push(_loc3_);
}
function SendListOfMapsForServerCount()
{
   var _loc2_ = arrListMapsToForServerCount.join();
   _global.SinglePlayerAPI.DownloadCurrentGamesCount(strFilterGameMode,_loc2_);
   arrListMapsToForServerCount = [];
}
function DisplayMapsWithServerCount(strGameMode, strMapPath, numServers)
{
   var _loc3_ = 0;
   while(_loc3_ <= MapTilesInfo._TotalTiles)
   {
      var _loc2_ = MapChooser.MapTiles["Tile" + _loc3_];
      var _loc7_ = _loc2_.PropertyMapIndex;
      var _loc6_ = _global.SinglePlayerAPI.GetWorkshopMapPath(Number(arrWorkshopMapsInfo[_loc7_][0]));
      if(strMapPath == _loc6_)
      {
         if(numServers > 0)
         {
            if(numServers == 1)
            {
               var _loc4_ = _global.GameInterface.Translate("#SFUI_Workshop_Workshop_Game_Available");
            }
            else
            {
               _loc4_ = _global.GameInterface.Translate("#SFUI_Workshop_Workshop_Games_Available");
            }
            _loc4_ = _global.ConstructString(_loc4_,numServers);
            _loc2_.GamesAvailable.Text.text = _loc4_;
            _loc2_.GamesAvailable._visible = true;
         }
         else
         {
            _loc2_.GamesAvailable._visible = false;
         }
      }
      _loc3_ = _loc3_ + 1;
   }
}
function ShowGlobalMissionAlert()
{
   var _loc4_ = GetActiveGlobalMission();
   ModeChooser.TabDefault.Alertdeathmatch._visible = false;
   ModeChooser.TabDefault.Alertgungameprogressive._visible = false;
   ModeChooser.TabDefault.Alertgungametrbomb._visible = false;
   ModeChooser.TabDefault.Alertcasual._visible = false;
   ModeChooser.TabDefault.Alertcompetitive._visible = false;
   if(_loc4_ != 0 && _global.SinglePlayerMovie.Panel.Panel.dialog.GetUsingMatchmaking())
   {
      var _loc3_ = _global.CScaleformComponent_Inventory.GetQuestItemIDFromQuestID(Number(_loc4_));
      var _loc5_ = _global.CScaleformComponent_Inventory.GetQuestGameMode(PlayerXuid,_loc3_);
      var _loc2_ = ModeChooser.TabDefault["Alert" + _loc5_];
      _loc2_._visible = true;
      _loc2_._StrikeMissionID = _loc3_;
      _loc2_._StrikeMissionMap = _global.CScaleformComponent_Inventory.GetQuestMapGroup(PlayerXuid,_loc3_);
      LoadImage(_loc2_.Icon.Image,"images/ui_icons/global.png",12,12);
      new Lib.Tween(_loc2_,"_yscale",mx.transitions.easing.Strong.easeIn,0,100,1,true);
   }
}
function LoadImage(objMap, ImagePath, numWidth, numHeight)
{
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
      target_mc.forceSmoothing = true;
   };
   var _loc3_ = ImagePath;
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(_loc3_,objMap);
}
function GetActiveGlobalMission(bGetTime)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetActiveQuest();
   if(_loc2_ != "" && _loc2_ != null && _loc2_ != undefined)
   {
      var _loc3_ = _loc2_.split(",",2);
      if(bGetTime)
      {
         return _loc3_[1];
      }
      return _loc3_[0];
   }
   return 0;
}
function onHide()
{
   ResetMapsToDownload();
   _global.navManager.RemoveLayout(_global.navSelectMode);
   _global.navManager.RemoveLayout(_global.navSelectMap);
   _global.navManager.RemoveLayout(_global.navWorkshopSelectMode);
   _global.navManager.RemoveLayout(_global.navSelectBotDifficulty);
   _global.navManager.RemoveLayout(_global.navFilter);
   delete _global.navSelectMode;
   delete _global.navWorkshopSelectMode;
   delete _global.navSelectMap;
   delete _global.navSelectBotDifficulty;
   delete _global.navFilter;
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
if(_global.navSelectMode != undefined)
{
   return undefined;
}
var dialog = new MainUI.StartSinglePlayerDialog.SinglePlayerDialog(this);
var nStyle_SelectMode = 1;
var nStyle_SelectMap = 2;
var _nStyle = nStyle_SelectMode;
var navSelectMap = new Lib.NavLayout();
_global.navSelectMode = navSelectMap;
navSelectMap.ShowCursor(true);
navSelectMap.AddCancelKeyHandlers({onDown:function(button, control, keycode)
{
   if(_global.SinglePlayerMovie.Panel.Panel.dialog.botDiffEnabled)
   {
      _global.PauseMenuMovie.Panel.MainMenuNav.OnCloseLoadout();
   }
   else if(_global.SinglePlayerMovie.Panel.Panel.dialog.bModeSelectEnabled)
   {
      _global.SinglePlayerMovie.Panel.Panel.dialog.OnCancelModePanel();
   }
   else
   {
      _global.SinglePlayerMovie.hidePanel(true);
   }
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}});
stop();
