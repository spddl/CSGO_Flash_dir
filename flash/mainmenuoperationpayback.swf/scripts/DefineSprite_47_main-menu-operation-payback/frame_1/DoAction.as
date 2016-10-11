function InitOperationPayback()
{
   DoesPlayerOwnGame();
   ShowButtons();
   ShowPanel();
   InitButtons();
}
function DoesPlayerOwnGame()
{
   var _loc2_ = _global.CScaleformComponent_MyPersona.GetLicenseType();
   if(_loc2_ == "purchased")
   {
      bOwnsGame = true;
   }
   else
   {
      bOwnsGame = false;
   }
}
function ShowPanel()
{
   if(bOwnsGame)
   {
      PaybackPanel._visible = _global.CScaleformComponent_MyPersona.IsInventoryValid();
   }
   else
   {
      PaybackPanel._visible = true;
   }
}
function DoesPlayerOwnPayback()
{
   var _loc3_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc2_ = _global.CScaleformComponent_FriendsList.GetFriendMedalRankByType(_loc3_,_global.CScaleformComponent_Medals.GetMedalTypeByIndex(_global.CScaleformComponent_Medals.GetMedalTypesCount() - 1));
   return _loc2_;
}
function InitButtons()
{
   PaybackPanel.DoesOwn.BuyMoreButton.dialog = this;
   PaybackPanel.DoesOwn.BuyMoreButton.Action = function()
   {
      this.dialog.onBuyMore(this);
   };
   PaybackPanel.DoesOwn.PlayButton.dialog = this;
   PaybackPanel.DoesOwn.PlayButton.Action = function()
   {
      this.dialog.onPlay(this);
   };
   PaybackPanel.DoesNotOwn.NotOwnButton.dialog = this;
   PaybackPanel.DoesNotOwn.NotOwnButton.Action = function()
   {
      this.dialog.onBuyFirst(this);
   };
   PaybackPanel.MoreInfoBtn.dialog = this;
   PaybackPanel.MoreInfoBtn.SetText("#CSGO_MessageBox_More_Info_Button");
   PaybackPanel.MoreInfoBtn.Action = function()
   {
      this.dialog.onMoreInfo(this);
   };
   PaybackPanel.TradeInfoBtn.dialog = this;
   PaybackPanel.TradeInfoBtn.SetText("#CSGO_MessageBox_More_Info_Button");
   PaybackPanel.TradeInfoBtn.Action = function()
   {
      this.dialog.onTradeInfo(this);
   };
   PaybackPanel.DoesNotOwnGame.NotOwnGamebtn.dialog = this;
   PaybackPanel.DoesNotOwnGame.NotOwnGamebtn.Action = function()
   {
      this.dialog.onNotOwnCSGO(this);
   };
}
function ShowButtons()
{
   var _loc2_ = DoesPlayerOwnPayback();
   var _loc1_ = false;
   if(!bOwnsGame)
   {
      PaybackPanel.DoesNotOwnGame._visible = true;
      PaybackPanel.DoesNotOwn._visible = false;
      PaybackPanel.DoesOwn._visible = false;
      PaybackPanel.TradeInfoBtn._visible = false;
      return undefined;
   }
   if(_loc2_ > 0)
   {
      _loc1_ = true;
   }
   if(!_loc1_)
   {
      PaybackPanel.DoesNotOwn._visible = true;
      PaybackPanel.DoesOwn._visible = false;
      PaybackPanel.TradeInfoBtn._visible = false;
      PaybackPanel.DoesNotOwnGame._visible = false;
   }
   else if(_loc1_)
   {
      PaybackPanel.DoesNotOwn._visible = false;
      PaybackPanel.DoesNotOwnGame._visible = false;
      PaybackPanel.DoesOwn._visible = true;
      PaybackPanel.TradeInfoBtn._visible = true;
      if(_loc2_ == 1)
      {
         PaybackPanel.DoesOwn.Description.htmlText = "#SFUI_MainMenu_OperationPayback_Activate";
      }
      else
      {
         PaybackPanel.DoesOwn.Description.htmlText = "#SFUI_MainMenu_OperationPayback_Play";
      }
   }
   SetPrice();
}
function onNotOwnCSGO()
{
   _global.CScaleformComponent_SteamOverlay.OpenURL("http://store.steampowered.com/app/730");
}
function onBuyFirst()
{
   _global.CScaleformComponent_Store.PurchaseItemWithStaticAttrValue("season access",0);
}
function onPlay()
{
   _global.MainMenuAPI.LaunchOperationPaybackQuickPlay();
}
function onBuyMore()
{
   _global.CScaleformComponent_Store.PurchaseItemWithStaticAttrValue("season access",0);
}
function onMoreInfo()
{
   _global.CScaleformComponent_SteamOverlay.OpenURL("http://blog.counter-strike.net/operationpayback/");
}
function onTradeInfo()
{
   _global.CScaleformComponent_SteamOverlay.OpenURL("https://support.steampowered.com/kb_article.php?ref=6748-ETSG-5417");
}
function SetPrice()
{
   var _loc8_ = DoesPlayerOwnPayback();
   var _loc2_ = null;
   var _loc6_ = false;
   var _loc3_ = false;
   var _loc5_ = _global.CScaleformComponent_Store.GetStoreItemPercentReduction("season access",0);
   var _loc7_ = _global.CScaleformComponent_Store.GetStoreItemOriginalPrice("season access",0);
   var _loc4_ = _global.CScaleformComponent_Store.GetStoreItemSalePrice("season access",0);
   if(_loc8_ > 0)
   {
      _loc6_ = true;
   }
   if(_loc6_)
   {
      _loc2_ = PaybackPanel.DoesOwn.Price;
   }
   else
   {
      _loc2_ = PaybackPanel.DoesNotOwn.Price;
   }
   if(_loc4_ == "")
   {
      _loc2_._visible = false;
      return undefined;
   }
   _loc2_._visible = true;
   if(_loc5_ != "")
   {
      _loc3_ = true;
   }
   _loc2_.SalePanel._visible = _loc3_;
   _loc2_.RegularPricePanel._visible = !_loc3_;
   if(_loc3_)
   {
      _loc2_.SalePanel.TextCurrent.htmlText = _loc4_;
      _loc2_.SalePanel.TextOriginal.htmlText = _loc7_;
      _loc2_.SalePanel.TextPercent.htmlText = _loc5_;
   }
   else
   {
      _loc2_.RegularPricePanel.TextCurrent.htmlText = _loc4_;
   }
}
var bIsInventoryValid = false;
var bOwnsGame = false;
this.stop();
