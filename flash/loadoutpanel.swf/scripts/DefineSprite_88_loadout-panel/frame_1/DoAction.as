function InitLoadoutPanel()
{
   ShowLoadout();
   GetLoadoutSortOptions();
   SetUpButtons();
   SetUpLoadoutItemButtons();
   SetupLoadoutScrollButtons();
   if(IsPauseMenuActive())
   {
      var _loc2_ = _global.PauseMenuAPI.GetTeamNumber();
      if(_loc2_ == 2)
      {
         m_strTeam = "t";
         TeamIcons.SwitchTeamsT._visible = true;
      }
      else
      {
         _loc2_ == 3;
      }
      m_strTeam = "ct";
      TeamIcons.SwitchTeamsT._visible = false;
   }
   SelectLoadoutCatagory(m_objSelectedCatagoryBtn,m_strCurrentCatagory,false);
   RefreshLoadoutItemTiles();
   Inventory.gotoAndPlay("StartAnim");
}
function ShowLoadout()
{
   this._visible = true;
   this._parent.AddKeyHandlersForTextFields("loadout");
   FilterCustomText.Init("#SFUI_InvPanel_filter_Text",15,this.RefreshLoadoutItemTiles);
   FilterCustomText.EnableAutoExecuteTimer();
}
function GetLoadoutSortOptions()
{
   var _loc4_ = _global.CScaleformComponent_Inventory.GetSortMethodsCount();
   aFilterLoadoutSort = [];
   var _loc2_ = 0;
   while(_loc2_ <= _loc4_ - 1)
   {
      var _loc3_ = _global.CScaleformComponent_Inventory.GetSortMethodByIndex(_loc2_);
      aFilterLoadoutSort.push(_loc3_);
      _loc2_ = _loc2_ + 1;
   }
}
function InitFromInventoryContextMenu(Team, WeaponCatagory, WeaponSlot)
{
   var _loc4_ = this[WeaponCatagory];
   ShowLoadout();
   GetLoadoutSortOptions();
   SetUpButtons();
   SetUpLoadoutItemButtons();
   SetupLoadoutScrollButtons();
   SetTeam(Team);
   SelectLoadoutCatagory(_loc4_,WeaponCatagory);
   var _loc2_ = 0;
   while(_loc2_ < NUM_TOTAL_WEDGES)
   {
      objWedge = Wedges["Wedge" + _loc2_];
      if(WeaponSlot == objWedge.EquipedWeapon.GetSlotID())
      {
         OnWeaponSlotPressed(objWedge);
      }
      _loc2_ = _loc2_ + 1;
   }
   RefreshLoadoutItemTiles();
}
function SetToolTipPaths(StrToolTipType)
{
   var _loc2_ = null;
   var _loc3_ = null;
   var _loc4_ = null;
   if(IsPauseMenuActive())
   {
      _loc2_ = _global.PauseMenuMovie.Panel.TooltipItemPreview;
      _loc3_ = _global.PauseMenuMovie.Panel.TooltipContextMenu;
      _loc4_ = _global.PauseMenuMovie.Panel.TooltipItem;
   }
   else
   {
      _loc2_ = _global.MainMenuMovie.Panel.TooltipItemPreview;
      _loc3_ = _global.MainMenuMovie.Panel.TooltipContextMenu;
      _loc4_ = _global.MainMenuMovie.Panel.TooltipItem;
   }
   if(StrToolTipType == "Context")
   {
      return _loc3_;
   }
   if(StrToolTipType == "Preview")
   {
      return _loc2_;
   }
   if(StrToolTipType == "ToolTip")
   {
      return _loc4_;
   }
}
function ResetLoadoutSettings()
{
   Wedges._visible = false;
   TeamIcons._visible = false;
   EquippedBothTeamsPanel._visible = false;
   MessageBox._visible = false;
   SpawningWarning._visible = false;
   m_objSelectedCatagoryBtn = secondary;
   m_strCurrentCatagory = "secondary";
   UnSelectLoadoutItem();
   ItemPreview._visible = false;
}
function SetupLoadoutScrollButtons()
{
   ButtonNext.actionSound = "PageScroll";
   ButtonNext.Action = function()
   {
      onScrollForward(LoadoutPanelInfo,RefreshLoadoutItemTiles);
   };
   ButtonPrev.actionSound = "PageScroll";
   ButtonPrev.Action = function()
   {
      onScrollBackward(LoadoutPanelInfo,RefreshLoadoutItemTiles);
   };
}
function SetUpButtons()
{
   TeamIcons.SwitchTeamsT.Action = function()
   {
      SetTeam("ct",false);
   };
   TeamIcons.SwitchTeamsCT.Action = function()
   {
      SetTeam("t",false);
   };
   secondary.dialog = this;
   secondary.SetText("#SFUI_InvPanel_filter_secondary");
   secondary.Selected._visible = false;
   secondary.Action = function()
   {
      this.dialog.SelectLoadoutCatagory(this,"secondary");
   };
   heavy.dialog = this;
   heavy.SetText("#SFUI_InvPanel_filter_heavy");
   heavy.Selected._visible = false;
   heavy.Action = function()
   {
      this.dialog.SelectLoadoutCatagory(this,"heavy");
   };
   smg.dialog = this;
   smg.SetText("#SFUI_InvPanel_filter_smg");
   smg.Selected._visible = false;
   smg.Action = function()
   {
      this.dialog.SelectLoadoutCatagory(this,"smg");
   };
   rifle.dialog = this;
   rifle.SetText("#SFUI_InvPanel_filter_rifle");
   rifle.Selected._visible = false;
   rifle.Action = function()
   {
      this.dialog.SelectLoadoutCatagory(this,"rifle");
   };
   melee.dialog = this;
   melee.SetText("#SFUI_InvPanel_filter_melee");
   melee.Selected._visible = false;
   melee.Action = function()
   {
      this.dialog.SelectLoadoutCatagory(this,"melee");
   };
   flair0.dialog = this;
   flair0.SetText("#SFUI_InvPanel_filter_flair0");
   flair0.Selected._visible = false;
   flair0.Action = function()
   {
      this.dialog.SelectLoadoutCatagory(this,"flair0");
   };
   musickit.dialog = this;
   musickit.SetText("#SFUI_InvPanel_filter_musickit");
   musickit.Selected._visible = false;
   musickit.Action = function()
   {
      this.dialog.SelectLoadoutCatagory(this,"musickit");
   };
   spray.dialog = this;
   spray.SetText("#SFUI_InvPanel_filter_spray");
   spray.Selected._visible = false;
   spray.Action = function()
   {
      this.dialog.SelectLoadoutCatagory(this,"spray");
   };
   SortDropdown.SetUpDropDown(aFilterLoadoutSort,"#SFUI_InvPanel_Sort_title","#SFUI_InvPanel_Sort_",this.SetLoadoutDropdownSort,m_strLoadoutSortDropdown);
   Bg.onRelease = function()
   {
      CanelSelectionClickTest();
   };
   Bg.onRollOver = function()
   {
   };
}
function SetTeam(strTeam)
{
   if(strTeam == "ct")
   {
      TeamIcons.SwitchTeamsCT._visible = true;
      TeamIcons.SwitchTeamsT._visible = false;
   }
   else if(strTeam == "t")
   {
      TeamIcons.SwitchTeamsCT._visible = false;
      TeamIcons.SwitchTeamsT._visible = true;
   }
   m_strTeam = strTeam;
   GetItemsForCatagory(m_strCurrentCatagory,false);
   RefreshLoadoutItemTiles();
}
function SelectLoadoutCatagory(objCatButton, strCatagory)
{
   m_objSelectedCatagoryBtn.Selected._visible = false;
   objCatButton.Selected._visible = true;
   UnSelectLoadoutItem();
   m_objSelectedCatagoryBtn = objCatButton;
   Wedges._visible = true;
   ItemPreview._visible = false;
   Hint._visible = false;
   TeamIcons._visible = false;
   var _loc2_ = 0;
   while(_loc2_ < NUM_TOTAL_WEDGES)
   {
      var _loc3_ = Wedges["Wedge" + _loc2_];
      _loc3_._visible = false;
      _loc2_ = _loc2_ + 1;
   }
   switch(strCatagory)
   {
      case "flair0":
         Wedges.Wedge6._visible = true;
         break;
      case "spray":
         Wedges.Wedge9._visible = true;
         HintText();
         break;
      case "musickit":
         Wedges.Wedge8._visible = true;
         break;
      case "melee":
         Wedges.Wedge7._visible = true;
         TeamIcons._visible = true;
         break;
      case "rifle":
         Wedges.Wedge0._visible = true;
         Wedges.Wedge1._visible = true;
         Wedges.Wedge2._visible = true;
         Wedges.Wedge3._visible = true;
         Wedges.Wedge4._visible = true;
         Wedges.Wedge5._visible = true;
         TeamIcons._visible = true;
      default:
         Wedges.Wedge0._visible = true;
         Wedges.Wedge1._visible = true;
         Wedges.Wedge2._visible = true;
         Wedges.Wedge3._visible = true;
         Wedges.Wedge4._visible = true;
         TeamIcons._visible = true;
   }
   _global.CScaleformComponent_Inventory.SetInventorySortAndFilters(m_PlayerXuid,aFilterSort[0],false,strCatagory);
   GetItemsForCatagory(strCatagory,false);
   ScrollReset(LoadoutPanelInfo);
   RefreshLoadoutItemTiles();
}
function GetItemsForCatagory(strCatagory, bInDragOntoCatMode)
{
   m_strCurrentCatagory = strCatagory;
   m_strLoadoutFilterDropdown = strCatagory;
   var _loc3_ = "";
   var _loc5_ = 0;
   if(strCatagory == "flair0" || strCatagory == "melee" || strCatagory == "musickit" || strCatagory == "spray")
   {
      switch(strCatagory)
      {
         case "flair0":
            var _loc2_ = Wedges.Wedge6;
            _loc3_ = "flair0";
            SetItemDataForWedge(_loc2_,_loc3_);
            break;
         case "musickit":
            _loc2_ = Wedges.Wedge8;
            _loc3_ = "musickit";
            SetItemDataForWedge(_loc2_,_loc3_);
            break;
         case "melee":
            _loc2_ = Wedges.Wedge7;
            _loc3_ = strCatagory;
            SetItemDataForWedge(_loc2_,_loc3_);
            break;
         case "spray":
            _loc2_ = Wedges.Wedge9;
            _loc3_ = "spray0";
            SetItemDataForWedge(_loc2_,_loc3_);
      }
      return undefined;
   }
   if(strCatagory == "rifle")
   {
      _loc5_ = 6;
   }
   else
   {
      _loc5_ = 5;
   }
   var _loc1_ = 0;
   while(_loc1_ < _loc5_)
   {
      _loc2_ = Wedges["Wedge" + _loc1_];
      _loc3_ = strCatagory + _loc1_;
      SetItemDataForWedge(_loc2_,_loc3_);
      _loc1_ = _loc1_ + 1;
   }
}
function HintText()
{
   Hint.htmlText = "#SFUI_spray_hint";
   Hint._visible = true;
}
function SetItemDataForWedge(objWedge, strWeaponSlot)
{
   SetItemDataForCatagory(objWedge,strWeaponSlot);
   SetUpWedgeButtonActions(objWedge);
}
function SetUpWedgeButtonActions(objWedge)
{
   objWedge.dialog = this;
   objWedge.Action = function()
   {
      this.dialog.OnWeaponSlotPressed(this);
   };
   if(objWedge.EquipedWeapon._IsEmpty == false)
   {
      objWedge.setDisabled(false);
      objWedge.EquipedWeapon._visible = true;
      objWedge.RolledOver = function()
      {
         this.dialog.ShowHideLoadoutToolTip(this.EquipedWeapon,true,this);
         m_objLoadoutHoverSelection = this.EquipedWeapon;
      };
      objWedge.RolledOut = function()
      {
         this.dialog.ShowHideLoadoutToolTip(this.EquipedWeapon,false,this);
         m_objLoadoutHoverSelection = null;
      };
   }
   else
   {
      objWedge.EquipedWeapon._visible = false;
      objWedge.setDisabled(true);
      objWedge.RolledOver = function()
      {
      };
      objWedge.RolledOut = function()
      {
      };
   }
}
function OnWeaponSlotPressed(objWedge)
{
   ItemPreview._visible = true;
   m_objSelectedWeaponSlotBtn.Selected._visible = false;
   m_objSelectedWeaponSlotBtn = objWedge;
   objWedge.Selected._visible = true;
   FadeInLoadout(m_objSelectedWeaponSlotBtn.Selected);
   ScrollReset(LoadoutPanelInfo);
   RefreshLoadoutItemTiles();
}
function FadeInLoadout(TargetMc)
{
   TargetMc._alpha = 0;
   TargetMc.onEnterFrame = function()
   {
      if(TargetMc._alpha < 100)
      {
         TargetMc._alpha = TargetMc._alpha + 40;
      }
      else
      {
         delete TargetMc.onEnterFrame;
      }
   };
}
function SetItemDataForCatagory(objWedge, strWeaponSlot)
{
   var _loc2_ = m_strTeam;
   if(objWedge != m_objSelectedWeaponSlotBtn)
   {
      objWedge.Selected._visible = false;
   }
   if(strWeaponSlot == "flair0" || strWeaponSlot == "musickit" || strWeaponSlot == "spray0")
   {
      _loc2_ = "noteam";
   }
   objWedge.EquipedWeapon.SetInfoForLoadoutItems(m_PlayerXuid,_loc2_,strWeaponSlot);
   objWedge.EquipedWeapon._visible = !objWedge.EquipedWeapon._IsEmpty;
   if(objWedge.EquipedWeapon.GetName() == "" || objWedge.EquipedWeapon.GetName() == undefined)
   {
      objWedge.EquipedWeapon.Name.ItemName.htmlText = "#SFUI_InvPanel_empty_slot";
   }
}
function OpenLoadoutContextMenu(objTarget, bRightClick)
{
   var _loc8_ = SetToolTipPaths("Context");
   var _loc14_ = {x:objTarget._x + objTarget._width,y:objTarget._y};
   var _loc5_ = [];
   var _loc3_ = [];
   var _loc11_ = "";
   var _loc7_ = objTarget.GetSlotID();
   if(m_strCurrentCatagory == "flair0")
   {
      if(objTarget._Type == "inventory")
      {
         _loc5_.push("preview");
         _loc3_.push("#SFUI_InvContextMenu_preview");
         if(objTarget.IsNoTeam() == false)
         {
            _loc5_.push("seperator");
            _loc3_.push("");
            _loc5_.push("flair");
            _loc3_.push("#SFUI_InvContextMenu_flair");
         }
      }
      else
      {
         objTarget.EquipedWeapon.GetName() == "" || objTarget.EquipedWeapon.GetName() == undefined;
      }
      _loc5_.push("Unequip");
      _loc3_.push("#SFUI_InvContextMenu_Unequip");
   }
   else if(m_strCurrentCatagory == "musickit")
   {
      if(objTarget._Type == "inventory")
      {
         _loc5_.push("preview");
         _loc3_.push("#SFUI_InvContextMenu_preview");
         if(objTarget.IsNoTeam() == false)
         {
            _loc5_.push("seperator");
            _loc3_.push("");
            _loc5_.push("musickit");
            _loc3_.push("#SFUI_InvContextMenu_musickit");
         }
      }
   }
   else if(m_strCurrentCatagory == "spray")
   {
      if(objTarget._Type == "inventory")
      {
         _loc5_.push("preview");
         _loc3_.push("#SFUI_InvContextMenu_preview");
         if(objTarget.IsNoTeam() == false)
         {
            _loc5_.push("seperator");
            _loc3_.push("");
            _loc5_.push("spray");
            _loc3_.push("#SFUI_InvContextMenu_sprayequip");
         }
      }
   }
   else if(objTarget._Type == "inventory")
   {
      var _loc6_ = true;
      _loc5_.push("preview");
      _loc3_.push("#SFUI_InvContextMenu_preview");
      if(objTarget.GetTeam() == "#CSGO_Inventory_Team_CT" && objTarget.IsEquippedCT() == false)
      {
         if(_loc6_)
         {
            _loc5_.push("seperator");
            _loc3_.push("");
            _loc6_ = false;
         }
         var _loc9_ = GetItemToReplaceName("ct",_loc7_);
         _loc5_.push("ct");
         _loc3_.push(_loc9_);
      }
      else if(objTarget.GetTeam() == "#CSGO_Inventory_Team_T" && objTarget.IsEquippedT() == false)
      {
         _loc9_ = GetItemToReplaceName("t",_loc7_);
         if(_loc6_)
         {
            _loc5_.push("seperator");
            _loc3_.push("");
            _loc6_ = false;
         }
         _loc5_.push("t");
         _loc3_.push(_loc9_);
      }
      else if(objTarget.GetTeam() == "#CSGO_Inventory_Team_Any")
      {
         if(objTarget.IsEquippedT() == false && objTarget.IsEquippedCT() == false)
         {
            if(_loc6_)
            {
               _loc5_.push("seperator");
               _loc3_.push("");
               _loc6_ = false;
            }
            _loc5_.push("BothTeams");
            _loc3_.push("#SFUI_InvContextMenu_BothTeams");
         }
         if(objTarget.IsEquippedCT() == false)
         {
            if(_loc6_)
            {
               _loc5_.push("seperator");
               _loc3_.push("");
               _loc6_ = false;
            }
            _loc9_ = GetItemToReplaceName("ct",_loc7_);
            _loc5_.push("ct");
            _loc3_.push(_loc9_);
         }
         if(objTarget.IsEquippedT() == false)
         {
            if(_loc6_)
            {
               _loc5_.push("seperator");
               _loc3_.push("");
               _loc6_ = false;
            }
            _loc9_ = GetItemToReplaceName("t",_loc7_);
            _loc5_.push("t");
            _loc3_.push(_loc9_);
         }
      }
   }
   var _loc10_ = _global.CScaleformComponent_MyPersona.GetLauncherType() != "perfectworld"?false:true;
   if(objTarget._Type == "inventory" && _global.CScaleformComponent_Inventory.IsMarketable(m_PlayerXuid,objTarget._ItemID) && !_loc10_)
   {
      _loc5_.push("seperator");
      _loc3_.push("");
      _loc6_ = false;
      _loc5_.push("sell");
      _loc3_.push("#SFUI_InvContextMenu_sell");
   }
   _loc8_.TooltipShowHide(objTarget);
   _loc8_.TooltipLayout(_loc5_,_loc3_,objTarget,this.AssignLoadoutContextMenuAction);
   _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide();
}
function GetItemToReplaceName(team, strWeaponSlot)
{
   var _loc4_ = _global.CScaleformComponent_Loadout.GetItemID(m_PlayerXuid,team,strWeaponSlot.toString());
   var _loc3_ = _global.GameInterface.Translate("#SFUI_InvContextMenu_" + team);
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,_loc4_);
   var _loc5_ = _global.CScaleformComponent_Inventory.GetItemRarityColor(m_PlayerXuid,_loc4_);
   if(_loc2_ != "" && _loc2_ != undefined)
   {
      _loc3_ = _loc3_ + " " + "<font color=\'" + _loc5_ + "\'>" + _loc2_ + "</font>";
      return _loc3_;
   }
}
function AssignLoadoutContextMenuAction(strMenuItem, objFromInventory)
{
   switch(strMenuItem)
   {
      case "BothTeams":
         SwapWait(objFromInventory,true);
         break;
      case "Unequip":
         ResetToDefaultItem(objFromInventory);
         break;
      case "t":
         SetTeam("t",false);
         SwapWait(objFromInventory,false);
         break;
      case "ct":
         SetTeam("ct",false);
         SwapWait(objFromInventory,false);
         break;
      case "preview":
         previewLayoutItem(objFromInventory);
         var _loc4_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objFromInventory._ItemID,"spraypaint");
         var _loc3_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objFromInventory._ItemID,"spray");
         if(_loc4_ || _loc3_)
         {
            _global.CScaleformComponent_Inventory.PlayAudioFile("items/spraycan_spray.wav");
         }
         else
         {
            _global.navManager.PlayNavSound("InspectItem");
         }
         break;
      case "flair":
         SwapWait(objFromInventory,false);
         break;
      case "musickit":
         ShowMusicResetWarning(objFromInventory);
         break;
      case "sell":
         SellItemOnMarketPlace(objFromInventory);
         break;
      default:
         SwapWait(objFromInventory,false);
   }
}
function SellItemOnMarketPlace(objTargetTile)
{
   if(_global.CScaleformComponent_SteamOverlay.IsEnabled())
   {
      if(!_global.CScaleformComponent_Inventory.IsMarketable(m_PlayerXuid,objTargetTile._ItemID))
      {
      }
      _global.CScaleformComponent_Inventory.SellItem(m_PlayerXuid,objTargetTile._ItemID);
   }
}
function EquipFromInvContextMenu(objFromInventory, bBothTeams)
{
   SwapWait(objFromInventory,bBothTeams);
   clearInterval(EquipItemFromInvContextMenuInterval);
}
function previewLayoutItem(objTargetTile)
{
   var _loc3_ = SetToolTipPaths("Preview");
   var _loc5_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"musickit");
   var _loc6_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"musickit_default");
   var _loc4_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"spraypaint");
   _loc3_.ShowHidePreview(true,objTargetTile.GetName(),objTargetTile.GetRarityColor());
   if(_loc4_)
   {
      _loc3_.SetModel("vmt://spraypreview_" + objTargetTile._ItemID);
   }
   else if(_loc5_ || _loc6_)
   {
      _loc3_.SetModel(objTargetTile.GetDefaultItemModelPath());
      _loc3_.StartMusicPreview(objTargetTile._ItemID,m_PlayerXuid);
   }
   else
   {
      _loc3_.SetModel(objTargetTile.GetDefaultItemModelPath());
   }
}
function ShowMusicResetWarning(objFromInventory)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.TestMusicVolume();
   if(!_loc2_)
   {
      ShowMessageBox("ResetVolume",objFromInventory);
   }
   else
   {
      SwapWait(objFromInventory,false);
   }
}
function ShowMessageBox(Type, objFromInventory)
{
   MessageBox.gotoAndStop("Keyless");
   MessageBox.Delete._visible = false;
   MessageBox.Delete.setDisabled(false);
   MessageBox.Accept._visible = false;
   MessageBox.Accept.setDisabled(false);
   MessageBox.Close._visible = false;
   MessageBox.ImageTile._visible = false;
   MessageBox.Black.onRollOver = function()
   {
      trace("");
   };
   if((var _loc0_ = Type) === "ResetVolume")
   {
      MessageBox.gotoAndStop("Keyless");
      ResetVolumeMessageBox(objFromInventory);
   }
   MessageBox._visible = true;
   this._parent.HideShowBarButtons(false);
}
function ResetVolumeMessageBox(objFromInventory)
{
   MessageBox.Accept._visible = true;
   MessageBox.Accept.SetText("#SFUI_InvUse_Equip_MusicKit");
   MessageBox.Accept.Action = function()
   {
      OnResetVolume(objFromInventory);
   };
   trace("-----------------------------------objTargetTile-------------------------------------------" + objFromInventory);
   var _loc3_ = _global.GameInterface.Translate(objFromInventory.GetName());
   var _loc2_ = _global.GameInterface.Translate("#SFUI_InvUse_Reset_Volume_Warning");
   _loc2_ = _global.ConstructString(_loc2_,_loc3_);
   MessageBox.Close._visible = false;
   MessageBox.Text.htmlText = _loc2_;
   MessageBox.Close.Action = function()
   {
      MessageBox._visible = false;
   };
   MessageBox.ImageTile._visible = true;
   MessageBox.ImageTile.SetItemInfo(objFromInventory._ItemID,m_PlayerXuid,"ImageOnly");
}
function OnResetVolume(objFromInventory)
{
   trace("-----------------------------------objTargetTile-------------------------------------------" + objFromInventory);
   _global.CScaleformComponent_Loadout.EquipItemInSlot("noteam",objFromInventory._ItemID,"musickit");
   _global.CScaleformComponent_Inventory.SetDefaultMusicVolume();
   SwapWait(objFromInventory,false);
   CancelSelectionRefreshItems();
   MessageBox._visible = false;
}
function CloseMessageBox()
{
   MessageBox._visible = false;
   MessageBox.KeylessCaseOpen._visible = false;
   this._parent.HideShowBarButtons(true);
}
function SwapWait(objFromInventory, bBothTeams)
{
   var _loc3_ = objFromInventory.GetSlotID();
   var _loc1_ = null;
   var loop = 0;
   if(m_strCurrentCatagory == "melee")
   {
      _loc1_ = Wedges.Wedge7;
      if(_loc3_ == _loc1_.EquipedWeapon.GetSlotID())
      {
         _loc1_.EquipedWeapon.gotoAndPlay("StartAnim");
      }
   }
   else if(m_strCurrentCatagory == "flair0")
   {
      _loc1_ = Wedges.Wedge6;
      _loc1_.EquipedWeapon.gotoAndPlay("StartAnim");
   }
   else if(m_strCurrentCatagory == "musickit")
   {
      _loc1_ = Wedges.Wedge8;
      if(_loc3_ == _loc1_.EquipedWeapon.GetSlotID())
      {
         _loc1_.EquipedWeapon.gotoAndPlay("StartAnim");
      }
   }
   else if(m_strCurrentCatagory == "spray")
   {
      _loc1_ = Wedges.Wedge9;
      if(_loc3_ == _loc1_.EquipedWeapon.GetSlotID())
      {
         _loc1_.EquipedWeapon.gotoAndPlay("StartAnim");
      }
   }
   else if(m_strCurrentCatagory == "rifle")
   {
      numWedges = 6;
   }
   else
   {
      numWedges = 5;
   }
   var _loc2_ = 0;
   while(_loc2_ < numWedges)
   {
      _loc1_ = Wedges["Wedge" + _loc2_];
      if(_loc3_ == _loc1_.EquipedWeapon.GetSlotID())
      {
         _loc1_.EquipedWeapon.gotoAndPlay("StartAnim");
      }
      _loc2_ = _loc2_ + 1;
   }
   Wedges.onEnterFrame = function()
   {
      if(loop == 3)
      {
         SwapItem(objFromInventory,bBothTeams);
      }
      if(loop == 7)
      {
         delete Wedges.onEnterFrame;
      }
      loop++;
   };
}
function SwapItem(objFromInventory, bBothTeams)
{
   var _loc2_ = objFromInventory.GetSlotID();
   var _loc6_ = objFromInventory.GetItemType();
   var _loc5_ = objFromInventory.GetItemId();
   var _loc3_ = m_strTeam;
   if(_loc2_ == "flair0" || _loc2_ == "musickit" || _loc2_ == "spray0")
   {
      _loc3_ = "noteam";
   }
   _global.CScaleformComponent_Loadout.EquipItemInSlot(_loc3_,_loc5_,_loc2_.toString());
   trace("****Type:" + objFromInventory.GetItemType() + "****Slot:" + objFromInventory.GetSlotID() + "****Team:" + _loc3_ + "****ID:" + _loc5_ + "****SlotToGoIn:" + _loc2_ + "****Name:" + objFromInventory.GetName());
   if(bBothTeams)
   {
      if(m_strTeam == "ct")
      {
         _loc3_ = "t";
      }
      else
      {
         _loc3_ = "ct";
      }
      _global.CScaleformComponent_Loadout.EquipItemInSlot(_loc3_,_loc5_,_loc2_.toString());
      EquippedBothTeamsPanel._visible = true;
      EquippedBothTeamsPanel.gotoAndPlay("StartAnim");
      trace("**********Type:" + objFromInventory.GetItemType() + "**********Name:" + objFromInventory.GetSlotID() + "**********Team:" + _loc3_ + "**********ID:" + _loc5_ + "**********Slot:" + _loc2_);
   }
   CancelSelectionRefreshItems();
}
function PlayWeaponSlotAnims()
{
   var _loc1_ = 0;
   while(_loc1_ < NUM_TOTAL_WEDGES)
   {
      var _loc2_ = Wedges["Wedge" + _loc1_];
      _loc2_.EquipedWeapon.gotoAndPlay("StartAnim");
      _loc1_ = _loc1_ + 1;
   }
}
function ShowResetToDefaultItemButton(objSelectedItem)
{
   var _loc3_ = objSelectedItem.GetSlotID();
   var _loc2_ = m_strTeam;
   if(m_strCurrentCatagory == "flair0" || m_strCurrentCatagory == "musickit" || m_strCurrentCatagory == "spray0")
   {
      _loc2_ = "noteam";
   }
   var _loc4_ = _global.CScaleformComponent_Loadout.GetDefaultItem(m_PlayerXuid,_loc2_,_loc3_.toString());
   if(_loc4_ != objSelectedItem._ItemID && objSelectedItem._IsEmpty == false)
   {
      return true;
   }
   eles;
   return false;
}
function ResetToDefaultItem(ObjWedge)
{
   var _loc3_ = ObjWedge.GetSlotID();
   var _loc4_ = m_strTeam;
   if(m_strCurrentCatagory == "flair0" || m_strCurrentCatagory == "musickit" || m_strCurrentCatagory == "spray0")
   {
      _loc4_ = "noteam";
   }
   var _loc2_ = 0;
   while(_loc2_ < NUM_TOTAL_WEDGES)
   {
      objWedge = Wedges["Wedge" + _loc2_];
      if(_loc3_ == objWedge.EquipedWeapon.GetSlotID())
      {
         objWedge.EquipedWeapon.gotoAndPlay("StartAnim");
      }
      _loc2_ = _loc2_ + 1;
   }
   var _loc5_ = _global.CScaleformComponent_Loadout.GetDefaultItem(m_PlayerXuid,_loc4_,_loc3_.toString());
   trace("-----------------------------------------------ItemId------------------------------------" + _loc5_);
   _global.CScaleformComponent_Loadout.EquipItemInSlot(_loc4_,_loc5_,_loc3_.toString());
   CancelSelectionRefreshItems();
}
function ShowHideLoadoutToolTip(objTargetTile, bShow, objLocation)
{
   if(objTargetTile.GetName() == "" || objTargetTile.GetName() == undefined)
   {
      return undefined;
   }
   var _loc3_ = SetToolTipPaths("ToolTip");
   var _loc4_ = {x:objTargetTile._x + objTargetTile._width,y:objTargetTile._y};
   objLocation.localToGlobal(_loc4_);
   _loc3_._parent.globalToLocal(_loc4_);
   _loc3_.TooltipItemShowHide(bShow);
   if(bShow)
   {
      if(this._parent.m_MouseSpeed < 100)
      {
         _loc3_.gotoAndStop("Show");
      }
      _loc3_.TooltipItemGetInfo(objTargetTile._ItemXuid,objTargetTile._ItemID,objTargetTile.GetItemType());
      _loc3_.TooltipItemLayout(_loc4_.x,_loc4_.y,objTargetTile._width);
   }
}
function GetWeaponSlot(WedgeNum)
{
   if(m_strCurrentCatagory == "melee" || m_strCurrentCatagory == "flair0")
   {
      return m_strCurrentCatagory;
   }
   var _loc1_ = m_strCurrentCatagory + WedgeNum;
   return _loc1_;
}
function CancelSelectionRefreshItems()
{
   _global.CScaleformComponent_Loadout.CleanupDuplicateBaseItems(m_PlayerXuid,m_strTeam);
   GetItemsForCatagory(m_strCurrentCatagory,false);
   RefreshLoadoutItemTiles();
}
function UnSelectLoadoutItem()
{
   m_objSelectedWeaponSlotBtn.Selected._visible = false;
   m_objSelectedWeaponSlotBtn = null;
}
function BacktoCatSelect()
{
   UnSelectLoadoutItem();
   RefreshLoadoutItemTiles();
}
function CanelSelectionClickTest()
{
   var _loc4_ = Inventory;
   var _loc5_ = false;
   if(m_objSelectedWeaponSlotBtn != null)
   {
      var _loc2_ = 0;
      while(_loc2_ < NUM_TOTAL_WEDGES)
      {
         var _loc3_ = Wedges["Wedge" + _loc2_];
         if(!_loc3_.hitTest(_root._xmouse,_root._ymouse,true) && !_loc4_.hitTest(_root._xmouse,_root._ymouse,true))
         {
            bCancel = true;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(bCancel)
      {
         BacktoCatSelect();
      }
   }
}
function SetLoadoutDropdownSort(strDropdownOption)
{
   m_strLoadoutSortDropdown = strDropdownOption;
   ScrollReset(LoadoutPanelInfo);
   RefreshLoadoutItemTiles();
}
function SetUpLoadoutItemButtons()
{
   var _loc3_ = 0;
   while(_loc3_ <= LoadoutPanelInfo._TotalTiles)
   {
      var _loc2_ = Inventory["item" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         OpenLoadoutContextMenu(this,false);
      };
      _loc2_.RolledOver = function()
      {
         ShowHideLoadoutToolTip(this,true,Inventory);
         m_objLoadoutHoverSelection = this;
      };
      _loc2_.RolledOut = function()
      {
         ShowHideLoadoutToolTip(this,false,Inventory);
         m_objLoadoutHoverSelection = null;
      };
      _loc2_._Type = "inventory";
      _loc3_ = _loc3_ + 1;
   }
}
function SetCustomTextFilter()
{
   var _loc1_ = FilterCustomText.filterString;
   if(_loc1_ != "" && _loc1_ != undefined && _loc1_ != null)
   {
      _loc1_ = "@" + _loc1_;
   }
   else
   {
      _loc1_ = "";
   }
   return _loc1_;
}
function RefreshLoadoutItemTiles()
{
   var _loc3_ = m_strTeam;
   var _loc2_ = "";
   if(m_strCurrentCatagory == "flair0" || m_strCurrentCatagory == "spray")
   {
      _loc3_ = "noteam";
   }
   m_strLoadoutCustomFilterText = SetCustomTextFilter();
   if(m_objSelectedWeaponSlotBtn == null || m_objSelectedWeaponSlotBtn == undefined)
   {
      _loc3_ = "";
   }
   if(m_objSelectedWeaponSlotBtn != null)
   {
      _loc2_ = m_objSelectedWeaponSlotBtn.EquipedWeapon.GetSlotID();
   }
   else if(m_strCurrentCatagory == "spray")
   {
      _loc2_ = "item_definition:spraypaint";
   }
   else
   {
      _loc2_ = "";
   }
   m_PlayerXuid;
   m_objSortFilterSettings._strSort;
   m_objSortFilterSettings._bReverseSort;
   strFilter;
   m_strLoadoutFilterDropdown = _loc3_ + "," + "any_equipment" + "," + m_strCurrentCatagory + "," + _loc2_ + "," + m_strLoadoutCustomFilterText;
   trace("----------------------m_strLoadoutFilterDropdown--------------------" + m_strLoadoutFilterDropdown);
   _global.CScaleformComponent_Inventory.SetInventorySortAndFilters(m_PlayerXuid,m_strLoadoutSortDropdown,false,m_strLoadoutFilterDropdown);
   LoadoutPanelInfo._m_numItems = _global.CScaleformComponent_Inventory.GetInventoryCount();
   trace("----------------------LoadoutPanelInfo._m_numItems--------------------" + LoadoutPanelInfo._m_numItems);
   ItemCount.htmlText = LoadoutPanelInfo._m_numItems + " " + "Items";
   i = 0;
   while(i < LoadoutPanelInfo._TotalTiles)
   {
      SetDataLoadoutItemTiles(i,LoadoutPanelInfo._m_numTopItemTile + i);
      i++;
   }
   EnableDisableScrollButtons(LoadoutPanelInfo);
   UpdatePageCount(LoadoutPanelInfo);
}
function SetDataLoadoutItemTiles(numTile, numItemIndex, ItemId)
{
   var _loc2_ = Inventory["item" + numTile];
   var _loc3_ = _global.CScaleformComponent_Inventory.GetInventoryItemIDByIndex(numItemIndex);
   var _loc6_ = "";
   var _loc5_ = 0;
   if(numItemIndex < 0 || numItemIndex > LoadoutPanelInfo._m_numItems - 1 || _loc3_ == undefined || _loc3_ == "")
   {
      _loc2_._visible = false;
      return undefined;
   }
   _loc2_.SetItemInfo(_loc3_,m_PlayerXuid,"Inventory");
   _loc2_._visible = true;
}
function RefreshLoadoutItemImage()
{
   i = 0;
   while(i < LoadoutPanelInfo._TotalTiles)
   {
      var _loc1_ = Wedges["item" + numTile];
      _loc1_.RefreshItemImage();
      i++;
   }
}
function IsPauseMenuActive()
{
   if(_global.PauseMenuMovie)
   {
      return true;
   }
   return false;
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
var NUM_TOTAL_WEDGES = 10;
var m_strTeam = "ct";
var m_strCurrentCatagory = "";
var m_strLoadoutSortDropdown = "newest";
var m_strLoadoutFilterDropdown = "";
var m_strLoadoutCustomFilterText = "";
var m_objSelectedCatagoryBtn = null;
var m_objSelectedWeaponSlotBtn = null;
var m_objLoadoutHoverSelection = null;
var LoadoutPanelInfo = new Object();
LoadoutPanelInfo._TotalTiles = 12;
LoadoutPanelInfo._SelectableTiles = 6;
LoadoutPanelInfo._StartPos = Inventory._x;
LoadoutPanelInfo._EndPos = Inventory._x - Inventory._width / 2 - 22;
LoadoutPanelInfo._PrevButton = ButtonPrev;
LoadoutPanelInfo._NextButton = ButtonNext;
LoadoutPanelInfo._AnimObject = Inventory;
LoadoutPanelInfo._PageCountObject = PageCount;
LoadoutPanelInfo._m_numItems = 0;
LoadoutPanelInfo._m_numTopItemTile = 0;
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var aFilterLoadoutDropdown = new Array("all","heavy","secondary","rifle","smg","melee","grenade","flair0","spray","musickit","other");
var aFilterLoadoutSort = [];
TeamIcons.SwitchTeamsT._visible = false;
stop();
