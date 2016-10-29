function SetItemData(strId, PlayerXuid, bIsMarketItem, bisTournamentStickerStoreProxy)
{
   trace("!!!STORE!!!!strId----------------------" + strId);
   this._ItemID = strId;
   this._ItemXuid = PlayerXuid;
   this._Quantity = 1;
   ItemImage._x = 0;
   ItemImage._y = 0;
   ItemImageRef._x = 0;
   ItemImageRef._visible = false;
   var _loc4_ = _global.CScaleformComponent_Inventory.IsCouponCrate(0,strId);
   this._IsCoupon = _loc4_;
   if(bisTournamentStickerStoreProxy)
   {
      SetUpTournamentStrickerData();
   }
   else
   {
      if(_loc4_)
      {
         SetName(_global.CScaleformComponent_Inventory.GetItemName(this._ItemXuid,GetLootListItem()));
      }
      else
      {
         SetName(GetName());
      }
      SetPrice(GetOriginalPrice(strId),GetSalePrice(strId),GetSalePercent(strId));
      SetNew(GetIsNew());
      SetMarketLink(bIsMarketItem);
      SetUpButtons();
      if(ItemDoubleImage)
      {
         SetImage(240,102,GetImagePath("double"),ItemDoubleImage);
      }
      else if(ItemTripleImage)
      {
         SetImage(362,102,GetImagePath("triple"),ItemTripleImage);
      }
      else if(bIsTeamSticker)
      {
         SetImage(83.3,65,GetImagePath("large"),ItemImage);
         ItemImage._x = 18;
         ItemImage._y = 3;
      }
      else if(_loc4_)
      {
         SetImage(96,72,GetImagePath("coupon"),ItemImage);
         SetImage(96,72,GetImagePath("coupon"),ItemImageRef);
         ItemImage._x = 10;
         ItemImageRef._x = 10;
      }
      else
      {
         SetImage(118,100,GetImagePath(""),ItemImage);
      }
   }
   ItemImage.StatTrak._visible = IsStatTrak(strId);
   if(ShowQuantityBtn())
   {
      SetUpQuantityButtons();
      SetQuantity(this._Quantity);
   }
}
function ShowReflection()
{
   ItemImageRef._visible = this._IsCoupon;
}
function SetItemDataTeamWatchTab(strId, PlayerXuid)
{
   trace("!!!STORE!!!!strId----------------------" + strId);
   this._ItemID = strId;
   this._ItemXuid = PlayerXuid;
   this._Quantity = 1;
   SetName(GetName());
   SetPrice(GetOriginalPrice(strId),GetSalePrice(strId),GetSalePercent(strId));
   New._visible = false;
   SetMarketLink(false);
   SetUpButtons();
   SetImage(83.3,65,GetImagePath("large"),ItemImage);
   ItemImage._x = 18;
   ItemImage._y = 3;
   if(ShowQuantityBtn())
   {
      SetUpQuantityButtons();
      SetQuantity(this._Quantity);
   }
}
function SetUpTournamentStrickerData()
{
   SalePrice._visible = false;
   OriginalPrice._visible = false;
   SaleTag._visible = false;
   var aItemsShow = new Array();
   aItemsShow = GetTournamentItemsList();
   MarketLink.dialog = this;
   MarketLink.Action = function()
   {
      this.dialog.OpenStoreListerPanelTournament(aItemsShow);
   };
   MarketLink._visible = true;
   MarketLink.Price.htmlText = "#CSGO_Watch_Tournament_Stickers_See";
   SetName("#CSGO_Watch_Tournament_Stickers_Title_" + _global.CScaleformComponent_News.GetActiveTournamentEventID());
   Desc.htmlText = "#CSGO_Watch_Tournament_Stickers_Desc_" + _global.CScaleformComponent_News.GetActiveTournamentEventID();
   AreTournamentStickersOnSale();
   SetNew(GetIsNew());
   if(ItemTripleImage)
   {
      SetImage(362,102,GetImagePath("TeamStickersBanner"),ItemTripleImage);
   }
}
function AreTournamentStickersOnSale()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(4237,0);
   var _loc2_ = _global.CScaleformComponent_Store.GetStoreItemPercentReduction(_loc3_,1);
   if(_loc2_ != "" && _loc2_ != undefined)
   {
      SaleTag.TextPercent.htmlText = _loc2_;
      SaleTag._visible = true;
   }
}
function GetTournamentItemsList()
{
   var _loc7_ = new Array();
   var _loc8_ = _global.CScaleformComponent_Store.GetBannerEntryCount();
   var _loc3_ = 0;
   while(_loc3_ < _loc8_)
   {
      var _loc2_ = _global.CScaleformComponent_Store.GetBannerEntryDefIdx(_loc3_);
      _loc2_ = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(_loc2_,0);
      var _loc4_ = _global.CScaleformComponent_Store.GetBannerEntryCustomFormatString(_loc3_);
      if(_loc4_ == "hiddentournament" || !isNaN(Number(_loc4_)))
      {
         if(_loc2_ != undefined && _loc2_ != null && _loc2_ != -1 && _loc2_ != "")
         {
            _loc7_.push({time:0,itemid:_loc2_});
         }
      }
      _loc3_ = _loc3_ + 1;
   }
   return _loc7_;
}
function SetCouponData(aCoupons, PlayerXuid)
{
   var aCouponsWithSameTime = new Array();
   aCouponsWithSameTime = GetStrickersToShow(aCoupons);
   var _loc4_ = aCouponsWithSameTime.length;
   if(_loc4_ == 1)
   {
      var _loc5_ = Math.floor(Math.random() * 6) + 0;
      var _loc6_ = ShowCouponBg();
   }
   else
   {
      _loc5_ = 5;
      _loc6_ = this.CouponBg02;
   }
   this._ItemID = aCouponsWithSameTime[_loc4_ - 1].itemid;
   this._ItemXuid = PlayerXuid;
   this._Quantity = 1;
   ShowQuantityBtn();
   ImageMultiCoupon._visible = false;
   ItemImage._visible = false;
   ItemImageRef._visible = false;
   Desc._visible = false;
   Preview._visible = false;
   SalePrice._visible = false;
   OriginalPrice._visible = false;
   SaleTag._visible = false;
   MarketLink._visible = false;
   Name._visible = false;
   if(_loc4_ == 1)
   {
      var _loc9_ = this._ItemXuid;
      var _loc8_ = _global.CScaleformComponent_Inventory.GetItemName(this._ItemXuid,GetLootListItem());
      var _loc7_ = _global.CScaleformComponent_Inventory.GetItemDescription(this._ItemXuid,this._ItemID);
      TimerTitle.htmlText = "#SFUI_Store_Limit_Offer";
      ItemImage._visible = true;
      ItemImageRef._visible = true;
      Desc._visible = true;
      Preview._visible = true;
      Name._visible = true;
      SetName(_loc8_);
      SetPrice(GetOriginalPrice(this._ItemID),GetSalePrice(this._ItemID),GetSalePercent(this._ItemID));
      SetNew(false);
      SetSingleCouponImage();
      SetUpCouponButtons(IsCouponCrate(),true);
      Desc.htmlText = _loc7_;
   }
   else
   {
      MarketLink.dialog = this;
      MarketLink.Action = function()
      {
         this.dialog.OpenStoreListerPanel(aCouponsWithSameTime);
         _global.CScaleformComponent_Inventory.OnViewOffers();
      };
      MarketLink._visible = true;
      MarketLink.Price.htmlText = "#SFUI_Store_View_Offers";
      TimerTitle.htmlText = "#SFUI_Store_Available_Offers";
      ImageMultiCoupon._visible = true;
      MarketLink._visible = true;
      SetNew(false);
      SetMultiCouponImage(aCouponsWithSameTime,_loc5_);
   }
   if(SalePrice._visible || _loc4_ > 1)
   {
      CouponTimer._x = SalePrice._x + SalePrice._width + 5;
      TimerTitle._x = SalePrice._x + SalePrice._width + 5;
   }
   else if(OriginalPrice._visible)
   {
      CouponTimer._x = OriginalPrice._x + OriginalPrice._width + 5;
      TimerTitle._x = OriginalPrice._x + OriginalPrice._width + 5;
   }
   var _loc3_ = 0;
   while(_loc3_ < 3)
   {
      this["CouponBg0" + _loc3_]._visible = false;
      _loc3_ = _loc3_ + 1;
   }
   TintCouponBg(_loc6_,_loc5_);
   _loc6_._visible = true;
   CouponTimer.SetCouponExpirationTime(this._ItemID);
}
function SetTournamentStickerData(ItemID, PlayerXuid)
{
   this._ItemID = ItemID;
   this._ItemXuid = PlayerXuid;
   this._Quantity = 1;
   ItemImage._visible = false;
   ItemImageRef._visible = false;
   Desc._visible = false;
   SalePrice._visible = false;
   OriginalPrice._visible = false;
   SaleTag._visible = false;
   TimerTitle._visible = false;
   MarketLink._visible = false;
   StatTrak._visible = false;
   var _loc6_ = _global.CScaleformComponent_Inventory.GetItemDescription(this._ItemXuid,this._ItemID);
   ItemImage._visible = true;
   ItemImageRef._visible = true;
   Desc._visible = true;
   Preview._visible = true;
   TimerTitle._visible = true;
   Name._visible = true;
   var _loc4_ = _global.CScaleformComponent_Inventory.GetLootListItemsCount(this._ItemXuid,this._ItemID);
   if(_loc4_ > 1)
   {
      Preview._visible = false;
      SetImage(138,108,GetImagePath("none"),ItemImage);
      SetImage(138,108,GetImagePath("none"),ItemImageRef);
      if(ShowQuantityBtn(true))
      {
         SetUpQuantityButtons();
         SetQuantity(this._Quantity);
      }
   }
   else
   {
      Preview._visible = true;
      SetImage(138,108,GetImagePath("coupon"),ItemImage);
      SetImage(138,108,GetImagePath("coupon"),ItemImageRef);
      ShowQuantityBtn();
   }
   var _loc5_ = _global.CScaleformComponent_Inventory.GetItemName(this._ItemXuid,ItemID);
   SetName(_loc5_);
   SetPrice(GetOriginalPrice(ItemID),GetSalePrice(ItemID),GetSalePercent(ItemID));
   SetNew(false);
   SetUpButtons();
   SetPreviewButton();
}
function SetCouponDataSingle(ItemID, PlayerXuid)
{
   this._ItemID = ItemID;
   this._ItemXuid = PlayerXuid;
   this._Quantity = 1;
   ShowQuantityBtn();
   ItemImage._visible = false;
   ItemImageRef._visible = false;
   Desc._visible = false;
   SalePrice._visible = false;
   OriginalPrice._visible = false;
   SaleTag._visible = false;
   TimerTitle._visible = false;
   MarketLink._visible = false;
   StatTrak._visible = IsStatTrak(ItemID);
   _global.AutosizeTextDown(StatTrak.Text,6);
   var _loc5_ = this._ItemID;
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemName(this._ItemXuid,GetLootListItem());
   var _loc4_ = _global.CScaleformComponent_Inventory.GetItemDescription(this._ItemXuid,this._ItemID);
   ItemImage._visible = true;
   ItemImageRef._visible = true;
   Desc._visible = true;
   TimerTitle._visible = true;
   Name._visible = true;
   Preview._visible = true;
   SetName(_loc3_);
   SetPrice(GetOriginalPrice(this._ItemID),GetSalePrice(this._ItemID),GetSalePercent(this._ItemID));
   SetNew(false);
   SetImage(138,108,GetImagePath("coupon"),ItemImage);
   SetImage(138,108,GetImagePath("coupon"),ItemImageRef);
   SetUpCouponButtons(IsCouponCrate(),false);
}
function IsCouponCrate()
{
   if(_global.CScaleformComponent_Inventory.GetLootListItemsCount(this._ItemXuid,GetLootListItem()) > 2)
   {
      return true;
   }
   return false;
}
function IsStatTrak(strItemID)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetRawDefinitionKey(strItemID,"will_produce_stattrak");
   trace("--------------------------------------strItemID-------" + strItemID);
   trace("--------------------------------------numIsStatTrak-------" + _loc2_);
   if(_loc2_ == 1)
   {
      return true;
   }
   return false;
}
function IsMusicKit()
{
   if(FauxItemID != undefined && _global.CScaleformComponent_Inventory.GetLootListItemsCount(m_PlayerXuid,FauxItemIdx) > 0)
   {
      var _loc2_ = _global.CScaleformComponent_Inventory.GetLootListItemIdByIndex(m_PlayerXuid,FauxItemId,0);
      return _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,_loc2_,"musickit");
   }
   return false;
}
function GetStrickersToShow(aCoupons)
{
   var _loc3_ = new Array();
   var _loc10_ = 4;
   var _loc11_ = _global.CScaleformComponent_Inventory.GetCacheTypeElementFieldByIndex("Coupons",0,"expiration_date");
   var _loc9_ = _global.CScaleformComponent_Store.GetSecondsUntilTimestamp(_loc11_);
   var _loc2_ = 0;
   while(_loc2_ < aCoupons.length)
   {
      _loc3_.push({time:_loc9_,itemid:aCoupons[_loc2_]});
      _loc2_ = _loc2_ + 1;
   }
   _loc2_ = 0;
   while(_loc2_ < _loc3_.length)
   {
      if(_loc2_ >= _loc10_)
      {
         _loc3_.splice(_loc2_);
      }
      else
      {
         var _loc4_ = GetSalePercent(_loc3_[_loc2_].itemid);
         if(IsSalePercentValid(_loc4_))
         {
            var _loc5_ = _loc3_[_loc2_];
            _loc3_.splice(_loc2_,1);
            _loc3_.splice(0,0,_loc5_);
         }
      }
      _loc2_ = _loc2_ + 1;
   }
   return _loc3_;
}
function SetSingleCouponImage()
{
   if(_global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(this._ItemXuid,GetLootListItem(),"musickit"))
   {
      SetImage(96,72,GetImagePath("coupon"),ItemImage);
      SetImage(96,72,GetImagePath("coupon"),ItemImageRef);
      ItemImage._x = 149;
      ItemImage._y = 23;
      ItemImageRef._x = ItemImage._x;
      ItemImageRef._y = 154;
   }
   else
   {
      SetImage(104,78,GetImagePath("coupon"),ItemImage);
      SetImage(104,78,GetImagePath("coupon"),ItemImageRef);
      ItemImage._x = 145;
      ItemImage._y = 20;
      ItemImageRef._x = ItemImage._x;
      ItemImageRef._y = 174;
   }
   ItemImage.StatTrak._visible = IsStatTrak(this._ItemID);
}
function SetMultiCouponImage(aCoupons, numColorToUse)
{
   if(aCoupons.length > 1 && aCoupons.length < 9)
   {
      ImageMultiCoupon.BackIcons.gotoAndStop(aCoupons.length);
   }
   else
   {
      ImageMultiCoupon.BackIcons.gotoAndStop(8);
   }
   var _loc3_ = 0;
   while(_loc3_ < 9)
   {
      if(_loc3_ == 0)
      {
         var _loc4_ = this.ImageMultiCoupon["ItemMulti" + _loc3_];
      }
      else
      {
         _loc4_ = this.ImageMultiCoupon.BackIcons["ItemMulti" + _loc3_];
      }
      if(_loc3_ > aCoupons.length && _loc3_ > 0)
      {
         _loc4_._visible = false;
      }
      else
      {
         _loc4_._visible = true;
         var _loc7_ = _global.CScaleformComponent_Inventory.GetLootListItemIdByIndex(this._ItemXuid,aCoupons[_loc3_].itemid,0);
         var _loc8_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(this._ItemXuid,_loc7_) + ".png";
         var _loc6_ = GetSalePercent(aCoupons[_loc3_].itemid);
         SetImage(96,72,_loc8_,_loc4_,true);
         if(IsSalePercentValid(_loc6_))
         {
            _loc4_.SaleTag.TextPercent.htmlText = _loc6_;
            _loc4_.SaleTag._visible = true;
         }
         _loc4_.StatTrak._visible = IsStatTrak(aCoupons[_loc3_].itemid);
      }
      _loc3_ = _loc3_ + 1;
   }
   ImageMultiCoupon._visible = true;
}
function ShowCouponBg()
{
   var _loc2_ = Math.floor(Math.random() * 2) + 1;
   return this["CouponBg0" + _loc2_];
}
function TintCouponBg(mcCouponBg, numColorToUse)
{
   var _loc2_ = new Color(mcCouponBg);
   _loc2_.setTransform(this["Color" + numColorToUse]);
   _loc2_ = new Color(Bg);
   _loc2_.setTransform(this["Color" + numColorToUse]);
}
function GetImagePath(strImageType)
{
   if(strImageType == "slim")
   {
      return _global.CScaleformComponent_Inventory.GetItemInventoryImage(this._ItemXuid,this._ItemID) + "_slim_store.png";
   }
   if(strImageType == "double")
   {
      return _global.CScaleformComponent_Inventory.GetItemInventoryImage(this._ItemXuid,this._ItemID) + "_double_store.png";
   }
   if(strImageType == "triple")
   {
      return _global.CScaleformComponent_Inventory.GetItemInventoryImage(this._ItemXuid,this._ItemID) + "_triple_store.png";
   }
   if(strImageType == "none")
   {
      return _global.CScaleformComponent_Inventory.GetItemInventoryImage(this._ItemXuid,this._ItemID) + ".png";
   }
   if(strImageType == "large")
   {
      return _global.CScaleformComponent_Inventory.GetItemInventoryImage(this._ItemXuid,this._ItemID) + "_large.png";
   }
   if(strImageType == "coupon")
   {
      return _global.CScaleformComponent_Inventory.GetItemInventoryImage(this._ItemXuid,GetLootListItem()) + ".png";
   }
   if(strImageType == "TeamStickersBanner")
   {
      return "econ/tournaments/team_stickers_store_" + _global.CScaleformComponent_News.GetActiveTournamentEventID() + ".png";
   }
   return _global.CScaleformComponent_Inventory.GetItemInventoryImage(this._ItemXuid,this._ItemID) + "_store.png";
}
function SetImage(numWidth, numHeight, srtImagePath, objLoadTarget)
{
   objLoadTarget.DefaultItemImage._visible = false;
   objLoadTarget.DynamicItemImage._visible = true;
   objLoadTarget.SaleTag._visible = false;
   objLoadTarget.StatTrak._visible = false;
   if(objLoadTarget.DynamicItemImage.Image != undefined)
   {
      objLoadTarget.DynamicItemImage.Image.unloadMovie();
   }
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
   };
   _loc2_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc4_ = srtImagePath;
   var _loc3_ = new MovieClipLoader();
   _loc3_.addListener(_loc2_);
   _loc3_.loadClip(_loc4_,objLoadTarget.DynamicItemImage.Image);
}
function SetUpQuantityButtons()
{
   QuantityBtn.AddBtn.dialog = this;
   QuantityBtn.AddBtn.Action = function()
   {
      this.dialog.AddSubtractQuantity(true);
   };
   QuantityBtn.SubtractBtn.dialog = this;
   QuantityBtn.SubtractBtn.Action = function()
   {
      this.dialog.AddSubtractQuantity(false);
   };
}
function SetUpButtons()
{
   OriginalPrice.dialog = this;
   OriginalPrice.Action = function()
   {
      this.dialog.Purchase();
   };
   SalePrice.dialog = this;
   SalePrice.Action = function()
   {
      this.dialog.Purchase();
   };
}
function SetUpCouponButtons(bIsCrate, bIsPreviewOnly)
{
   OriginalPrice.dialog = this;
   OriginalPrice.Action = function()
   {
      this.dialog.PurchaseCoupon();
   };
   SalePrice.dialog = this;
   SalePrice.Action = function()
   {
      this.dialog.PurchaseCoupon();
   };
   SetPreviewButton(bIsCrate,bIsPreviewOnly);
}
function SetPreviewButton(bIsCrate, bIsPreviewOnly)
{
   Preview.dialog = this;
   if(bIsCrate)
   {
      Preview.SetText("#SFUI_Store_LookInside");
      Preview.Action = function()
      {
         this.dialog.ShowCratePreviewPanel(bIsPreviewOnly);
      };
   }
   else
   {
      Preview.SetText("#SFUI_Store_Preview");
      if(_global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(this._ItemXuid,GetLootListItem(),"sticker"))
      {
         Preview.Action = function()
         {
            this.dialog.PreviewItem(GetLootListItem());
            HideListerPanel();
         };
      }
      else if(_global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(this._ItemXuid,GetLootListItem(),"musickit"))
      {
         Preview.Action = function()
         {
            this.dialog.PreviewMusicKit(GetLootListItem());
            HideListerPanel();
         };
      }
   }
}
function ShowCratePreviewPanel(bIsPreviewOnly)
{
   CloseWatchPanel();
   _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide(false);
   if(bIsPreviewOnly)
   {
      _global.MainMenuMovie.Panel.StoreListerPanel.ShowOnlyPreview(GetLootListItem());
   }
   else
   {
      _global.MainMenuMovie.Panel.StoreListerPanel.ShowCratePreviewPanel(GetLootListItem(),false);
   }
}
function HideListerPanel()
{
   if(_global.MainMenuMovie.Panel.StoreListerPanel._visible)
   {
      _global.MainMenuMovie.Panel.StoreListerPanel.HidePanel();
   }
}
function ShowQuantityBtn(bisTournamentItem)
{
   var _loc4_ = _global.CScaleformComponent_Inventory.IsTool(this._ItemXuid,this._ItemID);
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemCapabilityByIndex(this._ItemXuid,this._ItemID,0);
   if(IsMusicKit())
   {
      QuantityBtn._visible = false;
      return false;
   }
   if((_loc4_ || bisTournamentItem) && _loc3_ == "decodable")
   {
      QuantityBtn._visible = true;
      return true;
   }
   QuantityBtn._visible = false;
   return false;
}
function AddSubtractQuantity(bAdd)
{
   if(bAdd && this._Quantity < 20)
   {
      this._Quantity = this._Quantity + 1;
   }
   else if(!bAdd && this._Quantity > 1)
   {
      this._Quantity = this._Quantity - 1;
   }
   SetQuantity(this._Quantity);
   SetPrice(GetOriginalPrice(this._ItemID),GetSalePrice(this._ItemID),GetSalePercent(this._ItemID));
}
function SetQuantity(numQuantity)
{
   var _loc2_ = _global.GameInterface.Translate("#SFUI_InvUse_Get_Quantity");
   _loc2_ = _global.ConstructString(_loc2_,numQuantity);
   QuantityBtn.Text.htmlText = _loc2_;
}
function SetName(strName)
{
   Name.htmlText = strName;
   _global.AutosizeTextDown(Name,6);
}
function SetPrice(strOriginalPrice, strSalePrice, strSalePercent)
{
   SalePrice._visible = false;
   OriginalPrice._visible = false;
   SaleTag._visible = false;
   if(!IsSalePercentValid(strSalePercent))
   {
      OriginalPrice.Price.htmlText = strSalePrice;
      if(strOriginalPrice != "")
      {
         OriginalPrice._visible = true;
      }
   }
   else
   {
      SalePrice.TextCurrent.htmlText = strSalePrice;
      SalePrice.TextOriginal.htmlText = strOriginalPrice;
      SaleTag.TextPercent.htmlText = strSalePercent;
      SalePrice._visible = true;
      SaleTag._visible = true;
   }
}
function SetNew(bIsNew)
{
   New._visible = bIsNew;
   if(SaleTag._visible == true)
   {
      New._x = SaleTag._x - SaleTag._width - 5;
      New._visible = false;
   }
   else
   {
      New._x = SaleTag._x;
   }
}
function SetMarketLink(bIsMarketItem)
{
   MarketLink.dialog = this;
   MarketLink.Action = function()
   {
      this.dialog.OpenOverlayToMarket();
   };
   MarketLink._visible = bIsMarketItem;
   if(ItemDoubleImage || ItemTripleImage)
   {
      var _loc4_ = _global.CScaleformComponent_Store.GetStoreItemName_Underscores(this._ItemID);
      var _loc5_ = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(1315,0);
      var _loc3_ = _global.CScaleformComponent_MyPersona.GetMyMedalRankByType("5Operation$Community Season Five Summer 2014");
      if(_loc3_ >= 1 && _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue() == 4 && this._ItemID == _loc5_)
      {
         if(_loc3_ <= 1)
         {
            Desc.htmlText = _global.GameInterface.Translate("#SFUI_Store_Hint_" + _loc4_ + "_Gift");
         }
         else if(_loc3_ > 1)
         {
            Desc.htmlText = _global.GameInterface.Translate("#SFUI_Store_Hint_" + _loc4_ + "_GiftActive");
         }
      }
      else
      {
         Desc.htmlText = _global.GameInterface.Translate("#SFUI_Store_Hint_" + _loc4_);
      }
   }
}
function OpenOverlayToMarket()
{
   var _loc3_ = _global.CScaleformComponent_SteamOverlay.GetAppID();
   var _loc5_ = _global.CScaleformComponent_SteamOverlay.GetSteamCommunityURL();
   var _loc4_ = _global.CScaleformComponent_Inventory.GetItemSet(this._ItemID);
   _global.CScaleformComponent_SteamOverlay.OpenURL(_loc5_ + "/market/search?q=&appid=" + _loc3_ + "&lock_appid=" + _loc3_ + "&category_" + _loc3_ + "_ItemSet%5B%5D=tag_" + _loc4_);
   _global.CScaleformComponent_Store.RecordUIEvent("ViewOnMarket");
}
function Purchase()
{
   var _loc4_ = [];
   var _loc3_ = 0;
   while(_loc3_ < this._Quantity)
   {
      _loc4_.push(this._ItemID);
      _loc3_ = _loc3_ + 1;
   }
   var _loc5_ = _loc4_.join(",");
   _global.CScaleformComponent_Store.StoreItemPurchase(_loc5_);
   HideListerPanel();
}
function OpenStoreListerPanel(aCoupons)
{
   _global.MainMenuMovie.Panel.StoreListerPanel.ShowPanel(true,aCoupons);
}
function OpenStoreListerPanelTournament(aCoupons)
{
   _global.MainMenuMovie.Panel.StoreListerPanel.ShowPanel(false,aCoupons);
}
function PurchaseSingle()
{
   _global.CScaleformComponent_Store.StoreItemPurchase(this._ItemID);
}
function PurchaseCoupon()
{
   _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide(false);
   _global.CScaleformComponent_Store.PurchaseKeyAndOpenCrate(this._ItemID);
   HideListerPanel();
}
function PreviewItem(ItemIdToTest)
{
   CloseWatchPanel();
   _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide(false);
   _global.MainMenuMovie.Panel.InventoryPanel.InitInventoryPanelMaster(false,ItemIdToTest,this._ItemID);
}
function PreviewMusicKit(MusikKitID)
{
   var _loc3_ = _global.MainMenuMovie.Panel.TooltipItemPreview;
   var _loc5_ = _global.CScaleformComponent_Inventory.GetItemName(this._ItemXuid,MusikKitID);
   var _loc6_ = _global.CScaleformComponent_Inventory.GetItemRarityColor(this._ItemXuid,MusikKitID);
   var _loc7_ = "img://inventory_" + MusikKitID;
   _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide(false);
   CloseWatchPanel();
   _loc3_.ShowHidePreview(true,_loc5_,_loc6_);
   _loc3_.SetModel(_loc7_);
   _loc3_.ShowNewItemBuyButton(this._ItemID,this._ItemXuid);
   _loc3_.StartMusicPreview(MusikKitID,this._ItemXuid);
}
function CloseWatchPanel()
{
   if(_global.MainMenuMovie.Panel.WatchPanel._visible)
   {
      _global.MainMenuMovie.Panel.WatchPanel.ClosePanel();
      _global.MainMenuMovie.ShowPanelsWhenInInventory();
   }
}
function onMoreInfo(Link)
{
   _global.CScaleformComponent_SteamOverlay.OpenURL(Link);
}
function GetIsNew()
{
   return _global.CScaleformComponent_Store.IsItemNew(this._ItemID);
}
function GetName()
{
   return _global.CScaleformComponent_Inventory.GetItemName(this._ItemXuid,this._ItemID);
}
function GetName()
{
   return _global.CScaleformComponent_Inventory.GetItemName(this._ItemXuid,this._ItemID);
}
function GetLootListItem()
{
   return _global.CScaleformComponent_Inventory.GetLootListItemIdByIndex(this._ItemXuid,this._ItemID,0);
}
function GetOriginalPrice(IDToUseForPrice)
{
   return _global.CScaleformComponent_Store.GetStoreItemOriginalPrice(IDToUseForPrice,this._Quantity);
}
function GetSalePrice(IDToUseForPrice)
{
   return _global.CScaleformComponent_Store.GetStoreItemSalePrice(IDToUseForPrice,this._Quantity);
}
function GetSalePercent(IDToUseForPrice)
{
   var _loc3_ = _global.CScaleformComponent_Store.GetStoreItemPercentReduction(IDToUseForPrice,this._Quantity);
   return _loc3_;
}
function GetAssociatedItemId(IDToUse)
{
   return _global.CScaleformComponent_Inventory.GetAssociatedItemIdByIndex(this._ItemXuid,IDToUse,0);
}
function IsSalePercentValid(strSalePercent)
{
   if(strSalePercent != "" && strSalePercent != undefined)
   {
      return true;
   }
   return false;
}
this._ItemID = "";
this._ItemXuid = "";
this._Quantity;
var Color0 = new Object();
Color0 = {rb:93,gb:37,bb:118};
var Color1 = new Object();
Color1 = {rb:73,gb:85,bb:94};
var Color2 = new Object();
Color2 = {rb:29,gb:60,bb:140};
var Color3 = new Object();
Color3 = {rb:3,gb:117,bb:97};
var Color4 = new Object();
Color4 = {rb:127,gb:57,bb:3};
var Color5 = new Object();
Color5 = {rb:0,gb:80,bb:138};
