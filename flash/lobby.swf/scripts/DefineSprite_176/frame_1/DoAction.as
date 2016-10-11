function SetUpPanel()
{
   if(MessageBox._visible || m_SelectionPending)
   {
      return undefined;
   }
   ShowPanel();
   MessageBox._visible = false;
   BestOfOneLayout._visible = false;
   BestOfThreeLayout._visible = false;
   InitialPick._visible = false;
   SetUpInitalVote();
   Close.dialog = this;
   Close.Action = function()
   {
      HidePanel();
   };
}
function ShowPanel()
{
   this._visible = true;
}
function HidePanel()
{
   this._visible = false;
}
function SetUpInitalVote()
{
   var _loc2_ = _global.CScaleformComponent_MatchDraft.GetFirstVetoTeamID();
   CompteteText._visible = false;
   trace("------------------------------------------SetUpInitalVote:numStartTeamID----------------------" + _loc2_);
   if(_loc2_ == undefined)
   {
      return undefined;
   }
   if(_loc2_ == 0)
   {
      _loc2_ = _global.CScaleformComponent_MatchDraft.GetTeamID(0);
      SetUpInitalVotePanel(_loc2_);
   }
   else
   {
      ChooseTypeOfLayout();
   }
}
function SetUpInitalVotePanel(numStartTeamID)
{
   var _loc3_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamTagByID(g_strMyOfficialTournamentName,numStartTeamID);
   var _loc4_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamNameByID(g_strMyOfficialTournamentName,numStartTeamID);
   trace("------------------------------------------SetUpInitalVotePanel:strTeamTag----------------------" + _loc3_);
   trace("------------------------------------------SetUpInitalVotePanel:strName----------------------" + _loc4_);
   trace("------------------------------------------m_MyTeamID----------------------" + _global.CScaleformComponent_MyPersona.GetMyOfficialTeamID());
   trace("------------------------------------------numStartTeamID----------------------" + numStartTeamID);
   InitialPick._visible = true;
   InitialPick.Close._visible = false;
   if(_global.CScaleformComponent_MyPersona.GetMyOfficialTeamID() == numStartTeamID)
   {
      InitialPick.Spinner._visible = false;
      InitialPick.btnChooseBan._visible = true;
      InitialPick.btnChooseBan.setDisabled(false);
      InitialPick.btnChooseBan.dialog = this;
      InitialPick.btnChooseBan.SetText("#SFUI_Tournament_VetoFirst");
      InitialPick.btnChooseBan.Action = function()
      {
         SendInitalPick(numStartTeamID,false);
      };
      InitialPick.btnChoosePick._visible = true;
      InitialPick.btnChoosePick.setDisabled(false);
      InitialPick.btnChoosePick.dialog = this;
      InitialPick.btnChoosePick.SetText("#SFUI_Tournament_PickFirst");
      InitialPick.btnChoosePick.Action = function()
      {
         SendInitalPick(numStartTeamID,true);
      };
      var _loc5_ = _global.CScaleformComponent_MatchDraft.GetMapsCount();
      if(_loc5_ == 1)
      {
         InitialPick.Text.htmlText = "#SFUI_InitalPick_Maps_Picks_One";
      }
      else
      {
         InitialPick.Text.htmlText = "#SFUI_InitalPick_Maps_Picks_Three";
      }
   }
   else
   {
      InitialPick.Spinner._visible = true;
      InitialPick.btnChooseBan._visible = false;
      InitialPick.btnChoosePick._visible = false;
      InitialPick.Text.htmlText = "#SFUI_Tournament_Wait";
   }
}
function SendInitalPick(numStartTeamID, bHasChoosenToVetoFirst)
{
   if(bHasChoosenToVetoFirst)
   {
      _global.CScaleformComponent_MatchDraft.UploadFirstVetoTeamID(_global.CScaleformComponent_MyPersona.GetMyOfficialTeamID());
   }
   else
   {
      _global.CScaleformComponent_MatchDraft.UploadFirstVetoTeamID(_global.CScaleformComponent_MatchDraft.GetTeamID(1));
   }
   InitialPick.btnChooseBan.setDisabled(true);
   InitialPick.btnChoosePick.setDisabled(true);
}
function ChooseTypeOfLayout()
{
   var _loc2_ = _global.CScaleformComponent_MatchDraft.GetMapsCount();
   var _loc3_ = _global.CScaleformComponent_MatchDraft.GetDraftEntriesCount();
   trace("------------------------------------------numMapsCount----------------------" + _loc2_);
   trace("------------------------------------------numEntriesCount----------------------" + _loc3_);
   if(_loc2_ == 1)
   {
      BestOfOneLayout._visible = true;
      SetInitalStateForTiles(BestOfOneLayout,_loc3_);
   }
   else if(_loc2_ == 3)
   {
      BestOfThreeLayout._visible = true;
      SetInitalStateForTiles(BestOfThreeLayout,_loc3_);
   }
}
function SetInitalStateForTiles(objLayout, numEntriesCount)
{
   var _loc7_ = _global.CScaleformComponent_MatchDraft.GetDraftEntryActiveIndex();
   m_aSelectedMaps = [];
   if(_global.CScaleformComponent_MatchDraft.GetDraft() == "completed")
   {
      CompteteText._visible = true;
      _loc7_ = numEntriesCount;
   }
   trace("------------------------------------------numActiveIndex----------------------" + _loc7_);
   i = 0;
   while(i < numEntriesCount)
   {
      var _loc8_ = _global.CScaleformComponent_MatchDraft.GetDraftEntryType(i);
      var _loc6_ = _global.CScaleformComponent_MatchDraft.GetDraftEntryMap(i);
      var _loc3_ = _global.CScaleformComponent_MatchDraft.GetDraftEntryMapChoiceTeamID(i);
      var _loc9_ = _global.CScaleformComponent_MatchDraft.GetDraftEntryCTTeamID(i);
      var _loc4_ = _global.CScaleformComponent_MatchDraft.GetDraftEntryCTChoiceTeamID(i);
      m_aSelectedMaps.push(_loc6_);
      trace("------------------------------------------TileType----------------------" + _loc8_);
      trace("------------------------------------------strMapName----------------------" + _loc6_);
      trace("------------------------------------------numTeamID----------------------" + _loc3_);
      trace("------------------------------------------numCtTeamID----------------------" + _loc9_);
      trace("------------------------------------------numTeamPickingSideID--------------" + _loc4_);
      trace("------------------------------------------numActiveIndex----------------------" + _loc7_);
      var _loc2_ = objLayout["Tile" + i];
      if(_loc8_ == "veto")
      {
         trace("------------------------------------------TileType == veto----------------------");
         if(_loc3_ == 0 || _loc3_ == undefined)
         {
            var _loc10_ = "";
            _loc2_.Logo._visible = false;
         }
         else
         {
            var _loc5_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamTagByID(g_strMyOfficialTournamentName,_loc3_);
            _loc5_ = _loc5_.toLowerCase();
            _loc5_ = _loc5_ + ".png";
            trace("------------------------------------------TileType == ICON----------------------" + _loc5_);
            _loc2_.Logo._visible = true;
            LoadImage("econ/tournaments/teams/" + _loc5_,_loc2_.Logo,30,30);
         }
         SetUpVetoTile(_loc2_,_loc6_,_loc7_,_loc3_,i);
      }
      else
      {
         trace("------------------------------------------TileType == pick----------------------");
         if(_loc3_ == 0 || _loc3_ == undefined)
         {
            _loc10_ = "";
            _loc2_.Logo._visible = false;
         }
         else
         {
            _loc5_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamTagByID(g_strMyOfficialTournamentName,_loc3_);
            _loc5_ = _loc5_.toLowerCase();
            _loc5_ = _loc5_ + ".png";
            _loc2_.Logo._visible = true;
            LoadImage("econ/tournaments/teams/" + _loc5_,_loc2_.Logo,30,30);
         }
         if(_loc4_ == 0 || _loc4_ == undefined)
         {
            _loc10_ = "";
            _loc2_.LogoChooseTeam._visible = false;
            _loc2_.EmptyTeam._visible = true;
         }
         else
         {
            _loc5_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamTagByID(g_strMyOfficialTournamentName,_loc4_);
            _loc5_ = _loc5_.toLowerCase();
            _loc5_ = _loc5_ + ".png";
            _loc2_.LogoChooseTeam._visible = true;
            _loc2_.EmptyTeam._visible = false;
            LoadImage("econ/tournaments/teams/" + _loc5_,_loc2_.LogoChooseTeam,30,30);
         }
         SetUpPickTile(_loc2_,_loc6_,_loc7_,_loc3_,i);
         SetUpPickTileTeamSection(_loc2_,_loc9_,_loc7_,_loc4_,i);
      }
      i++;
   }
}
function SetUpVetoTile(objTile, strMapName, numActiveIndex, numTeamID, numIndex)
{
   trace("------------------------------------------SetUpVetoTile-objTile---------------------" + objTile);
   trace("------------------------------------------SetUpVetoTile-strMapName---------------------" + strMapName);
   trace("------------------------------------------SetUpVetoTile-numActiveIndex---------------------" + numActiveIndex);
   trace("------------------------------------------SetUpVetoTile-numTeamID---------------------" + numTeamID);
   trace("------------------------------------------SetUpVetoTile-numIndex---------------------" + numIndex);
   objTile.VetoedText._visible = false;
   objTile._numIndex = numIndex;
   objTile._type = "veto";
   objTile.Wait._visible = false;
   objTile.Wait.onRollOver = function()
   {
   };
   if(numTeamID != _global.CScaleformComponent_MyPersona.GetMyOfficialTeamID() && numActiveIndex == numIndex)
   {
      objTile.Wait._visible = true;
   }
   objTile.btnChoose._visible = true;
   objTile.btnVeto._visible = true;
   objTile.IconVeto._visible = false;
   objTile.MapSelection._visible = false;
   objTile.ActiveIcon._visible = false;
   objTile.btnChoose.dialog = this;
   objTile.btnChoose.SetText("#SFUI_Tournament_ChooseMap");
   objTile.btnChoose.Action = function()
   {
      ShowMessageBox(objTile);
   };
   _global.AutosizeTextDown(objTile.btnChoose.ButtonText.Text,6);
   objTile.btnVeto.dialog = this;
   objTile.btnVeto.SetText("#SFUI_Tournament_Veto");
   if(numActiveIndex == numIndex && strMapName == "")
   {
      objTile.ActiveIcon._visible = true;
      SetActiveEntry(objTile.btnVeto,objTile.btnChoose,objTile.Icon);
   }
   else if(numActiveIndex > numIndex && strMapName != "")
   {
      trace("------------------------------------------SetUpVetoTile-PAST---------------------");
      var _loc7_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + strMapName,"nameID"));
      objTile.btnVeto.setDisabled(true);
      objTile.btnChoose.setDisabled(true);
      objTile.btnVeto._visible = false;
      objTile.btnChoose._visible = false;
      objTile.IconVeto._visible = true;
      objTile.btnChoose._visible = false;
      objTile.btnConfirm._visible = false;
      AttachMapImage(objTile,strMapName);
      objTile.VetoedText._visible = true;
      var _loc8_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamNameByID(g_strMyOfficialTournamentName,numTeamID);
      var _loc4_ = _global.GameInterface.Translate("#SFUI_Tournament_Vetoed_Title");
      _loc4_ = _global.ConstructString(_loc4_,_loc8_,_loc7_);
      objTile.VetoedText.htmlText = _loc4_;
      objTile.VetoedText.textColor = "0x990000";
   }
   else
   {
      SetFutureEntires(objTile.btnVeto,objTile.btnChoose,objTile.VetoedText,"#SFUI_Tournament_Upcoming_Veto");
      objTile.Icon._visible = false;
   }
}
function SetUpPickTile(objTile, strMapName, numActiveIndex, numTeamID, numIndex)
{
   trace("------------------------------------------SetUpPickTile-objTile---------------------" + objTile);
   trace("------------------------------------------SetUpPickTile-strMapName---------------------" + strMapName);
   trace("------------------------------------------SetUpPickTile-numActiveIndex---------------------" + numActiveIndex);
   trace("------------------------------------------SetUpPickTile-numTeamID---------------------" + numTeamID);
   trace("------------------------------------------SetUpPickTile-numIndex---------------------" + numIndex);
   objTile._numIndex = numIndex;
   objTile._type = "pick";
   objTile.PickRandom._visible = false;
   objTile.PickedText._visible = false;
   objTile.IconCheck._visible = false;
   objTile.MapSelection._visible = false;
   objTile.ActiveIcon._visible = false;
   objTile.Wait._visible = false;
   objTile.Wait.onRollOver = function()
   {
   };
   if(numTeamID != _global.CScaleformComponent_MyPersona.GetMyOfficialTeamID() && numActiveIndex == numIndex && strMapName == "")
   {
      objTile.Wait._visible = true;
   }
   if(numIndex == 4)
   {
      objTile.btnChoose._visible = false;
      objTile.btnConfirm._visible = false;
   }
   else
   {
      objTile.btnChoose._visible = true;
      objTile.btnConfirm._visible = true;
   }
   objTile.btnChoose.dialog = this;
   objTile.btnChoose.SetText("#SFUI_Tournament_ChooseMapPick");
   objTile.btnChoose.Action = function()
   {
      ShowMessageBox(objTile);
   };
   _global.AutosizeTextDown(objTile.btnChoose.ButtonText.Text,6);
   objTile.btnConfirm.dialog = this;
   objTile.btnConfirm.SetText("#SFUI_Tournament_Pick");
   if(numActiveIndex == numIndex)
   {
      objTile.ActiveIcon._visible = true;
      if(strMapName == "")
      {
         SetActiveEntry(objTile.btnConfirm,objTile.btnChoose,objTile.Icon);
      }
      else if(strMapName != "" && numTeamID == 0)
      {
         var _loc7_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + strMapName,"nameID"));
         objTile.Wait._visible = false;
         AttachMapImage(objTile,strMapName);
         objTile.btnConfirm.setDisabled(true);
         objTile.btnChoose.setDisabled(true);
         objTile.btnChoose._visible = false;
         objTile.btnConfirm._visible = false;
         var _loc9_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamNameByID(g_strMyOfficialTournamentName,numTeamID);
         var _loc6_ = _global.GameInterface.Translate("#SFUI_Tournament_Map_Random");
         _loc6_ = _global.ConstructString(_loc6_,_loc7_);
         objTile.PickRandom.Text.htmlText = _loc6_;
         objTile.PickRandom._visible = true;
         objTile.IconCheck._visible = true;
      }
      else if(strMapName != "" && numTeamID != 0)
      {
         trace("------------------------------------------SetUpVetoTile-PAST---------------------");
         _loc7_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + strMapName,"nameID"));
         objTile.btnConfirm.setDisabled(true);
         objTile.btnChoose.setDisabled(true);
         objTile.IconCheck._visible = true;
         objTile.btnChoose._visible = false;
         objTile.btnConfirm._visible = false;
         AttachMapImage(objTile,strMapName);
         _loc9_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamNameByID(g_strMyOfficialTournamentName,numTeamID);
         _loc6_ = _global.GameInterface.Translate("#SFUI_Tournament_Picked_Title");
         _loc6_ = _global.ConstructString(_loc6_,_loc9_,_loc7_);
         objTile.PickedText._visible = true;
         objTile.PickedText.htmlText = _loc6_;
         _global.AutosizeTextDown(objTile.PickedText,10);
         objTile.PickedText.textColor = "0x4F7123";
      }
   }
   else if(numActiveIndex > numIndex && strMapName != "")
   {
      trace("------------------------------------------SetUpVetoTile-PAST---------------------");
      _loc7_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + strMapName,"nameID"));
      objTile.btnConfirm.setDisabled(true);
      objTile.btnChoose.setDisabled(true);
      objTile.IconCheck._visible = true;
      objTile.btnChoose._visible = false;
      objTile.btnConfirm._visible = false;
      AttachMapImage(objTile,strMapName);
      if(numTeamID == 0)
      {
         _loc6_ = _global.GameInterface.Translate("#SFUI_Tournament_Map_Random");
         _loc6_ = _global.ConstructString(_loc6_,_loc7_);
         objTile.PickRandom.Text.htmlText = _loc6_;
         objTile.PickRandom._visible = true;
      }
      else
      {
         _loc9_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamNameByID(g_strMyOfficialTournamentName,numTeamID);
         _loc6_ = _global.GameInterface.Translate("#SFUI_Tournament_Picked_Title");
         _loc6_ = _global.ConstructString(_loc6_,_loc9_,_loc7_);
         objTile.PickedText._visible = true;
         objTile.PickedText.htmlText = _loc6_;
         _global.AutosizeTextDown(objTile.PickedText,10);
         objTile.PickedText.textColor = "0x4F7123";
      }
   }
   else
   {
      SetFutureEntires(objTile.btnConfirm,objTile.btnChoose,objTile.PickedText,"#SFUI_Tournament_Upcoming_Pick");
      objTile.Icon._visible = false;
   }
}
function SetUpPickTileTeamSection(objTile, numCtTeamID, numActiveIndex, numTeamID, numIndex)
{
   objTile._numIndex = numIndex;
   objTile._type = "pick";
   objTile.btnChooseTeam._visible = true;
   objTile.btnConfirmTeam._visible = true;
   objTile.WaitTeam._visible = false;
   objTile.WaitTeam.onRollOver = function()
   {
   };
   if(numTeamID != _global.CScaleformComponent_MyPersona.GetMyOfficialTeamID() && numActiveIndex == numIndex && _global.CScaleformComponent_MatchDraft.GetDraftEntryMap(numIndex) != "")
   {
      objTile.WaitTeam._visible = true;
   }
   objTile.btnChooseTeam.dialog = this;
   objTile.btnChooseTeam.SetText("#SFUI_Tournament_Starting_Side");
   objTile.btnChooseTeam.Action = function()
   {
      ShowMessageBox(objTile,true);
   };
   _global.AutosizeTextDown(objTile.btnChooseTeam.ButtonText.Text,6);
   objTile.btnConfirmTeam.dialog = this;
   objTile.btnConfirmTeam.SetText("#SFUI_Tournament_Pick");
   objTile.TPatch._visible = false;
   objTile.CtPatch._visible = false;
   objTile.IconTeamCheck._visible = false;
   objTile.PickedTeamText._visible = false;
   objTile.TeamSelection._visible = false;
   objTile.ActiveIcon._visible = false;
   if(numActiveIndex == numIndex)
   {
      objTile.ActiveIcon._visible = true;
      var _loc6_ = _global.CScaleformComponent_MatchDraft.GetDraftEntryMap(i);
      if(numCtTeamID == 0 && numTeamID != 0 && (_loc6_ != "" && _loc6_ != undefined))
      {
         SetActiveEntry(objTile.btnConfirmTeam,objTile.btnChooseTeam,objTile.IconChooseTeam);
      }
      else
      {
         SetFutureEntires(objTile.btnConfirmTeam,objTile.btnChooseTeam,objTile.PickedTeamText,"#SFUI_Tournament_Upcoming_Side_Pick");
      }
   }
   else if(numActiveIndex > numIndex && numCtTeamID != 0)
   {
      objTile.btnConfirmTeam.setDisabled(true);
      objTile.btnChooseTeam.setDisabled(true);
      objTile.IconCheck._visible = true;
      objTile.btnChooseTeam._visible = false;
      objTile.btnConfirmTeam._visible = false;
      objTile.PickedTeamText._visible = true;
      var _loc10_ = _global.CScaleformComponent_CompetitiveMatch.GetTournamentTeamNameByID(g_strMyOfficialTournamentName,numTeamID);
      if(numCtTeamID == numTeamID)
      {
         var _loc8_ = _global.GameInterface.Translate("#counter-terrorists");
         objTile.CtPatch._visible = true;
      }
      else
      {
         _loc8_ = _global.GameInterface.Translate("#terrorists");
         objTile.TPatch._visible = true;
      }
      objTile.IconTeamCheck._visible = true;
      var _loc4_ = _global.GameInterface.Translate("#SFUI_Tournament_PickedTeam_Title");
      _loc4_ = _global.ConstructString(_loc4_,_loc10_,_loc8_);
      objTile.PickedTeamText.htmlText = _loc4_;
   }
   else
   {
      SetFutureEntires(objTile.btnConfirmTeam,objTile.btnChooseTeam,objTile.PickedTeamText,"#SFUI_Tournament_Upcoming_Side_Pick");
   }
}
function SetActiveEntry(btnConfirm, btnChoose, objIcon)
{
   btnConfirm.setDisabled(true);
   btnConfirm._visible = false;
   btnChoose.setDisabled(false);
   objIcon._visible = false;
}
function SetFutureEntires(btnConfrim, btnChoose, objText, srtText)
{
   btnConfrim.setDisabled(true);
   btnChoose.setDisabled(true);
   btnChoose._visible = false;
   btnConfrim._visible = false;
   objText._visible = true;
   objText.htmlText = srtText;
   objText.textColor = "0x141D28";
}
function AttachMapImage(objTile, strMapName)
{
   var _loc3_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + strMapName,"imagename");
   trace("------------------------------------------AttachMapImage---------------------" + _loc3_);
   objTile.Icon._visible = true;
   objTile.Icon.Image.attachMovie(_loc3_,"mapImage",1);
   objTile.Icon.Image._parent._width = 83;
   objTile.Icon.Image._parent._height = 45;
}
function LoadImage(imagePath, objImage, numWidth, numHeight)
{
   var _loc4_ = false;
   var _loc1_ = new Object();
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
   };
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc3_ = imagePath;
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc3_,objImage.Image);
}
function ShowMessageBox(objEntry, bIsPickTeam)
{
   var _loc7_ = 8;
   var _loc5_ = [];
   MessageBox._visible = true;
   MessageBox.Close;
   MessageBox.Close.dialog = this;
   MessageBox.Close.Action = function()
   {
      HideMessageBox();
   };
   MessageBox.Bg.onRollOver = function()
   {
   };
   MessageBox.Lister.ClickBlocker.onRollOver = function()
   {
   };
   if(bIsPickTeam)
   {
      _loc5_ = new Array("#counter-terrorists","#terrorists");
   }
   else
   {
      RemoveAlreadyPickedMaps();
      _loc5_ = m_aActiveMaps;
   }
   var _loc4_ = 0;
   while(_loc4_ < _loc7_)
   {
      var _loc3_ = MessageBox.Lister["btn" + _loc4_];
      trace("------------------------------------------------------arrToUse--------------------" + _loc5_);
      if(_loc4_ >= _loc5_.length)
      {
         _loc3_._visible = false;
      }
      else
      {
         _loc3_._visible = true;
         _loc3_.dialog = this;
         if(bIsPickTeam)
         {
            var _loc6_ = _global.GameInterface.Translate(_loc5_[_loc4_]);
            _loc3_.Action = function()
            {
               UpdateEntryWithTeamSelection(objEntry,this);
               HideMessageBox();
            };
         }
         else
         {
            _loc6_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + _loc5_[_loc4_],"nameID"));
            _loc3_.Action = function()
            {
               UpdateEntryWithSelection(objEntry,this);
               HideMessageBox();
            };
         }
         _loc3_.Selected._visible = false;
         _loc3_.setDisabled(false);
         _loc3_._Selction = _loc5_[_loc4_];
         _loc3_.ButtonText.Text.htmlText = _loc6_;
         _loc3_.ButtonText.Text.autoSize = "left";
      }
      _loc4_ = _loc4_ + 1;
   }
}
function RemoveAlreadyPickedMaps()
{
   var _loc2_ = 0;
   while(_loc2_ < m_aActiveMaps.length)
   {
      var _loc1_ = 0;
      while(_loc1_ < m_aSelectedMaps.length)
      {
         if(m_aActiveMaps[_loc2_] == m_aSelectedMaps[_loc1_])
         {
            _loc2_;
            m_aActiveMaps.splice(_loc2_--,1);
         }
         _loc1_ = _loc1_ + 1;
      }
      _loc2_ = _loc2_ + 1;
   }
}
function HideMessageBox()
{
   MessageBox._visible = false;
}
function UpdateEntryWithSelection(objEntry, objSelection)
{
   trace("------------------------------------UpdateEntryWithSelection---objEntry:" + objEntry);
   trace("------------------------------------UpdateEntryWithSelection---objSelection:" + objSelection);
   var _loc4_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + objSelection._Selction,"imagename");
   var _loc3_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + objSelection._Selction,"nameID"));
   m_SelectionPending = true;
   if(objEntry._type == "veto")
   {
      var _loc2_ = objEntry.btnVeto;
      _loc2_.SetText("#SFUI_Tournament_Veto");
   }
   else if(objEntry._type == "pick")
   {
      _loc2_ = objEntry.btnConfirm;
      _loc2_.SetText("#SFUI_Tournament_Pick");
   }
   _global.AutosizeTextDown(_loc2_.ButtonText.Text,6);
   _loc2_.setDisabled(false);
   _loc2_._visible = true;
   _loc2_.Action = function()
   {
      SetPickBan(objEntry,objSelection._Selction);
   };
   objEntry.btnChoose.SetText("#SFUI_Tournament_Change");
   objEntry.Icon._visible = true;
   objEntry.Icon.Image.attachMovie(_loc4_,"mapImage",1);
   objEntry.Icon.Image._parent._width = 83;
   objEntry.Icon.Image._parent._height = 45;
   objEntry.MapSelection._visible = true;
   objEntry.MapSelection.SelectedPickVeto.htmlText = _loc3_;
}
function UpdateEntryWithTeamSelection(objEntry, objSelection)
{
   m_SelectionPending = true;
   objEntry.btnConfirmTeam.SetText("#SFUI_Tournament_Pick");
   _global.AutosizeTextDown(objEntry.btnConfirmTeam.ButtonText.Text,6);
   objEntry.btnConfirmTeam.setDisabled(false);
   objEntry.btnConfirmTeam._visible = true;
   objEntry.btnConfirmTeam.Action = function()
   {
      SetTeamPick(objEntry,objSelection._Selction);
   };
   objEntry.btnChooseTeam.SetText("#SFUI_Tournament_Change");
   objEntry.CtPatch._visible = false;
   objEntry.TPatch._visible = false;
   if(objSelection._Selction == "#counter-terrorists")
   {
      objEntry.CtPatch._visible = true;
   }
   else
   {
      objEntry.TPatch._visible = true;
   }
   objEntry.TeamSelection._visible = true;
   objEntry.TeamSelection.SelectedPickVeto.htmlText = _global.GameInterface.Translate(objSelection._Selction);
}
function SetTeamPick(objEntry, Team)
{
   trace("------------------------------------UploadDraftEntryCTTeamID:" + Team);
   objEntry.btnConfirmTeam.setDisabled(true);
   objEntry.btnConfirmTeam.setDisabled(true);
   objEntry.btnChooseTeam.setDisabled(true);
   if(Team == "#counter-terrorists")
   {
      _global.CScaleformComponent_MatchDraft.UploadDraftEntryCTTeamID(objEntry._numIndex,_global.CScaleformComponent_MyPersona.GetMyOfficialTeamID());
   }
   else
   {
      var _loc3_ = _global.CScaleformComponent_MatchDraft.GetTeamID(0);
      var _loc4_ = _global.CScaleformComponent_MatchDraft.GetTeamID(1);
      if(_global.CScaleformComponent_MyPersona.GetMyOfficialTeamID() != _loc3_)
      {
         _global.CScaleformComponent_MatchDraft.UploadDraftEntryCTTeamID(objEntry._numIndex,_loc3_);
      }
      else
      {
         _global.CScaleformComponent_MatchDraft.UploadDraftEntryCTTeamID(objEntry._numIndex,_loc4_);
      }
   }
   m_SelectionPending = false;
}
function SetPickBan(objEntry, MapName)
{
   trace("------------------------------------UploadDraftEntryMap:" + MapName);
   objEntry.btnVeto.setDisabled(true);
   objEntry.btnConfirm.setDisabled(true);
   objEntry.btnChoose.setDisabled(true);
   _global.CScaleformComponent_MatchDraft.UploadDraftEntryMap(objEntry._numIndex,MapName);
   m_SelectionPending = false;
}
var m_FirstVetoTeamID = "";
var g_strMyOfficialTournamentName = _global.CScaleformComponent_MyPersona.GetMyOfficialTournamentName();
var ActiveMaps = _global.CScaleformComponent_GameTypes.GetMapGroupAttributeSubKeys("mg_active","maps");
var m_aActiveMaps = ActiveMaps.split(",");
var m_aSelectedMaps = [];
var m_SelectionPending = false;
MessageBox._visible = false;
BestOfOneLayout._visible = false;
BestOfThreeLayout._visible = false;
InitialPick._visible = false;
Bg.onRollOver = function()
{
};
