function InitMapVotePanel()
{
   ResetMapData();
   trace("---------->InitMapVotePanel !!!!!!!!!!!!!!!!!!! ");
   this._visible = false;
   Panel.OKButton.dialog = this;
   Panel.OKButton.ButtonText.SetText("#SFUI_MainMenu_MapVote_SelectMaps");
   Panel.OKButton.setDisabled(true);
   Panel.OKButton.Action = function()
   {
      this.dialog.SubmitVote();
   };
   Panel.LaterButton.dialog = this;
   Panel.LaterButton.ButtonText.SetText("#SFUI_MainMenu_MapVote_RemindMeLater");
   Panel.LaterButton.setDisabled(false);
   Panel.LaterButton.Action = function()
   {
      this.dialog.ClosePanel();
   };
   Panel.DontVoteButton.dialog = this;
   Panel.DontVoteButton.ButtonText.SetText("#SFUI_MainMenu_MapVote_DontWantToVote");
   Panel.DontVoteButton.setDisabled(false);
   Panel.DontVoteButton.Action = function()
   {
      this.dialog.SubmitNoVote();
   };
   Panel.OpPaybackButton.dialog = this;
   Panel.OpPaybackButton.ButtonText.SetText("#SFUI_MainMenu_MapVote_Learn_OpPayback");
   Panel.OpPaybackButton.setDisabled(false);
   Panel.OpPaybackButton.Action = function()
   {
      this.dialog.OpenOpPaybackPage();
   };
   Panel.OpBravoButton.dialog = this;
   Panel.OpBravoButton.ButtonText.SetText("#SFUI_MainMenu_MapVote_Learn_OpBravo");
   Panel.OpBravoButton.setDisabled(false);
   Panel.OpBravoButton.Action = function()
   {
      this.dialog.OpenOpBravoPage();
   };
   if(HasVotedForMaps() == false)
   {
      ShowPanel();
   }
}
function SetUpCZUpdatePanel()
{
   CZMessagelPanel.OKButton.dialog = this;
   CZMessagelPanel.OKButton.ButtonText.SetText("#SFUI_MainMenu_CZUpdate_Ok");
   CZMessagelPanel.OKButton.setDisabled(false);
   CZMessagelPanel.OKButton.Action = function()
   {
      this.dialog.SubmitVoteCZUpdatePanel();
   };
   _global.AutosizeTextDown(CZMessagelPanel.Equip,8);
   ThankYouPanel.gotoAndStop("NoIcon");
   ThankYouPanel.Text.htmlText = "#SFUI_MainMenu_CZUpdate_Thanks";
   _global.AutosizeTextDown(ThankYouPanel.Text,10);
}
function ShowPanel(VoteType)
{
   Panel._visible = false;
   CZMessagelPanel._visible = false;
   if(this._visible)
   {
      return undefined;
   }
   if(VoteType == "MapVote")
   {
      SetUpMapTiles();
      Panel._visible = true;
   }
   else if(VoteType == "CZupdate")
   {
      SetUpCZUpdatePanel();
      CZMessagelPanel._visible = true;
   }
   this._visible = true;
   this.gotoAndPlay("Show");
   _global.MainMenuMovie.Panel.Blog.EnableInput(false);
   _global.MainMenuMovie.Panel.SelectPanel.MainMenuTopBar.AlertButton.setDisabled(true);
}
function ClosePanel()
{
   this._visible = false;
   _global.MainMenuMovie.Panel.Blog.EnableInput(true);
   onHide();
}
function SubmitNoVote()
{
   ClosePanel();
   _global.CScaleformComponent_News.SubmitMySurveyVote(20140122,1);
}
function SubmitVote()
{
   this.gotoAndPlay("Hide");
   var _loc3_ = GetVotedForMaps();
   _global.CScaleformComponent_News.SubmitMySurveyVote(20140122,_loc3_);
   onHide();
}
function SubmitVoteCZUpdatePanel()
{
   this.gotoAndPlay("Hide");
   _global.CScaleformComponent_News.SubmitMySurveyVote(20140900,0);
   onHide();
}
function OpenLoadoutToCZ()
{
   _global.MainMenuMovie.Panel.SelectPanel.onSelectedButton(_global.MainMenuMovie.Panel.SelectPanel.MainMenuTopBar.InventoryButton);
   _global.MainMenuMovie.Panel.InventoryPanel.onSelectTitleBarButton(_global.MainMenuMovie.Panel.InventoryPanel.LoadoutButton);
   _global.MainMenuMovie.Panel.InventoryPanel.Loadout.InitFromInventoryContextMenu("ct","secondary","secondary3");
}
function GetVotedForMaps()
{
   var _loc1_ = 0;
   i = 0;
   while(i < arrCheckedMapIDs.length)
   {
      _loc1_ = _loc1_ + arrCheckedMapIDs[i];
      i++;
   }
   trace("---------->nVotesToSend: " + _loc1_);
   return _loc1_;
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
      var _loc2_ = button.idx;
      _global.MainMenuAPI.ViewMapInWorkshop(_loc2_);
   }
   else
   {
      _global.SinglePlayerMovie.Panel.Panel.dialog.InitErrorPanel(0);
   }
}
function OpenOpPaybackPage()
{
   if(_global.CScaleformComponent_SteamOverlay.IsEnabled())
   {
      _global.CScaleformComponent_SteamOverlay.OpenURL("http://blog.counter-strike.net/operationpayback/");
   }
   else
   {
      _global.SinglePlayerMovie.Panel.Panel.dialog.InitErrorPanel(0);
   }
}
function OpenOpBravoPage()
{
   if(_global.CScaleformComponent_SteamOverlay.IsEnabled())
   {
      _global.CScaleformComponent_SteamOverlay.OpenURL("http://blog.counter-strike.net/operationbravo/");
   }
   else
   {
      _global.SinglePlayerMovie.Panel.Panel.dialog.InitErrorPanel(0);
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
   SetSelectedMapName(button);
}
function UnselectButton()
{
   if(objSelectedButton != undefined)
   {
      objSelectedButton.Selected._visible = false;
      objSelectedButton = undefined;
      arrCheckedMapIDsID = 0;
      _global.SinglePlayerMovie.Panel.Panel.dialog.EnableDisablePlayButton();
   }
}
function SetSelectedMapName(button)
{
   arrCheckedMapIDsID = button.VoteID;
   UpdateCompetitiveMapList(button);
   trace("---------->Array sel:" + arrCheckedMapIDsID);
}
function UpdateCompetitiveMapList(button)
{
   if(!button.Check.Check._visible)
   {
      arrCheckedMapIDs.push(arrCheckedMapIDsID);
      trace("---------->Array +:" + arrCheckedMapIDs);
   }
   else if(button.Check.Check._visible)
   {
      i = 0;
      while(i < arrCheckedMapIDs.length)
      {
         if(arrCheckedMapIDs[i] == arrCheckedMapIDsID)
         {
            arrCheckedMapIDs.splice(i,1);
            trace("---------->Array -:" + arrCheckedMapIDs);
         }
         i++;
      }
   }
   button.Check.Check._visible = !button.Check.Check._visible;
   if(arrCheckedMapIDs.length > 0)
   {
      Panel.OKButton.ButtonText.SetText("#SFUI_MainMenu_MapVote_SubmitSelection");
      Panel.OKButton.setDisabled(false);
   }
   else
   {
      Panel.OKButton.ButtonText.SetText("#SFUI_MainMenu_MapVote_SelectMaps");
      Panel.OKButton.setDisabled(true);
   }
}
function SetUpMapTiles()
{
   _global.AutosizeTextDown(ThankYouPanel.Text,10);
   ThankYouPanel.Text.htmlText = "#SFUI_MainMenu_MapVote_Thanks";
   ThankYouPanel.gotoAndStop("Icon");
   var _loc4_ = 0;
   while(_loc4_ < MapTileData.length)
   {
      var _loc3_ = Panel.MapTiles["Tile" + _loc4_];
      _loc3_.Action = function()
      {
         onSelectedButton(this);
      };
      _loc3_.RolledOver = function()
      {
         rollOverToolTip(this,true,Panel.MapTiles);
      };
      _loc3_.RolledOut = function()
      {
         rollOverToolTip(this,false,Panel.MapTiles);
      };
      _loc3_._visible = true;
      _loc3_.Check._visible = true;
      _loc3_.Check.Check._visible = false;
      _loc3_.IconBomb._visible = false;
      _loc3_.IconHostage._visible = false;
      _loc3_.Selected._visible = false;
      _loc3_.PropertyMapIndex = _loc4_;
      _loc3_.PropertyTileIndex = _loc4_;
      var _loc5_ = "map-" + MapTileData[_loc4_].mapname + "-overall";
      trace("---------->SetUpMapTiles:" + _loc5_);
      _loc3_.MapImage.MapImagePlaceholder.attachMovie(_loc5_,"mapImage",1);
      _loc3_.MapImage.MapImagePlaceholder._parent._width = 115;
      _loc3_.MapImage.MapImagePlaceholder._parent._height = 70;
      _loc3_.MapImage._visible = true;
      var _loc7_ = MapTileData[_loc4_].nameID;
      _loc3_.idx = MapTileData[_loc4_].idx;
      _loc3_.MapName.Text.htmlText = _global.GameInterface.Translate(_loc7_);
      var _loc6_ = MapTileData[_loc4_].mapname;
      _loc3_.PropertyMapName = _loc6_;
      _loc3_.VoteID = MapTileData[_loc4_].vote_id;
      var _loc8_ = MapTileData[_loc4_].icontag;
      if(_loc8_ == "hostage")
      {
         _loc3_.IconHostage._visible = true;
      }
      else
      {
         _loc3_.IconBomb._visible = true;
      }
      _loc4_ = _loc4_ + 1;
   }
}
function rollOverToolTip(button, bShow, objLocation)
{
   var _loc2_ = "";
   var _loc3_ = button.PropertyMapIndex;
   var _loc4_ = _global.MainMenuMovie.Panel.TooltipItemPreview;
   var _loc5_ = {x:button._x + button._width,y:button._y};
   objLocation.localToGlobal(_loc5_);
   _loc4_._parent.globalToLocal(_loc5_);
   if(arrWorkshopMapsInfo[_loc3_][4] != "" && arrWorkshopMapsInfo[_loc3_][4] != undefined)
   {
      var _loc8_ = arrWorkshopMapsInfo[_loc3_][4].split(",");
      var _loc10_ = _loc8_.join("\n");
      _loc2_ = "<b><font color=\'#FFFFFF\'>" + _global.GameInterface.Translate("#SFUI_Map_Workshop_Modes_Title") + "</b></font>";
      _loc2_ = _loc2_ + "\n" + _loc10_;
   }
   else
   {
      _loc2_ = "";
   }
   var _loc9_ = arrWorkshopMapsInfo[_loc3_][2] + "\n\n" + _loc2_;
   var _loc7_ = arrWorkshopMapsInfo[_loc3_][1];
   _loc4_.TooltipItemShowHide(bShow);
   _loc4_.TooltipMapInfo(_loc7_,_loc9_);
   _loc4_.TooltipMapLayout(_loc5_.x,_loc5_.y,button._width);
}
function ResetMapData()
{
   arrWorkshopMapsInfo = [];
   UnselectButton();
   var _loc1_ = 0;
   while(_loc1_ <= MapTilesInfo._TotalTiles)
   {
      var _loc2_ = Panel.MapTiles["Tile" + _loc1_];
      _loc2_._visible = false;
      _loc1_ = _loc1_ + 1;
   }
   Panel.OKButton.ButtonText.SetText("#SFUI_MainMenu_MapVote_SelectMaps");
   Panel.OKButton.setDisabled(true);
}
function onHide()
{
   if(Panel._visible)
   {
      ResetMapData();
   }
   _global.MainMenuMovie.CheckForUnacknowlegedGameAlerts();
}
var PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var arrCheckedMapIDs = new Array();
trace("---------->LOADING MAP VOTE PANEL !!!!!!!!!!!!!!!!!!! ");
var objSelectedButton = undefined;
var objOpenInOverlayButton = undefined;
var bIsWorkshopmap = false;
var bSingleButtonRefresh = false;
var bOwnsOperationPayback = false;
var arrCheckedMapIDsID = 0;
var numMapDisplayCount = 0;
var MapTilesInfo = new Object();
MapTilesInfo._TotalTiles = 15;
MapTilesInfo._SelectableTiles = 15;
MapTilesInfo._m_numItems = 0;
MapTilesInfo._m_numTopItemTile = 0;
var MapTileData = new Array();
var map_agency = new Object();
map_agency.mapname = "agency";
map_agency.nameID = "#SFUI_Map_cs_agency";
map_agency.idx = 174668691;
map_agency.icontag = "hostage";
map_agency.show_medal_icon = "Bravo";
map_agency.vote_id = 2;
MapTileData.push(map_agency);
var map_ali = new Object();
map_ali.mapname = "ali";
map_ali.nameID = "#SFUI_Map_de_ali";
map_ali.idx = 153370123;
map_ali.icontag = "bomb";
map_ali.show_medal_icon = "Bravo";
map_ali.vote_id = 4;
MapTileData.push(map_ali);
var map_cache = new Object();
map_cache.mapname = "cache";
map_cache.nameID = "#SFUI_Map_de_cache";
map_cache.idx = 163589843;
map_cache.icontag = "bomb";
map_cache.show_medal_icon = "Bravo";
map_cache.vote_id = 8;
MapTileData.push(map_cache);
var map_chinatown = new Object();
map_chinatown.mapname = "chinatown";
map_chinatown.nameID = "#SFUI_Map_de_chinatown";
map_chinatown.idx = 150267492;
map_chinatown.icontag = "bomb";
map_chinatown.show_medal_icon = "Bravo";
map_chinatown.vote_id = 16;
MapTileData.push(map_chinatown);
var map_downtown = new Object();
map_downtown.mapname = "downtown";
map_downtown.nameID = "#SFUI_Map_cs_downtown";
map_downtown.idx = 125689526;
map_downtown.icontag = "hostage";
map_downtown.show_medal_icon = "Payback";
map_downtown.vote_id = 32;
MapTileData.push(map_downtown);
var map_favela = new Object();
map_favela.mapname = "favela";
map_favela.nameID = "#SFUI_Map_de_favela";
map_favela.idx = 123518981;
map_favela.icontag = "bomb";
map_favela.show_medal_icon = "Payback";
map_favela.vote_id = 64;
MapTileData.push(map_favela);
var map_gwalior = new Object();
map_gwalior.mapname = "gwalior";
map_gwalior.nameID = "#SFUI_Map_de_gwalior";
map_gwalior.idx = 136819520;
map_gwalior.icontag = "bomb";
map_gwalior.show_medal_icon = "Bravo";
map_gwalior.vote_id = 128;
MapTileData.push(map_gwalior);
var map_library = new Object();
map_library.mapname = "library";
map_library.nameID = "#SFUI_Map_de_library";
map_library.idx = 128107346;
map_library.icontag = "bomb";
map_library.show_medal_icon = "Payback";
map_library.vote_id = 256;
MapTileData.push(map_library);
var map_motel = new Object();
map_motel.mapname = "motel";
map_motel.nameID = "#SFUI_Map_cs_motel";
map_motel.idx = 122439431;
map_motel.icontag = "hostage";
map_motel.show_medal_icon = "Payback";
map_motel.vote_id = 512;
MapTileData.push(map_motel);
var map_museum = new Object();
map_museum.mapname = "museum";
map_museum.nameID = "#SFUI_Map_cs_museum";
map_museum.idx = 127012360;
map_museum.icontag = "hostage";
map_museum.show_medal_icon = "Payback";
map_museum.vote_id = 1024;
MapTileData.push(map_museum);
var map_ruins = new Object();
map_ruins.mapname = "ruins";
map_ruins.nameID = "#SFUI_Map_de_ruins";
map_ruins.idx = 152827986;
map_ruins.icontag = "bomb";
map_ruins.show_medal_icon = "Bravo";
map_ruins.vote_id = 2048;
MapTileData.push(map_ruins);
var map_seaside = new Object();
map_seaside.mapname = "seaside";
map_seaside.nameID = "#SFUI_Map_de_seaside";
map_seaside.idx = 126446777;
map_seaside.icontag = "bomb";
map_seaside.show_medal_icon = "Bravo";
map_seaside.vote_id = 4096;
MapTileData.push(map_seaside);
var map_siege = new Object();
map_siege.mapname = "siege";
map_siege.nameID = "#SFUI_Map_cs_siege";
map_siege.idx = 125663769;
map_siege.icontag = "hostage";
map_siege.show_medal_icon = "Bravo";
map_siege.vote_id = 8192;
MapTileData.push(map_siege);
var map_thunder = new Object();
map_thunder.mapname = "thunder";
map_thunder.nameID = "#SFUI_Map_cs_thunder";
map_thunder.idx = 129816764;
map_thunder.icontag = "hostage";
map_thunder.show_medal_icon = "Payback";
map_thunder.vote_id = 16384;
MapTileData.push(map_thunder);
var navSelectMap = new Lib.NavLayout();
navSelectMap.ShowCursor(true);
stop();
