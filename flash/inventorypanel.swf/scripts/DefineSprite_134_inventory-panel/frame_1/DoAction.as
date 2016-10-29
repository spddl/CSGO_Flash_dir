function InitInventoryPanel()
{
   ShowInventory();
   GetSortOptions();
   SetupInventoryButtons();
   SetUpItemButtons();
   ItemsLayout.gotoAndPlay("StartAnim");
   if(m_bAskedForTournamentMatches == false)
   {
      var _loc2_ = _global.CScaleformComponent_News.GetActiveTournamentEventID();
      if(_loc2_ != 0 && _loc2_ != undefined)
      {
         var _loc3_ = "tournament:" + _loc2_;
         _global.CScaleformComponent_MatchList.Refresh(_loc3_);
      }
      m_bAskedForTournamentMatches = true;
   }
   RefreshItemTiles();
}
function ShowInventory()
{
   this._visible = true;
}
function GetSortOptions()
{
   var _loc4_ = _global.CScaleformComponent_Inventory.GetSortMethodsCount();
   aFilterSort = [];
   var _loc2_ = 0;
   while(_loc2_ <= _loc4_ - 1)
   {
      var _loc3_ = _global.CScaleformComponent_Inventory.GetSortMethodByIndex(_loc2_);
      aFilterSort.push(_loc3_);
      _loc2_ = _loc2_ + 1;
   }
}
function FadeIn(TargetMc)
{
   TargetMc._alpha = 0;
   ItemsLayout.onEnterFrame = function()
   {
      if(TargetMc._alpha < 100)
      {
         TargetMc._alpha = TargetMc._alpha + 18;
      }
      else
      {
         delete ItemsLayout.onEnterFrame;
      }
   };
}
function ResetSettings(bGiftOnly)
{
   m_OnlyGifts = bGiftOnly;
   objSelectedTitleButton = null;
   var _loc2_ = _global.CScaleformComponent_Inventory.GetSavedFilterMethod().split(",");
   m_strFilterDropdown = _loc2_[0];
   m_strSortDropdown = _global.CScaleformComponent_Inventory.GetSavedSortMethod();
   m_FilterEquippedItems = LoadDefaultItemsFlag(_loc2_);
   m_objCouponPreview._CouponID = "";
   m_objCouponPreview._InPreviewMode = false;
   FilterEquippedItems.Selected._visible = m_FilterEquippedItems;
   SortBg._visible = true;
   FilterBg._visible = true;
   m_bBuyingKey = false;
   m_bStopOnCrateItem = false;
   MessageBox._visible = false;
   ActionItemSelectPanel._visible = false;
   ItemUsePanel._visible = false;
   ItemUsePanel.Scroll._visible = false;
   MessageBox.KeylessCaseOpen._visible = false;
   ItemUsePanel.FakeRewardItem.SetItemInfo("","");
   SortDropdown._visible = true;
   FilterDropdown._visible = true;
   FilterEquippedItems._visible = true;
   FilterCustomText._visible = true;
   FilterEquippedItems._visible = true;
   clearInterval(ItemCrateFailedToGiveItem);
   if(bGiftOnly)
   {
      SortDropdown._visible = false;
      FilterDropdown._visible = false;
      FilterCustomText._visible = false;
      FilterEquippedItems._visible = false;
      SortBg._visible = false;
      FilterBg._visible = false;
      m_strFilterDropdown = "only_gifts";
      ActionItemSelectPanel._visible = true;
      ActionItemSelectPanel.Cancel._visible = false;
      ActionItemSelectPanel.PreviewImage._visible = false;
      var _loc3_ = ActionItemSelectPanel.ActionText.Text;
      _loc3_.htmlText = "#SFUI_InvAction_SelectGift";
      ScrollReset(InventoryPanelInfo);
   }
}
function LoadDefaultItemsFlag(arrFilterDropdown)
{
   var _loc1_ = 0;
   while(_loc1_ < arrFilterDropdown.length)
   {
      if(arrFilterDropdown[_loc1_].indexOf("not_defaultequipped") != -1)
      {
         return true;
      }
      _loc1_ = _loc1_ + 1;
   }
   return false;
}
function SetupInventoryButtons()
{
   ButtonNext.dialog = this;
   ButtonNext.actionSound = "PageScroll";
   ButtonNext.Action = function()
   {
      this.dialog.onScrollForward(InventoryPanelInfo,RefreshItemTiles);
   };
   ButtonPrev.dialog = this;
   ButtonPrev.actionSound = "PageScroll";
   ButtonPrev.Action = function()
   {
      this.dialog.onScrollBackward(InventoryPanelInfo,RefreshItemTiles);
   };
   FilterDropdown.SetUpDropDown(aFilterDropdown,"#SFUI_InvPanel_filter_title","#SFUI_InvPanel_filter_",this.SetInventoryDropdownFilter,m_strFilterDropdown);
   SortDropdown.SetUpDropDown(aFilterSort,"#SFUI_InvPanel_sort_title","#SFUI_InvPanel_sort_",this.SetInventoryDropdownSort,m_strSortDropdown);
   this._parent.AddKeyHandlersForTextFields("inv");
   FilterCustomText.Init("#SFUI_InvPanel_filter_Text",15,this.RefreshItemTiles);
   FilterCustomText.EnableAutoExecuteTimer();
   FilterEquippedItems.dialog = this;
   FilterEquippedItems.SetText("#SFUI_InvPanel_filter_default");
   FilterEquippedItems.Action = function()
   {
      this.dialog.ToggleEquippedItemFilter();
   };
   Bg.onRollOver = function()
   {
   };
}
function ToggleEquippedItemFilter()
{
   var _loc1_ = "";
   if(FilterEquippedItems.Selected._visible == true)
   {
      FilterEquippedItems.Selected._visible = false;
      m_FilterEquippedItems = false;
   }
   else
   {
      FilterEquippedItems.Selected._visible = true;
      m_FilterEquippedItems = true;
   }
   RefreshItemTiles();
}
function SetUpItemButtons()
{
   var _loc3_ = 0;
   while(_loc3_ <= InventoryPanelInfo._TotalTiles)
   {
      var _loc2_ = ItemsLayout["item" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.RolledOver = function()
      {
         ShowHideToolTip(this,true,ItemsLayout);
         m_objInvHoverSelection = this;
      };
      _loc2_.RolledOut = function()
      {
         ShowHideToolTip(this,false,ItemsLayout);
         m_objInvHoverSelection = null;
      };
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         OpenContextMenu(this,false);
      };
      _loc3_ = _loc3_ + 1;
   }
   this._parent.HideShowBarButtons(true);
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
function OpenContextMenu(objTargetTile, bRightClick)
{
   var _loc28_ = SetToolTipPaths("Context");
   var _loc39_ = {x:objTargetTile._x + objTargetTile._width,y:objTargetTile._y};
   var _loc20_ = objTargetTile.GetItemCapabilityCount();
   var _loc8_ = false;
   var _loc5_ = [];
   var _loc4_ = [];
   if(ActionItemSelectPanel._visible && m_strFilterDropdown != "only_gifts")
   {
      if(!objTargetTile.IsTool() && objTargetTile.GetCatagory() != "" && objTargetTile.GetCatagory() != undefined)
      {
         _loc5_.push("preview");
         _loc4_.push("#SFUI_InvContextMenu_preview");
         _loc5_.push("seperator");
         _loc4_.push("");
      }
      _loc5_.push("selectActionItem");
      _loc4_.push("#SFUI_InvContextMenu_selectActionItem");
      _loc28_.TooltipShowHide(objTargetTile);
      _loc28_.TooltipLayout(_loc5_,_loc4_,objTargetTile,this.AssignContextMenuAction);
      _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide();
      return undefined;
   }
   if(!objTargetTile.IsTool() && objTargetTile.GetCatagory() != "" && objTargetTile.GetCatagory() != undefined)
   {
      _loc5_.push("preview");
      var _loc34_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"musickit");
      var _loc35_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"musickit_default");
      if((_loc34_ || _loc35_) && !IsPauseMenuActive())
      {
         _loc4_.push("#SFUI_InvContextMenu_preview_musickit");
      }
      else
      {
         _loc4_.push("#SFUI_InvContextMenu_preview");
      }
      _loc5_.push("seperator");
      _loc4_.push("");
   }
   if(objTargetTile.IsTool() && _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"sticker"))
   {
      var _loc33_ = "tournament:" + _global.CScaleformComponent_News.GetActiveTournamentEventID();
      var _loc31_ = _global.CScaleformComponent_Predictions.GetMyPredictionItemIDEventSectionIndex(_loc33_,objTargetTile._ItemID);
      trace("------------------------------------SectionUsableInPickEm----------------------------------" + _loc31_);
      _loc5_.push("preview");
      _loc4_.push("#SFUI_InvContextMenu_preview");
      if(_loc31_ != null && _loc31_ != undefined && !IsPauseMenuActive())
      {
         _loc5_.push("open_watch_panel_pickem");
         _loc4_.push("#SFUI_InvContextMenu_can_PickEm");
      }
      if(_loc20_ > 0)
      {
         _loc5_.push("seperator");
         _loc4_.push("");
      }
   }
   var _loc21_ = _global.CScaleformComponent_MyPersona.GetLauncherType() != "perfectworld"?false:true;
   var _loc7_ = 0;
   while(_loc7_ < _loc20_)
   {
      var _loc6_ = objTargetTile.GetItemCapability(_loc7_);
      if(_loc6_ == undefined || _loc6_ == null || _loc6_ == "")
      {
         if(IsGift(objTargetTile))
         {
            _loc5_.push("usegift");
            _loc4_.push("#SFUI_InvContextMenu_usegift");
         }
         else if(objTargetTile.IsTool() && _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"spray"))
         {
            _loc8_ = false;
            _loc5_.push("preview");
            _loc4_.push("#SFUI_InvContextMenu_preview");
            _loc5_.push("seperator");
            _loc4_.push("");
            _loc5_.push("usespray");
            _loc4_.push("#SFUI_InvContextMenu_usespray");
         }
         else if(objTargetTile.IsTool() && _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"spraypaint"))
         {
            _loc8_ = false;
         }
         else
         {
            _loc8_ = false;
            _loc5_.push("useitem");
            _loc4_.push("#SFUI_InvContextMenu_useitem");
         }
      }
      else
      {
         _loc8_ = IsCapIsVisible(_loc6_,objTargetTile);
      }
      if(_loc8_)
      {
         var _loc15_ = false;
         if(_loc6_ == "decodable")
         {
            var _loc13_ = _global.CScaleformComponent_Inventory.GetAssociatedItemsCount(m_PlayerXuid,objTargetTile._ItemID);
            if((_loc13_ == 0 || _loc13_ == undefined || _loc13_ == null) && objTargetTile.IsTool() == false)
            {
               if(_global.CScaleformComponent_Inventory.GetLootListItemsCount(m_PlayerXuid,objTargetTile._ItemID) > 0)
               {
                  _loc5_.push("decodableKeylessSpin");
               }
               else
               {
                  _loc5_.push("decodableKeylessCountdown");
               }
               _loc4_.push("#SFUI_InvContextMenu_open_package");
            }
            else
            {
               _loc5_.push("inspectcase");
               if(objTargetTile.IsTool() == false)
               {
                  _loc4_.push("#SFUI_InvContextMenu_inspectcase");
               }
               else
               {
                  _loc4_.push("#SFUI_InvContextMenu_" + _loc6_);
               }
            }
         }
         else if(_loc6_ == "nameable")
         {
            _loc5_.push(_loc6_);
            if(objTargetTile.IsTool() == false)
            {
               _loc4_.push("#SFUI_InvContextMenu_" + _loc6_);
            }
            else
            {
               _loc4_.push("#SFUI_InvContextMenu_nameable_use");
            }
         }
         else if(_loc6_ == "recipe")
         {
            _loc5_.push(_loc6_);
            _loc4_.push("#SFUI_InvContextMenu_" + _loc6_);
            _loc15_ = true;
         }
         else if(_loc6_ == "can_sticker")
         {
            if(!objTargetTile.IsTool())
            {
               var _loc16_ = objTargetTile.GetChosenActionItemsCount("can_sticker");
               var _loc11_ = _global.CScaleformComponent_Inventory.GetItemStickerCount(m_PlayerXuid,objTargetTile._ItemID);
               var _loc14_ = _global.CScaleformComponent_Inventory.GetItemStickerSlotCount(m_PlayerXuid,objTargetTile._ItemID);
               var _loc27_ = undefined;
               if(_loc16_ > 0 && _loc11_ != _loc14_)
               {
                  _loc5_.push(_loc6_);
                  _loc4_.push("#SFUI_InvContextMenu_" + _loc6_);
               }
               if(_loc11_ == _loc14_)
               {
                  _loc5_.push("can_sticker_Wear_full");
                  _loc4_.push("#SFUI_InvContextMenu_" + _loc6_ + "_Wear_full");
               }
               else if(_loc11_ > 0)
               {
                  _loc5_.push("can_sticker_Wear");
                  _loc4_.push("#SFUI_InvContextMenu_" + _loc6_ + "_Wear");
               }
            }
            else
            {
               _loc5_.push(_loc6_);
               _loc4_.push("#SFUI_InvContextMenu_" + _loc6_);
            }
         }
         else if(_loc6_ == "can_tone")
         {
            _loc5_.push(_loc6_);
            _loc4_.push("#SFUI_InvContextMenu_" + _loc6_);
         }
         else if(_loc6_ == "can_stattrack_swap" && objTargetTile.IsTool())
         {
            _loc5_.push("can_stattrack_swap");
            _loc4_.push("#SFUI_InvContextMenu_" + _loc6_);
         }
      }
      if(!_loc15_ && _loc7_ == _loc20_ - 1 && objTargetTile.GetSlotID() != "flair0" && objTargetTile.GetSlotID() != "musickit" && objTargetTile.GetSlotID() != "spray0")
      {
         if(!_loc21_)
         {
            _loc5_.push("seperator");
            _loc4_.push("");
         }
      }
      _loc7_ = _loc7_ + 1;
   }
   if(objTargetTile.GetCatagory() != "" && objTargetTile.GetCatagory() != undefined)
   {
      var _loc23_ = objTargetTile.GetSlotID();
      if(objTargetTile.GetSlotID() == "flair0")
      {
         _loc5_.push("flair");
         _loc4_.push("#SFUI_InvContextMenu_flair");
         var _loc32_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,objTargetTile._ItemID,"season access");
         var _loc26_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,objTargetTile._ItemID,"deployment date");
         trace("--------------------------------strDeploy------------------------------" + _loc26_);
         if(_loc32_ >= 3 && !IsPauseMenuActive() && _loc26_ != null && _loc26_ != "" && _loc26_ != undefined)
         {
            _loc5_.push("seperator");
            _loc4_.push("");
            _loc5_.push("journal");
            _loc4_.push("#SFUI_InvContextMenu_Journal");
            var _loc24_ = _global.CScaleformComponent_Inventory.GetCampaignForSeason(_loc32_);
            if(_loc24_ != "" && _loc24_ != undefined && _loc24_ != null)
            {
               var _loc19_ = _loc24_.split(",");
               _loc19_.sort();
               _loc7_ = 0;
               while(_loc7_ < _loc19_.length)
               {
                  var _loc9_ = Number(_loc19_[_loc7_]);
                  var _loc18_ = _global.CScaleformComponent_Inventory.CheckCampaignOwnership(_loc9_);
                  if(_loc18_)
                  {
                     _loc5_.push("campaign" + _loc9_);
                     var _loc17_ = _global.CScaleformComponent_Inventory.GetCampaignName(_loc9_);
                     var _loc12_ = _global.GameInterface.Translate("#SFUI_InvContextMenu_Campaign");
                     _loc17_ = _global.GameInterface.Translate(_loc17_);
                     _loc12_ = _global.ConstructString(_loc12_,_loc17_);
                     _loc4_.push(_loc12_);
                  }
                  _loc7_ = _loc7_ + 1;
               }
            }
            _loc5_.push("stats");
            _loc4_.push("#SFUI_InvContextMenu_Stats");
            _loc5_.push("leaderboards");
            _loc4_.push("#SFUI_InvContextMenu_Leaderboards");
            _loc5_.push("seperator");
            _loc4_.push("");
         }
      }
      else if(objTargetTile.GetSlotID() == "musickit")
      {
         _loc5_.push("musickit");
         _loc4_.push("#SFUI_InvContextMenu_musickit");
      }
      else
      {
         var _loc30_ = false;
         if(objTargetTile.GetTeam() == "#CSGO_Inventory_Team_Any")
         {
            if(_loc23_ == "spray0")
            {
               var _loc22_ = 1;
               _loc30_ = true;
               _loc5_.push("preview");
               _loc4_.push("#SFUI_InvContextMenu_preview");
               _loc5_.push("seperator");
               _loc4_.push("");
               _loc7_ = 0;
               while(_loc7_ < _loc22_)
               {
                  var _loc36_ = GetItemToReplaceName("noteam","spray" + _loc7_);
                  if(_loc36_ == "")
                  {
                     _loc5_.push("equipspray" + _loc7_);
                     _loc4_.push(MakeSprayContextMenuEntry(objTargetTile._ItemID,_loc7_ + 1,"equip"));
                  }
                  else
                  {
                     var _loc10_ = _global.CScaleformComponent_Loadout.GetItemID(m_PlayerXuid,"noteam","spray" + _loc7_);
                     if(objTargetTile._ItemID == _loc10_)
                     {
                        _loc5_.push("disabled");
                        _loc36_ = MakeSprayContextMenuEntry(_loc10_,_loc7_ + 1,"equipped");
                     }
                     else
                     {
                        _loc5_.push("equipspray" + _loc7_);
                        _loc36_ = MakeSprayContextMenuEntry(_loc10_,_loc7_ + 1,"replace");
                     }
                     _loc4_.push(_loc36_);
                  }
                  objTargetTile._SpraySlot = _loc7_;
                  _loc7_ = _loc7_ + 1;
               }
               _loc5_.push("openloadout");
               _loc4_.push("#SFUI_InvContextMenu_openloadout");
            }
            else
            {
               if(objTargetTile.IsEquippedT() == false && objTargetTile.IsEquippedCT() == false)
               {
                  _loc5_.push("BothTeams");
                  _loc4_.push("#SFUI_InvContextMenu_BothTeams");
               }
               if(objTargetTile.IsEquippedCT() == false)
               {
                  _loc36_ = GetItemToReplaceName("ct",_loc23_);
                  _loc5_.push("ct");
                  _loc4_.push(_loc36_);
               }
               if(objTargetTile.IsEquippedT() == false)
               {
                  _loc36_ = GetItemToReplaceName("t",_loc23_);
                  _loc5_.push("t");
                  _loc4_.push(_loc36_);
               }
            }
         }
         else if(objTargetTile.GetTeam() == "#CSGO_Inventory_Team_CT" && objTargetTile.IsEquippedCT() == false)
         {
            _loc36_ = GetItemToReplaceName("ct",_loc23_);
            _loc5_.push("ct");
            _loc4_.push(_loc36_);
         }
         else if(objTargetTile.GetTeam() == "#CSGO_Inventory_Team_T" && objTargetTile.IsEquippedT() == false)
         {
            _loc36_ = GetItemToReplaceName("t",_loc23_);
            _loc5_.push("t");
            _loc4_.push(_loc36_);
         }
      }
      if(!_loc30_)
      {
         _loc5_.push("openloadout");
         _loc4_.push("#SFUI_InvContextMenu_openloadout");
      }
      if(objTargetTile.GetSlotID() != "flair0" && !_loc30_ && !_global.CScaleformComponent_Inventory.IsItemDefault(m_PlayerXuid,objTargetTile._ItemID))
      {
         if(!_loc21_)
         {
            _loc5_.push("seperator");
            _loc4_.push("");
         }
      }
   }
   if(objTargetTile != null && objTargetTile.GetItemType() != "default")
   {
      if(_global.CScaleformComponent_Inventory.IsMarketable(m_PlayerXuid,objTargetTile._ItemID) && !_loc21_)
      {
         _loc5_.push("sell");
         _loc4_.push("#SFUI_InvContextMenu_sell");
      }
      if(_global.CScaleformComponent_Inventory.IsDeletable(m_PlayerXuid,objTargetTile._ItemID))
      {
         _loc5_.push("delete");
         _loc4_.push("#SFUI_InvContextMenu_delete");
      }
      if(!objTargetTile.IsTool() && objTargetTile.GetSlotID() != "flair0" && objTargetTile.GetSlotID() != "musickit" && objTargetTile.GetSlotID() != "spray0")
      {
         if(_global.CScaleformComponent_Inventory.CanTradeUp(m_PlayerXuid,objTargetTile._ItemID))
         {
            _loc5_.push("tradeup");
            _loc4_.push("#SFUI_InvContextMenu_tradeup");
         }
         else
         {
            var _loc25_ = _global.CScaleformComponent_Inventory.GetNumItemsNeededToTradeUp(m_PlayerXuid,objTargetTile._ItemID);
            if(_loc25_ > 0)
            {
               _loc25_ = 10 - _loc25_;
               _loc5_.push("tradeNeedsItems");
               var _loc29_ = _global.GameInterface.Translate("#SFUI_InvContextMenu_tradeup_More");
               _loc29_ = _global.ConstructString(_loc29_,_loc25_);
               _loc4_.push(_loc29_);
            }
         }
      }
   }
   _loc28_.TooltipShowHide(objTargetTile);
   _loc28_.TooltipLayout(_loc5_,_loc4_,objTargetTile,this.AssignContextMenuAction);
   _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide();
}
function IsGift(objTargetTile)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetToolType(m_PlayerXuid,objTargetTile._ItemID);
   if(_loc2_ == "gift")
   {
      return true;
   }
   return false;
}
function GetItemToReplaceName(team, strWeaponSlot)
{
   var _loc4_ = _global.CScaleformComponent_Loadout.GetItemID(m_PlayerXuid,team,strWeaponSlot.toString());
   var _loc3_ = _global.GameInterface.Translate("#SFUI_InvContextMenu_" + team);
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,_loc4_);
   if(_loc2_ == undefined || _loc2_ == "" || _loc2_ == null)
   {
      return "";
   }
   var _loc5_ = _global.CScaleformComponent_Inventory.GetItemRarityColor(m_PlayerXuid,_loc4_);
   if(_loc2_ != "" && _loc2_ != undefined)
   {
      _loc3_ = _loc3_ + " " + "<font color=\'" + _loc5_ + "\'>" + _loc2_ + "</font>";
      return _loc3_;
   }
}
function MakeSprayContextMenuEntry(ItemId, numSlot, Context)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,ItemId);
   var _loc4_ = _global.CScaleformComponent_Inventory.GetItemRarityColor(m_PlayerXuid,ItemId);
   _loc2_ = "<font color=\'" + _loc4_ + "\'>" + _loc2_ + "</font>";
   if(Context == "disabled")
   {
      var _loc3_ = _loc2_;
   }
   else
   {
      _loc3_ = _global.GameInterface.Translate("#SFUI_InvContextMenu_spray" + Context);
      _loc3_ = _global.ConstructString(_loc3_,_loc2_);
   }
   return _loc3_;
}
function IsCapIsVisible(cap, objTargetTile)
{
   switch(cap)
   {
      case "decodable":
         return true;
      case "nameable":
         return true;
      case "can_sticker":
         return true;
      case "recipe":
         return true;
      default:
         var _loc1_ = objTargetTile.GetChosenActionItemsCount(cap);
         if(_loc1_ < 1)
         {
            return false;
         }
         return true;
   }
}
function ShowHideToolTip(objTargetTile, bShow, objLocation)
{
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
function HideInventoryPanel()
{
   var _loc2_ = SetToolTipPaths("Preview");
   _loc2_.ShowHidePreview(false);
   this._visible = false;
}
function ShowInventoryPanel()
{
   this._visible = true;
}
function RefreshItemTiles()
{
   var _loc3_ = Panel.Inventory;
   var _loc2_ = SetSortFilterSettings();
   _global.CScaleformComponent_Inventory.SetInventorySortAndFilters(m_PlayerXuid,m_objSortFilterSettings._strSort,m_objSortFilterSettings._bReverseSort,_loc2_,SaveLoadFilterSortSettings());
   InventoryPanelInfo._m_numItems = _global.CScaleformComponent_Inventory.GetInventoryCount();
   trace("---------FILTER TEXT PASSED---xuid: " + m_PlayerXuid + ", Sort: " + m_objSortFilterSettings._strSort + ", ReverseSort: " + m_objSortFilterSettings._bReverseSort + ", Filter: " + _loc2_ + ", Save: " + SaveLoadFilterSortSettings());
   ItemCount.htmlText = InventoryPanelInfo._m_numItems + " " + "Items";
   i = 0;
   while(i < InventoryPanelInfo._TotalTiles)
   {
      SetDataItemTiles(i,InventoryPanelInfo._m_numTopItemTile + i);
      i++;
   }
   EnableDisableScrollButtons(InventoryPanelInfo);
   UpdatePageCount(InventoryPanelInfo);
}
function SetSortFilterSettings()
{
   var _loc2_ = SetCustomTextFilter();
   var _loc1_ = m_strFilterDropdown;
   var _loc3_ = false;
   if(ActionItemSelectPanel._visible == false && (m_objSortFilterSettings._FilterEquippedItems != m_FilterEquippedItems || m_objSortFilterSettings._strSort != m_strSortDropdown || m_objSortFilterSettings._strFilter != m_strFilterDropdown || m_objSortFilterSettings._strFilterCustomText != _loc2_))
   {
      ScrollReset(InventoryPanelInfo);
   }
   m_objSortFilterSettings._bReverseSort = bReverseSort;
   m_objSortFilterSettings._strSort = m_strSortDropdown;
   m_objSortFilterSettings._strFilter = m_strFilterDropdown;
   m_objSortFilterSettings._FilterEquippedItems = m_FilterEquippedItems;
   m_objSortFilterSettings._strFilterCustomText = _loc2_;
   if(ActionItemSelectPanel._visible)
   {
      if(m_strSelectedToolID != "")
      {
         _loc1_ = m_strSelectedCapability + ":" + m_strSelectedToolID;
      }
      else if(m_strSelectedItemID != "")
      {
         _loc1_ = m_strSelectedCapability + ":" + m_strSelectedItemID;
      }
      if(IsSelectingStickerItem())
      {
         if(m_strRevertSortOverride == "")
         {
            SortDropdown.SetDropDownTitle("#SFUI_InvPanel_sort_equipped");
            m_objSortFilterSettings._strSort = "equipped";
         }
         else
         {
            m_objSortFilterSettings._strSort = m_strRevertSortOverride;
         }
      }
      return _loc1_;
   }
   if(_loc1_ == "item_definition:sticker")
   {
      _loc1_ = _loc1_ + "," + "not_base_item";
   }
   if(_loc1_ != "" && _loc2_ != "")
   {
      _loc1_ = _loc1_ + "," + _loc2_;
   }
   else if(_loc2_ != "")
   {
      _loc1_ = _loc2_;
   }
   if(m_FilterEquippedItems)
   {
      if(_loc1_ != "")
      {
         _loc1_ = _loc1_ + "," + "not_defaultequipped";
      }
      else
      {
         _loc1_ = "not_defaultequipped";
      }
   }
   return _loc1_;
}
function SaveLoadFilterSortSettings()
{
   if(ActionItemSelectPanel._visible == true)
   {
      return "";
   }
   if(m_objSortFilterSettings._strFilter != "" || m_objSortFilterSettings._strSort != "")
   {
      return "save";
   }
   return "load";
}
function IsSelectingStickerItem()
{
   if(m_strSelectedCapability == "can_sticker" && m_strSelectedToolID != "" && ActionItemSelectPanel._visible)
   {
      return true;
   }
   return false;
}
function SetDataItemTiles(numTile, numItemIndex)
{
   var _loc2_ = ItemsLayout["item" + numTile];
   var _loc3_ = "";
   var _loc5_ = 0;
   if(numItemIndex < 0 || numItemIndex > InventoryPanelInfo._m_numItems - 1)
   {
      _loc2_._visible = false;
      return undefined;
   }
   _loc3_ = _global.CScaleformComponent_Inventory.GetInventoryItemIDByIndex(numItemIndex);
   _loc2_.SetItemInfo(_loc3_,m_PlayerXuid,"Inventory");
   _loc2_._visible = true;
}
function RefreshItemImage()
{
   i = 0;
   while(i < InventoryPanelInfo._TotalTiles)
   {
      var _loc1_ = ItemsLayout["item" + numTile];
      _loc1_.RefreshItemImage();
      i++;
   }
}
function onToggleSort()
{
   ReverseSort.Selected._visible = !ReverseSort.Selected._visible;
   if(ReverseSort.Selected._visible == false)
   {
      bReverseSort = false;
   }
   else
   {
      bReverseSort = true;
   }
   RefreshItemTiles();
}
function ItemFromContextMenu(objTargetTile, strCapability, ItemIdToPreview)
{
   m_strSelectedToolID = "";
   m_strSelectedItemID = "";
   m_strSelectedCapability = strCapability;
   numActionItems = objTargetTile.GetChosenActionItemsCount(strCapability);
   if(objTargetTile.IsTool())
   {
      m_strSelectedToolID = objTargetTile._ItemID;
      if(numActionItems == 1)
      {
         var _loc3_ = objTargetTile.GetChosenActionItemIDByIndex(strCapability,0);
         m_strSelectedItemID = _loc3_;
         SetupUsePanel(objTargetTile);
      }
      else if(numActionItems > 1 || numActionItems == 0)
      {
         GetListOfItemsSelectionCanPerformActionsWith(m_strSelectedToolID,strCapability,numActionItems);
      }
   }
   else
   {
      m_strSelectedItemID = objTargetTile._ItemID;
      SetupUsePanel(objTargetTile);
   }
}
function InitStickerPreview(ItemIdToTest, CouponId)
{
   m_objCouponPreview._CouponID = CouponId;
   m_objCouponPreview._InPreviewMode = true;
   m_strSelectedItemID = "";
   m_strSelectedToolID = "";
   m_strSelectedCapability = "";
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemCapabilityByIndex(m_PlayerXuid,ItemIdToTest,0);
   numActionItems = _global.CScaleformComponent_Inventory.GetChosenActionItemsCount(m_PlayerXuid,ItemIdToTest,_loc2_);
   m_strSelectedToolID = ItemIdToTest;
   m_strSelectedCapability = _loc2_;
   GetListOfItemsSelectionCanPerformActionsWith(ItemIdToTest,_loc2_,numActionItems,m_objCouponPreview._InPreviewMode);
}
function GetListOfItemsSelectionCanPerformActionsWith(objSelectedID, cap, numActionItems, bIsPreview)
{
   m_strRevertSortOverride = "";
   var _loc8_ = false;
   ItemUsePanel._visible = false;
   FilterDropdown._visible = false;
   FilterCustomText._visible = false;
   FilterEquippedItems._visible = false;
   ActionItemSelectPanel.PreviewImage._visible = false;
   ItemsLayout.gotoAndPlay("StartAnim");
   ActionItemSelectPanel._visible = true;
   ActionItemSelectPanel.InfoIcon._visible = true;
   ActionItemSelectPanel.ActionText._x = 49;
   ScrollReset(InventoryPanelInfo);
   ActionItemSelectPanel.Cancel.dialog = this;
   ActionItemSelectPanel.Cancel.SetText("#SFUI_MBox_CancelButton");
   ActionItemSelectPanel.Cancel.Action = function()
   {
      this.dialog.onActionItemCancel();
   };
   ActionItemSelectPanel.Cancel._visible = true;
   SetUpItemButtonToSelectActionItem();
   UpdatePageCount(InventoryPanelInfo);
   RefreshItemTiles();
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,objSelectedID);
   var _loc4_ = ActionItemSelectPanel.ActionText.Text;
   if(bIsPreview)
   {
      ActionItemSelectPanel.PreviewImage._visible = true;
      ActionItemSelectPanel.PreviewImage.SetItemInfo(objSelectedID,m_PlayerXuid,"ImageOnly");
      ActionItemSelectPanel.InfoIcon._visible = false;
      ActionItemSelectPanel.ActionText._x = 66.25;
      ActionItemSelectPanel.Cancel.Action = function()
      {
         this.dialog.ClosePanel();
      };
   }
   if(numActionItems == 0)
   {
      if(bIsPreview)
      {
         var _loc5_ = _global.GameInterface.Translate("#SFUI_InvActionPreview_No_Items");
      }
      else
      {
         _loc5_ = _global.GameInterface.Translate("#SFUI_InvAction_No_Items");
      }
      _loc5_ = _global.ConstructString(_loc5_,_loc3_);
      _loc4_.htmlText = _loc5_;
   }
   else if(m_strSelectedItemID == "")
   {
      if(bIsPreview)
      {
         _loc5_ = _global.GameInterface.Translate("#SFUI_InvActionPreview_Choose_Item_" + cap);
      }
      else
      {
         _loc5_ = _global.GameInterface.Translate("#SFUI_InvAction_Choose_Item_" + cap);
      }
      _loc5_ = _global.ConstructString(_loc5_,_loc3_);
      _loc4_.htmlText = _loc5_;
   }
   else
   {
      if(bIsPreview)
      {
         _loc5_ = _global.GameInterface.Translate("#SFUI_InvActionPreview_Choose_Tool_" + cap);
      }
      else
      {
         _loc5_ = _global.GameInterface.Translate("#SFUI_InvAction_Choose_Tool_" + cap);
      }
      _loc5_ = _global.ConstructString(_loc5_,_loc3_);
      _loc4_.htmlText = _loc5_;
   }
}
function SetUpItemButtonToSelectActionItem()
{
   var _loc2_ = 0;
   while(_loc2_ <= InventoryPanelInfo._TotalTiles)
   {
      var _loc3_ = ItemsLayout["item" + _loc2_];
      _loc3_.Action = function()
      {
         this.dialog.onSelectActionItem(this);
      };
      _loc2_ = _loc2_ + 1;
   }
}
function onSelectActionItem(objTargetTile)
{
   if(m_strSelectedToolID == "")
   {
      m_strSelectedToolID = objTargetTile._ItemID;
   }
   else if(m_strSelectedItemID == "")
   {
      m_strSelectedItemID = objTargetTile._ItemID;
   }
   SetupUsePanel(objTargetTile);
}
function ResetUsePanel(bUseFade)
{
   ItemUsePanel.gotoAndStop("ItemsInCrate");
   ItemUsePanel.ResetName._visible = false;
   ItemUsePanel.MissingKey._visible = false;
   ItemUsePanel.Warning._visible = false;
   ItemUsePanel.Accept._visible = false;
   ItemUsePanel.GetItem._visible = false;
   ItemUsePanel.Scroll._visible = false;
   ItemUsePanel.Countdown._visible = false;
   ItemUsePanel.Tool._visible = false;
   ItemUsePanel.RenamePanel._visible = false;
   ItemUsePanel.StickerPanel._visible = false;
   ItemUsePanel.Cancel.dialog = this;
   if(m_objCouponPreview._InPreviewMode)
   {
      ItemUsePanel.Cancel.Action = function()
      {
         this.dialog.onActionPanelReset();
         this.dialog.ClosePanel();
      };
   }
   else
   {
      ItemUsePanel.Cancel.Action = function()
      {
         this.dialog.onItemUsePanelCancel();
      };
   }
   ItemUsePanel.Cancel._visible = true;
   ShowInventoryPanel();
   ItemUsePanel._visible = true;
   if(bUseFade)
   {
      FadeIn(ItemUsePanel);
   }
   ItemUsePanel.BlackPanel.onRollOver = function()
   {
   };
   this._parent.HideShowBarButtons(false);
   this._parent.showHideLobbyButton();
}
function SetupUsePanel(objTargetTile)
{
   ResetUsePanel(true);
   switch(m_strSelectedCapability)
   {
      case "decodableKeyless":
         SetImagesForItemsInCrate(m_strSelectedItemID);
         UsePanelHasKeylessCaseSelected();
         ItemUsePanel.gotoAndStop("OpenKeyless");
         return undefined;
         break;
      case "decodable":
         SetImagesForItemsInCrate(m_strSelectedItemID);
         break;
      case "nameable":
         ItemUsePanel.CrateContents._visible = false;
         ItemUsePanel.CrateContentsForty._visible = false;
         ItemUsePanel.ResetName.SetText("#SFUI_InvUse_Reset_nameable");
         ItemUsePanel.ResetName.Action = function()
         {
            ShowMessageBox("ResetName");
         };
         ItemUsePanel.ResetName._visible = _global.CScaleformComponent_Inventory.HasCustomName(m_PlayerXuid,m_strSelectedItemID);
         break;
      case "can_sticker":
         ItemUsePanel.CrateContents._visible = false;
         ItemUsePanel.CrateContentsForty._visible = false;
   }
   if(m_strSelectedItemID != "" && m_strSelectedToolID == "")
   {
      numActionItems = _global.CScaleformComponent_Inventory.GetChosenActionItemsCount(m_PlayerXuid,m_strSelectedItemID,m_strSelectedCapability);
      switch(numActionItems)
      {
         case 0:
            if(m_strSelectedCapability == "can_sticker")
            {
               var _loc2_ = _global.CScaleformComponent_Inventory.GetItemStickerCount(m_PlayerXuid,m_strSelectedItemID);
               if(_loc2_ > 0)
               {
                  UsePanelHasToolSelected();
               }
            }
            else
            {
               UsePanelOwnsNoTool();
            }
            break;
         case 1:
            UsePanelHasToolSelected();
            break;
         default:
            if(m_strSelectedCapability == "can_sticker")
            {
               var _loc3_ = _global.CScaleformComponent_Inventory.GetItemStickerSlotCount(m_PlayerXuid,m_strSelectedItemID);
               _loc2_ = _global.CScaleformComponent_Inventory.GetItemStickerCount(m_PlayerXuid,m_strSelectedItemID);
               if(_loc3_ == _loc2_)
               {
                  UsePanelHasToolSelected();
               }
               else
               {
                  GetListOfItemsSelectionCanPerformActionsWith(m_strSelectedItemID,m_strSelectedCapability,numActionItems);
               }
               break;
            }
            m_strSelectedToolID = _global.CScaleformComponent_Inventory.GetChosenActionItemIDByIndex(m_PlayerXuid,m_strSelectedItemID,m_strSelectedCapability,0);
            UsePanelHasToolSelected();
            break;
      }
   }
   else if(m_strSelectedToolID != "" && m_strSelectedItemID != "")
   {
      UsePanelHasToolSelected();
   }
}
function UsePanelOwnsNoTool()
{
   var _loc11_ = ItemUsePanel.Tool;
   var _loc3_ = ItemUsePanel.Item;
   var _loc7_ = m_strSelectedItemID;
   var _loc8_ = GetToolId();
   var _loc9_ = _global.GameInterface.Translate(_global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,_loc7_));
   var _loc10_ = _global.GameInterface.Translate(_global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,_loc8_));
   var _loc6_ = ItemUsePanel.MissingKey;
   m_bBuyingKey = true;
   _loc3_.SetItemInfo(_loc7_,m_PlayerXuid);
   _loc6_._Capability = m_strSelectedCapability;
   _loc6_.SetItemInfoForStore(_loc8_,m_PlayerXuid);
   _loc6_._visible = true;
   var _loc5_ = _global.GameInterface.Translate("#SFUI_InvUse_Header_" + m_strSelectedCapability);
   _loc5_ = _global.ConstructString(_loc5_,_loc9_);
   ItemUsePanel.Header.Text.htmlText = _loc5_;
   var _loc4_ = _global.GameInterface.Translate("#SFUI_InvUse_Warning_buy_" + m_strSelectedCapability);
   _loc4_ = _global.ConstructString(_loc4_,_loc10_);
   ItemUsePanel.Warning._visible = true;
   ItemUsePanel.Warning.Text.htmlText = _loc4_;
   _loc3_.RolledOver = function()
   {
      ShowHideToolTip(this,true,ItemUsePanel);
   };
   _loc3_.RolledOut = function()
   {
      ShowHideToolTip(this,false,ItemUsePanel);
   };
}
function SelectToolToUse(objTargetTile)
{
   m_strSelectedToolID = objTargetTile.GetChosenActionItemIDByIndex(m_strSelectedCapability,0);
}
function UsePanelHasToolSelected()
{
   var _loc4_ = ItemUsePanel.Tool;
   var _loc3_ = ItemUsePanel.Item;
   var strItemId = m_strSelectedItemID;
   _loc3_.SetItemInfo(strItemId,m_PlayerXuid);
   if(m_strSelectedToolID == "")
   {
      m_strSelectedToolID = _loc3_.GetChosenActionItemIDByIndex(m_strSelectedCapability,0);
   }
   var strToolId = m_strSelectedToolID;
   _loc4_.SetItemInfo(strToolId,m_PlayerXuid);
   _loc4_._visible = true;
   _loc3_._visible = true;
   m_bBuyingKey = false;
   ItemUsePanel.MissingKey._visible = false;
   ItemUsePanel.Warning._visible = true;
   var _loc6_ = _global.GameInterface.Translate(_global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,m_strSelectedItemID));
   var _loc7_ = _global.GameInterface.Translate(_global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,m_strSelectedToolID));
   if(m_objCouponPreview._InPreviewMode)
   {
      var _loc5_ = _global.GameInterface.Translate("#SFUI_InvUse_HeaderPreview_" + m_strSelectedCapability);
      ItemUsePanel.Warning.Text.htmlText = "#SFUI_InvUse_Warning_usePreview_" + m_strSelectedCapability;
   }
   else
   {
      _loc5_ = _global.GameInterface.Translate("#SFUI_InvUse_Header_" + m_strSelectedCapability);
      ItemUsePanel.Warning.Text.htmlText = "#SFUI_InvUse_Warning_use_" + m_strSelectedCapability;
   }
   _loc5_ = _global.ConstructString(_loc5_,_loc6_);
   ItemUsePanel.Header.Text.htmlText = _loc5_;
   _loc4_.RolledOver = function()
   {
      ShowHideToolTip(this,true,ItemUsePanel);
   };
   _loc4_.RolledOut = function()
   {
      ShowHideToolTip(this,false,ItemUsePanel);
   };
   _loc3_.RolledOver = function()
   {
      ShowHideToolTip(this,true,ItemUsePanel);
   };
   _loc3_.RolledOut = function()
   {
      ShowHideToolTip(this,false,ItemUsePanel);
   };
   ItemUsePanel.Accept.actionSound = "OpenCrate";
   ItemUsePanel.Accept._visible = true;
   ItemUsePanel.Accept.SetText("#SFUI_InvUse_Use_" + m_strSelectedCapability);
   ItemUsePanel.Accept.setDisabled(false);
   if(m_strSelectedCapability == "nameable")
   {
      SetUpRenamePanel();
      ItemUsePanel.Accept.Action = function()
      {
         onRenameString();
      };
      return undefined;
   }
   if(m_strSelectedCapability == "can_sticker")
   {
      SetUpStickerPanel(_loc3_,_loc4_);
      return undefined;
   }
   if(m_strSelectedCapability == "can_tone")
   {
      ItemUsePanel.Accept.Action = function()
      {
         onApplyTone();
      };
      return undefined;
   }
   ItemUsePanel.Accept.Action = function()
   {
      onItemUsePanelAccept(strToolId,strItemId);
   };
}
function UsePanelHasKeylessCaseSelected()
{
   var _loc4_ = ItemUsePanel.Item;
   var strItemId = m_strSelectedItemID;
   _loc4_.SetItemInfo(strItemId,m_PlayerXuid);
   _loc4_._visible = true;
   m_bBuyingKey = false;
   objTool._visible = false;
   ItemUsePanel.MissingKey._visible = false;
   ItemUsePanel.Warning._visible = true;
   ItemUsePanel.Warning.Text.htmlText = "#SFUI_InvUse_Warning_use_" + m_strSelectedCapability;
   var _loc5_ = _global.GameInterface.Translate(_global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,m_strSelectedItemID));
   var _loc3_ = _global.GameInterface.Translate("#SFUI_InvUse_Header_" + m_strSelectedCapability);
   _loc3_ = _global.ConstructString(_loc3_,_loc5_);
   ItemUsePanel.Header.Text.htmlText = _loc3_;
   objTool.RolledOver = function()
   {
      ShowHideToolTip(this,true,ItemUsePanel);
   };
   objTool.RolledOut = function()
   {
      ShowHideToolTip(this,false,ItemUsePanel);
   };
   ItemUsePanel.Accept.actionSound = "OpenCrate";
   ItemUsePanel.Accept._visible = true;
   if(IsSouvenirPackage(strItemId))
   {
      ItemUsePanel.Accept.SetText("#SFUI_InvUse_Use_" + m_strSelectedCapability);
   }
   else if(IsContainerStickerCapsule())
   {
      ItemUsePanel.Accept.SetText("#SFUI_InvUse_Use_KeylessCapsule");
   }
   else
   {
      ItemUsePanel.Accept.SetText("#SFUI_InvUse_Use_KeylessCapsuleDefault");
   }
   ItemUsePanel.Accept.setDisabled(false);
   ItemUsePanel.Accept.Action = function()
   {
      onItemUsePanelAccept("",strItemId);
   };
}
function SetUpKillTonePanel()
{
}
function SetUpRenamePanel()
{
   ItemUsePanel.gotoAndStop("Rename");
   ItemUsePanel.Accept._visible = true;
   ItemUsePanel.RenamePanel._visible = true;
   ItemUsePanel.RenamePanel.NewNamePlate._visible = false;
   ItemUsePanel.RenamePanel.RenameWarning._visible = false;
   ItemUsePanel.RenamePanel.Accept._visible = false;
   ItemUsePanel.RenamePanel.Rename._visible = false;
   this._parent.AddKeyHandlersForTextFields("rename");
   ItemUsePanel.RenamePanel.FilterPanel.Init("",20,this.onRenameString);
   var _loc3_ = _global.GameInterface.Translate(_global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,m_strSelectedItemID));
   ItemUsePanel.RenamePanel.CurrentName.htmlText = _loc3_;
}
function onRenameString()
{
   var _loc2_ = ItemUsePanel.RenamePanel.FilterPanel.filterString;
   var _loc3_ = _global.CScaleformComponent_Inventory.SetNameToolString(_loc2_);
   if(_loc3_)
   {
      ItemUsePanel.Accept._visible = false;
      ItemUsePanel.ResetName._visible = false;
      ItemUsePanel.RenamePanel.NewNamePlate._visible = true;
      ItemUsePanel.RenamePanel.NewNamePlate.Name.Text.htmlText = _loc2_;
      ItemUsePanel.RenamePanel.NewNamePlate.gotoAndPlay("StartAnim");
      ItemUsePanel.RenamePanel.Accept._visible = true;
      ItemUsePanel.RenamePanel.Accept.SetText("#SFUI_InvUse_Use_Name");
      ItemUsePanel.RenamePanel.Accept.Action = function()
      {
         onAcceptNewName();
      };
      ItemUsePanel.RenamePanel.Rename._visible = true;
      ItemUsePanel.RenamePanel.Rename.SetText("#SFUI_InvUse_Diff_Name");
      ItemUsePanel.RenamePanel.Rename.Action = function()
      {
         onTryDifferentName();
      };
   }
   else
   {
      ItemUsePanel.RenamePanel.RenameWarning._visible = true;
      ItemUsePanel.RenamePanel.RenameWarning.EquippedMessage.Text.Text.htmlText = "#SFUI_InvUse_Pick_Another_Name";
      ItemUsePanel.RenamePanel.RenameWarning.gotoAndPlay("StartAnim");
   }
}
function onAcceptNewName()
{
   _global.CScaleformComponent_Inventory.UseTool(m_PlayerXuid,m_strSelectedToolID,m_strSelectedItemID);
   onActionItemCancel();
}
function onTryDifferentName()
{
   SetUpRenamePanel();
}
function onResetName(ItemId)
{
   _global.CScaleformComponent_Inventory.ClearCustomName(ItemId);
   MessageBox._visible = false;
   onActionItemCancel();
}
function ResetStrickerPanel()
{
   if(m_objStickerToApplyWearTo != null || m_objStickerToApplyWearTo != undefined)
   {
      StickerScrapeAnimLoop(m_objStickerToApplyWearTo,true);
   }
   m_objStickerToApplyWearTo = null;
   ItemUsePanel.Accept._visible = false;
   ItemUsePanel.ResetName._visible = false;
   ItemUsePanel.StickerPanel.BtnSlotPicked._visible = false;
   ItemUsePanel.StickerPanel.StickerApplyAnim._visible = false;
   ItemUsePanel.StickerPanel.HowToWearWarning._visible = false;
   ItemUsePanel.StickerPanel.MessageBoxSticker._visible = false;
   ItemUsePanel.StickerPanel.ButtonBlocker._visible = false;
   ItemUsePanel.Warning._visible = true;
   ItemUsePanel.StickerPanel._visible = true;
   ItemUsePanel.StickerPanel.BtnCyclePos._visible = true;
   ItemUsePanel.StickerPanel.BtnCyclePos.setDisabled(false);
   ItemUsePanel.StickerPanel.Bg.onRollOver = function()
   {
   };
   ItemUsePanel.StickerPanel.ButtonBlocker.onRollOver = function()
   {
   };
}
function SetUpStickerPanel(objItem, objTool)
{
   ItemUsePanel._visible = true;
   ItemUsePanel.gotoAndStop("Sticker");
   ItemUsePanel.StickerPanel._ObjItem = objItem;
   ItemUsePanel.StickerPanel._ObjItem._ItemID = objItem._ItemID;
   ItemUsePanel.StickerPanel._bIsStickerWearMode = false;
   var _loc3_ = objItem.GetDefaultItemModelPath();
   _loc3_ = _loc3_ + "?stickers";
   _global.CScaleformComponent_Inventory.LaunchWeaponPreviewPanel(_loc3_);
   _global.navManager.PlayNavSound("InspectItem");
   ResetStrickerPanel();
   var aStickerInfo = SetStickerSlotsInfo();
   ItemUsePanel.StickerPanel.BtnCyclePos.SetText("#SFUI_InvUse_Pick_Sticker_slot");
   _global.AutosizeTextDown(ItemUsePanel.StickerPanel.BtnCyclePos.ButtonText.Text,8);
   ItemUsePanel.StickerPanel.BtnCyclePos.Action = function()
   {
      PickStickerSlot(aStickerInfo[0],m_strSelectedToolID);
   };
   ItemUsePanel.StickerPanel.BtnCyclePos.actionSound = "ApplySticker";
   if(m_objCouponPreview._InPreviewMode)
   {
      var _loc7_ = m_objCouponPreview._CouponID;
      var _loc5_ = _global.CScaleformComponent_Store.GetStoreItemSalePrice(_loc7_,this._Quantity);
      var _loc4_ = _global.GameInterface.Translate("#SFUI_InvUse_UsePreview_" + m_strSelectedCapability);
      _loc4_ = _global.ConstructString(_loc4_,_loc5_);
      ItemUsePanel.StickerPanel.BtnSlotPicked.SetText(_loc4_);
   }
   else
   {
      ItemUsePanel.StickerPanel.BtnSlotPicked.SetText("#SFUI_InvUse_Use_" + m_strSelectedCapability);
   }
   _global.AutosizeTextDown(ItemUsePanel.StickerPanel.BtnSlotPicked.ButtonText.Text,8);
   ItemUsePanel.StickerPanel.BtnSlotPicked.actionSound = "ButtonLarge";
   if(aStickerInfo[0].length == 0)
   {
      ShowScrapingPanel(aStickerInfo[1].length,true);
      SetUpStickerMessageBox("Scratch",0,true,false);
   }
   else
   {
      SetUpStickerPanelForApply(aStickerInfo[1].length,aStickerInfo[0].length);
   }
}
function SetUpStickerPanelForApply(numTakenSlots, numAvailableSlots)
{
   ResetStrickerPanel();
   switch(numTakenSlots)
   {
      case 0:
         ItemUsePanel.StickerPanel.gotoAndStop("Zero");
         break;
      case 1:
         ItemUsePanel.StickerPanel.gotoAndStop("OneTwo");
         break;
      case 2:
         ItemUsePanel.StickerPanel.gotoAndStop("OneTwo");
         break;
      case 3:
         ItemUsePanel.StickerPanel.gotoAndStop("Three");
         break;
      case 4:
         ItemUsePanel.StickerPanel.gotoAndStop("Four");
         break;
      case 5:
         ItemUsePanel.StickerPanel.gotoAndStop("Five");
   }
   ItemUsePanel.StickerPanel.BtnSlotPicked._visible = true;
   ItemUsePanel.StickerPanel.StickerApplyAnim._visible = true;
   ItemUsePanel.StickerPanel.StickerApplyAnim.Front.SetItemInfo(m_strSelectedToolID,m_PlayerXuid,"ImageOnly");
   ItemUsePanel.StickerPanel.StickerApplyAnim.BackPeelSide.BackSide.SetItemInfo(m_strSelectedToolID,m_PlayerXuid,"ImageOnly");
   ItemUsePanel.StickerPanel.StickerApplyAnim.gotoAndStop("StartAnim");
   ItemUsePanel.StickerPanel.StickerApplyAnim.gotoAndPlay("StartAnim");
   if(numAvailableSlots == 1)
   {
      ItemUsePanel.StickerPanel.BtnCyclePos.setDisabled(true);
   }
   else
   {
      ItemUsePanel.StickerPanel.BtnCyclePos._visible = true;
   }
}
function SetUpPanelForScraping(objItem, bSlotsFull)
{
   _global.navManager.PlayNavSound("InspectItem");
   ResetUsePanel(false);
   ResetStrickerPanel();
   ItemUsePanel.Header.Text.htmlText = "#SFUI_InvUse_Header_Sticker_Wear";
   ItemUsePanel.gotoAndStop("Sticker");
   ItemUsePanel.StickerPanel._ObjItem = objItem;
   ItemUsePanel.StickerPanel._ObjItem._ItemID = objItem._ItemID;
   ItemUsePanel.StickerPanel._bIsStickerWearMode = true;
   var _loc2_ = objItem.GetDefaultItemModelPath();
   _loc2_ = _loc2_ + "?stickers";
   _global.CScaleformComponent_Inventory.LaunchWeaponPreviewPanel(_loc2_);
   var _loc3_ = SetStickerSlotsInfo();
   SetUpStickerMessageBox("Scratch",0,bSlotsFull,true);
   ShowScrapingPanel(_loc3_[1].length,bSlotsFull);
}
function ShowScrapingPanel(numTakenSlots, bSlotsFull)
{
   switch(numTakenSlots)
   {
      case 1:
         ItemUsePanel.StickerPanel.gotoAndStop("RemoveOne");
         break;
      case 2:
         ItemUsePanel.StickerPanel.gotoAndStop("RemoveTwo");
         break;
      case 3:
         ItemUsePanel.StickerPanel.gotoAndStop("RemoveThree");
         break;
      case 4:
         ItemUsePanel.StickerPanel.gotoAndStop("RemoveFour");
         break;
      case 5:
         ItemUsePanel.StickerPanel.gotoAndStop("RemoveFive");
   }
   ItemUsePanel.Warning._visible = false;
   ItemUsePanel.StickerPanel.BtnCyclePos._visible = false;
   ItemUsePanel.StickerPanel.BtnSlotPicked._visible = false;
}
function SetStickerSlotsInfo()
{
   if(ItemUsePanel.StickerPanel._visible)
   {
      var _loc7_ = _global.CScaleformComponent_Inventory.GetItemStickerSlotCount(m_PlayerXuid,ItemUsePanel.StickerPanel._ObjItem._ItemID);
      var _loc5_ = [];
      var _loc4_ = [];
      var _loc6_ = [];
      var _loc8_ = [];
      m_numStickerPos = 0;
      var _loc2_ = 0;
      while(_loc2_ < _loc7_)
      {
         var _loc3_ = _global.CScaleformComponent_Inventory.GetItemStickerImageBySlot(m_PlayerXuid,ItemUsePanel.StickerPanel._ObjItem._ItemID,_loc2_);
         if(_loc3_ == "" || _loc3_ == null || _loc3_ == undefined)
         {
            _loc5_.push(_loc2_);
         }
         else
         {
            _loc4_.push(_loc3_);
            _loc6_.push(_loc2_);
         }
         _loc2_ = _loc2_ + 1;
      }
      ShowPreviouslyAppliedStrickers(_loc4_,_loc6_);
      PickStickerSlot(_loc5_,m_strSelectedToolID);
      _loc8_.push(_loc5_);
      _loc8_.push(_loc4_);
      return _loc8_;
   }
}
function ShowPreviouslyAppliedStrickers(aFilledStickerSlots, aFilledSlotsIndex)
{
   var _loc8_ = 5;
   var _loc4_ = 0;
   while(_loc4_ < _loc8_)
   {
      var _loc3_ = ItemUsePanel.StickerPanel["Item" + _loc4_];
      _loc3_.gotoAndStop("Reset");
      if(aFilledStickerSlots[_loc4_] == null || aFilledStickerSlots[_loc4_] == undefined || aFilledStickerSlots[_loc4_] == "")
      {
         _loc3_._visible = false;
      }
      else
      {
         var _loc7_ = aFilledStickerSlots[_loc4_] + "_large.png";
         _loc3_._visible = true;
         _loc3_.Sticker.Item.LoadItemImage(_loc7_,90,67);
         var _loc6_ = aFilledSlotsIndex[_loc4_];
         if(ItemUsePanel.StickerPanel._bIsStickerWearMode)
         {
            _loc3_.Sticker.dialog = this;
            _loc3_.Sticker._Slot = _loc6_;
            _loc3_.Sticker.setDisabled(false);
            _loc3_.Sticker.Action = function()
            {
               this.dialog.onCheckStickerAtExtremeWear(this);
            };
            _loc3_.Sticker.RolledOver = function()
            {
               _global.CScaleformComponent_Inventory.HighlightStickerBySlot(this._Slot);
            };
            _loc3_.Sticker.actionSound = "ButtonLarge";
         }
         else
         {
            _loc3_.Sticker.setDisabled(true);
         }
      }
      _loc3_.Sticker.Item.Stickers._visible = false;
      _loc4_ = _loc4_ + 1;
   }
}
function PickStickerSlot(aEmptyStickerSlots, StickerID)
{
   var numSlot;
   numSlot = m_numStickerPos;
   if(ItemUsePanel.StickerPanel._bIsStickerWearMode)
   {
      _global.CScaleformComponent_Inventory.PreviewStickerInModelPanel(m_PlayerXuid,"stickercamera",0);
   }
   else
   {
      _global.CScaleformComponent_Inventory.PreviewStickerInModelPanel(m_PlayerXuid,StickerID,aEmptyStickerSlots[numSlot]);
   }
   if(ItemUsePanel.StickerPanel._bIsStickerWearMode == false)
   {
      _global.CScaleformComponent_Inventory.PeelEffectStickerBySlot(aEmptyStickerSlots[numSlot]);
   }
   if(m_objCouponPreview._InPreviewMode)
   {
      ItemUsePanel.StickerPanel.BtnSlotPicked.Action = function()
      {
         PurchaseCoupon();
      };
   }
   else
   {
      ItemUsePanel.StickerPanel.BtnSlotPicked.Action = function()
      {
         SetUpStickerMessageBox("apply",aEmptyStickerSlots[numSlot],true);
      };
   }
   if(m_numStickerPos == aEmptyStickerSlots.length - 1)
   {
      m_numStickerPos = 0;
   }
   else
   {
      m_numStickerPos++;
   }
}
function PurchaseCoupon()
{
   ClosePanel();
   if("coupon_crate" == _global.CScaleformComponent_Inventory.GetItemTypeFromEnum(m_objCouponPreview._CouponID))
   {
      _global.CScaleformComponent_Store.PurchaseKeyAndOpenCrate(m_objCouponPreview._CouponID);
   }
   else
   {
      _global.CScaleformComponent_Store.StoreItemPurchase(m_objCouponPreview._CouponID);
   }
}
function SetUpStickerMessageBox(strType, numStickerSlot, bSlotsFull, UseFadeIn)
{
   ItemUsePanel.StickerPanel.MessageBoxSticker._visible = true;
   ItemUsePanel.StickerPanel.MessageBoxSticker.BtnDelete._visible = false;
   ItemUsePanel.StickerPanel.MessageBoxSticker.BtnAccept._visible = false;
   if(UseFadeIn)
   {
      FadeIn(ItemUsePanel.StickerPanel.MessageBoxSticker);
   }
   if(strType == "apply")
   {
      ItemUsePanel.StickerPanel.MessageBoxSticker.Text._visible = false;
      ItemUsePanel.StickerPanel.MessageBoxSticker.IconInfo._visible = false;
      ItemUsePanel.StickerPanel.MessageBoxSticker.Image._visible = true;
      ItemUsePanel.StickerPanel.MessageBoxSticker.Image.Image.SetItemInfo(m_strSelectedToolID,m_PlayerXuid,"ImageOnly");
      ItemUsePanel.StickerPanel.MessageBoxSticker.Image.gotoAndPlay("StartAnim");
      ItemUsePanel.StickerPanel.MessageBoxSticker.BtnAccept._visible = true;
      ItemUsePanel.StickerPanel.MessageBoxSticker.BtnAccept.SetText("#SFUI_InvUse_Use_Sticker");
      _global.AutosizeTextDown(ItemUsePanel.StickerPanel.MessageBoxSticker.BtnAccept.ButtonText.Text,8);
      ItemUsePanel.StickerPanel.MessageBoxSticker.BtnAccept.Action = function()
      {
         onStickerApply(numStickerSlot);
      };
      ItemUsePanel.StickerPanel.MessageBoxSticker.BtnClose.Action = function()
      {
         SetUpStickerPanel(ItemUsePanel.StickerPanel._ObjItem,null);
      };
      ItemUsePanel.StickerPanel.MessageBoxSticker.Bg._visible = true;
   }
   else if(strType == "DeleteWarning")
   {
      ItemUsePanel.StickerPanel.MessageBoxSticker.Text.htmlText = "#SFUI_Sticker_Remove_Desc";
      ItemUsePanel.StickerPanel.MessageBoxSticker.Text._visible = true;
      ItemUsePanel.StickerPanel.MessageBoxSticker.IconInfo._visible = true;
      ItemUsePanel.StickerPanel.HowToWearWarning._visible = false;
      ItemUsePanel.StickerPanel.MessageBoxSticker.BtnDelete._visible = true;
      ItemUsePanel.StickerPanel.MessageBoxSticker.BtnDelete.SetText("#SFUI_Sticker_Remove");
      _global.AutosizeTextDown(ItemUsePanel.StickerPanel.MessageBoxSticker.BtnDelete.ButtonText.Text,8);
      ItemUsePanel.StickerPanel.MessageBoxSticker.BtnDelete.Action = function()
      {
         onApplyWear(numStickerSlot);
         onActionItemCancel();
      };
      ItemUsePanel.StickerPanel.MessageBoxSticker.BtnClose.Action = function()
      {
         ItemUsePanel.StickerPanel.MessageBoxSticker._visible = false;
         ItemUsePanel.StickerPanel.HowToWearWarning._visible = true;
      };
      ItemUsePanel.StickerPanel.MessageBoxSticker.Bg._visible = false;
   }
   else
   {
      ItemUsePanel.StickerPanel.MessageBoxSticker.Image._visible = false;
      ItemUsePanel.StickerPanel.MessageBoxSticker.Text._visible = true;
      ItemUsePanel.StickerPanel.MessageBoxSticker.Text.htmlText = "#SFUI_Sticker_Wear_Warning";
      ItemUsePanel.StickerPanel.MessageBoxSticker.IconInfo._visible = true;
      if(ItemUsePanel.StickerPanel._bIsStickerWearMode == false && bSlotsFull)
      {
         ItemUsePanel.StickerPanel.MessageBoxSticker.BtnAccept._visible = false;
         ItemUsePanel.StickerPanel.MessageBoxSticker.Text.htmlText = "#SFUI_Sticker_Wear_Warning_Full";
      }
      else
      {
         ItemUsePanel.StickerPanel.MessageBoxSticker.BtnAccept._visible = true;
         ItemUsePanel.StickerPanel.MessageBoxSticker.BtnAccept.SetText("#SFUI_InvUse_Use_can_sticker");
         _global.AutosizeTextDown(ItemUsePanel.StickerPanel.MessageBoxSticker.BtnAccept.ButtonText.Text,8);
         ItemUsePanel.StickerPanel.MessageBoxSticker.BtnAccept.Action = function()
         {
            ItemUsePanel.StickerPanel.MessageBoxSticker._visible = false;
            ItemUsePanel.StickerPanel.HowToWearWarning._visible = true;
         };
      }
      ItemUsePanel.StickerPanel.MessageBoxSticker.BtnClose.Action = function()
      {
         onActionItemCancel();
      };
      ItemUsePanel.StickerPanel.MessageBoxSticker.Bg._visible = false;
   }
   ItemUsePanel.StickerPanel.MessageBoxSticker.Black.onRollOver = function()
   {
   };
}
function onStickerApply(numStickerSlot)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.SetStickerToolSlot(m_PlayerXuid,m_strSelectedItemID,numStickerSlot);
   if(_loc2_)
   {
      _global.CScaleformComponent_Inventory.UseTool(m_PlayerXuid,m_strSelectedToolID,m_strSelectedItemID);
      _global.navManager.PlayNavSound("ConfirmSticker");
      onActionItemCancel();
   }
   else
   {
      ShowMessageBox("NoItem");
   }
}
function onCheckStickerAtExtremeWear(ObjSticker)
{
   var _loc3_ = _global.CScaleformComponent_Inventory.IsItemStickerAtExtremeWear(m_PlayerXuid,ItemUsePanel.StickerPanel._ObjItem._ItemID,ObjSticker._Slot);
   trace("----------------------------------------------bApplyingWearWillDeleteSticker" + _loc3_);
   if(_loc3_)
   {
      SetUpStickerMessageBox("DeleteWarning",ObjSticker._Slot,true);
   }
   else
   {
      StickerScrapeAnimLoop(ObjSticker._parent,false);
      m_objStickerToApplyWearTo = ObjSticker._parent;
      onApplyWear(ObjSticker._Slot);
   }
}
function StickerScrapeAnimLoop(ObjSticker, bStopAnim)
{
   var numCount = 0;
   ObjSticker.gotoAndStop("Scrape");
   ObjSticker.ScrapeAnim.gotoAndPlay("StartAnim");
   ItemUsePanel.StickerPanel.ButtonBlocker._visible = true;
   if(bStopAnim)
   {
      ObjSticker.gotoAndPlay("EndAnim");
      ObjSticker.ScrapeAnim.gotoAndStop("Reset");
      ItemUsePanel.StickerPanel.ButtonBlocker._visible = false;
      delete ObjSticker.onEnterFrame;
      return undefined;
   }
   ObjSticker.onEnterFrame = function()
   {
      numCount++;
      if(numCount >= 160)
      {
         ObjSticker.gotoAndPlay("EndAnim");
         ObjSticker.ScrapeAnim.gotoAndStop("Reset");
         ItemUsePanel.StickerPanel.ButtonBlocker._visible = false;
         ShowMessageBox("NoItem");
         delete ObjSticker.onEnterFrame;
      }
   };
}
function CallbackStickerWearApplied()
{
   if(m_objStickerToApplyWearTo != null && m_objStickerToApplyWearTo != undefined && ItemUsePanel.StickerPanel._visible)
   {
      var _loc1_ = ItemUsePanel.StickerPanel["Item" + i];
      StickerScrapeAnimLoop(m_objStickerToApplyWearTo,true);
      ItemUsePanel.StickerPanel.ButtonBlocker._visible = false;
   }
}
function onApplyWear(Slot)
{
   _global.CScaleformComponent_Inventory.WearItemSticker(m_PlayerXuid,ItemUsePanel.StickerPanel._ObjItem._ItemID,Slot);
}
function onApplyTone()
{
   _global.CScaleformComponent_Inventory.UseTool(m_PlayerXuid,m_strSelectedToolID,m_strSelectedItemID);
   onActionItemCancel();
}
function GetToolId()
{
   if(m_strSelectedCapability == "decodable")
   {
      var _loc2_ = _global.CScaleformComponent_Inventory.GetAssociatedItemIdByIndex(m_PlayerXuid,m_strSelectedItemID,0);
   }
   else if(m_strSelectedCapability == "nameable")
   {
      _loc2_ = "18446744069414585520";
   }
   return _loc2_;
}
function DoesContainerHaveUnsualItem()
{
   if(ItemUsePanel.CrateContents._visible || ItemUsePanel.CrateContentsForty._visible)
   {
      if(ItemUsePanel.CrateContents._bHasUnusualItem || ItemUsePanel.CrateContentsForty._bHasUnusualItem)
      {
         return true;
      }
   }
   return false;
}
function IsContainerStickerCapsule()
{
   if(ItemUsePanel.CrateContents._visible && ItemUsePanel.CrateContents.Item0.GetItemCapability(0) == "can_sticker")
   {
      return true;
   }
   if(ItemUsePanel.CrateContentsForty._visible && ItemUsePanel.CrateContentsForty.Item0.GetItemCapability(0) == "can_sticker")
   {
      return true;
   }
   return false;
}
function IsSouvenirPackage(strItemId)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,strItemId,"tournament event id");
   trace("------------------------tournamentId------------------------" + _loc2_);
   if(_loc2_ != 0 && _loc2_ != "" && _loc2_ != undefined && _loc2_ != null)
   {
      return true;
   }
   return false;
}
function RemoveActionFromItemButton()
{
   var _loc1_ = 0;
   while(_loc1_ <= InventoryPanelInfo._TotalTiles)
   {
      var _loc2_ = ItemsLayout["item" + _loc1_];
      _loc2_.Action = function()
      {
      };
      _loc1_ = _loc1_ + 1;
   }
}
function SetImagesForItemsInCrate(strItemId)
{
   var _loc6_ = _global.CScaleformComponent_Inventory.GetLootListItemsCount(m_PlayerXuid,strItemId);
   m_LootCount = _loc6_;
   var _loc8_ = 0;
   var _loc7_ = null;
   ItemUsePanel.CrateContentsForty._bHasUnusualItem = false;
   ItemUsePanel.CrateContents._bHasUnusualItem = false;
   if(_loc6_ > 20)
   {
      ItemUsePanel.CrateContentsForty._visible = true;
      ItemUsePanel.CrateContents._visible = false;
      _loc7_ = ItemUsePanel.CrateContentsForty;
      _loc8_ = InventoryPanelInfo._TotalTilesInCrateForty;
   }
   else
   {
      ItemUsePanel.CrateContentsForty._visible = false;
      ItemUsePanel.CrateContents._visible = true;
      _loc7_ = ItemUsePanel.CrateContents;
      _loc8_ = InventoryPanelInfo._TotalTilesInCrate;
   }
   aLootItems = [];
   m_UnusualLootListImagePath = "";
   m_UnusualLootListName = "";
   var _loc2_ = 0;
   while(_loc2_ <= _loc8_)
   {
      var _loc3_ = _loc7_["Item" + _loc2_];
      if(_loc2_ >= _loc6_)
      {
         _loc3_._visible = false;
      }
      else
      {
         var _loc4_ = _global.CScaleformComponent_Inventory.GetLootListItemIdByIndex(m_PlayerXuid,strItemId,_loc2_);
         if(_loc2_ == _loc6_ - 1)
         {
            if(_loc4_ == "0")
            {
               m_UnusualLootListImagePath = _global.CScaleformComponent_Inventory.GetLootListUnusualItemImage(m_PlayerXuid,strItemId) + ".png";
               m_UnusualLootListName = _global.CScaleformComponent_Inventory.GetLootListUnusualItemName(m_PlayerXuid,strItemId);
               _loc3_.SetItemInfoForExceedinglyRareItem(strItemId,m_PlayerXuid,m_UnusualLootListImagePath,m_UnusualLootListName);
               _loc7_._bHasUnusualItem = true;
            }
            else
            {
               _loc3_.SetItemInfoHideEquippedStatus(_loc4_,m_PlayerXuid);
            }
         }
         else
         {
            _loc3_.SetItemInfoHideEquippedStatus(_loc4_,m_PlayerXuid);
         }
         SetScrollItemWeights(_loc4_);
         _loc3_._visible = true;
      }
      _loc3_.setDisabled(true);
      _loc2_ = _loc2_ + 1;
   }
   if(IsContainerStickerCapsule())
   {
      ItemUsePanel.CrateContents.Text.htmlText = "#SFUI_InvUse_Items_InStickerBox_Header";
   }
   else
   {
      ItemUsePanel.CrateContents.Text.htmlText = "#SFUI_InvUse_Items_InCrate_Header";
   }
   ItemUsePanel.CrateContents.gotoAndPlay("StartAnim");
}
function SetScrollItemWeights(ItemId)
{
   var _loc3_ = [];
   if(ItemId == "0")
   {
      var _loc4_ = 99;
   }
   else
   {
      _loc4_ = _global.CScaleformComponent_Inventory.GetItemRarity(m_PlayerXuid,ItemId);
   }
   var _loc2_ = 0;
   switch(_loc4_)
   {
      case 99:
         _loc2_ = 2;
         break;
      case 6:
         _loc2_ = 10;
         break;
      case 5:
         _loc2_ = 50;
         break;
      case 4:
         _loc2_ = 250;
         break;
      case 3:
         _loc2_ = 1250;
         break;
      case 2:
         _loc2_ = 6000;
         break;
      case 1:
         _loc2_ = 30000;
         break;
      case 0:
         _loc2_ = 150000;
   }
   _loc3_.push(ItemId,_loc2_);
   aLootItems.push(_loc3_);
}
function onItemUsePanelCancel()
{
   onActionItemCancel();
}
function onActionPanelReset()
{
   ActionItemSelectPanel._visible = false;
   ItemUsePanel._visible = false;
   ItemUsePanel.Scroll._visible = false;
   ItemUsePanel.StickerPanel._visible = false;
   MessageBox.KeylessCaseOpen._visible = false;
   m_bStopOnCrateItem = false;
   SortDropdown._visible = true;
   FilterDropdown._visible = true;
   FilterCustomText._visible = true;
   FilterEquippedItems._visible = true;
   m_bBuyingKey = false;
   m_bRevertSortOverride = false;
   clearInterval(ItemRevealTimeInterval);
   clearInterval(ItemCrateFailedToGiveItem);
   ItemUsePanel.FakeRewardItem.SetItemInfo("","");
   _global.CScaleformComponent_Inventory.LaunchWeaponPreviewPanel("");
   this._parent.AddKeyHandlersForTextFields("inv");
   SortDropdown.SetDropDownTitle("#SFUI_InvPanel_sort_" + m_strSortDropdown);
   this._parent.showHideLobbyButton();
   StickerScrapeAnimLoop(m_objStickerToApplyWearTo,true);
   delete ItemUsePanel.onEnterFrame;
   delete ItemsLayout.onEnterFrame;
   delete ItemUsePanel.Scroll.Test.Test.onEnterFrame;
}
function onActionItemCancel()
{
   onActionPanelReset();
   ScrollReset(InventoryPanelInfo);
   SetUpItemButtons();
   RefreshItemTiles();
}
function onItemUsePanelAccept(strToolId, strItemId)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetLootListItemsCount(m_PlayerXuid,strItemId);
   _global.CScaleformComponent_Inventory.UseTool(m_PlayerXuid,strToolId,strItemId);
   ItemUsePanel.gotoAndStop("OpeningCrate");
   TestAnim();
   ItemUsePanel.Accept._visible = false;
   ItemUsePanel.Cancel._visible = false;
   ItemUsePanel.Tool.setDisabled(true);
   ItemUsePanel.Item.setDisabled(true);
   ItemUsePanel.Accept.setDisabled(true);
   ItemUsePanel.Countdown._visible = true;
   FadeIn(ItemUsePanel.Countdown);
}
function ShowNewItemFromCratePanel()
{
   if(ItemUsePanel.FakeRewardItem.GetItemId() == null || ItemUsePanel.FakeRewardItem.GetItemId() == "" || ItemUsePanel.FakeRewardItem.GetItemId() == undefined)
   {
      return undefined;
   }
   var _loc5_ = ItemUsePanel.FakeRewardItem;
   previewItem(_loc5_);
   if(_global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,ItemUsePanel.FakeRewardItem.GetItemId(),"sticker"))
   {
      _global.navManager.PlayNavSound("InspectSticker");
   }
   else
   {
      var _loc3_ = _global.CScaleformComponent_Inventory.GetItemRarity(m_PlayerXuid,ItemUsePanel.FakeRewardItem.GetItemId());
      if(GetRarityNiceName(_loc3_) == "tag_Rarity_Rare_Weapon")
      {
         _global.navManager.PlayNavSound("RareItemReveal");
      }
      else if(GetRarityNiceName(_loc3_) == "tag_Rarity_Mythical_Weapon")
      {
         _global.navManager.PlayNavSound("MythicalItemReveal");
      }
      else if(GetRarityNiceName(_loc3_) == "tag_Rarity_Legendary_Weapon")
      {
         _global.navManager.PlayNavSound("LedendaryItemReveal");
      }
      else if(GetRarityNiceName(_loc3_) == "tag_Rarity_Ancient_Weapon")
      {
         _global.navManager.PlayNavSound("AncientItemReveal");
      }
      else
      {
         _global.navManager.PlayNavSound("NewItem");
      }
   }
   var _loc4_ = SetToolTipPaths("Preview");
   _loc4_.ShowNewItemAcceptButton(this.onActionItemCancel);
}
function SetItemThatCameFromOpeningCrate(ItemId)
{
   ItemUsePanel.FakeRewardItem.SetItemInfo(ItemId,m_PlayerXuid);
}
function SwapItem(strTeam, objFromInventory, bBothTeams)
{
   var _loc3_ = objFromInventory.GetSlotID();
   var _loc12_ = objFromInventory.GetItemType();
   var _loc7_ = objFromInventory.GetItemId();
   var _loc4_ = _global.GameInterface.Translate(objFromInventory.GetName());
   var _loc10_ = false;
   if(bBothTeams)
   {
      var _loc8_ = _global.GameInterface.Translate("#SFUI_InvEquippedItem_BothTeams");
   }
   else if(strTeam == "ct")
   {
      _loc8_ = _global.GameInterface.Translate("#CSGO_Inventory_Team_CT");
   }
   else if(strTeam == "t")
   {
      _loc8_ = _global.GameInterface.Translate("#CSGO_Inventory_Team_T");
   }
   if(_loc3_ == "flair0")
   {
      var _loc5_ = _global.GameInterface.Translate("#SFUI_InvEquippedFlair");
      _loc5_ = _global.ConstructString(_loc5_,_loc4_);
      EquippedWarning.EquippedMessage.Text.Text.htmlText = _loc5_;
      strTeam = "noteam";
   }
   else if(_loc3_ == "musickit")
   {
      var _loc9_ = _global.CScaleformComponent_Inventory.TestMusicVolume();
      _loc5_ = _global.GameInterface.Translate("#SFUI_InvEquippedMusickit");
      _loc5_ = _global.ConstructString(_loc5_,_loc4_);
      EquippedWarning.EquippedMessage.Text.Text.htmlText = _loc5_;
      if(!_loc9_ && !bIsEquipped)
      {
         ShowMessageBox("ResetVolume",objFromInventory);
         return undefined;
      }
      strTeam = "noteam";
   }
   else
   {
      _loc5_ = _global.GameInterface.Translate("#SFUI_InvEquippedItem");
      _loc5_ = _global.ConstructString(_loc5_,_loc4_,_loc8_);
      EquippedWarning.EquippedMessage.Text.Text.htmlText = _loc5_;
   }
   EquippedWarning.gotoAndPlay("StartAnim");
   _global.CScaleformComponent_Loadout.EquipItemInSlot(strTeam,_loc7_,_loc3_.toString());
   if(bBothTeams)
   {
      if(strTeam == "ct")
      {
         strTeam = "t";
      }
      else
      {
         strTeam = "ct";
      }
      _global.CScaleformComponent_Loadout.EquipItemInSlot(strTeam,_loc7_,_loc3_.toString());
   }
   RefreshItemTiles();
}
function EquipSpray(objFromInventory, Slot)
{
   var _loc2_ = _global.GameInterface.Translate("#SFUI_InvEquippedSpray");
   var _loc6_ = _global.GameInterface.Translate(objFromInventory.GetName());
   var _loc3_ = objFromInventory.GetItemId();
   var _loc4_ = "noteam";
   trace("-----------------------------Slot" + Slot);
   _loc2_ = _global.ConstructString(_loc2_,_loc6_,Number(Slot) + 1);
   EquippedWarning.EquippedMessage.Text.Text.htmlText = _loc2_;
   _global.AutosizeTextDown(EquippedWarning.EquippedMessage.Text.Text,8);
   EquippedWarning.gotoAndPlay("StartAnim");
   trace("-----------------------------Slot: spray" + Slot);
   trace("-----------------------------objFromInventoryID: " + _loc3_);
   trace("-----------------------------strTeam: " + _loc4_);
   _global.CScaleformComponent_Loadout.EquipItemInSlot(_loc4_,_loc3_,"spray" + Slot);
   RefreshItemTiles();
}
function UseItem(objFromInventory)
{
   _global.CScaleformComponent_Inventory.UseTool(m_PlayerXuid,objFromInventory._ItemID,"");
}
function UseGift(objFromInventory)
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemCapabilityDisabledMessageByIndex(m_PlayerXuid,objFromInventory._ItemID,0);
   if(_loc3_ == "")
   {
      ShowMessageBox("Gift",objFromInventory);
   }
   else
   {
      ShowMessageBox("ErrorCapability",objFromInventory);
   }
}
function UseSpray(objFromInventory)
{
   ShowMessageBox("Spray",objFromInventory);
}
function OpenItemInLoadout(objFromInventory)
{
   var _loc2_ = objFromInventory.GetTeam();
   var _loc3_ = objFromInventory.GetCatagory();
   var _loc4_ = objFromInventory.GetSlotID();
   if(_loc2_ == "#CSGO_Inventory_Team_CT")
   {
      _loc2_ = "ct";
   }
   else if(_loc2_ == "#CSGO_Inventory_Team_T")
   {
      _loc2_ = "t";
   }
   else if(_loc2_ == "#CSGO_Inventory_Team_Any")
   {
      _loc2_ = "ct";
   }
   this._parent.onSelectTitleBarButton(this._parent.LoadoutButton);
   this._parent.Loadout.InitFromInventoryContextMenu(_loc2_,_loc3_,_loc4_);
}
function OpenRecipeForCrafting(RecipeId)
{
   this._parent.onSelectTitleBarButton(this._parent.CraftingButton);
   this._parent.Crafting.InitRecipe(RecipeId);
}
function OpenCraftingForStattrackSwap(ToolId)
{
   this._parent.onSelectTitleBarButton(this._parent.CraftingButton);
   this._parent.Crafting.InitSwapStatTrack(ToolId);
}
function OpenWathPanelToPickEm(StickerId)
{
   var _loc4_ = "tournament:" + _global.CScaleformComponent_News.GetActiveTournamentEventID();
   var _loc3_ = _global.CScaleformComponent_Predictions.GetMyPredictionItemIDEventSectionIndex(_loc4_,StickerId);
   trace("-----------------------------------SectionUsableInPickEm----------------------------" + _loc3_);
   if(_loc3_ != undefined && _loc3_ != null)
   {
      _global.MainMenuMovie.Panel.SelectPanel.OnWatchPressed();
      this._parent.HideShowBarButtons(true);
      _global.MainMenuMovie.Panel.WatchPanel.TournamentPanel.SetUpTournamentSchedule(_global.CScaleformComponent_News.GetActiveTournamentEventID(),_loc3_);
   }
}
function OpenTradeUpRecipeWithItemSelected(ItemId)
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetTradeUpContractItemID();
   this._parent.onSelectTitleBarButton(this._parent.CraftingButton);
   this._parent.Crafting.InitRecipe(_loc3_);
   this._parent.Crafting.AddIngredients(ItemId);
}
function OpenMarketURL(ItemId)
{
   var _loc5_ = _global.CScaleformComponent_Inventory.GetItemRarity(m_PlayerXuid,ItemId);
   var _loc6_ = GetRarityNiceName(_loc5_);
   var _loc3_ = _global.CScaleformComponent_SteamOverlay.GetAppID();
   var _loc2_ = _global.CScaleformComponent_SteamOverlay.GetSteamCommunityURL();
   var _loc4_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,ItemId,"kill eater");
   _loc2_ = _loc2_ + ("/market/search?q=&appid=" + _loc3_ + "&lock_appid=" + _loc3_ + "&category_" + _loc3_ + "_Rarity%5B%5D=" + _loc6_);
   if(_loc4_ != null && _loc4_ != undefined)
   {
      _loc2_ = _loc2_ + ("&category_" + _loc3_ + "_Quality%5B%5D=tag_strange");
   }
   _loc2_ = _loc2_ + "&";
   _global.CScaleformComponent_SteamOverlay.OpenURL(_loc2_);
}
function GetRarityNiceName(numRarity)
{
   switch(numRarity)
   {
      case 1:
         return "tag_Rarity_Common";
      case 2:
         return "tag_Rarity_Uncommon_Weapon";
      case 3:
         return "tag_Rarity_Rare_Weapon";
      case 4:
         return "tag_Rarity_Mythical_Weapon";
      case 5:
         return "tag_Rarity_Legendary_Weapon";
      case 6:
         return "tag_Rarity_Ancient_Weapon";
      default:
         "";
   }
}
function ShowMessageBox(Type, objTargetTile)
{
   MessageBox.gotoAndStop("Keyless");
   MessageBox.KeylessCaseOpen.gotoAndStop("Reset");
   MessageBox.KeylessCaseOpen._visible = false;
   MessageBox.Delete._visible = false;
   MessageBox.Delete.setDisabled(false);
   MessageBox.Accept._visible = false;
   MessageBox.Accept.setDisabled(false);
   MessageBox.Close._visible = false;
   MessageBox.ImageTile._visible = false;
   MessageBox.AnimImageTile._visible = false;
   MessageBox.AnimImageTile.TextBox._visible = false;
   MessageBox.AnimImageTile.gotoAndStop("Default");
   MessageBox.Black.onRollOver = function()
   {
      trace("");
   };
   switch(Type)
   {
      case "ResetName":
         MessageBox.gotoAndStop("Default");
         ResetCustomNameMessageBox();
         break;
      case "DeleteItem":
         MessageBox.gotoAndStop("Delete");
         DeleteItemMessageBox(objTargetTile);
         break;
      case "InvError":
         MessageBox.gotoAndStop("Default");
         InventoryValidErrorMessageBox();
         break;
      case "NoItem":
         MessageBox.gotoAndStop("Default");
         NoItemErrorMessageBox();
         break;
      case "OverlayDisabled":
         MessageBox.gotoAndStop("Default");
         OverlayDisabledMessageBox();
         break;
      case "KeylessCase":
         MessageBox.gotoAndStop("Keyless");
         KeylessCaseMessageBox(objTargetTile);
         break;
      case "ErrorCapability":
         MessageBox.gotoAndStop("Default");
         ErrorCapability(objTargetTile);
         break;
      case "Gift":
         MessageBox.gotoAndStop("Gift");
         GiftCaseMessageBox(objTargetTile);
         break;
      case "Spray":
         MessageBox.gotoAndStop("Gift");
         SprayMessageBox(objTargetTile);
         break;
      case "ResetVolume":
         MessageBox.gotoAndStop("Keyless");
         ResetVolumeMessageBox(objTargetTile);
   }
   MessageBox._visible = true;
   FadeIn(MessageBox);
   this._parent.HideShowBarButtons(false);
}
function ResetCustomNameMessageBox()
{
   MessageBox.Delete._alpha = 100;
   MessageBox.Delete._visible = true;
   MessageBox.Delete.SetText("#SFUI_InvUse_Reset_nameable");
   MessageBox.Delete.Action = function()
   {
      onResetName(m_strSelectedItemID);
   };
   MessageBox.Close._visible = true;
   MessageBox.TextPanel.Text.htmlText = "#SFUI_InvUse_Reset_nameable_Warning";
   MessageBox.Close.Action = function()
   {
      MessageBox._visible = false;
   };
}
function ResetVolumeMessageBox(objTargetTile)
{
   MessageBox.Accept._visible = true;
   MessageBox.Accept.SetText("#SFUI_InvUse_Equip_MusicKit");
   MessageBox.Accept.Action = function()
   {
      OnResetVolume(objTargetTile);
   };
   trace("-----------------------------------objTargetTile-------------------------------------------" + objTargetTile);
   var _loc3_ = _global.GameInterface.Translate(objTargetTile.GetName());
   var _loc2_ = _global.GameInterface.Translate("#SFUI_InvUse_Reset_Volume_Warning");
   _loc2_ = _global.ConstructString(_loc2_,_loc3_);
   MessageBox.Close._visible = false;
   MessageBox.TextPanel.Text.htmlText = _loc2_;
   VerticalCenterText(MessageBox.TextPanel.Text,MessageBox.TextPanel);
   MessageBox.Close.Action = function()
   {
      MessageBox._visible = false;
   };
   MessageBox.ImageTile._visible = true;
   MessageBox.ImageTile.SetItemInfo(objTargetTile._ItemID,m_PlayerXuid,"ImageOnly");
}
function OnResetVolume(objTargetTile)
{
   trace("-----------------------------------objTargetTile-------------------------------------------" + objTargetTile);
   _global.CScaleformComponent_Loadout.EquipItemInSlot("noteam",objTargetTile._ItemID,"musickit");
   _global.CScaleformComponent_Inventory.SetDefaultMusicVolume();
   EquippedWarning.gotoAndPlay("StartAnim");
   RefreshItemTiles();
   MessageBox._visible = false;
}
function DeleteItemMessageBox(objTargetTile)
{
   var IdToDelete = objTargetTile._ItemID;
   MessageBox.Delete._visible = true;
   MessageBox.Delete.SetText("#SFUI_InvError_Delete_Item_Btn");
   MessageBox.Delete.Action = function()
   {
      onDeleteItem(IdToDelete);
      objTargetTile._visible = false;
   };
   MessageBox.Close._visible = true;
   MessageBox.Close.Action = function()
   {
      CloseMessageBox();
   };
   var _loc3_ = _global.GameInterface.Translate(objTargetTile.GetName());
   var _loc2_ = _global.GameInterface.Translate("#SFUI_InvError_Delete_Item");
   _loc2_ = _global.ConstructString(_loc2_,_loc3_);
   MessageBox.TextPanel.Text.htmlText = _loc2_;
   VerticalCenterText(MessageBox.TextPanel.Text,MessageBox.TextPanel);
   MessageBox.ImageTile._visible = true;
   MessageBox.ImageTile.SetItemInfo(objTargetTile._ItemID,m_PlayerXuid,"ImageOnly");
}
function onDeleteItem(IdToDelete)
{
   if(MessageBox._visible == true)
   {
      MessageBox.Delete.setDisabled(true);
      _global.CScaleformComponent_Inventory.DeleteItem(m_PlayerXuid,IdToDelete);
   }
   CloseMessageBox();
}
function InventoryValidErrorMessageBox()
{
   MessageBox.Close._visible = true;
   MessageBox.Close.Action = function()
   {
      CloseInventoryValidError();
   };
   MessageBox.TextPanel.Text.htmlText = "#SFUI_InvError_InvValid_Error";
}
function CloseInventoryValidError()
{
   this._parent.ClosePanel();
}
function OverlayDisabledMessageBox()
{
   MessageBox.Close._visible = true;
   MessageBox.Close.Action = function()
   {
      CloseMessageBox();
   };
   MessageBox.TextPanel.Text.htmlText = "#SFUI_InvError_Steam_Overlay_Disabled";
}
function ErrorCapability(objTargetTile)
{
   MessageBox.Close._visible = true;
   MessageBox.Close.Action = function()
   {
      CloseMessageBox();
   };
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemCapabilityDisabledMessageByIndex(m_PlayerXuid,objTargetTile._ItemID,0);
   MessageBox.TextPanel.Text.htmlText = _loc2_;
}
function NoItemErrorMessageBox()
{
   onActionItemCancel();
   MessageBox.Accept._visible = true;
   MessageBox.Accept.SetText("#SFUI_InvUse_Continue");
   MessageBox.Accept.Action = function()
   {
      onActionItemCancel();
      MessageBox._visible = false;
   };
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,objTargetTile._ItemID);
   MessageBox.TextPanel.Text.htmlText = "#SFUI_InvError_Item_Not_Given";
}
function KeylessCaseMessageBox(objTargetTile)
{
   MessageBox.Accept._visible = true;
   MessageBox.Accept.SetText("#SFUI_InvContextMenu_open_package");
   MessageBox.Accept.Action = function()
   {
      StartKeylessCaseOpenAnim(objTargetTile);
   };
   MessageBox.Close._visible = true;
   MessageBox.Close.Action = function()
   {
      CloseMessageBox();
   };
   var _loc3_ = _global.GameInterface.Translate(objTargetTile.GetName());
   var _loc2_ = _global.GameInterface.Translate("#SFUI_InvError_Open_Package");
   _loc2_ = _global.ConstructString(_loc2_,_loc3_);
   MessageBox.TextPanel.Text.htmlText = _loc2_;
   VerticalCenterText(MessageBox.TextPanel.Text,MessageBox.TextPanel);
   MessageBox.ImageTile._visible = true;
   MessageBox.ImageTile.SetItemInfo(objTargetTile._ItemID,m_PlayerXuid,"ImageOnly");
}
function StartKeylessCaseOpenAnim(objTargetTile)
{
   MessageBox.KeylessCaseOpen._visible = true;
   MessageBox.KeylessCaseOpen.gotoAndPlay("StartAnim");
   MessageBox.Close._visible = false;
   MessageBox.Accept._visible = false;
   MessageBox.Accept.setDisabled(true);
   MessageBox.TextPanel.Text.htmlText.htmlText = "";
   OpenKeylessCase(objTargetTile);
}
function SprayMessageBox(objTargetTile)
{
   MessageBox.Accept._visible = true;
   MessageBox.Accept.SetText("#SFUI_InvContextMenu_usespray");
   MessageBox.Accept.Action = function()
   {
      StartUnpackSprayOpenAnim(objTargetTile);
   };
   MessageBox.Close._visible = true;
   MessageBox.Close.Action = function()
   {
      CloseMessageBox();
   };
   var _loc4_ = _global.CScaleformComponent_Inventory.GetSprayChargesAsBaseline(objTargetTile._ItemID);
   var _loc3_ = _global.GameInterface.Translate(objTargetTile.GetName());
   if(_loc4_ > 0)
   {
      var _loc2_ = _global.GameInterface.Translate("#SFUI_InvError_Unpack_Spray_combine");
      _loc2_ = _global.ConstructString(_loc2_,_loc3_,_loc4_);
   }
   else
   {
      _loc2_ = _global.GameInterface.Translate("#SFUI_InvError_Unpack_Spray");
      _loc2_ = _global.ConstructString(_loc2_,_loc3_);
   }
   MessageBox.TextPanel.Text.htmlText = _loc2_;
   VerticalCenterText(MessageBox.TextPanel.Text,MessageBox.TextPanel);
   MessageBox.AnimImageTile._visible = true;
   MessageBox.AnimImageTile.ImageTile.SetItemInfo(objTargetTile._ItemID,m_PlayerXuid,"ImageOnly");
}
function GiftCaseMessageBox(objTargetTile)
{
   MessageBox.Accept._visible = true;
   MessageBox.Accept.SetText("#SFUI_InvContextMenu_usegift");
   MessageBox.Accept.Action = function()
   {
      StartGiveGiftOpenAnim(objTargetTile);
   };
   MessageBox.Close._visible = true;
   MessageBox.Close.Action = function()
   {
      CloseMessageBox();
   };
   var _loc3_ = _global.GameInterface.Translate(objTargetTile.GetName());
   var _loc2_ = _global.GameInterface.Translate("#SFUI_InvError_Give_Gift");
   _loc2_ = _global.ConstructString(_loc2_,_loc3_);
   MessageBox.TextPanel.Text.htmlText = _loc2_;
   VerticalCenterText(MessageBox.TextPanel.Text,MessageBox.TextPanel);
   MessageBox.AnimImageTile._visible = true;
   MessageBox.AnimImageTile.ImageTile.SetItemInfo(objTargetTile._ItemID,m_PlayerXuid,"ImageOnly");
}
function StartGiveGiftOpenAnim(objTargetTile)
{
   MessageBox.Accept._visible = false;
   MessageBox.AnimImageTile.gotoAndPlay("StartAnim");
   _global.navManager.PlayNavSound("NewItem");
   var _loc3_ = _global.GameInterface.Translate(objTargetTile.GetName());
   var _loc2_ = _global.GameInterface.Translate("#SFUI_InvError_Gift_Given");
   _loc2_ = _global.ConstructString(_loc2_,_loc3_);
   MessageBox.AnimImageTile.TextBox.Text.htmlText = _loc2_;
   VerticalCenterText(MessageBox.AnimImageTile.TextBox.Text,MessageBox.AnimImageTile.TextBox);
   MessageBox.AnimImageTile.TextBox._visible = true;
   MessageBox.TextPanel.Text.htmlText = "";
   _global.CScaleformComponent_Inventory.UseTool(m_PlayerXuid,objTargetTile._ItemID,"");
}
function StartUnpackSprayOpenAnim(objTargetTile)
{
   CloseMessageBox();
   var _loc5_ = SetToolTipPaths("Preview");
   _global.CScaleformComponent_Inventory.PlayAudioFile("items/spraycan_spray.wav");
   previewItem(objTargetTile);
   _loc5_.ShowNewItemAcceptButton(this.onActionItemCancel,true);
   var _loc4_ = _global.GameInterface.Translate(objTargetTile.GetName());
   var _loc3_ = _global.GameInterface.Translate("#SFUI_InvError_Spray_Unpacked");
   _loc3_ = _global.ConstructString(_loc3_,_loc4_);
   _global.CScaleformComponent_Inventory.UseTool(m_PlayerXuid,objTargetTile._ItemID,"");
}
function OpenKeylessCase(objFromInventory)
{
   _global.CScaleformComponent_Inventory.UseTool(m_PlayerXuid,"",objFromInventory._ItemID);
}
function ShowItemFromKeylessCase()
{
   CloseMessageBox();
   if(ItemUsePanel.FakeRewardItem.GetItemId() == null || ItemUsePanel.FakeRewardItem.GetItemId() == "" || ItemUsePanel.FakeRewardItem.GetItemId() == undefined)
   {
      ShowMessageBox("NoItem");
   }
   else
   {
      ShowNewItemFromCratePanel();
   }
}
function CloseMessageBox()
{
   MessageBox._visible = false;
   MessageBox.KeylessCaseOpen._visible = false;
   this._parent.HideShowBarButtons(true);
}
function ClosePanel()
{
   _global.MainMenuMovie.Panel.SelectPanel.OnHomePressed();
   this._parent.HideShowBarButtons(true);
}
function previewItem(objTargetTile)
{
   var _loc3_ = SetToolTipPaths("Preview");
   var _loc6_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"musickit");
   var _loc7_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"musickit_default");
   var _loc8_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"sticker");
   var _loc5_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"spraypaint");
   var _loc4_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"spray");
   _loc3_.ShowHidePreview(true,objTargetTile.GetName(),objTargetTile.GetRarityColor());
   if(_loc5_ || _loc4_)
   {
      _loc3_.SetModel("vmt://spraypreview_" + objTargetTile._ItemID);
   }
   else if(_loc8_)
   {
      _loc3_.SetModel("vmt://stickerpreview_" + objTargetTile._ItemID);
   }
   else if(_loc6_ || _loc7_)
   {
      _loc3_.SetModel(objTargetTile.GetDefaultItemModelPath());
      _loc3_.StartMusicPreview(objTargetTile._ItemID,m_PlayerXuid);
   }
   else
   {
      _loc3_.SetModel(objTargetTile.GetDefaultItemModelPath());
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
   else
   {
      ShowMessageBox("OverlayDisabled");
   }
}
function TestAnim()
{
   ItemUsePanel.Scroll._visible = true;
   ItemUsePanel.Scroll.Test.Test._x = 0;
   var bIsWeapnCase = DoesContainerHaveUnsualItem();
   var _loc2_ = Math.floor(Math.random() * 88 + -44);
   var objTest = ItemUsePanel.Scroll.Test.Test;
   var StartPos = objTest._x;
   var EndPos = objTest._x - 685;
   var StopPos = objTest._x - 778 + _loc2_;
   var LoopCount = 0;
   var PosForSound = 0;
   var OldPos = 0;
   var SetReward = false;
   RandomItemsForScroll(bIsWeapnCase);
   objTest.onEnterFrame = function()
   {
      if(LoopCount > 2)
      {
         if(!SetReward)
         {
            if(ItemUsePanel.FakeRewardItem.GetItemId() == null || ItemUsePanel.FakeRewardItem.GetItemId() == "" || ItemUsePanel.FakeRewardItem.GetItemId() == undefined)
            {
               delete objTest.onEnterFrame;
               ShowMessageBox("NoItem");
            }
            else
            {
               SetRewardItem();
               SetReward = true;
            }
         }
         OldPos = objTest._x - 50;
         objTest._x = objTest._x + (StopPos - 1 - objTest._x) * 0.045;
         if(OldPos != 0)
         {
            PosForSound = PosForSound + (OldPos - (objTest._x - 50));
            if(PosForSound > 100)
            {
               if(!bIsWeapnCase)
               {
                  _global.navManager.PlayNavSound("StickerScroll");
               }
               else
               {
                  _global.navManager.PlayNavSound("ItemScroll");
               }
               PosForSound = 0;
               OldPos = 0;
            }
         }
         if(objTest._x <= StopPos)
         {
            ShowNewItemFromCratePanel();
            delete objTest.onEnterFrame;
         }
      }
      else if(LoopCount <= 2)
      {
         objTest._x = objTest._x + -35;
         if(PosForSound < 100)
         {
            PosForSound = PosForSound + 35;
         }
         else
         {
            if(!bIsWeapnCase)
            {
               _global.navManager.PlayNavSound("StickerScroll");
            }
            else
            {
               _global.navManager.PlayNavSound("ItemScroll");
            }
            PosForSound = 0;
         }
      }
      if(objTest._x <= EndPos && !SetReward)
      {
         LoopCount++;
         objTest._x = StartPos;
         RandomItemsForScroll(bIsWeapnCase);
      }
   };
}
function SetRewardItem()
{
   var _loc2_ = ItemUsePanel.Scroll.Test.Test.Item9;
   var _loc3_ = ItemUsePanel.FakeRewardItem.GetItemId();
   var _loc4_ = aLootItems.length;
   var _loc5_ = aLootItems[_loc4_ - 1][0];
   if(_global.CScaleformComponent_Inventory.IsItemUnusual(m_PlayerXuid,_loc3_))
   {
      _loc2_.SetItemInfoForExceedinglyRareItem(ItemUsePanel.Item.GetItemId(),m_PlayerXuid,m_UnusualLootListImagePath,m_UnusualLootListName);
   }
   else
   {
      _loc2_.SetItemInfoHideEquippedStatus(_loc3_,m_PlayerXuid);
   }
}
function RandomItemsForScroll(bIsWeapnCase)
{
   var _loc8_ = ItemUsePanel.Item._ItemID;
   var _loc6_ = 11;
   trace("---------------------------------------bIsWeapnCase--------------------------" + bIsWeapnCase);
   var _loc3_ = 0;
   while(_loc3_ < _loc6_)
   {
      var _loc5_ = GetRandomChance();
      var _loc2_ = ItemUsePanel.Scroll.Test.Test["Item" + _loc3_];
      var _loc1_ = _loc5_[0];
      if(_loc1_ == "0")
      {
         if(ItemUsePanel.FakeRewardItem.GetItemId() == null || ItemUsePanel.FakeRewardItem.GetItemId() == "" || ItemUsePanel.FakeRewardItem.GetItemId() == undefined)
         {
            _loc2_.SetItemInfoForExceedinglyRareItem(ItemUsePanel.Item.GetItemId(),m_PlayerXuid,m_UnusualLootListImagePath,m_UnusualLootListName);
         }
         else
         {
            _loc1_ = aLootItems[3][0];
            _loc2_.SetItemInfoStatTrak(_loc1_,m_PlayerXuid,-1);
         }
      }
      else
      {
         var _loc4_ = -1;
         if(Math.random() < 0.1 && bIsWeapnCase)
         {
            _loc4_ = 0;
         }
         _loc2_.SetItemInfoStatTrak(_loc1_,m_PlayerXuid,_loc4_);
      }
      _loc3_ = _loc3_ + 1;
   }
}
function GetRandomChance()
{
   var _loc3_ = 0;
   var _loc2_ = 0;
   var _loc1_ = 0;
   while(_loc1_ < aLootItems.length)
   {
      _loc3_ = _loc3_ + aLootItems[_loc1_][1];
      _loc1_ = _loc1_ + 1;
   }
   var _loc4_ = Math.floor(Math.random() * _loc3_);
   _loc1_ = 0;
   while(_loc1_ < aLootItems.length)
   {
      _loc2_ = _loc2_ + aLootItems[_loc1_][1];
      if(_loc4_ <= _loc2_)
      {
         return aLootItems[_loc1_];
      }
      _loc1_ = _loc1_ + 1;
   }
}
function AssignContextMenuAction(strMenuItem, objTargetTile)
{
   switch(strMenuItem)
   {
      case "nameable":
         ItemFromContextMenu(objTargetTile,"nameable");
         break;
      case "decodable":
         ItemFromContextMenu(objTargetTile,"decodable");
         break;
      case "inspectcase":
         ItemFromContextMenu(objTargetTile,"decodable");
         break;
      case "decodableKeylessSpin":
         ItemFromContextMenu(objTargetTile,"decodableKeyless");
         break;
      case "decodableKeylessCountdown":
         ShowMessageBox("KeylessCase",objTargetTile);
         break;
      case "can_sticker":
         ItemFromContextMenu(objTargetTile,"can_sticker");
         break;
      case "can_sticker_Wear":
         SetUpPanelForScraping(objTargetTile,false);
         break;
      case "can_sticker_Wear_full":
         SetUpPanelForScraping(objTargetTile,true);
         break;
      case "open_watch_panel_pickem":
         OpenWathPanelToPickEm(objTargetTile.GetItemId());
         break;
      case "recipe":
         OpenRecipeForCrafting(objTargetTile.GetItemId());
         break;
      case "can_stattrack_swap":
         OpenCraftingForStattrackSwap(objTargetTile.GetItemId());
         break;
      case "ct":
         SwapItem("ct",objTargetTile,false);
         break;
      case "t":
         SwapItem("t",objTargetTile,false);
         break;
      case "BothTeams":
         SwapItem("ct",objTargetTile,true);
         break;
      case "flair":
         SwapItem("ct",objTargetTile,false);
         break;
      case "equipspray0":
         EquipSpray(objTargetTile,"0");
         break;
      case "equipspray1":
         EquipSpray(objTargetTile,"1");
         break;
      case "equipspray2":
         EquipSpray(objTargetTile,"2");
         break;
      case "equipspray3":
         EquipSpray(objTargetTile,"3");
         break;
      case "journal":
         OpenJournal(objTargetTile.GetItemId(),0,false);
         break;
      case "campaign1":
         OpenJournal(objTargetTile.GetItemId(),8,true);
         break;
      case "campaign2":
         OpenJournal(objTargetTile.GetItemId(),2,true);
         break;
      case "campaign3":
         OpenJournal(objTargetTile.GetItemId(),6,true);
         break;
      case "campaign4":
         OpenJournal(objTargetTile.GetItemId(),4,true);
         break;
      case "campaign5":
         OpenJournal(objTargetTile.GetItemId(),2,true);
         break;
      case "campaign6":
         OpenJournal(objTargetTile.GetItemId(),4,true);
         break;
      case "campaign7":
         OpenJournal(objTargetTile.GetItemId(),4,true);
         break;
      case "campaign8":
         OpenJournal(objTargetTile.GetItemId(),2,true);
         break;
      case "leaderboards":
         var _loc3_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,objTargetTile.GetItemId(),"season access");
         if(3 == _loc3_)
         {
            OpenJournal(objTargetTile.GetItemId(),4,true);
         }
         else if(4 == _loc3_)
         {
            OpenJournal(objTargetTile.GetItemId(),12,true);
         }
         else if(5 == _loc3_)
         {
            OpenJournal(objTargetTile.GetItemId(),8,true);
         }
         else if(6 == _loc3_)
         {
            OpenJournal(objTargetTile.GetItemId(),8,true);
         }
         break;
      case "stats":
         _loc3_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,objTargetTile.GetItemId(),"season access");
         if(3 == _loc3_)
         {
            OpenJournal(objTargetTile.GetItemId(),2,true);
         }
         else if(4 == _loc3_)
         {
            OpenJournal(objTargetTile.GetItemId(),10,true);
         }
         else if(5 == _loc3_)
         {
            OpenJournal(objTargetTile.GetItemId(),6,true);
         }
         else if(6 == _loc3_)
         {
            OpenJournal(objTargetTile.GetItemId(),6,true);
         }
         break;
      case "musickit":
         SwapItem("ct",objTargetTile,false);
         break;
      case "musickitunequip":
         SwapItem("ct",objTargetTile,false);
         break;
      case "openloadout":
         OpenItemInLoadout(objTargetTile);
         break;
      case "delete":
         ShowMessageBox("DeleteItem",objTargetTile);
         break;
      case "tradeup":
         OpenTradeUpRecipeWithItemSelected(objTargetTile.GetItemId());
         break;
      case "tradeNeedsItems":
         break;
      case "preview":
         previewItem(objTargetTile);
         var _loc5_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"spraypaint");
         var _loc4_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"spray");
         if(_loc5_ || _loc4_)
         {
            _global.CScaleformComponent_Inventory.PlayAudioFile("items/spraycan_spray.wav");
         }
         else if(_global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,objTargetTile._ItemID,"sticker"))
         {
            _global.navManager.PlayNavSound("InspectSticker");
         }
         else if(_global.CScaleformComponent_Inventory.GetSlotSubPosition(m_PlayerXuid,objTargetTile._ItemID) == "flair0")
         {
            _global.navManager.PlayNavSound("InspectSticker");
         }
         else
         {
            _global.navManager.PlayNavSound("InspectItem");
         }
         break;
      case "sell":
         SellItemOnMarketPlace(objTargetTile);
         break;
      case "useitem":
         UseItem(objTargetTile);
         break;
      case "usegift":
         UseGift(objTargetTile);
         break;
      case "usespray":
         UseSpray(objTargetTile);
         break;
      case "previewmusic":
         PreviewMusic(objTargetTile);
         break;
      case "selectActionItem":
         onSelectActionItem(objTargetTile);
         break;
      case "can_tone":
         ItemFromContextMenu(objTargetTile,"can_tone");
   }
}
function OpenJournal(ItemID, Page, bOpenToPage)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,ItemID,"season access");
   _global.MainMenuMovie.Panel.JournalPanel._visible = true;
   _global.MainMenuMovie.Panel.JournalPanel.Journal.ShowPanel(Page,ItemID,_loc2_,bOpenToPage);
}
function IsInItemScroll()
{
   if(ItemUsePanel.Scroll._visible == true || MessageBox.KeylessCaseOpen._visible == true)
   {
      return true;
   }
   return false;
}
function IsBuyKeyTileVisible()
{
   return m_bBuyingKey;
}
function IsPauseMenuActive()
{
   if(_global.PauseMenuMovie)
   {
      return true;
   }
   return false;
}
function VerticalCenterText(objText, objBounds)
{
   _global.AutosizeTextDown(objText,8);
   objText.autoSize = "left";
   if(objText._height > objBounds._height)
   {
      objText._height = objBounds._height;
   }
   objText._y = (objBounds._height - objText._height) * 0.5;
}
function SetInventoryDropdownFilter(strDropdownOption)
{
   m_strFilterDropdown = strDropdownOption;
   RefreshItemTiles();
}
function SetInventoryDropdownSort(strDropdownOption)
{
   if(IsSelectingStickerItem())
   {
      m_strRevertSortOverride = strDropdownOption;
   }
   else
   {
      m_strSortDropdown = strDropdownOption;
   }
   RefreshItemTiles();
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
var m_strSelectedToolID = "";
var m_strSelectedItemID = "";
var m_strSelectedCapability = "";
var m_objInvHoverSelection = null;
var m_bStopOnCrateItem = false;
var m_LootCount = 0;
var m_OnlyGifts = false;
var m_numStickerPos = 0;
var m_strFilterDropdown = "";
var m_strFilterCustomText = "";
var m_strSortDropdown = "";
var m_FilterEquippedItems = false;
var m_strRevertSortOverride = "";
var bReverseSort = false;
var m_bBuyingKey = false;
var m_bShowStickerWearPanel = false;
var m_objStickerToApplyWearTo = null;
var m_UnusualLootListImagePath;
var m_UnusualLootListName;
var aFilterDropdown = new Array("all","only_weapons","heavy","secondary","rifle","smg","melee","flair0","item_definition:sticker","spray","musickit","not_equipment");
var aFilterSort = [];
var aLootItems = [];
var m_aStickerArray = [];
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var InventoryPanelInfo = new Object();
InventoryPanelInfo._TotalTiles = 60;
InventoryPanelInfo._TotalTilesInCrate = 18;
InventoryPanelInfo._TotalTilesInCrateForty = 40;
InventoryPanelInfo._SelectableTiles = 30;
InventoryPanelInfo._StartPos = ItemsLayout._x;
InventoryPanelInfo._EndPos = ItemsLayout._x - ItemsLayout._width / 2 - 22;
InventoryPanelInfo._PrevButton = ButtonPrev;
InventoryPanelInfo._NextButton = ButtonNext;
InventoryPanelInfo._AnimObject = ItemsLayout;
InventoryPanelInfo._PageCountObject = PageCount;
InventoryPanelInfo._m_numItems = 0;
InventoryPanelInfo._m_numTopItemTile = 0;
var m_objSortFilterSettings = new Object();
m_objSortFilterSettings._bReverseSort = false;
m_objSortFilterSettings._strFilter = "";
m_objSortFilterSettings._strSort = "";
var m_objCouponPreview = new Object();
m_objCouponPreview._CouponID = "";
m_objCouponPreview._InPreviewMode = false;
ItemUsePanel.Scroll._visible = false;
MessageBox.KeylessCaseOpen._visible = false;
var m_bAskedForTournamentMatches = false;
this._visible = false;
var NUM_CAMPAIGN_1_DEFINDEX = 1321;
var NUM_CAMPAIGN_2_DEFINDEX = 1319;
var NUM_CAMPAIGN_3_DEFINDEX = 1320;
var NUM_CAMPAIGN_4_DEFINDEX = 1312;
stop();
