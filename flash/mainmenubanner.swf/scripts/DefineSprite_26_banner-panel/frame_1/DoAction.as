function PlaceStoreTiles()
{
   m_numItems = _global.CScaleformComponent_Store.GetBannerEntryCount();
   if(m_numItems == undefined || m_numItems < 1 || m_numItems == null)
   {
      return undefined;
   }
   GetCoupons();
   MakePages(GetTileSizes());
   SetUpBannerControls();
}
function GetCoupons()
{
   var _loc7_ = _global.CScaleformComponent_Inventory.GetCacheTypeElementsCount("Coupons");
   m_bHasCoupon = false;
   CouponTile._visible = false;
   if(_loc7_ > 0)
   {
      m_aCoupons = [];
      var _loc2_ = 0;
      while(_loc2_ < _loc7_)
      {
         var _loc5_ = _global.CScaleformComponent_Inventory.GetCacheTypeElementFieldByIndex("Coupons",_loc2_,"defidx");
         var _loc6_ = _global.CScaleformComponent_Inventory.GetCacheTypeElementFieldByIndex("Coupons",_loc2_,"expiration_date");
         var _loc3_ = _global.CScaleformComponent_Store.GetSecondsUntilTimestamp(_loc6_);
         if(_loc3_ <= 0)
         {
            return undefined;
         }
         var _loc4_ = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(_loc5_,0);
         m_aCoupons.push(_loc4_);
         _loc2_ = _loc2_ + 1;
      }
      CouponTile._visible = true;
      m_bHasCoupon = true;
      SetCouponTile(m_aCoupons,_loc7_);
   }
   return m_bHasCoupon;
}
function SetCouponTile(aCoupons, numCoupons)
{
   CouponTile.SetCouponData(aCoupons,m_PlayerXuid);
   if(numCoupons == 1)
   {
      var objTooltip = _global.MainMenuMovie.Panel.TooltipItem;
      CouponTile.Hitbox.RolledOver = function()
      {
         if(objTooltip._visible == false)
         {
            var _loc3_ = _global.CScaleformComponent_Inventory.GetRawDefinitionKey(CouponTile._ItemID,"will_produce_stattrak");
            if(_loc3_ == 1)
            {
               var _loc2_ = _global.MainMenuMovie.Panel.StoreListerPanel.GetMusicKitStatTrakDescAddition();
            }
            else
            {
               _loc2_ = "";
            }
            ShowHideToolTip(true,_loc2_);
         }
      };
      CouponTile.Hitbox.RolledOut = function()
      {
         if(!this.hitTest(_root._xmouse,_root._ymouse,true))
         {
            ShowHideToolTip(false);
         }
      };
   }
   else
   {
      CouponTile.Hitbox.RolledOver = function()
      {
      };
      CouponTile.Hitbox.RolledOut = function()
      {
      };
   }
}
function ShowHideToolTip(bShow, strDesc)
{
   var _loc9_ = _global.MainMenuMovie.Panel.TooltipItem;
   var _loc2_ = CouponTile;
   var _loc4_ = CouponTile._parent;
   var _loc5_ = _global.CScaleformComponent_Inventory.GetLootListItemIdByIndex(m_PlayerXuid,_loc2_._ItemID,0);
   trace("-------------------------------------------ShowHideToolTip-----objTargetTile._ItemID" + _loc2_._ItemID);
   trace("-------------------------------------------ShowHideToolTip-----objTargetTile" + _loc2_);
   var _loc3_ = {x:_loc2_._x + _loc2_.Hitbox._width,y:_loc2_._y};
   _loc4_.localToGlobal(_loc3_);
   _global.MainMenuMovie.Panel.TooltipItem._parent.globalToLocal(_loc3_);
   _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide(bShow);
   if(bShow)
   {
      _global.MainMenuMovie.Panel.TooltipItem.TooltipItemGetInfo(_loc2_._ItemXuid,_loc5_,"",strDesc);
      _global.MainMenuMovie.Panel.TooltipItem.TooltipItemLayout(_loc3_.x,_loc3_.y,_loc2_._width);
   }
}
function GetTileSizes()
{
   var _loc14_ = [];
   var _loc17_ = false;
   var _loc15_ = [];
   var _loc16_ = [];
   m_aKeys = [];
   var _loc4_ = 0;
   while(_loc4_ < m_numItems)
   {
      var _loc7_ = [];
      var _loc5_ = _global.CScaleformComponent_Store.GetBannerEntryDefIdx(_loc4_);
      var _loc2_ = _global.CScaleformComponent_Store.GetBannerEntryCustomFormatString(_loc4_);
      var _loc6_ = false;
      var _loc3_ = false;
      if(_loc2_ != "hiddentournament")
      {
         var _loc9_ = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(_loc5_,0);
         var _loc13_ = _global.CScaleformComponent_Inventory.IsTool(m_PlayerXuid,_loc9_);
         var _loc12_ = _global.CScaleformComponent_Inventory.GetItemCapabilityByIndex(m_PlayerXuid,_loc9_,0);
         if(_loc13_ && _loc12_ == "decodable" && !IsMusicKit(_loc9_))
         {
            _loc3_ = true;
         }
         if(_global.CScaleformComponent_Store.IsBannerEntryMarketLink(_loc4_) == 1)
         {
            _loc6_ = true;
         }
         if(_loc2_ == "operationPass")
         {
            var _loc8_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
            _loc8_ = _loc8_ + 1;
            var _loc11_ = _loc8_ + "Operation$OperationCoin";
            var _loc10_ = _global.CScaleformComponent_MyPersona.GetMyMedalRankByType(_loc11_);
            if(_loc10_ >= 1)
            {
               _loc17_ = true;
               _loc2_ = "single";
            }
            else
            {
               _loc2_ = "triple";
            }
            _loc15_.push(_loc5_,_loc2_,_loc6_,_loc3_,false);
         }
         else if(_loc2_ == "TournamentStickerStoreProxy")
         {
            _loc2_ = "triple";
            _loc16_.push(_loc5_,_loc2_,_loc6_,_loc3_,true);
         }
         else
         {
            _loc7_.push(_loc5_,_loc2_,_loc6_,_loc3_,false);
            if(_loc2_ == "single" || _loc2_ == "double" || _loc2_ == "triple")
            {
               if(_loc3_)
               {
                  m_aKeys.push(_loc7_);
               }
               else
               {
                  _loc14_.push(_loc7_);
               }
            }
         }
      }
      _loc4_ = _loc4_ + 1;
   }
   if(_loc17_)
   {
      _loc14_.push(_loc15_);
   }
   else if(_loc15_.length > 0)
   {
      _loc14_.unshift(_loc15_);
   }
   if(_loc16_.length > 0)
   {
      _loc14_.unshift(_loc16_);
   }
   return _loc14_;
}
function IsMusicKit(FauxItemId)
{
   if(FauxItemID != undefined && _global.CScaleformComponent_Inventory.GetLootListItemsCount(m_PlayerXuid,FauxItemIdx) > 0)
   {
      var _loc2_ = _global.CScaleformComponent_Inventory.GetLootListItemIdByIndex(m_PlayerXuid,FauxItemId,0);
      return _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(m_PlayerXuid,_loc2_,"musickit");
   }
   return false;
}
function MakePages(aItemList)
{
   var _loc12_ = 0;
   var _loc1_ = 0;
   var _loc11_ = [];
   if(m_bHasCoupon)
   {
      _loc12_ = 3;
   }
   else
   {
      _loc12_ = 5;
   }
   m_aPages = [];
   var _loc4_ = 0;
   while(_loc4_ < aItemList.length)
   {
      var _loc6_ = aItemList[_loc4_][1];
      if(_loc6_ == "triple")
      {
         _loc1_ = 3 + _loc1_;
      }
      else if(_loc6_ == "double")
      {
         _loc1_ = 2 + _loc1_;
      }
      else
      {
         _loc1_ = 1 + _loc1_;
      }
      if(_loc1_ > _loc12_)
      {
         var _loc8_ = false;
         if(_loc6_ == "triple")
         {
            _loc1_ = _loc1_ - 3;
         }
         else if(_loc6_ == "double")
         {
            _loc1_ = _loc1_ - 2;
         }
         else
         {
            _loc1_ = _loc1_ - 1;
         }
         var _loc3_ = _loc4_;
         while(_loc3_ < aItemList.length)
         {
            _loc6_ = aItemList[_loc3_][1];
            if(_loc8_ == false)
            {
               if(_loc6_ != "triple" && _loc6_ != "double")
               {
                  var _loc10_ = aItemList[_loc3_];
                  aItemList.splice(_loc3_,1);
                  aItemList.splice(_loc4_,0,_loc10_);
                  _loc1_ = 1 + _loc1_;
                  _loc8_ = true;
               }
            }
            _loc3_ = _loc3_ + 1;
         }
         if(_loc8_ == false)
         {
            aItemList[_loc4_][1] = "single";
            _loc1_ = 1 + _loc1_;
         }
      }
      _loc11_.push(aItemList[_loc4_]);
      if(_loc4_ == aItemList.length - 1)
      {
         if(_loc1_ < _loc12_)
         {
            var _loc13_ = _loc12_ - _loc1_;
            var _loc7_ = undefined;
            var _loc5_ = 0;
            while(_loc5_ < aItemList.length)
            {
               var _loc9_ = aItemList[_loc5_][1];
               if(_loc9_ == "single")
               {
                  _loc7_ = 1 + _loc7_;
                  if(_loc7_ <= _loc13_)
                  {
                     _loc11_.push(aItemList[_loc5_]);
                  }
               }
               _loc5_ = _loc5_ + 1;
            }
         }
      }
      if(_loc1_ == _loc12_ || _loc4_ == aItemList.length - 1)
      {
         m_aPages.push(_loc11_);
         _loc1_ = 0;
         _loc11_ = [];
      }
      _loc4_ = _loc4_ + 1;
   }
}
function SetUpBannerControls()
{
   var numPages = m_aPages.length;
   var _loc3_ = 15;
   var _loc2_ = 15;
   Controls._visible = true;
   var _loc1_ = 0;
   while(_loc1_ < _loc3_)
   {
      if(Controls["mcDot" + _loc1_])
      {
         Controls["mcDot" + _loc1_].removeMovieClip();
      }
      _loc1_ = _loc1_ + 1;
   }
   _loc1_ = 0;
   while(_loc1_ < numPages)
   {
      Controls.mcDot.duplicateMovieClip("mcDot" + _loc1_,_loc1_);
      if(_loc1_ == 0)
      {
         Controls.ButtonPrev._x = 0;
         Controls["mcDot" + _loc1_]._x = Controls.ButtonPrev._x + _loc2_;
      }
      if(_loc1_ >= numPages - 1)
      {
         Controls["mcDot" + _loc1_]._x = Controls["mcDot" + (_loc1_ - 1)]._x + _loc2_;
         Controls.ButtonNext._x = Controls["mcDot" + _loc1_]._x + _loc2_ + 5;
      }
      else
      {
         Controls["mcDot" + _loc1_]._x = Controls["mcDot" + (_loc1_ - 1)]._x + _loc2_;
      }
      _loc1_ = _loc1_ + 1;
   }
   Bg.BgControls._x = Bg._width - Bg.BgControls._width;
   Controls._x = Bg.BgControls._x + Bg.BgControls._width / 2;
   Controls._x = Controls._x - Controls._width / 2;
   trace("-------------------------!!!STORE!!!!Controls._x----------------------" + Controls._x);
   Bg.BgControls._visible = true;
   var numLoop = 0;
   Controls.onEnterFrame = function()
   {
      if(numLoop == 1)
      {
         SetUpContolsButtons(numPages);
         delete Controls.onEnterFrame;
      }
      numLoop++;
   };
}
function SetUpContolsButtons(numPages)
{
   var _loc3_ = 0;
   while(_loc3_ < numPages)
   {
      var _loc2_ = Controls["mcDot" + _loc3_];
      if(numPages <= 1)
      {
         _loc2_._visible = false;
      }
      else
      {
         _loc2_._visible = true;
      }
      _loc2_.dialog = this;
      _loc2_.actionSound = "PageScroll";
      _loc2_.Selected._visible = false;
      _loc2_.PageNum = _loc3_;
      _loc2_.Action = function()
      {
         this.dialog.GoToPage(this);
      };
      _loc3_ = _loc3_ + 1;
   }
   SetUpScrollButtons(numPages);
   SetUpKeyButton();
   GoToPage(Controls.mcDot0);
   StartTimer();
}
function StartTimer()
{
   if(m_numItems > 0)
   {
      StartScrollTimer();
   }
}
function SetUpKeyButton()
{
   if(m_aKeys.length <= 0)
   {
      return undefined;
   }
   mcKey._visible = true;
   mcKey.dialog = this;
   mcKey.actionSound = "PageScroll";
   mcKey.Selected._visible = false;
   mcKey.Action = function()
   {
      this.dialog.ShowHideKeys();
   };
}
function ShowHideKeys()
{
   bShowKeys = !bShowKeys;
   mcKey.Selected._visible = bShowKeys;
   if(bShowKeys)
   {
      MakePages(m_aKeys);
   }
   else
   {
      MakePages(GetTileSizes());
   }
   SetUpBannerControls();
   GoToPage(Controls.mcDot0);
}
function GoToPage(objButton)
{
   var _loc3_ = objButton.PageNum;
   var _loc2_ = false;
   if(m_SelectedPage != null)
   {
      m_SelectedPage.Selected._visible = false;
   }
   if(m_SelectedPage.PageNum > objButton.PageNum)
   {
      _loc2_ = true;
   }
   m_SelectedPage = objButton;
   objButton.Selected._visible = true;
   MakeLayout(_loc3_,_loc2_);
}
function MakeLayout(numPage, bReverseAnim)
{
   var _loc3_ = m_aPages[numPage].length;
   var _loc4_ = 0;
   if(m_bHasCoupon)
   {
      _loc4_ = StoreLister.mcDouble._width + (StoreLister._x - 8);
   }
   var _loc1_ = 0;
   while(_loc1_ <= 5)
   {
      if(StoreLister["mcTile" + _loc1_])
      {
         StoreLister["mcTile" + _loc1_].removeMovieClip();
      }
      _loc1_ = _loc1_ + 1;
   }
   _loc1_ = 0;
   while(_loc1_ < _loc3_)
   {
      var _loc2_ = m_aPages[numPage][_loc1_][1];
      if(_loc2_ == "triple")
      {
         StoreLister.mcTriple.duplicateMovieClip("mcTile" + _loc1_,_loc1_);
      }
      else if(_loc2_ == "double")
      {
         StoreLister.mcDouble.duplicateMovieClip("mcTile" + _loc1_,_loc1_);
      }
      else
      {
         StoreLister.mcSingle.duplicateMovieClip("mcTile" + _loc1_,_loc1_);
      }
      if(_loc1_ == 0)
      {
         StoreLister["mcTile" + _loc1_]._x = _loc4_;
      }
      else
      {
         StoreLister["mcTile" + _loc1_]._x = StoreLister["mcTile" + (_loc1_ - 1)]._width + StoreLister["mcTile" + (_loc1_ - 1)]._x;
      }
      StoreLister["mcTile" + _loc1_]._alpha = 0;
      StoreLister["mcTile" + _loc1_].ItemImageRef._visible = false;
      _loc1_ = _loc1_ + 1;
   }
   PageAnim(_loc3_,numPage,bReverseAnim);
}
function PageAnim(numItemsInPage, numPage, bReverseAnim)
{
   var numLoop = 0;
   if(bReverseAnim)
   {
      var numTile = numItemsInPage - 1;
   }
   else
   {
      var numTile = 0;
   }
   StoreLister.onEnterFrame = function()
   {
      if(numLoop == 2)
      {
         var _loc2_ = m_aPages[numPage][numTile][0];
         _loc2_ = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(_loc2_,0);
         StoreLister["mcTile" + numTile].SetItemData(_loc2_,m_PlayerXuid,m_aPages[numPage][numTile][2],m_aPages[numPage][numTile][4]);
         if(bReverseAnim)
         {
            if(numTile >= 0)
            {
               FadeUpTile(StoreLister["mcTile" + numTile]);
            }
            if(numTile == 0)
            {
               delete StoreLister.onEnterFrame;
            }
            numTile--;
         }
         else
         {
            if(numTile < numItemsInPage)
            {
               FadeUpTile(StoreLister["mcTile" + numTile]);
            }
            if(numTile == numItemsInPage - 1)
            {
               delete StoreLister.onEnterFrame;
            }
            numTile++;
         }
         numLoop = 0;
      }
      numLoop++;
   };
}
function FadeUpTile(TargetMc)
{
   TargetMc._alpha = 0;
   TargetMc.onEnterFrame = function()
   {
      if(TargetMc._alpha < 100)
      {
         TargetMc._alpha = TargetMc._alpha + 20;
      }
      else
      {
         TargetMc.ShowReflection();
         delete TargetMc.onEnterFrame;
      }
   };
}
function SetScrollButtonsState(numPage)
{
   if(numPage == 0)
   {
      Controls.ButtonPrev.setDisabled(true);
   }
   else
   {
      Controls.ButtonPrev.setDisabled(false);
   }
   if(numPage == m_aPages.length - 1)
   {
      Controls.ButtonNext.setDisabled(true);
   }
   else
   {
      Controls.ButtonNext.setDisabled(false);
   }
}
function SetUpScrollButtons(numPages)
{
   Bg.onRollOver = function()
   {
      PauseScrollTimer();
   };
   Bg.onRollOut = function()
   {
      StartScrollTimer();
      ShowHideToolTip(null);
   };
   if(numPages <= 1)
   {
      Controls.ButtonNext._visible = false;
      Controls.ButtonPrev._visible = false;
      return undefined;
   }
   Controls.ButtonNext.dialog = this;
   Controls.ButtonNext.actionSound = "PageScroll";
   Controls.ButtonNext.Action = function()
   {
      onScrollForward();
      ShowHideToolTip(false);
   };
   Controls.ButtonNext._visible = true;
   Controls.ButtonNext.onRollOver = function()
   {
      PauseScrollTimer();
   };
   Controls.ButtonPrev.dialog = this;
   Controls.ButtonPrev.actionSound = "PageScroll";
   Controls.ButtonPrev.Action = function()
   {
      onScrollBackward();
      ShowHideToolTip(false);
   };
   Controls.ButtonPrev._visible = true;
   Controls.ButtonPrev.onRollOver = function()
   {
      PauseScrollTimer();
   };
}
function onScrollForward()
{
   if(m_SelectedPage.PageNum == m_aPages.length - 1)
   {
      var _loc1_ = Controls.mcDot0;
   }
   else
   {
      _loc1_ = Controls["mcDot" + (m_SelectedPage.PageNum + 1)];
   }
   GoToPage(_loc1_);
}
function onScrollBackward()
{
   if(m_SelectedPage.PageNum == 0)
   {
      var _loc1_ = Controls["mcDot" + (m_aPages.length - 1)];
   }
   else
   {
      _loc1_ = Controls["mcDot" + (m_SelectedPage.PageNum - 1)];
   }
   GoToPage(_loc1_);
}
function onTimerScrollForward()
{
   if(m_SelectedPage.PageNum == m_aPages.length - 1)
   {
      var _loc1_ = Controls.mcDot0;
      GoToPage(_loc1_);
      return undefined;
   }
   _loc1_ = Controls["mcDot" + (m_SelectedPage.PageNum + 1)];
   GoToPage(_loc1_);
}
function resetToFirstPage()
{
   if(m_numItems > 0)
   {
      GoToPage(Controls.mcDot0);
   }
   StartTimer();
}
function ShowPanel()
{
   this._visible = true;
   resetToFirstPage();
}
function HidePanel()
{
   clearInterval(ScrollTimeInterval);
   this._visible = false;
}
function StartScrollTimer()
{
   if(Bg.hitTest(_root._xmouse,_root._ymouse,true))
   {
      return undefined;
   }
   clearInterval(ScrollTimeInterval);
   ScrollTimeInterval = setInterval(onTimerScrollForward,40000);
}
function PauseScrollTimer()
{
   if(Bg.hitTest(_root._xmouse,_root._ymouse,true))
   {
      clearInterval(ScrollTimeInterval);
   }
}
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var numQuantity = 1;
var ScrollTimeInterval;
var m_bAlreadyLoadedData = false;
var m_numItems;
var m_aPages = [];
var m_aKeys = [];
var m_aCoupons = [];
var m_bHasCoupon = false;
var m_SelectedPage = null;
var bShowKeys = false;
StoreLister.mcTriple._visible = false;
StoreLister.mcDouble._visible = false;
StoreLister.mcSingle._visible = false;
Controls.ButtonNext._visible = false;
Controls.ButtonPrev._visible = false;
Controls.mcDot._visible = false;
mcKey._visible = false;
Controls._visible = false;
CouponTile._visible = false;
Bg.BgControls._visible = false;
stop();
