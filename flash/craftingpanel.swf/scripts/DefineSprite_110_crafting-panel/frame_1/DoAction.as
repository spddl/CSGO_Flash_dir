function InitCraftingPanel()
{
   ShowCraftingPanel();
   GetSortOptions();
   SetUpCraftingButtons();
   SetUpCraftingInventoryTiles();
   SetUpCraftingIngredientsTiles();
}
function SetUpCraftingButtons()
{
   Close.Action = function()
   {
      ClosePanel();
   };
   ButtonNext.dialog = this;
   ButtonNext.actionSound = "PageScroll";
   ButtonNext.Action = function()
   {
      this.dialog.onScrollForward(CraftingPanelInfo,RefreshCraftingItemTiles);
   };
   ButtonPrev.dialog = this;
   ButtonPrev.actionSound = "PageScroll";
   ButtonPrev.Action = function()
   {
      this.dialog.onScrollBackward(CraftingPanelInfo,RefreshCraftingItemTiles);
   };
   Ingredients.RemoveIngredients._visible = false;
   Ingredients.RemoveIngredients.dialog = this;
   Ingredients.RemoveIngredients.SetText("#SFUI_Crafting_Remove_Goods");
   Ingredients.RemoveIngredients.Action = function()
   {
      this.dialog.onRemoveAllIngredients();
   };
   Ingredients.Craft._visible = false;
   Ingredients.Craft.dialog = this;
   Ingredients.Craft.SetText("#SFUI_Crafting_Exchange");
   Ingredients.Craft.Action = function()
   {
      this.dialog.ShowBlackMarketForm();
   };
   StattrackSwapPanel.SubmitSwap._visible = false;
   StattrackSwapPanel.SubmitSwap.dialog = this;
   StattrackSwapPanel.SubmitSwap.actionSound = "ButtonLarge";
   StattrackSwapPanel.SubmitSwap.SetText("#SFUI_Crafting_Exchange");
   StattrackSwapPanel.SubmitSwap.Action = function()
   {
      m_numStatrakCounterAtZero = 0;
      m_numStatrakCounterAnimDone = 0;
      this.dialog.StartStattrakSwapAnim(StattrackSwapPanel.Module0,StattrackSwapPanel.Module1._StattrakValue);
      this.dialog.StartStattrakSwapAnim(StattrackSwapPanel.Module1,StattrackSwapPanel.Module0._StattrakValue);
   };
   StattrackSwapPanel.RemoveStattraks._visible = false;
   StattrackSwapPanel.RemoveStattraks.dialog = this;
   StattrackSwapPanel.RemoveStattraks.actionSound = "ButtonLarge";
   StattrackSwapPanel.RemoveStattraks.SetText("#SFUI_Stattrak_Remove");
   StattrackSwapPanel.RemoveStattraks.Action = function()
   {
      this.dialog.onRemoveAllStattraks();
   };
   StattrackSwapPanel.StattrakConfirm.Cancel.dialog = this;
   StattrackSwapPanel.StattrakConfirm.Cancel.SetText("#SFUI_Crafting_Cancel");
   StattrackSwapPanel.StattrakConfirm.Cancel.Action = function()
   {
      this.dialog.onCancelStattrakConfirm();
   };
   BlackMarketForm.RemoveIngredients._visible = false;
   BlackMarketForm.RemoveIngredients.dialog = this;
   BlackMarketForm.RemoveIngredients.SetText("#SFUI_Crafting_Cancel");
   BlackMarketForm.RemoveIngredients.Action = function()
   {
      this.dialog.onCancelCrafting();
   };
   BlackMarketForm.Craft._visible = false;
   BlackMarketForm.Craft.dialog = this;
   BlackMarketForm.Craft.SetText("#SFUI_Crafting_Sign");
   BlackMarketForm.Craft.Action = function()
   {
      this.dialog.OnCraft();
   };
   BlackMarketForm.Form.onMouseDown = function()
   {
      SignName(true);
   };
   BlackMarketForm.Form.onMouseUp = function()
   {
      SignName(false);
   };
   Market.dialog = this;
   Market.SetText("#SFUI_InvPanel_Market_Title");
   Market.Action = function()
   {
      this.dialog.FindOnMarket();
   };
   Tagline();
   Black.onRollOver = function()
   {
   };
   BlackMarketForm.Black.onRollOver = function()
   {
   };
}
function Tagline()
{
   var _loc1_ = Math.floor(Math.random() * 5 + 1);
   switch(_loc1_)
   {
      case 1:
         BlackMarketForm.Form.Text.TagLine.htmlText = "#SFUI_Crafting_Castle_TagLine1";
         break;
      case 2:
         BlackMarketForm.Form.Text.TagLine.htmlText = "#SFUI_Crafting_Castle_TagLine2";
         break;
      case 3:
         BlackMarketForm.Form.Text.TagLine.htmlText = "#SFUI_Crafting_Castle_TagLine3";
         break;
      case 4:
         BlackMarketForm.Form.Text.TagLine.htmlText = "#SFUI_Crafting_Castle_TagLine4";
         break;
      case 5:
         BlackMarketForm.Form.Text.TagLine.htmlText = "#SFUI_Crafting_Castle_TagLine5";
         break;
      case 6:
         BlackMarketForm.Form.Text.TagLine.htmlText = "#SFUI_Crafting_Castle_TagLine6";
   }
}
function SetUpCraftingInventoryTiles()
{
   var _loc3_ = 0;
   while(_loc3_ <= CraftingPanelInfo._TotalTiles)
   {
      var _loc2_ = CraftingInventory["item" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.RolledOver = function()
      {
         ShowHideToolTip(this,true,CraftingInventory);
         m_objCraftingHoverSelection = this;
      };
      _loc2_.RolledOut = function()
      {
         ShowHideToolTip(this,false,CraftingInventory);
         m_objCraftingHoverSelection = null;
      };
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         OpenContextMenu(this,false,false);
      };
      _loc3_ = _loc3_ + 1;
   }
}
function SetUpCraftingIngredientsTiles()
{
   var _loc3_ = 0;
   while(_loc3_ <= m_numMaxIngredients)
   {
      var _loc2_ = Ingredients["item" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.RolledOver = function()
      {
         ShowHideToolTip(this,true,Ingredients);
         m_objCraftingHoverSelection = this;
      };
      _loc2_.RolledOut = function()
      {
         ShowHideToolTip(this,false,Ingredients);
         m_objCraftingHoverSelection = null;
      };
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         OpenContextMenu(this,false,true);
      };
      _loc2_._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   _loc3_ = 0;
   while(_loc3_ <= 2)
   {
      _loc2_ = StattrackSwapPanel["item" + _loc3_];
      _loc2_.dialog = this;
      _loc2_.RolledOver = function()
      {
         ShowHideToolTip(this,true,StattrackSwapPanel);
         m_objCraftingHoverSelection = this;
      };
      _loc2_.RolledOut = function()
      {
         ShowHideToolTip(this,false,StattrackSwapPanel);
         m_objCraftingHoverSelection = null;
      };
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         OpenContextMenu(this,false,true);
      };
      _loc2_._visible = false;
      _loc3_ = _loc3_ + 1;
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
function OpenContextMenu(objTargetTile, bRightClick, bIngredients)
{
   var _loc6_ = SetToolTipPaths("Context");
   var _loc10_ = {x:objTargetTile._x + objTargetTile._width,y:objTargetTile._y};
   var _loc4_ = [];
   var _loc3_ = [];
   if(bIngredients)
   {
      _loc4_.push("removeIngredient");
      if(m_bInStattrackTransferUi)
      {
         _loc3_.push("#SFUI_Statrak_ContextMenu_Remove");
      }
      else
      {
         _loc3_.push("#SFUI_CraftContextMenu_Remove");
      }
   }
   else
   {
      _loc4_.push("addIngredient");
      if(m_bInStattrackTransferUi)
      {
         _loc3_.push("#SFUI_Statrak_ContextMenu_Add");
      }
      else
      {
         _loc3_.push("#SFUI_CraftContextMenu_Add");
      }
   }
   _loc4_.push("preview");
   _loc3_.push("#SFUI_InvContextMenu_preview");
   if(!bIngredients && _global.CScaleformComponent_Inventory.IsMarketable(m_PlayerXuid,objTargetTile._ItemID) == true)
   {
      _loc4_.push("seperator");
      _loc3_.push("");
      bAddSeperator = false;
      _loc4_.push("sell");
      _loc3_.push("#SFUI_InvContextMenu_sell");
   }
   _loc6_.TooltipShowHide(objTargetTile);
   _loc6_.TooltipLayout(_loc4_,_loc3_,objTargetTile,this.AssignContextMenuAction);
   _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide();
}
function AssignContextMenuAction(strMenuItem, objTargetTile)
{
   switch(strMenuItem)
   {
      case "addIngredient":
         AddIngredients(objTargetTile.GetItemId());
         _global.navManager.PlayNavSound("ButtonLarge");
         break;
      case "removeIngredient":
         RemoveIngredients(objTargetTile.GetItemId());
         _global.navManager.PlayNavSound("StoreRollover");
         break;
      case "preview":
         PreviewItem(objTargetTile,false);
         break;
      case "sell":
         SellItemOnMarketPlace(objTargetTile);
   }
   RefreshCraftingItemTiles();
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
function AddIngredients(ItemId)
{
   if(m_bInStattrackTransferUi)
   {
      var _loc3_ = false;
      var _loc2_ = 0;
      while(_loc2_ < m_aStattrackSwapItemIds.length)
      {
         if(m_aStattrackSwapItemIds[_loc2_] == ItemId)
         {
            _loc3_ = true;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(_loc3_ == false)
      {
         m_aStattrackSwapItemIds.push(ItemId);
      }
      StattrackSwapDisplayInputOutput();
      var _loc5_ = m_aStattrackSwapItemIds.length;
      trace("---------------------------ADD--------------------Item1: " + m_aStattrackSwapItemIds[0] + ";item2: " + m_aStattrackSwapItemIds[1]);
      trace("---------------------------ADD--------------------Item1: " + _loc5_);
   }
   else
   {
      _global.CScaleformComponent_Inventory.AddCraftIngredient(ItemId);
      DisplayInputOutput();
   }
   RefreshCraftingItemTiles();
}
function RemoveIngredients(ItemId)
{
   if(m_bInStattrackTransferUi)
   {
      var _loc2_ = 0;
      while(_loc2_ < m_aStattrackSwapItemIds.length)
      {
         if(m_aStattrackSwapItemIds[_loc2_] == ItemId)
         {
            m_aStattrackSwapItemIds.splice(_loc2_,1);
         }
         _loc2_ = _loc2_ + 1;
      }
      StattrackSwapDisplayInputOutput();
      var _loc4_ = m_aStattrackSwapItemIds.length;
      trace("---------------------------REMOVE--------------------Item1: " + m_aStattrackSwapItemIds[0] + ";item2: " + m_aStattrackSwapItemIds[1]);
      trace("---------------------------ADD--------------------Item1: " + _loc4_);
   }
   else
   {
      _global.CScaleformComponent_Inventory.RemoveCraftIngredient(ItemId);
      DisplayInputOutput();
   }
   RefreshCraftingItemTiles();
}
function onRemoveAllIngredients()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetCraftIngredientCount();
   i = 0;
   while(i < _loc3_)
   {
      var _loc2_ = Ingredients["item" + i];
      _global.CScaleformComponent_Inventory.RemoveCraftIngredient(_loc2_.GetItemId());
      i++;
   }
   DisplayInputOutput();
   ScrollReset();
   RefreshCraftingItemTiles();
}
function onRemoveAllStattraks()
{
   m_aStattrackSwapItemIds = [];
   StattrackSwapDisplayInputOutput();
   ScrollReset();
   RefreshCraftingItemTiles();
}
function FindOnMarket()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetMarketCraftCompletionLink();
   if(_global.CScaleformComponent_SteamOverlay.IsEnabled())
   {
      _global.CScaleformComponent_SteamOverlay.OpenURL(_loc3_);
   }
   else
   {
      ClosePanel();
      this._parent.Inventory.ErrorSteamOverlayDisabled();
   }
}
function ShowBlackMarketForm()
{
   Ingredients.Craft._visible = false;
   Ingredients.RemoveIngredients._visible = false;
   BlackMarketForm.Form.Stamp._visible = false;
   BlackMarketForm.Craft._visible = true;
   BlackMarketForm.Craft.setDisabled(true);
   BlackMarketForm.RemoveIngredients._visible = true;
   BlackMarketForm.RemoveIngredients.setDisabled(false);
   BlackMarketForm._visible = true;
   BlackMarketForm.gotoAndPlay("StartAnim");
   BlackMarketForm.Form.SignGlow._visible = true;
   BlackMarketForm.Form.SignGlow.gotoAndPlay("StartAnim");
   _global.navManager.PlayNavSound("PageScroll");
   TypeWriterAnim();
   Tagline();
}
function OnCraft()
{
   BlackMarketForm.Craft.setDisabled(true);
   BlackMarketForm.RemoveIngredients.setDisabled(true);
   _global.CScaleformComponent_Inventory.CraftIngredients();
   GetIndredientsName();
}
function onCancelCrafting()
{
   BlackMarketForm.Craft._visible = false;
   BlackMarketForm.RemoveIngredients._visible = false;
   BlackMarketForm.Form.SignGlow._visible = false;
   BlackMarketForm.Form.SignGlow.gotoAndStop("Reset");
   CancelAnims();
   RefreshCraftingItemTiles();
   GetActiveCraftIngredients();
}
function onConfirmStattrakSwap(ToolId)
{
   if(ToolId != null && ToolId != undefined && ToolId != "")
   {
      var _loc3_ = _global.CScaleformComponent_Inventory.SetStatTrakSwapToolItems(m_PlayerXuid,m_aStattrackSwapItemIds[0],m_aStattrackSwapItemIds[1]);
      if(_loc3_)
      {
         _global.CScaleformComponent_Inventory.UseTool(m_PlayerXuid,ToolId,"");
      }
   }
   trace("------------------------------------------onConfirmStattrakSwap--:" + _loc3_);
   ClosePanel();
   this._parent.Inventory.onActionItemCancel();
}
function onCancelStattrakConfirm()
{
   StattrackSwapPanel.StattrakConfirm._visible = false;
   StattrackSwapDisplayInputOutput();
}
function DisplayInputOutput()
{
   var _loc4_ = _global.CScaleformComponent_Inventory.GetMaxCraftIngredientsNeeded();
   var _loc3_ = _global.CScaleformComponent_Inventory.GetCraftIngredientCount();
   var _loc2_ = _global.GameInterface.Translate("#SFUI_Crafting_Items_Remain");
   _loc2_ = _global.ConstructString(_loc2_,"<b><font color=\'#FFFFFF\'>" + _loc3_ + "/" + _loc4_ + "</font></b>");
   IngCount.htmlText = _loc2_;
   IngCount._visible = true;
   GetActiveCraftIngredients();
}
function StattrackSwapDisplayInputOutput()
{
   var _loc4_ = 2;
   var _loc3_ = m_aStattrackSwapItemIds.length;
   var _loc2_ = _global.GameInterface.Translate("#SFUI_Stattrak_Swap_Remain");
   _loc2_ = _global.ConstructString(_loc2_,"<b><font color=\'#FFFFFF\'>" + _loc3_ + "/" + _loc4_ + "</font></b>");
   IngCount.htmlText = _loc2_;
   IngCount._visible = true;
   delete StattrackSwapPanel.Module0.onEnterFrame;
   delete StattrackSwapPanel.Module1.onEnterFrame;
   GetSelectionsForStattrackSwap();
}
function UpdateMessagePanel(Messsage)
{
   Warning.Message.Text.Text.htmlText = Messsage;
   Warning.gotoAndPlay("StartAnim");
}
function ResetCraftingSettings()
{
   _global.CScaleformComponent_Inventory.ClearCraftIngredients();
   m_strCraftingSortDropdown = "newest";
   FakeCraftedItem.SetItemInfo("","");
   m_aStattrackSwapItemIds = [];
   CancelAnims();
}
function CancelAnims()
{
   BlackMarketForm._visible = false;
   BlackMarketForm.gotoAndPlay("Reset");
   delete BlackMarketForm.onEnterFrame;
   delete Canvas.onEnterFrame;
   delete StattrackSwapPanel.Module0.onEnterFrame;
   delete StattrackSwapPanel.Module1.onEnterFrame;
   BlackMarketForm.Form.SignGlow._visible = false;
   BlackMarketForm.Form.SignGlow.gotoAndStop("Reset");
   Canvas.line.removeMovieClip();
}
function ShowCraftingPanel()
{
   this._visible = true;
}
function ClosePanel()
{
   this._visible = false;
   this._parent.onSelectTitleBarButton(this._parent.InventoryButton);
   ResetCraftingSettings();
}
function OnCraftedItemAcknowlege()
{
   ResetCraftingSettings();
   RefreshCraftingItemTiles();
   GetActiveCraftIngredients();
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
function SetCraftDropdownSort(strDropdownOption)
{
   m_strCraftingSortDropdown = strDropdownOption;
   ScrollReset();
   RefreshCraftingItemTiles();
}
function InitRecipe(RecipeId)
{
   m_bInStattrackTransferUi = false;
   SetStateForStattrackTranfer();
   var _loc4_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,RecipeId,"recipe filter");
   _global.CScaleformComponent_Inventory.ClearCraftIngredients();
   _global.CScaleformComponent_Inventory.SetCraftTarget(_loc4_);
   Title.htmlText = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,RecipeId);
   UpdateMessagePanel("#CSGO_Recipe_TradeUp_Desc_html");
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,RecipeId,"preferred sort");
   m_strCraftingSortDropdown = _global.CScaleformComponent_Inventory.GetSortMethodByIndex(_loc3_);
   SortDropdown.SetUpDropDown(aFilterSort,"#SFUI_InvPanel_sort_title","#SFUI_InvPanel_sort_",this.SetCraftDropdownSort,m_strCraftingSortDropdown);
   DisplayInputOutput();
   RefreshCraftingItemTiles();
}
function InitSwapStatTrack(ToolId)
{
   m_bInStattrackTransferUi = true;
   SetStateForStattrackTranfer();
   StattrackSwapPanel.StattrakConfirm.Craft.dialog = this;
   StattrackSwapPanel.StattrakConfirm.Craft.SetText("#SFUI_Stattrak_Swap_Confirm");
   StattrackSwapPanel.StattrakConfirm.Craft.Action = function()
   {
      this.dialog.onConfirmStattrakSwap(ToolId);
   };
   _global.CScaleformComponent_Inventory.ClearCraftIngredients();
   Title.htmlText = "#CSGO_Swap_Stattrak_Title";
   UpdateMessagePanel("#CSGO_Swap_Stattrak_Desc_html");
   m_strCraftingSortDropdown = aFilterSort[0];
   SortDropdown.SetUpDropDown(aFilterSort,"#SFUI_InvPanel_sort_title","#SFUI_InvPanel_sort_",this.SetCraftDropdownSort,m_strCraftingSortDropdown);
   IngCount._visible = false;
   StattrackSwapDisplayInputOutput();
   RefreshCraftingItemTiles();
}
function SetStateForStattrackTranfer()
{
   Market._visible = !m_bInStattrackTransferUi;
   Ingredients._visible = !m_bInStattrackTransferUi;
   StattrackSwapPanel._visible = m_bInStattrackTransferUi;
   m_aStattrackSwapItemIds = [];
}
function RefreshCraftingItemTiles()
{
   if(m_bInStattrackTransferUi)
   {
      var _loc8_ = "";
      if(m_aStattrackSwapItemIds.length == 2)
      {
         _loc8_ = "@returnnoitemszzxx123";
      }
      else if(m_aStattrackSwapItemIds.length > 0)
      {
         var _loc12_ = _global.CScaleformComponent_Inventory.GetSlot(m_PlayerXuid,m_aStattrackSwapItemIds[0]);
         var _loc10_ = _global.CScaleformComponent_Inventory.GetSlotSubPosition(m_PlayerXuid,m_aStattrackSwapItemIds[0]);
         if(_loc12_ == "melee" && _loc10_ == "melee")
         {
            _loc8_ = _loc10_;
         }
         else
         {
            _loc8_ = "item_definition:" + _global.CScaleformComponent_Inventory.GetItemDefinitionName(m_aStattrackSwapItemIds[0]);
         }
         trace("----------------------------------------------------strWeaponType--" + _loc8_);
      }
      _global.CScaleformComponent_Inventory.SetInventorySortAndFilters(m_PlayerXuid,m_strCraftingSortDropdown,false,_loc8_ + ",not_base_item,has_attribute:kill eater","");
      var _loc9_ = _global.GameInterface.Translate("#SFUI_Stattrak_Swap_Inv");
      CraftingPanelInfo._m_numItems = _global.CScaleformComponent_Inventory.GetInventoryCount();
      if(m_aStattrackSwapItemIds.length > 0)
      {
         var _loc7_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,m_aStattrackSwapItemIds[0],"kill eater");
         var _loc6_ = 0;
         var _loc5_ = [];
         var _loc2_ = 0;
         while(_loc2_ < CraftingPanelInfo._m_numItems)
         {
            var _loc3_ = _global.CScaleformComponent_Inventory.GetInventoryItemIDByIndex(_loc2_);
            var _loc4_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,_loc3_,"kill eater");
            if(_loc7_ == _loc4_)
            {
               _loc6_ = _loc6_ + 1;
            }
            else
            {
               _loc5_.push(_loc3_);
            }
            _loc2_ = _loc2_ + 1;
         }
         CraftingPanelInfo._m_numItems = CraftingPanelInfo._m_numItems - _loc6_;
         if(CraftingPanelInfo._m_numItems == 0)
         {
            SortDropdown._visible = false;
         }
      }
   }
   else
   {
      _global.CScaleformComponent_Inventory.SetInventorySortAndFilters(m_PlayerXuid,m_strCraftingSortDropdown,false,"recipe");
      _loc9_ = _global.GameInterface.Translate("#SFUI_Crafting_Items_Inv");
      CraftingPanelInfo._m_numItems = _global.CScaleformComponent_Inventory.GetInventoryCount();
   }
   _loc9_ = _global.ConstructString(_loc9_,"<b><font color=\'#FFFFFF\'>" + CraftingPanelInfo._m_numItems + "</font></b>");
   ItemCount.htmlText = _loc9_;
   _loc2_ = 0;
   while(_loc2_ < CraftingPanelInfo._TotalTiles)
   {
      SetCraftingInventoryItemTiles(_loc2_,CraftingPanelInfo._m_numTopItemTile + _loc2_,_loc5_);
      _loc2_ = _loc2_ + 1;
   }
   EnableDisableScrollButtons(CraftingPanelInfo);
   UpdatePageCount(CraftingPanelInfo);
   var _loc13_ = GetCurrentPageNumber(CraftingPanelInfo._m_numTopItemTile,CraftingPanelInfo._TotalTiles);
   var _loc11_ = GetPageCount(CraftingPanelInfo._m_numItems,CraftingPanelInfo._SelectableTiles);
   if(_loc13_ > _loc11_)
   {
      ScrollReset(CraftingPanelInfo);
   }
}
function SetCraftingInventoryItemTiles(numTile, numItemIndex, aStatTrakWithNoDupValues)
{
   var _loc2_ = CraftingInventory["item" + numTile];
   var _loc3_ = "";
   if(numItemIndex < 0 || numItemIndex > CraftingPanelInfo._m_numItems - 1)
   {
      _loc2_._visible = false;
      return undefined;
   }
   if(m_bInStattrackTransferUi && aStatTrakWithNoDupValues.length > 0)
   {
      _loc3_ = aStatTrakWithNoDupValues[numItemIndex];
   }
   else
   {
      _loc3_ = _global.CScaleformComponent_Inventory.GetInventoryItemIDByIndex(numItemIndex);
   }
   _loc2_.SetItemInfo(_loc3_,m_PlayerXuid,"Inventory");
   _loc2_._visible = true;
}
function GetActiveCraftIngredients()
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetCraftIngredientCount();
   SortDropdown._visible = true;
   i = 0;
   while(i < m_numMaxIngredients)
   {
      DisplayActiveCraftIngredients(i,_loc2_);
      i++;
   }
   if(_loc2_ > 0)
   {
      Ingredients.RemoveIngredients._visible = true;
      Ingredients.Craft._visible = true;
      Ingredients.Craft.setDisabled(true);
   }
   else if(_loc2_ == 0)
   {
      Ingredients.RemoveIngredients._visible = false;
      Ingredients.Craft._visible = false;
   }
   if(_global.CScaleformComponent_Inventory.IsCraftReady())
   {
      Ingredients.Craft.setDisabled(false);
      SortDropdown._visible = false;
   }
}
function GetSelectionsForStattrackSwap()
{
   var _loc6_ = m_aStattrackSwapItemIds.length;
   SortDropdown._visible = true;
   StattrackSwapPanel.StattrakConfirm._visible = false;
   StattrackSwapPanel.SubmitSwap.setDisabled(true);
   i = 0;
   while(i < 2)
   {
      var _loc3_ = StattrackSwapPanel["item" + i];
      var _loc2_ = StattrackSwapPanel["Module" + i];
      var _loc5_ = "";
      if(i < 0 || i > _loc6_ - 1)
      {
         _loc3_._visible = false;
         _loc2_._visible = false;
      }
      else
      {
         _loc3_.SetItemInfo(m_aStattrackSwapItemIds[i],m_PlayerXuid,"Inventory");
         _loc3_._visible = true;
         _loc2_._visible = true;
         var _loc4_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,m_aStattrackSwapItemIds[i],"kill eater");
         _loc2_._StattrakValue = _loc4_;
         _loc2_.Text.htmlText = FormatStattrakNumber(_loc4_);
      }
      i++;
   }
   if(_loc6_ > 0)
   {
      StattrackSwapPanel.RemoveStattraks._visible = true;
      StattrackSwapPanel.SubmitSwap._visible = true;
   }
   else if(_loc6_ == 0)
   {
      StattrackSwapPanel.SubmitSwap._visible = false;
      StattrackSwapPanel.RemoveStattraks._visible = false;
   }
   if(_loc6_ == 2)
   {
      if(_global.CScaleformComponent_Inventory.CanUseStattTrakSwap(m_aStattrackSwapItemIds[0],m_aStattrackSwapItemIds[1]))
      {
         trace("-------------------------------------CAN-USE----:" + _global.CScaleformComponent_Inventory.CanUseStattTrakSwap(m_aStattrackSwapItemIds[0],m_aStattrackSwapItemIds[1]));
         trace("-------------------------------------killeater1----:" + _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,m_aStattrackSwapItemIds[0],"kill eater"));
         trace("-------------------------------------killeater1----:" + _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,m_aStattrackSwapItemIds[1],"kill eater"));
         StattrackSwapPanel.SubmitSwap.setDisabled(false);
         SortDropdown._visible = false;
      }
   }
}
function DisplayActiveCraftIngredients(numTile, numIngredientCount)
{
   var _loc2_ = Ingredients["item" + numTile];
   var _loc4_ = "";
   if(numTile < 0 || numTile > numIngredientCount - 1)
   {
      _loc2_._visible = false;
      return undefined;
   }
   _loc4_ = _global.CScaleformComponent_Inventory.GetCraftIngredientByIndex(numTile);
   _loc2_.SetItemInfo(_loc4_,m_PlayerXuid,"Inventory");
   _loc2_._visible = true;
}
function SetCraftedItem(CraftedItemId)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,CraftedItemId);
   FakeCraftedItem.SetItemInfo(CraftedItemId,m_PlayerXuid,"Inventory");
}
function ShowNewItemFromCratePanel()
{
   PreviewItem(FakeCraftedItem,true);
   _global.navManager.PlayNavSound("NewItem");
}
function PreviewItem(objTargetTile, NewItemFromCrafting)
{
   var _loc2_ = SetToolTipPaths("Preview");
   _loc2_.ShowHidePreview(true,objTargetTile.GetName(),objTargetTile.GetRarityColor());
   _loc2_.SetModel(objTargetTile.GetDefaultItemModelPath());
   if(NewItemFromCrafting)
   {
      _loc2_.ShowNewItemAcceptButton(this.OnCraftedItemAcknowlege);
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
function GetDate()
{
   WEEKDAYS = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
   MONTHS = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
   var _loc1_ = new Date();
   var _loc2_ = WEEKDAYS[_loc1_.getDay()];
   var _loc4_ = MONTHS[_loc1_.getMonth()];
   var _loc6_ = _loc1_.getDate();
   var _loc3_ = _loc1_.getFullYear();
   var _loc5_ = _loc2_ + ", " + _loc4_ + " " + _loc6_ + ", " + _loc3_;
   return _loc5_;
}
function GetRandomString(srtLenght)
{
   var _loc2_ = "0123456789";
   var _loc4_ = _loc2_.length - 1;
   var _loc3_ = "";
   var _loc1_ = 0;
   while(_loc1_ < srtLenght)
   {
      _loc3_ = _loc3_ + _loc2_.charAt(Math.floor(Math.random() * _loc4_));
      _loc1_ = _loc1_ + 1;
   }
   return _loc3_;
}
function TypeWriterAnim()
{
   var _loc3_ = new Array();
   var _loc2_ = 0;
   while(_loc2_ <= 18)
   {
      _loc3_[_loc2_] = "#SFUI_ELO_RankName_" + _loc2_;
      _loc2_ = _loc2_ + 1;
   }
   var Name = _global.CScaleformComponent_FriendsList.GetFriendName(m_PlayerXuid);
   var DateText = GetDate();
   var FormNumber = GetRandomString(12);
   var _loc4_ = _global.CScaleformComponent_FriendsList.GetFriendCompetitiveRank(m_PlayerXuid);
   var Rank = _global.GameInterface.Translate(_loc3_[_loc4_]);
   var numItemsSent = _global.CScaleformComponent_Inventory.GetMaxCraftIngredientsNeeded().toString();
   var Speed = 0;
   var WordCount = 0;
   var _loc5_ = 0;
   ResetFormTextStrings();
   LargestField = [Name.length,Rank.length,DateText.length,FormNumber.length,numItemsSent.length];
   LargestField.sort(Array.NUMERIC);
   BlackMarketForm.onEnterFrame = function()
   {
      if(Speed == 2)
      {
         if(Name.length != BlackMarketForm.Form.Text.Name.length)
         {
            BlackMarketForm.Form.Text.Name.htmlText = Name.substr(0,WordCount);
         }
         if(Rank.length != BlackMarketForm.Form.Text.Rank.length)
         {
            BlackMarketForm.Form.Text.Rank.htmlText = Rank.substr(0,WordCount);
         }
         if(DateText.length != BlackMarketForm.Form.Text.Date.length)
         {
            BlackMarketForm.Form.Text.Date.htmlText = DateText.substr(0,WordCount);
         }
         if(FormNumber.length != BlackMarketForm.Form.Text.FormNumber.length)
         {
            BlackMarketForm.Form.Text.FormNumber.htmlText = FormNumber.substr(0,WordCount);
         }
         if(numItemsSent.length != BlackMarketForm.Form.Text.GoodsSent.length)
         {
            BlackMarketForm.Form.Text.GoodsSent.htmlText = numItemsSent.substr(0,WordCount);
         }
         PlayTypingSound();
         WordCount++;
         Speed = 0;
         if(WordCount == LargestField[4] + 1)
         {
            delete BlackMarketForm.onEnterFrame;
         }
      }
      Speed++;
   };
}
function ResetFormTextStrings()
{
   BlackMarketForm.Form.Text.Name.htmlText = "";
   BlackMarketForm.Form.Text.Rank.htmlText = "";
   BlackMarketForm.Form.Text.Date.htmlText = "";
   BlackMarketForm.Form.Text.FormNumber.htmlText = "";
   BlackMarketForm.Form.Text.GoodsSent.htmlText = "";
   BlackMarketForm.Form.Text.GoodsReceived.htmlText = "";
   var _loc1_ = 0;
   while(_loc1_ <= 12)
   {
      var _loc2_ = BlackMarketForm.Form.Text["Good" + _loc1_];
      _loc2_.htmlText = "";
      _loc1_ = _loc1_ + 1;
   }
}
function GetIndredientsName()
{
   var _loc4_ = new Array();
   var _loc5_ = _global.CScaleformComponent_Inventory.GetCraftIngredientCount();
   i = 0;
   while(i < _loc5_)
   {
      var _loc3_ = _global.CScaleformComponent_Inventory.GetCraftIngredientByIndex(i);
      var _loc2_ = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,_loc3_);
      _loc4_.push(_loc2_);
      i++;
   }
   RevelItemsOnForm(_loc4_);
}
function RevelItemsOnForm(aNames)
{
   var WordCount = 0;
   var Index = 0;
   BlackMarketForm.onEnterFrame = function()
   {
      if(Index == aNames.length)
      {
         if(FakeCraftedItem.GetItemId() == null || FakeCraftedItem.GetItemId() == "" || FakeCraftedItem.GetItemId() == undefined)
         {
            delete BlackMarketForm.onEnterFrame;
            ClosePanel();
            this._parent._parent.Inventory.ErrorNoItemFromCrate();
            return undefined;
         }
         delete BlackMarketForm.onEnterFrame;
         RevealCraftedItem();
         return undefined;
      }
      if(aNames[Index].length != BlackMarketForm.Form.Text["Good" + Index].length)
      {
         BlackMarketForm.Form.Text["Good" + Index].htmlText = aNames[Index].substr(0,WordCount);
         PlayTypingSound();
      }
      if(WordCount >= aNames[Index].length)
      {
         Index++;
         WordCount = 0;
      }
      WordCount++;
   };
}
function RevealCraftedItem()
{
   var Item = FakeCraftedItem.GetName();
   var _loc3_ = 0;
   var WordCount = 0;
   BlackMarketForm.onEnterFrame = function()
   {
      if(Item.length != BlackMarketForm.Form.Text.GoodsReceived.length)
      {
         BlackMarketForm.Form.Text.GoodsReceived.htmlText = Item.substr(0,WordCount);
         PlayTypingSound();
      }
      if(WordCount == Item.length + 5)
      {
         BlackMarketForm.Form.Stamp._visible = true;
         BlackMarketForm.Form.Stamp.gotoAndPlay("StartAnim");
         _global.navManager.PlayNavSound("AcceptSeal");
      }
      if(WordCount >= Item.length + 20)
      {
         ShowNewItemFromCratePanel();
         ClosePanel();
         this._parent._parent.Inventory.ResetSettings();
         this._parent._parent.InitInventoryPanelMasterShowInventory();
         this._parent._parent.Inventory.SetInventoryDropdownSort("newest");
         delete BlackMarketForm.onEnterFrame;
         return undefined;
      }
      WordCount++;
   };
}
function SignName(drawing)
{
   var bHasSigned = false;
   Canvas.createEmptyMovieClip("line",Canvas.getNextHighestDepth());
   Canvas.line.lineStyle(2,3099511,100);
   Canvas.line.moveTo(_xmouse,_ymouse);
   Canvas.onEnterFrame = function()
   {
      var _loc2_ = {x:_xmouse,y:_ymouse};
      if(drawing == false)
      {
         Canvas.line.moveTo(_loc2_.x,_loc2_.y);
      }
      if(drawing)
      {
         if(Canvas.hitTest(_root._xmouse,_root._ymouse,true))
         {
            Canvas.line.lineTo(_loc2_.x,_loc2_.y);
            if(!bHasSigned)
            {
               BlackMarketForm.Craft.setDisabled(false);
               bHasSigned = true;
            }
         }
      }
   };
}
function PlayTypingSound()
{
   var _loc2_ = Math.floor(Math.random() * 4 + 1);
   switch(_loc2_)
   {
      case 1:
         _global.navManager.PlayNavSound("TypeWriter1");
         break;
      case 2:
         _global.navManager.PlayNavSound("TypeWriter2");
         break;
      case 3:
         _global.navManager.PlayNavSound("TypeWriter3");
         break;
      case 4:
         _global.navManager.PlayNavSound("TypeWriter4");
         break;
      case 5:
         _global.navManager.PlayNavSound("TypeWriter5");
   }
}
function IsWaitingForCraftingItem()
{
   return BlackMarketForm._visible;
}
function StartStattrakSwapAnim(objStattrackModule, numTarget)
{
   StattrackSwapPanel.SubmitSwap.setDisabled(true);
   StattrackSwapPanel.StattrakConfirm._visible = true;
   StattrackSwapPanel.StattrakConfirm.Craft.setDisabled(true);
   var bCountUp = false;
   var numValue = objStattrackModule._StattrakValue;
   var numWait = 0;
   var numMuliplier = 2 * numValue / 128;
   var numMuliplierTarget = 2 * numTarget / 128;
   objStattrackModule.onEnterFrame = function()
   {
      if(numValue > 0 && !bCountUp)
      {
         numValue = Math.floor(numValue = numValue - numMuliplier);
         if(numValue < 0)
         {
            numValue = 0;
         }
         objStattrackModule.Text.htmlText = FormatStattrakNumber(numValue);
         _global.navManager.PlayNavSound("ButtonRollover");
      }
      else if(numValue <= 0 && !bCountUp)
      {
         bCountUp = true;
         numValue = 0;
         objStattrackModule.Text.htmlText = FormatStattrakNumber(numValue);
         m_numStatrakCounterAtZero++;
         _global.navManager.PlayNavSound("ItemScroll");
      }
      if(m_numStatrakCounterAtZero == 2 && numWait < 8)
      {
         numWait++;
      }
      if(numValue < numTarget && bCountUp && numWait >= 8)
      {
         numValue = Math.ceil(numValue = numValue + numMuliplierTarget);
         if(numValue > numTarget)
         {
            numValue = numTarget;
         }
         objStattrackModule.Text.htmlText = FormatStattrakNumber(numValue);
         _global.navManager.PlayNavSound("ButtonRollover");
      }
      else if(numValue >= numTarget && bCountUp)
      {
         objStattrackModule.Text.htmlText = FormatStattrakNumber(numTarget);
         _global.navManager.PlayNavSound("ItemScroll");
         m_numStatrakCounterAnimDone++;
         if(m_numStatrakCounterAnimDone == 2)
         {
            StattrackSwapPanel.StattrakConfirm.Craft.setDisabled(false);
         }
         delete objStattrackModule.onEnterFrame;
      }
   };
}
function FormatStattrakNumber(numValue)
{
   var _loc2_ = "";
   switch(true)
   {
      case numValue < 10:
         _loc2_ = "00000" + numValue;
         break;
      case numValue < 100:
         _loc2_ = "0000" + numValue;
         break;
      case numValue < 1000:
         _loc2_ = "000" + numValue;
         break;
      case numValue < 10000:
         _loc2_ = "00" + numValue;
         break;
      case numValue < 100000:
         _loc2_ = "0" + numValue;
         break;
      case numValue <= 999999:
         _loc2_ = "" + numValue;
         break;
      case numValue > 999999:
         _loc2_ = "999999";
   }
   trace("-------------------------------strFormatedValue------------------" + _loc2_);
   return _loc2_;
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
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var m_strCraftingSortDropdown = "";
var aFilterSort = [];
var m_aStattrackSwapItemIds = [];
var m_objCraftingHoverSelection = null;
var m_numMaxIngredients = 10;
var m_bInStattrackTransferUi = false;
var m_numStatrakCounterAtZero = 0;
var m_numStatrakCounterAnimDone = 0;
var CraftingPanelInfo = new Object();
CraftingPanelInfo._TotalTiles = 24;
CraftingPanelInfo._TotalTilesInCrate = 12;
CraftingPanelInfo._SelectableTiles = 12;
CraftingPanelInfo._StartPos = CraftingInventory._x;
CraftingPanelInfo._EndPos = CraftingInventory._x - CraftingInventory._width / 2 - 21;
CraftingPanelInfo._PrevButton = ButtonPrev;
CraftingPanelInfo._NextButton = ButtonNext;
CraftingPanelInfo._AnimObject = CraftingInventory;
CraftingPanelInfo._PageCountObject = PageCount;
CraftingPanelInfo._m_numItems = 0;
CraftingPanelInfo._m_numTopItemTile = 0;
BlackMarketForm._visible = false;
BlackMarketForm.Form.SignGlow._visible = false;
stop();
