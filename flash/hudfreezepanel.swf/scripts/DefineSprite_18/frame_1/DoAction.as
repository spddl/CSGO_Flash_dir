function SetItemInfo(strId, PlayerXuid, TileDesc)
{
   SetIdXuidType(strId,PlayerXuid,TileDesc);
}
function SetIdXuidType(strId, PlayerXuid, TileDesc)
{
   var _loc2_ = "";
   var _loc3_ = "";
   this._ItemID = strId;
   this._ItemXuid = PlayerXuid;
   this._IsEmpty = false;
   this._StatTrakKills = -1;
   UnusualItemEffect._visible = false;
   UnusualItemEffect.gotoAndStop("StopAnim");
   GetItemData(TileDesc);
}
function SetItemInfoHideEquippedStatus(strId, PlayerXuid)
{
   this._ItemID = strId;
   this._ItemXuid = PlayerXuid;
   this._IsEmpty = false;
   this._StatTrakKills = -1;
   UnusualItemEffect._visible = false;
   UnusualItemEffect.gotoAndStop("StopAnim");
   GetItemData("HideEquipped");
}
function SetInfoForLoadoutItems(PlayerXuid, Team, strWeaponSlot)
{
   var _loc3_ = "";
   var _loc4_ = _global.CScaleformComponent_Loadout.GetItemID(PlayerXuid,Team,strWeaponSlot.toString());
   this._ItemID = _loc4_;
   this._ItemXuid = PlayerXuid;
   this._ItemType = _loc3_;
   UnusualItemEffect._visible = false;
   UnusualItemEffect.gotoAndStop("StopAnim");
   GetItemData("Loadout");
}
function SetInfoForHudDropItem(strId, fauxItemId, PlayerXuid, numDropReason)
{
   this._ItemID = strId;
   this._FauxItemId = fauxItemId;
   this._ItemXuid = PlayerXuid;
   this._DropReason = numDropReason;
   UnusualItemEffect._visible = false;
   UnusualItemEffect.gotoAndStop("StopAnim");
   GetItemData("Drop");
}
function SetInfoForHudSpecItem(strId, defIndex, PlayerXuid, nPaintIndex, nRarity, nQuality, nPaintWear, nPaintSeed, nStatTrakKills)
{
   this._ItemID = strId;
   this._DefIndex = defIndex;
   this._ItemXuid = PlayerXuid;
   this._Rarity = nRarity;
   this._PaintIndexID = nPaintIndex;
   this._Quality = nQuality;
   this._PaintWear = nPaintWear;
   this._PaintSeed = nPaintSeed;
   this._StatTrakKills = nStatTrakKills;
   UnusualItemEffect._visible = false;
   UnusualItemEffect.gotoAndStop("StopAnim");
   GetItemData("Spec");
}
function SetItemInfoStatTrak(strId, PlayerXuid, StatTrakKills)
{
   this._ItemID = strId;
   this._ItemXuid = PlayerXuid;
   this._IsEmpty = false;
   this._StatTrakKills = StatTrakKills;
   UnusualItemEffect._visible = false;
   UnusualItemEffect.gotoAndStop("StopAnim");
   GetItemData("HideEquipped");
}
function SetItemInfoForStore(srtBundleID, PlayerXuid)
{
   if(!_global.CScaleformComponent_Store.IsBundle(srtBundleID))
   {
      this._ItemID = srtBundleID;
      Quantity._visible = true;
   }
   else
   {
      var _loc5_ = _global.CScaleformComponent_Store.GetBundleItemCount(srtBundleID);
      if(_loc5_ == 1)
      {
         var _loc4_ = _global.CScaleformComponent_Store.GetBundleItemByIndex(srtBundleID,0);
         this._ItemID = _loc4_;
      }
      else
      {
         this._ItemID = srtBundleID;
      }
      Quantity._visible = false;
   }
   UnusualItemEffect._visible = false;
   UnusualItemEffect.gotoAndStop("StopAnim");
   this._ItemXuid = PlayerXuid;
   this._BundleID = srtBundleID;
   this._Quantity = 1;
   GetItemData("Store");
}
function SetItemInfoForExceedinglyRareItem(ItemId, PlayerXuid, ImagePath, ItemName)
{
   this._IsEmpty = false;
   this._ItemID = ItemId;
   this._ItemXuid = PlayerXuid;
   this._StatTrakKills = -1;
   trace("----------------------------------------!!!!!!PlayerXuid!!!!!!--------------------------------------" + PlayerXuid);
   UnusualItemEffect._visible = true;
   UnusualItemEffect.gotoAndPlay("StartAnim");
   GetItemData("RareItem");
   LoadItemImage(ImagePath,90,67);
   DisplayTileText(SeperateName(ItemName));
}
function SetTestItemInfo(SlotIndex, ItemIndex, ImagePath, ItemName, Rarity)
{
   this._IsEmpty = false;
   this._SlotIndex = SlotIndex;
   this._ItemIndex = ItemIndex;
   this._StatTrakKills = -1;
   LoadItemImage(ImagePath,90,67);
   DisplayTileText(SeperateName(ItemName));
   SetColor(Rarity);
   SetStickers(GetStickerCount());
   UnusualItemEffect._visible = false;
   UnusualItemEffect.gotoAndStop("StopAnim");
   CTDot._visible = false;
   TDot._visible = false;
   FlairDot._visible = false;
}
function GetItemData(TileDesc)
{
   if(this._ItemID == "" || this._ItemID == undefined)
   {
      return undefined;
   }
   if(this._ItemXuid == "" || this._ItemXuid == undefined)
   {
      return undefined;
   }
   var _loc5_ = _global.CScaleformComponent_Inventory.IsItemInfoValid(String(this._ItemXuid),String(this._ItemID));
   if(!_loc5_ && this._FauxItemId > 0)
   {
      this._ItemID = this._FauxItemId;
      trace("----GetItemData: This item doesn\'t not have data availible, falling back to a generic painted one: _DefIndex = " + this._DefIndex + ", _PaintIndexID = " + this._PaintIndexID);
   }
   switch(TileDesc)
   {
      case "Loadout":
         Name.ItemName.htmlText = GetName();
         SetColor(GetRarityColor());
         SetEquippedDot(IsEquippedCT(),IsEquippedT(),IsNoTeam(),GetTeam());
         SetGift("");
         SetQuest("");
         if(GetMoney() != 0 && GetMoney() != undefined)
         {
            Cost.htmlText = "$" + GetMoney();
         }
         else
         {
            MoneyBg._visible = false;
         }
         LoadItemImage(GetImagePath(),180,135);
         SetStickers(GetStickerCount());
         _global.AutosizeTextDown(Name.ItemName,8);
         break;
      case "Acknowledge":
         Name.ItemName.htmlText = GetName();
         SetColor(GetRarityColor());
         SetGift(GetItemGifter());
         SetQuest(GetItemPickUpMethod());
         SetEquippedDot(IsEquippedCT(),IsEquippedT(),IsNoTeam(),GetTeam());
         MoneyBg._visible = false;
         LoadItemImage(GetImagePath(),180,135);
         SetStickers(GetStickerCount());
         _global.AutosizeTextDown(Name.ItemName,8);
         break;
      case "RareItem":
         SetColor("#ffd700");
         SetStickers(GetStickerCount());
         CTDot._visible = false;
         TDot._visible = false;
         FlairDot._visible = false;
         break;
      case "Drop":
         var _loc3_ = "";
         if(this._DropReason == 1)
         {
            var _loc4_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(this._ItemXuid.toString(),this._ItemID.toString(),"quest");
            if(!_loc4_)
            {
               _loc3_ = "quest_reward";
            }
         }
         else
         {
            _loc3_ = "";
         }
         LoadItemImage(GetImagePath(),180,135);
         SetQuest(_loc3_);
         if(_loc4_)
         {
            Name.ItemName.htmlText = GetSeperateNameString(SeperateNameQuest(GetName()));
         }
         else
         {
            Name.ItemName.htmlText = GetSeperateNameString(SeperateName(GetName()));
         }
         SetColor(GetRarityColor());
         _global.AutosizeTextDown(Name.ItemName,12);
         break;
      case "Spec":
         this._ItemIdIsValid = _global.CScaleformComponent_Inventory.IsItemInfoValid(this._ItemXuid.toString(),this._ItemID.toString());
         Name.ItemName.htmlText = GetSeperateNameString(SeperateName(GetName()));
         LoadItemImage(GetImagePath(),176,132);
         SetColor(GetRarityColor());
         break;
      case "Store":
         DisplayTileText(SeperateName(GetName()));
         SetEquippedDot(IsEquippedCT(),IsEquippedT(),IsNoTeam(),GetTeam());
         SetColor(GetRarityColor());
         LoadItemImage(GetImagePath(),90,67);
         SetStorePriceData();
         SetUpQuantityButtons();
         SetStickers(GetStickerCount());
         CTDot._visible = false;
         TDot._visible = false;
         FlairDot._visible = false;
         break;
      case "HideEquipped":
         DisplayTileText(SeperateName(GetName()));
         SetColor(GetRarityColor());
         LoadItemImage(GetImagePath(),90,67);
         SetStickers(0);
         CTDot._visible = false;
         TDot._visible = false;
         FlairDot._visible = false;
         break;
      case "ImageOnly":
         LoadItemImage(GetImagePath(),90,67);
         SetStickers(GetStickerCount());
         break;
      default:
         DisplayTileText(SeperateName(GetName()));
         SetEquippedDot(IsEquippedCT(),IsEquippedT(),IsNoTeam(),GetTeam());
         SetColor(GetRarityColor());
         SetStickers(GetStickerCount());
         LoadItemImage(GetImagePath(),90,67);
   }
}
function SetUpQuantityButtons()
{
   QuantityBtn.Less.dialog = this;
   QuantityBtn.Less.Action = function()
   {
      this.dialog.ChangeQuantity(false);
   };
   QuantityBtn.More.dialog = this;
   QuantityBtn.More.Action = function()
   {
      this.dialog.ChangeQuantity(true);
   };
   var _loc4_ = _global.GameInterface.Translate("#SFUI_InvUse_Get_Quantity");
   _loc4_ = _global.ConstructString(_loc4_,1);
   QuantityBtn.Quantity.htmlText = _loc4_;
   BuyBtn.dialog = this;
   BuyBtn.Action = function()
   {
      this.dialog.Purchase();
   };
   if(this._Capability == "decodable")
   {
      var _loc3_ = _global.GameInterface.Translate("#SFUI_InvUse_Get_decodable");
   }
   else if(this._Capability == "nameable")
   {
      _loc3_ = _global.GameInterface.Translate("#SFUI_InvUse_Get_nameable");
   }
   _loc3_ = _global.ConstructString(_loc3_,GetStoreOriginalPrice());
   BuyBtn.OriginalPrice.Price.htmlText = _loc3_;
}
function ChangeQuantity(bAdd)
{
   if(bAdd && this._Quantity < 20)
   {
      this._Quantity = this._Quantity + 1;
   }
   else if(!bAdd && this._Quantity > 1)
   {
      this._Quantity = this._Quantity - 1;
   }
   var _loc3_ = _global.GameInterface.Translate("#SFUI_InvUse_Get_Quantity");
   _loc3_ = _global.ConstructString(_loc3_,this._Quantity);
   QuantityBtn.Quantity.htmlText = _loc3_;
   SetStorePriceData();
}
function Purchase()
{
   var _loc4_ = [];
   var _loc3_ = 0;
   while(_loc3_ < this._Quantity)
   {
      _loc4_.push(this._BundleID);
      _loc3_ = _loc3_ + 1;
   }
   var _loc5_ = _loc4_.join(",");
   _global.CScaleformComponent_Store.StoreItemPurchase(_loc5_);
}
function SetStorePriceData()
{
   var _loc5_ = GetStoreOriginalPrice();
   var _loc6_ = GetStoreSalePrice();
   var _loc4_ = GetStoreSalePercentReduction();
   if(_loc4_ == "" || _loc4_ == undefined)
   {
      BuyBtn.OriginalPrice._visible = true;
      BuyBtn.Discount._visible = false;
      BuyBtn.SalePrice._visible = false;
      if(this._Quantity > 1)
      {
         if(this._Capability == "decodable")
         {
            var _loc3_ = _global.GameInterface.Translate("#SFUI_InvUse_Get_decodable_multi");
         }
         else if(this._Capability == "nameable")
         {
            _loc3_ = _global.GameInterface.Translate("#SFUI_InvUse_Get_nameable_multi");
         }
      }
      else if(this._Capability == "decodable")
      {
         _loc3_ = _global.GameInterface.Translate("#SFUI_InvUse_Get_decodable");
      }
      else if(this._Capability == "nameable")
      {
         _loc3_ = _global.GameInterface.Translate("#SFUI_InvUse_Get_nameable");
      }
      _loc3_ = _global.ConstructString(_loc3_,_loc5_);
      BuyBtn.OriginalPrice.Price.htmlText = _loc3_;
   }
   else
   {
      BuyBtn.OriginalPrice._visible = false;
      BuyBtn.Discount._visible = true;
      BuyBtn.SalePrice._visible = true;
      BuyBtn.SalePrice.SalePrice.htmlText = _loc6_;
      BuyBtn.SalePrice.OriginalPrice.htmlText = _loc5_;
      BuyBtn.Discount.Percent.htmlText = _loc4_;
   }
}
function SetStickers(numStickerCount)
{
   if(numStickerCount > 0)
   {
      var _loc7_ = 7;
      var _loc3_ = 0;
      while(_loc3_ < _loc7_)
      {
         var _loc4_ = Stickers["Tile" + _loc3_];
         if(_loc3_ >= numStickerCount)
         {
            _loc4_._visible = false;
         }
         else
         {
            var _loc5_ = _global.CScaleformComponent_Inventory.GetItemStickerImageByIndex(this._ItemXuid,this._ItemID,_loc3_);
            var _loc6_ = _global.CScaleformComponent_Inventory.GetItemStickerNameByIndex(this._ItemXuid,this._ItemID,_loc3_);
            _loc4_._visible = true;
            LoadStickerImage(_loc4_,_loc5_,_loc6_);
         }
         _loc3_ = _loc3_ + 1;
      }
      Stickers._visible = true;
   }
   else
   {
      Stickers._visible = false;
   }
}
function LoadStickerImage(objTile, Path, Name)
{
   if(objTile.Image != undefined)
   {
      objTile.Image.unloadMovie();
   }
   var _loc1_ = new Object();
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = 12;
      target_mc._height = 9;
      target_mc.forceSmoothing = true;
   };
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("LoadSetImage: Error loading image: " + errorCode + " [" + status + "] ----- You probably forgot to author a small version of your flair item (needs to end with _small).");
   };
   var _loc4_ = Path + ".png";
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc4_,objTile.Image);
   objTile.Text.htmlText = Name;
}
function EnsureImageCached()
{
   _global.CScaleformComponent_ImageCache.EnsureInventoryImageCached(this._ItemID);
}
function GetName()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemName(this._ItemXuid,this._ItemID);
   if(this._StatTrakKills >= 0)
   {
      _loc3_ = _global.GameInterface.Translate("#strange") + " " + _loc3_;
   }
   return _loc3_;
}
function GetTeam()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemTeam(this._ItemXuid,this._ItemID);
   return _loc3_;
}
function GetRarityColor()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemRarityColor(this._ItemXuid,this._ItemID);
   return _loc3_;
}
function GetSlotID()
{
   trace("-------------------------------------------GetSlotID()" + _global.CScaleformComponent_Inventory.GetSlotSubPosition(this._ItemXuid,this._ItemID));
   var _loc3_ = _global.CScaleformComponent_Inventory.GetSlotSubPosition(this._ItemXuid,this._ItemID);
   return _loc3_;
}
function GetCatagory()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetSlot(this._ItemXuid,this._ItemID);
   return _loc3_;
}
function GetImagePath()
{
   if(this._ItemIdIsValid == false)
   {
      _global.CScaleformComponent_ImageCache.EnsureItemDataImageCached(this._DefIndex,this._PaintIndexID);
      var _loc3_ = "img://itemdata_" + this._DefIndex + "_" + this._PaintIndexID + "_" + this._Rarity + "_" + this._Quality + "_" + this._PaintWear + "_" + this._PaintSeed + "_" + this._StatTrakKills;
   }
   else
   {
      var _loc4_ = _global.CScaleformComponent_Inventory.IsInventoryImageCachable(this._ItemXuid,this._ItemID);
      if(!_loc4_)
      {
         _loc3_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(this._ItemXuid,this._ItemID) + ".png";
      }
      else
      {
         EnsureImageCached();
         _loc3_ = "img://inventory_" + this._ItemID;
      }
   }
   return _loc3_;
}
function GetDefaultItemModelPath()
{
   if(GetSlotID() == "flair0" || GetSlotID() == "musickit" || GetSlotID().slice(0,9) == "clothing_")
   {
      var _loc2_ = "img://inventory_" + this._ItemID;
   }
   else
   {
      _loc2_ = GetImagePath();
   }
   return _loc2_;
}
function IsTool()
{
   return _global.CScaleformComponent_Inventory.IsTool(this._ItemXuid,this._ItemID);
}
function IsEquippedCT()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.IsEquipped(this._ItemXuid,this._ItemID.toString(),"ct");
   return _loc3_;
}
function IsEquippedT()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.IsEquipped(this._ItemXuid,this._ItemID.toString(),"t");
   return _loc3_;
}
function IsNoTeam()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.IsEquipped(this._ItemXuid,this._ItemID.toString(),"noteam");
   return _loc3_;
}
function GetItemCapability(Index)
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemCapabilityByIndex(this._ItemXuid,this._ItemID,Number(Index));
   return _loc3_;
}
function GetItemCapabilityCount()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemCapabilitiesCount(this._ItemXuid,this._ItemID);
   return _loc3_;
}
function GetChosenActionItemsCount(Capability)
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetChosenActionItemsCount(this._ItemXuid,this._ItemID,Capability);
   return _loc3_;
}
function GetChosenActionItemIDByIndex(Capability, Index)
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetChosenActionItemIDByIndex(this._ItemXuid,this._ItemID,Capability,Number(Index));
   return _loc3_;
}
function GetStickerCount()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemStickerCount(this._ItemXuid,this._ItemID);
   return _loc3_;
}
function HasMusic()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.HasMusic(this._ItemXuid,this._ItemID);
   return _loc3_;
}
function GetMoney()
{
   var _loc4_ = IsEquippedCT();
   var _loc5_ = IsEquippedT();
   var _loc3_ = "";
   if(_loc4_)
   {
      _loc3_ = "ct";
   }
   else
   {
      _loc3_ = "t";
   }
   return _global.CScaleformComponent_Loadout.GetItemGamePrice(this._ItemXuid,_loc3_,GetSlotID().toString());
}
function GetStoreOriginalPrice()
{
   return _global.CScaleformComponent_Store.GetStoreItemOriginalPrice(this._BundleID,this._Quantity);
}
function GetStoreSalePrice()
{
   return _global.CScaleformComponent_Store.GetStoreItemSalePrice(this._BundleID,this._Quantity);
}
function GetStoreSalePercentReduction()
{
   return _global.CScaleformComponent_Store.GetStoreItemPercentReduction(this._BundleID,this._Quantity);
}
function GetItemGifter()
{
   return _global.CScaleformComponent_Inventory.GetItemGifterXuid(this._ItemXuid,this._ItemID);
}
function GetItemPickUpMethod()
{
   return _global.CScaleformComponent_Inventory.GetItemPickupMethod(this._ItemXuid,this._ItemID);
}
function LoadItemImage(ImagePath, numWidth, numHeight)
{
   ItemImage.DefaultItemImage._visible = false;
   ItemImage.DynamicItemImage._visible = true;
   if(ItemImage.DynamicItemImage.Image != undefined)
   {
      ItemImage.DynamicItemImage.Image.unloadMovie();
   }
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
   var _loc3_ = ImagePath;
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc3_,ItemImage.DynamicItemImage.Image);
}
function RefreshItemImage()
{
   ItemImage.DynamicItemImage.Image.unloadMovie();
   var _loc3_ = new Object();
   _loc3_.onLoadInit = function(target_mc)
   {
      target_mc._width = 90;
      target_mc._height = 90;
   };
   var _loc4_ = "img://inventory_" + this._ItemID;
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc3_);
   _loc2_.loadClip(_loc4_,ItemImage.DynamicItemImage.Image);
}
function SetTeamImage(strTeam)
{
   switch(strTeam)
   {
      case "#CSGO_Inventory_Team_CT":
         CTIcon._visible = true;
         TIcon._visible = false;
         break;
      case "#CSGO_Inventory_Team_T":
         TIcon._visible = true;
         CTIcon._visible = false;
         break;
      case "#CSGO_Inventory_Team_Any":
         TIcon._visible = false;
         CTIcon._visible = false;
         break;
      default:
         CTIcon._visible = false;
         TIcon._visible = false;
   }
}
function SetColor(strColor)
{
   strColor = strColor.substring(1,strColor.length);
   strColor = "0x" + strColor;
   var _loc4_ = new Number(strColor);
   trace("***** ItemTile:  strColor *******" + strColor);
   var _loc3_ = new Color(this.RarityColor);
   _loc3_.setRGB(_loc4_);
}
function SetGift(strGifterId)
{
   if(strGifterId != "" && strGifterId != null && strGifterId != undefined)
   {
      Gift._visible = true;
      var _loc4_ = _global.CScaleformComponent_FriendsList.GetFriendName(strGifterId);
      var _loc2_ = _global.GameInterface.Translate("#SFUI_InvUse_Acknowledge_Gift");
      _loc2_ = _global.ConstructString(_loc2_,_loc4_);
      Gift.Text.htmlText = _loc2_;
   }
   else
   {
      Gift._visible = false;
   }
}
function SetQuest(PickUpMethod)
{
   if(PickUpMethod == "quest_reward")
   {
      Qwest._visible = true;
      _global.AutosizeTextDown(Qwest.Text,10);
   }
   else
   {
      Qwest._visible = false;
   }
}
function SetEquippedDot(IsEquippedCt, IsEquippedT, IsNoTeam, strTeam)
{
   FlairDot._visible = false;
   CTDot._visible = false;
   TDot._visible = false;
   CTDot.Equipped._visible = false;
   TDot.Equipped._visible = false;
   if(IsNoTeam == true && (GetSlotID() == "flair0" || GetSlotID() == "musickit"))
   {
      FlairDot._visible = true;
      return undefined;
   }
   switch(strTeam)
   {
      case "#CSGO_Inventory_Team_CT":
         if(IsEquippedCt)
         {
            CTDot._visible = true;
            CTDot.Equipped._visible = true;
         }
         break;
      case "#CSGO_Inventory_Team_T":
         if(IsEquippedT)
         {
            TDot._visible = true;
            TDot.Equipped._visible = true;
         }
         break;
      case "#CSGO_Inventory_Team_Any":
         if(IsEquippedCt)
         {
            CTDot._visible = true;
            CTDot.Equipped._visible = true;
            TDot._visible = true;
         }
         if(IsEquippedT)
         {
            TDot._visible = true;
            TDot.Equipped._visible = true;
            CTDot._visible = true;
         }
   }
}
function SeperateName(strName)
{
   if(strName.indexOf("|  ") != -1)
   {
      var _loc2_ = strName.split("|  ",2);
   }
   else if(strName.indexOf("| ") != -1)
   {
      _loc2_ = strName.split("| ",2);
   }
   else
   {
      _loc2_ = new Array(strName);
   }
   return _loc2_;
}
function SeperateNameQuest(strName)
{
   if(strName.indexOf(":  ") != -1)
   {
      var _loc2_ = strName.split(":  ",2);
   }
   else if(strName.indexOf(": ") != -1)
   {
      _loc2_ = strName.split(": ",2);
   }
   else
   {
      _loc2_ = new Array(strName);
   }
   return _loc2_;
}
function GetSeperateNameString(aName)
{
   if(aName.length == 1)
   {
      return "<b>" + aName[0] + "</b>";
   }
   return "<b>" + aName[0] + "</b>" + "\n" + aName[1];
}
function DisplayTileText(aName)
{
   ItemName.htmlText = GetSeperateNameString(aName);
}
function GetItemId()
{
   return "" + this._ItemID;
}
function GetDefIndex()
{
   return this._DefIndex;
}
function GetFauxId()
{
   return this._FauxItemId;
}
function GetOwnerXuid()
{
   return "" + this._ItemXuid;
}
function GetItemType()
{
   return this._ItemType;
}
function NeedsPaintId()
{
   return this._NeedsPaint;
}
function GetPaintIndex()
{
   return this._PaintIndexID;
}
this._ItemID = "";
this._ItemXuid = "";
this._ItemIdIsValid = true;
this._StatTrakKills = -1;
this._Capability = "";
this._FauxItemId = 0;
this._IsEmpty = false;
this.stop();
